package com.alpro.consignment.frontend.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/config")
public class ApiConfigController {

    @Value("${app.mode:dev}")
    private String appMode;

    @Value("${app.gateway.base-url:http://localhost:8080}")
    private String gatewayBaseUrl;

    @Value("${app.services.auth:/auth}")
    private String serviceAuth;

    @Value("${app.services.trace-log:/api/trace-log}")
    private String serviceTraceLog;

    @Value("${app.services.master-setup:/api/master-setup}")
    private String serviceMasterSetup;

    @Value("${app.services.transaction:/api/transaction}")
    private String serviceTransaction;

    @Value("${app.services.settlement:/api/settlement}")
    private String serviceSettlement;

    @Value("${app.services.report:/api/report}")
    private String serviceReport;

    @GetMapping
    public ResponseEntity<Map<String, Object>> getConfig() {
        Map<String, Object> config = new HashMap<>();
        config.put("APP_MODE", appMode);
        config.put("GATEWAY_BASE_URL", gatewayBaseUrl);
        
        Map<String, String> services = new HashMap<>();
        services.put("AUTH", serviceAuth);
        services.put("TRACE_LOG", serviceTraceLog);
        services.put("MASTER_SETUP", serviceMasterSetup);
        services.put("TRANSACTION", serviceTransaction);
        services.put("SETTLEMENT", serviceSettlement);
        services.put("REPORT", serviceReport);
        
        config.put("SERVICES", services);
        
        return ResponseEntity.ok(config);
    }
}
