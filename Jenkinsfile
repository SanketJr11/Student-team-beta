pipeline {
    agent any

    environment {
        PATH = "/opt/homebrew/bin:/usr/local/bin:${env.PATH}"
        DOCKERHUB_USERNAME = 'sanketshetty23'

        AUTH_IMAGE = 'sanketshetty23/auth-service'
        ROOM_IMAGE = 'sanketshetty23/room-service'
        BOOKING_IMAGE = 'sanketshetty23/booking-service'
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Microservices') {
            parallel {
                stage('Build Auth Service') {
                    steps {
                        sh '''
                            set -e

                            mvn \
                              -f services/auth-service/pom.xml \
                              clean package \
                              -DskipTests
                        '''
                    }
                }

                stage('Build Room Service') {
                    steps {
                        sh '''
                            set -e

                            mvn \
                              -f services/room-service/pom.xml \
                              clean package \
                              -DskipTests
                        '''
                    }
                }

                stage('Build Booking Service') {
                    steps {
                        sh '''
                            set -e

                            mvn \
                              -f services/booking-service/pom.xml \
                              clean package \
                              -DskipTests
                        '''
                    }
                }
            }
        }

        stage('Verify JAR Files') {
            steps {
                sh '''
                    echo "Auth Service JAR:"
                    ls -lh services/auth-service/target/*.jar

                    echo "Room Service JAR:"
                    ls -lh services/room-service/target/*.jar

                    echo "Booking Service JAR:"
                    ls -lh services/booking-service/target/*.jar
                '''
            }
        }

        stage('Prepare Docker Buildx') {
            steps {
                sh '''
                    docker buildx inspect classroom-builder >/dev/null 2>&1 || \
                    docker buildx create \
                      --name classroom-builder \
                      --driver docker-container \
                      --use

                    docker buildx use classroom-builder
                    docker buildx inspect --bootstrap
                '''
            }
        }

        stage('Docker Hub Login') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_TOKEN'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_TOKEN" | \
                        docker login \
                          -u "$DOCKER_USER" \
                          --password-stdin
                    '''
                }
            }
        }

        stage('Build and Push Docker Images') {
            parallel {
                stage('Auth Image') {
                    steps {
                        sh '''
                            docker buildx build \
                              --platform linux/amd64,linux/arm64 \
                              --no-cache \
                              -t ${AUTH_IMAGE}:latest \
                              -t ${AUTH_IMAGE}:${BUILD_NUMBER} \
                              --push \
                              ./services/auth-service
                        '''
                    }
                }

                stage('Room Image') {
                    steps {
                        sh '''
                            docker buildx build \
                              --platform linux/amd64,linux/arm64 \
                              --no-cache \
                              -t ${ROOM_IMAGE}:latest \
                              -t ${ROOM_IMAGE}:${BUILD_NUMBER} \
                              --push \
                              ./services/room-service
                        '''
                    }
                }

                stage('Booking Image') {
                    steps {
                        sh '''
                            docker buildx build \
                              --platform linux/amd64,linux/arm64 \
                              --no-cache \
                              -t ${BOOKING_IMAGE}:latest \
                              -t ${BOOKING_IMAGE}:${BUILD_NUMBER} \
                              --push \
                              ./services/booking-service
                        '''
                    }
                }
            }
        }

        stage('Verify Published Images') {
            steps {
                sh '''
                    docker buildx imagetools inspect ${AUTH_IMAGE}:latest
                    docker buildx imagetools inspect ${ROOM_IMAGE}:latest
                    docker buildx imagetools inspect ${BOOKING_IMAGE}:latest
                '''
            }
        }
    }

    post {
        success {
            echo 'All three Docker images were built and pushed successfully.'
        }

        failure {
            echo 'Pipeline failed. Check the failed stage in the Jenkins console.'
        }

        always {
            sh 'docker logout || true'
        }
    }
}