package com.alpro.consignment.frontend.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * API Configuration Controller
 * Provides frontend with service endpoint configuration aligned with backend API architecture.
 * See plans/api-endpoint.md for full API documentation.
 * 
 * Services:
 * - AUTH: Auth Service (/auth) - 3 endpoints
 * - CONSIGNMENT: Consignment Service (/api) - 56 endpoints
 * - INVENTORY: Inventory Service (/api/v1/inventory) - 2 endpoints
 * - BATCH: Batch Job Service (/batch) - 2 endpoints
 */
@RestController
@RequestMapping("/api/config")
public class ApiConfigController {

    @Value("${app.mode:dev}")
    private String appMode;

    @Value("${app.gateway.base-url:http://localhost:8080}")
    private String gatewayBaseUrl;

    @Value("${app.services.auth:/auth}")
    private String serviceAuth;

    @Value("${app.services.consignment:/api}")
    private String serviceConsignment;

    @Value("${app.services.inventory:/api/v1/inventory}")
    private String serviceInventory;

    @Value("${app.services.batch:/batch}")
    private String serviceBatch;

    @GetMapping
    public ResponseEntity<Map<String, Object>> getConfig() {
        Map<String, Object> config = new HashMap<>();
        config.put("APP_MODE", appMode);
        config.put("GATEWAY_BASE_URL", gatewayBaseUrl);
        
        Map<String, String> services = new HashMap<>();
        services.put("AUTH", serviceAuth);
        services.put("CONSIGNMENT", serviceConsignment);
        services.put("INVENTORY", serviceInventory);
        services.put("BATCH", serviceBatch);
        
        config.put("SERVICES", services);
        
        return ResponseEntity.ok(config);
    }
}
