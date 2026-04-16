<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!-- Sidebar -->
    <nav class="sidebar" id="sidebar">
        <div class="sidebar-brand">
            <h4><i class="fas fa-pills mr-2"></i>ALPRO</h4>
            <small>Consignment System</small>
        </div>

        <ul class="sidebar-menu">
            <!-- Consignment -->
            <li class="menu-header">Consignment</li>
            <li>
                <a href="/consignment/receiving" id="nav-consignment-receiving">
                    <i class="fas fa-box-open"></i> Receiving
                </a>
            </li>
            <li>
                <a href="/consignment/stock-out" id="nav-consignment-stockout">
                    <i class="fas fa-box"></i> Stock Out
                </a>
            </li>
            <li>
                <a href="/consignment/stock-request" id="nav-consignment-stock-request">
                    <i class="fas fa-clipboard-list"></i> Stock Request
                </a>
            </li>
            <li>
                <a href="/consignment/delivery-order" id="nav-consignment-delivery-order">
                    <i class="fas fa-truck-loading"></i> Delivery Order
                </a>
            </li>
            <li>
                <a href="/consignment/stock-return" id="nav-consignment-stockreturn">
                    <i class="fas fa-undo-alt"></i> Stock Return
                </a>
            </li>
            <li>
                <a href="/consignment/stock-return-collect" id="nav-consignment-stockreturn-collect">
                    <i class="fas fa-people-carry"></i> Stock Return Collect
                </a>
            </li>
            <li>
                <a href="/consignment/stock-adjustment" id="nav-consignment-stockadjustment">
                    <i class="fas fa-sliders-h"></i> Stock Adjustment
                </a>
            </li>

            <!-- Settlement -->
            <li class="menu-header">Settlement</li>
            <li>
                <a href="/consignment/settlement/customer-compute" id="nav-consignment-customer-compute">
                    <i class="fas fa-calculator"></i> Compute Customer Settlement
                </a>
            </li>
            <li>
                <a href="/consignment/settlement/customer-billing" id="nav-consignment-customer-billing">
                    <i class="fas fa-file-invoice-dollar"></i> Customer Billing Request
                </a>
            </li>
            <li>
                <a href="/consignment/settlement/failure-customer" id="nav-consignment-failure-customer">
                    <i class="fas fa-exclamation-triangle"></i> Failed Customer Compute
                </a>
            </li>
            <li>
                <a href="/consignment/settlement/supplier-compute" id="nav-consignment-supplier-compute">
                    <i class="fas fa-calculator"></i> Compute Supplier Settlement
                </a>
            </li>
            <li>
                <a href="/consignment/settlement/supplier-billing" id="nav-consignment-supplier-billing">
                    <i class="fas fa-file-invoice"></i> Supplier Billing Request
                </a>
            </li>
            <li>
                <a href="/consignment/settlement/failure-supplier" id="nav-consignment-failure-supplier">
                    <i class="fas fa-exclamation-triangle"></i> Failed Supplier Compute
                </a>
            </li>

            <!-- Master Data -->
            <li class="menu-header">Master Data</li>
            <li>
                <a href="/master-data/companies" id="nav-companies">
                    <i class="fas fa-building"></i> Companies
                </a>
            </li>
            <li>
                <a href="/master-data/stores" id="nav-stores">
                    <i class="fas fa-store"></i> Stores
                </a>
            </li>
            <li>
                <a href="/master-data/suppliers" id="nav-suppliers">
                    <i class="fas fa-truck"></i> Suppliers
                </a>
            </li>
            <li>
                <a href="/master-data/contracts" id="nav-contracts">
                    <i class="fas fa-file-contract"></i> Contracts
                </a>
            </li>
            <li>
                <a href="/master-data/items" id="nav-items">
                    <i class="fas fa-boxes"></i> Items
                </a>
            </li>

            <!-- Setup -->
            <li class="menu-header">Setup</li>
            <!--<li>
                <a href="/setup/system-config" id="nav-system-config">
                    <i class="fas fa-sliders-h"></i> System Config
                </a>
            </li>-->
            <!--<li>
                <a href="/setup/reference-data" id="nav-reference-data">
                    <i class="fas fa-tags"></i> Reference Data
                </a>
            </li>-->
            <li>
                <a href="/setup/consignment-items" id="nav-consignment-items">
                    <i class="fas fa-boxes"></i> Items Supplier Setup
                </a>
            </li>

            <!-- Report -->
            <li class="menu-header">Report</li>
            <li>
                <a href="/reports" id="nav-reports">
                    <i class="fas fa-chart-bar"></i> Report Center
                </a>
            </li>
            <li>
                <a href="/reports?type=csrq" id="nav-report-csrq">
                    <i class="fas fa-clipboard-list"></i> CSRQ Report
                </a>
            </li>
            <li>
                <a href="/reports?type=csrv" id="nav-report-csrv">
                    <i class="fas fa-box-open"></i> CSRV Report
                </a>
            </li>
            <li>
                <a href="/reports?type=cso" id="nav-report-cso">
                    <i class="fas fa-box"></i> CSO Report
                </a>
            </li>
            <li>
                <a href="/reports?type=csdo" id="nav-report-csdo">
                    <i class="fas fa-truck-loading"></i> CSDO Report
                </a>
            </li>
            <li>
                <a href="/reports?type=csr" id="nav-report-csr">
                    <i class="fas fa-undo-alt"></i> CSR Report
                </a>
            </li>
            <li>
                <a href="/reports?type=csa" id="nav-report-csa">
                    <i class="fas fa-sliders-h"></i> CSA Report
                </a>
            </li>
            <li>
                <a href="/reports?type=settlement-summary" id="nav-report-settlement-summary">
                    <i class="fas fa-handshake"></i> Settlement Summary
                </a>
            </li>
            <li>
                <a href="/reports?type=settlement-detail" id="nav-report-settlement-detail">
                    <i class="fas fa-file-invoice-dollar"></i> Settlement Detail
                </a>
            </li>
            <li>
                <a href="/reports?type=supplier-book-value" id="nav-report-supplier-book-value">
                    <i class="fas fa-book"></i> Supplier Book Value
                </a>
            </li>
            <li>
                <a href="/reports?type=customer-inventory" id="nav-report-customer-inventory">
                    <i class="fas fa-warehouse"></i> Customer Inventory
                </a>
            </li>
            <li>
                <a href="/reports?type=reservations" id="nav-report-reservations">
                    <i class="fas fa-bookmark"></i> Reservations
                </a>
            </li>
            <li>
                <a href="/reports?type=consignment-setup" id="nav-report-consignment-setup">
                    <i class="fas fa-cogs"></i> Consignment Setup
                </a>
            </li>

            <!-- Audit -->
            <li class="menu-header">System</li>
            <li>
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
