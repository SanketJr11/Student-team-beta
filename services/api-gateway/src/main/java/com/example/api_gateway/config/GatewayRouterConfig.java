package com.example.api_gateway.config;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * API Gateway Routes Configuration
 *
 * Defines routing rules for the API Gateway using Spring Cloud Gateway.
 * Routes requests to downstream services based on path patterns.
 *
 * @author API Gateway Team
 * @version 1.0
 */
@Configuration
public class GatewayRouterConfig {

    /**
     * Define routes for microservices
     *
     * Routes:
     * - /api/rooms/** → room-service (port 8081)
     * - /api/bookings/** → booking-service (port 8082)
     * - /api/config/** → config-server (port 8888)
     *
     * @param builder RouteLocatorBuilder for fluent route definition
     * @return RouteLocator with all defined routes
     */
    @Bean
    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
        return builder.routes()
                // Room Service Route
                .route("room-service", r -> r
                        .path("/api/rooms/**")
                        .filters(f -> f
                                .rewritePath("/api/rooms/(?<segment>.*)", "/${segment}")
                                .circuitBreaker(config -> config.setName("roomServiceBreaker")))
                        .uri("lb://room-service")
                )
                // Booking Service Route
                .route("booking-service", r -> r
                        .path("/api/bookings/**")
                        .filters(f -> f
                                .rewritePath("/api/bookings/(?<segment>.*)", "/${segment}")
                                .circuitBreaker(config -> config.setName("bookingServiceBreaker")))
                        .uri("lb://booking-service")
                )
                // Config Server Route
                .route("config-server", r -> r
                        .path("/api/config/**")
                        .filters(f -> f
                                .rewritePath("/api/config/(?<segment>.*)", "/${segment}"))
                        .uri("lb://config-server")
                )
                // Health Check Routes
                .route("room-service-health", r -> r
                        .path("/health/rooms")
                        .uri("lb://room-service/actuator/health")
                )
                .route("booking-service-health", r -> r
                        .path("/health/bookings")
                        .uri("lb://booking-service/actuator/health")
                )
                .route("config-server-health", r -> r
                        .path("/health/config")
                        .uri("lb://config-server/actuator/health")
                )
                .build();
    }
}
