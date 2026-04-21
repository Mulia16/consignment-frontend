<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!-- Sidebar -->
    <nav class="sidebar" id="sidebar">
        <div class="sidebar-brand">
            <h4><i class="fas fa-pills mr-2"></i>ALPRO</h4>
            <small>Consignment System</small>
        </div>

        <ul class="sidebar-menu">
            <!-- Dashboard (available for both roles) -->
            <li class="menu-header">Main</li>
            <li data-menu="DASHBOARD">
                <a href="/consignee/dashboard" id="nav-dashboard">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>

            <!-- Products & Purchase Orders (CONSIGNEE role) -->
            <li data-menu="PRODUCTS">
                <a href="/products" id="nav-products">
                    <i class="fas fa-boxes"></i> Products
                </a>
            </li>
            <li data-menu="PURCHASE_ORDERS">
                <a href="/purchase-orders" id="nav-purchase-orders">
                    <i class="fas fa-shopping-cart"></i> Purchase Orders
                </a>
            </li>

            <!-- Consignment -->
            <li class="menu-header">Consignment</li>
            <li data-menu="CONSIGNMENT_RECEIVING">
                <a href="/consignment/receiving" id="nav-consignment-receiving">
                    <i class="fas fa-box-open"></i> Receiving
                </a>
            </li>
            <li data-menu="CONSIGNMENT_STOCK_OUT">
                <a href="/consignment/stock-out" id="nav-consignment-stockout">
                    <i class="fas fa-box"></i> Stock Out
                </a>
            </li>
            <li data-menu="CONSIGNMENT_STOCK_REQUEST">
                <a href="/consignment/stock-request" id="nav-consignment-stock-request">
                    <i class="fas fa-clipboard-list"></i> Stock Request
                </a>
            </li>
            <li data-menu="CONSIGNMENT_DELIVERY_ORDER">
                <a href="/consignment/delivery-order" id="nav-consignment-delivery-order">
                    <i class="fas fa-truck-loading"></i> Delivery Order
                </a>
            </li>
            <li data-menu="CONSIGNMENT_STOCK_RETURN">
                <a href="/consignment/stock-return" id="nav-consignment-stockreturn">
                    <i class="fas fa-undo-alt"></i> Stock Return
                </a>
            </li>
            <li data-menu="CONSIGNMENT_STOCK_RETURN_COLLECT">
                <a href="/consignment/stock-return-collect" id="nav-consignment-stockreturn-collect">
                    <i class="fas fa-people-carry"></i> Stock Return Collect
                </a>
            </li>
            <li data-menu="CONSIGNMENT_STOCK_ADJUSTMENT">
                <a href="/consignment/stock-adjustment" id="nav-consignment-stockadjustment">
                    <i class="fas fa-sliders-h"></i> Stock Adjustment
                </a>
            </li>

            <!-- Settlement -->
            <li class="menu-header">Settlement</li>
            <li data-menu="SETTLEMENT_CUSTOMER_COMPUTE">
                <a href="/consignment/settlement/customer-compute" id="nav-consignment-customer-compute">
                    <i class="fas fa-calculator"></i> Compute Customer Settlement
                </a>
            </li>
            <li data-menu="SETTLEMENT_CUSTOMER_BILLING">
                <a href="/consignment/settlement/customer-billing" id="nav-consignment-customer-billing">
                    <i class="fas fa-file-invoice-dollar"></i> Customer Billing Request
                </a>
            </li>
            <li data-menu="SETTLEMENT_FAILURE_CUSTOMER">
                <a href="/consignment/settlement/failure-customer" id="nav-consignment-failure-customer">
                    <i class="fas fa-exclamation-triangle"></i> Failed Customer Compute
                </a>
            </li>
            <li data-menu="SETTLEMENT_SUPPLIER_COMPUTE">
                <a href="/consignment/settlement/supplier-compute" id="nav-consignment-supplier-compute">
                    <i class="fas fa-calculator"></i> Compute Supplier Settlement
                </a>
            </li>
            <li data-menu="SETTLEMENT_SUPPLIER_BILLING">
                <a href="/consignment/settlement/supplier-billing" id="nav-consignment-supplier-billing">
                    <i class="fas fa-file-invoice"></i> Supplier Billing Request
                </a>
            </li>
            <li data-menu="SETTLEMENT_FAILURE_SUPPLIER">
                <a href="/consignment/settlement/failure-supplier" id="nav-consignment-failure-supplier">
                    <i class="fas fa-exclamation-triangle"></i> Failed Supplier Compute
                </a>
            </li>

            <!-- Master Data -->
            <li class="menu-header">Master Data</li>
            <li data-menu="MASTER_DATA_COMPANIES">
                <a href="/master-data/companies" id="nav-companies">
                    <i class="fas fa-building"></i> Companies
                </a>
            </li>
            <li data-menu="MASTER_DATA_STORES">
                <a href="/master-data/stores" id="nav-stores">
                    <i class="fas fa-store"></i> Stores
                </a>
            </li>
            <li data-menu="MASTER_DATA_SUPPLIERS">
                <a href="/master-data/suppliers" id="nav-suppliers">
                    <i class="fas fa-truck"></i> Suppliers
                </a>
            </li>
            <li data-menu="MASTER_DATA_CONTRACTS">
                <a href="/master-data/contracts" id="nav-contracts">
                    <i class="fas fa-file-contract"></i> Contracts
                </a>
            </li>
            <li data-menu="MASTER_DATA_ITEMS">
                <a href="/master-data/items" id="nav-items">
                    <i class="fas fa-boxes"></i> Items
                </a>
            </li>

            <!-- Setup -->
            <li class="menu-header">Setup</li>
            <li data-menu="SETUP_CONSIGNMENT_ITEMS">
                <a href="/setup/consignment-items" id="nav-consignment-items">
                    <i class="fas fa-boxes"></i> Items Supplier Setup
                </a>
            </li>

            <!-- Report -->
            <li class="menu-header">Report</li>
            <li data-menu="REPORT_CENTER">
                <a href="/reports" id="nav-reports">
                    <i class="fas fa-chart-bar"></i> Report Center
                </a>
            </li>
            <li data-menu="REPORT_CSRQ">
                <a href="/reports?type=csrq" id="nav-report-csrq">
                    <i class="fas fa-clipboard-list"></i> CSRQ Report
                </a>
            </li>
            <li data-menu="REPORT_CSRV">
                <a href="/reports?type=csrv" id="nav-report-csrv">
                    <i class="fas fa-box-open"></i> CSRV Report
                </a>
            </li>
            <li data-menu="REPORT_CSO">
                <a href="/reports?type=cso" id="nav-report-cso">
                    <i class="fas fa-box"></i> CSO Report
                </a>
            </li>
            <li data-menu="REPORT_CSDO">
                <a href="/reports?type=csdo" id="nav-report-csdo">
                    <i class="fas fa-truck-loading"></i> CSDO Report
                </a>
            </li>
            <li data-menu="REPORT_CSR">
                <a href="/reports?type=csr" id="nav-report-csr">
                    <i class="fas fa-undo-alt"></i> CSR Report
                </a>
            </li>
            <li data-menu="REPORT_CSA">
                <a href="/reports?type=csa" id="nav-report-csa">
                    <i class="fas fa-sliders-h"></i> CSA Report
                </a>
            </li>
            <li data-menu="REPORT_SETTLEMENT_SUMMARY">
                <a href="/reports?type=settlement-summary" id="nav-report-settlement-summary">
                    <i class="fas fa-handshake"></i> Settlement Summary
                </a>
            </li>
            <li data-menu="REPORT_SETTLEMENT_DETAIL">
                <a href="/reports?type=settlement-detail" id="nav-report-settlement-detail">
                    <i class="fas fa-file-invoice-dollar"></i> Settlement Detail
                </a>
            </li>
            <li data-menu="REPORT_SUPPLIER_BOOK_VALUE">
                <a href="/reports?type=supplier-book-value" id="nav-report-supplier-book-value">
                    <i class="fas fa-book"></i> Supplier Book Value
                </a>
            </li>
            <li data-menu="REPORT_CUSTOMER_INVENTORY">
                <a href="/reports?type=customer-inventory" id="nav-report-customer-inventory">
                    <i class="fas fa-warehouse"></i> Customer Inventory
                </a>
            </li>
            <li data-menu="REPORT_RESERVATIONS">
                <a href="/reports?type=reservations" id="nav-report-reservations">
                    <i class="fas fa-bookmark"></i> Reservations
                </a>
            </li>
            <li data-menu="REPORT_CONSIGNMENT_SETUP">
                <a href="/reports?type=consignment-setup" id="nav-report-consignment-setup">
                    <i class="fas fa-cogs"></i> Consignment Setup
                </a>
            </li>

            <!-- Audit -->
            <li class="menu-header">System</li>
            <li data-menu="SYSTEM_AUDIT_LOG">
                <a href="/audit/logs" id="nav-audit">
                    <i class="fas fa-history"></i> Audit Log
                </a>
            </li>
        </ul>
    </nav>

    <!-- Top Header -->
    <header class="main-header">
        <div>
            <button class="btn btn-sm btn-light d-md-none mr-2" id="sidebarToggle">
                <i class="fas fa-bars"></i>
            </button>
            <span class="page-title">${param.pageTitle}</span>
        </div>
        <div class="header-right">
            <span class="user-info">
                <i class="fas fa-user-circle mr-1"></i>
                <strong id="currentUser">Admin</strong>
            </span>
            <button class="btn btn-outline-danger btn-logout" onclick="Auth.logout()">
                <i class="fas fa-sign-out-alt mr-1"></i> Logout
            </button>
        </div>
    </header>
