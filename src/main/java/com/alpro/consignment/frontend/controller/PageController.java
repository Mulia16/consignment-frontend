package com.alpro.consignment.frontend.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    // ─── Auth ───────────────────────────────────────────────
    @GetMapping("/")
    public String root() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    // ─── Dashboard ──────────────────────────────────────────
    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }

    // ─── Master Data ────────────────────────────────────────
    @GetMapping("/master-data/products")
    public String products() {
        return "master-data/products";
    }

    @GetMapping("/master-data/suppliers")
    public String suppliers() {
        return "master-data/suppliers";
    }

    @GetMapping("/master-data/warehouses")
    public String warehouses() {
        return "master-data/warehouses";
    }

    // ─── Setup ──────────────────────────────────────────────
    @GetMapping("/setup/system-config")
    public String systemConfig() {
        return "setup/system-config";
    }

    @GetMapping("/setup/reference-data")
    public String referenceData() {
        return "setup/reference-data";
    }

    @GetMapping("/setup/consignment-items")
    public String consignmentItems() {
        return "setup/consignment-items/list";
    }

    @GetMapping("/setup/consignment-items/setup")
    public String consignmentItemsSetup() {
        return "setup/consignment-items/details";
    }

    // ─── Inventory ──────────────────────────────────────────
    @GetMapping("/inventory/stock")
    public String stock() {
        return "inventory/stock";
    }

    @GetMapping("/inventory/movement")
    public String movement() {
        return "inventory/movement";
    }

    // ─── Inbound ────────────────────────────────────────────
    @GetMapping("/inbound/purchase-orders")
    public String purchaseOrders() {
        return "inbound/purchase-orders";
    }

    @GetMapping("/inbound/goods-receipt")
    public String goodsReceipt() {
        return "inbound/goods-receipt";
    }

    // ─── Consignment Transaction ────────────────────────────
    @GetMapping("/consignment/receiving")
    public String consignmentReceivingList() {
        return "consignment/receiving/list";
    }

    @GetMapping("/consignment/receiving/details")
    public String consignmentReceivingDetails() {
        return "consignment/receiving/details";
    }

    @GetMapping("/consignment/receiving/print")
    public String consignmentReceivingPrint() {
        return "consignment/receiving/print-slip";
    }

    // ─── Outbound ───────────────────────────────────────────
    @GetMapping("/consignment/stock-request")
    public String consignmentStockRequestList() {
        return "consignment/stock-request/list";
    }

    @GetMapping("/consignment/stock-request/details")
    public String consignmentStockRequestDetails() {
        return "consignment/stock-request/details";
    }

    @GetMapping("/consignment/stock-out")
    public String consignmentStockOutList() {
        return "consignment/stock-out/list";
    }

    @GetMapping("/consignment/stock-out/details")
    public String consignmentStockOutDetails() {
        return "consignment/stock-out/details";
    }

    @GetMapping("/consignment/delivery-order")
    public String consignmentDeliveryOrderList() {
        return "consignment/delivery-order/list";
    }

    @GetMapping("/consignment/delivery-order/details")
    public String consignmentDeliveryOrderDetails() {
        return "consignment/delivery-order/details";
    }

    @GetMapping("/outbound/sales-orders")
    public String salesOrders() {
        return "outbound/sales-orders";
    }

    @GetMapping("/outbound/delivery")
    public String delivery() {
        return "outbound/delivery";
    }

    // ─── Returns & Adjustments ──────────────────────────────
    @GetMapping("/returns/return-orders")
    public String returnOrders() {
        return "returns/return-orders";
    }

    @GetMapping("/returns/adjustments")
    public String adjustments() {
        return "returns/adjustments";
    }

    // ─── POS Sales ──────────────────────────────────────────
    @GetMapping("/pos/transactions")
    public String posTransactions() {
        return "pos/transactions";
    }

    // ─── Settlement ─────────────────────────────────────────
    @GetMapping("/settlement/list")
    public String settlementList() {
        return "settlement/list";
    }

    @GetMapping("/settlement/payments")
    public String payments() {
        return "settlement/payments";
    }

    // ─── Audit & Trace Log ──────────────────────────────────
    @GetMapping("/audit/logs")
    public String auditLogs() {
        return "audit/logs";
    }

    // ─── Reports ────────────────────────────────────────────
    @GetMapping("/reports")
    public String reports() {
        return "reports/index";
    }
}
