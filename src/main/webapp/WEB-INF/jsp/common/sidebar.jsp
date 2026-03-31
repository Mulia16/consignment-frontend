<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Sidebar -->
<nav class="sidebar" id="sidebar">
    <div class="sidebar-brand">
        <h4><i class="fas fa-pills mr-2"></i>ALPRO</h4>
        <small>Consignment System</small>
    </div>

    <ul class="sidebar-menu">
        <!-- Dashboard -->
        <li>
            <a href="/dashboard" id="nav-dashboard">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
        </li>

        <!-- Master Data & Setup -->
        <li class="menu-header">Master & Setup</li>
        <li class="has-submenu" id="menu-master">
            <a href="#"><i class="fas fa-database"></i> Master Data</a>
            <ul class="submenu">
                <li><a href="/master-data/products" id="nav-products"><i class="fas fa-boxes"></i> Products</a></li>
                <li><a href="/master-data/suppliers" id="nav-suppliers"><i class="fas fa-truck"></i> Suppliers</a></li>
                <li><a href="/master-data/warehouses" id="nav-warehouses"><i class="fas fa-warehouse"></i> Warehouses</a></li>
            </ul>
        </li>
        <li class="has-submenu" id="menu-setup">
            <a href="#"><i class="fas fa-cogs"></i> Setup</a>
            <ul class="submenu">
                <li><a href="/setup/system-config" id="nav-system-config"><i class="fas fa-sliders-h"></i> System Config</a></li>
                <li><a href="/setup/reference-data" id="nav-reference-data"><i class="fas fa-tags"></i> Reference Data</a></li>
                <li><a href="/setup/consignment-items" id="nav-consignment-items"><i class="fas fa-boxes"></i> Items Supplier Setup</a></li>
            </ul>
        </li>

        <!-- Transaction -->
        <li class="menu-header">Transaction</li>
        <li class="has-submenu" id="menu-inventory">
            <a href="#"><i class="fas fa-cubes"></i> Inventory</a>
            <ul class="submenu">
                <li><a href="/inventory/stock" id="nav-stock"><i class="fas fa-layer-group"></i> Stock Balance</a></li>
                <li><a href="/inventory/movement" id="nav-movement"><i class="fas fa-exchange-alt"></i> Stock Movement</a></li>
            </ul>
        </li>
        <li class="has-submenu" id="menu-inbound">
            <a href="#"><i class="fas fa-sign-in-alt"></i> Inbound</a>
            <ul class="submenu">
                <li><a href="/inbound/purchase-orders" id="nav-po"><i class="fas fa-file-invoice"></i> Purchase Orders</a></li>
                <li><a href="/inbound/goods-receipt" id="nav-gr"><i class="fas fa-clipboard-check"></i> Goods Receipt</a></li>
            </ul>
        </li>
        <li class="has-submenu" id="menu-outbound">
            <a href="#"><i class="fas fa-sign-out-alt"></i> Outbound</a>
            <ul class="submenu">
                <li><a href="/outbound/sales-orders" id="nav-so"><i class="fas fa-file-invoice-dollar"></i> Sales Orders</a></li>
                <li><a href="/outbound/delivery" id="nav-delivery"><i class="fas fa-shipping-fast"></i> Delivery Orders</a></li>
            </ul>
        </li>
        <li class="has-submenu" id="menu-returns">
            <a href="#"><i class="fas fa-undo-alt"></i> Returns & Adj</a>
            <ul class="submenu">
                <li><a href="/returns/return-orders" id="nav-returns"><i class="fas fa-reply"></i> Return Orders</a></li>
                <li><a href="/returns/adjustments" id="nav-adj"><i class="fas fa-balance-scale"></i> Adjustments</a></li>
            </ul>
        </li>
        <li>
            <a href="/pos/transactions" id="nav-pos">
                <i class="fas fa-cash-register"></i> POS Sales
            </a>
        </li>

        <!-- Settlement & Report -->
        <li class="menu-header">Settlement & Report</li>
        <li class="has-submenu" id="menu-settlement">
            <a href="#"><i class="fas fa-handshake"></i> Settlement</a>
            <ul class="submenu">
                <li><a href="/settlement/list" id="nav-settlement"><i class="fas fa-file-contract"></i> Settlement List</a></li>
                <li><a href="/settlement/payments" id="nav-payments"><i class="fas fa-money-check-alt"></i> Payments</a></li>
            </ul>
        </li>
        <li>
            <a href="/reports" id="nav-reports">
                <i class="fas fa-chart-bar"></i> Reports
            </a>
        </li>

        <!-- System -->
        <li class="menu-header">System</li>
        <li>
            <a href="/audit/logs" id="nav-audit">
                <i class="fas fa-history"></i> Audit & Trace Log
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
