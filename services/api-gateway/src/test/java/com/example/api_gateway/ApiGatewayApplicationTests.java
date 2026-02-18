package com.example.api_gateway;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

import static org.springframework.boot.test.context.SpringBootTest.WebEnvironment.RANDOM_PORT;

/**
 * API Gateway Application Tests
 */
@SpringBootTest(webEnvironment = RANDOM_PORT)
@TestPropertySource(properties = {
        "eureka.client.enabled=false",
        "spring.cloud.config.enabled=false"
})
class ApiGatewayApplicationTests {

    @Test
    void contextLoads() {
        // Verify application context loads successfully
    }

    @Test
    void gatewayStarts() {
        // API Gateway should start and be ready to route requests
    }

}
