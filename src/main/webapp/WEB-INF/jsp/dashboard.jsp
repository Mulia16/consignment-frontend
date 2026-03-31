<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="title" value="Dashboard"/>
</jsp:include>
<jsp:include page="common/sidebar.jsp">
    <jsp:param name="pageTitle" value="Dashboard"/>
</jsp:include>

<main class="main-content fade-in">

    <!-- Welcome -->
    <div class="content-header">
        <div>
            <h5><i class="fas fa-tachometer-alt mr-2 text-primary"></i>Dashboard</h5>
            <small class="text-muted">Overview Consignment System</small>
        </div>
        <span class="badge badge-pill badge-light shadow-sm px-3 py-2">
            <i class="fas fa-calendar-alt mr-1"></i>
            <span id="currentDate"></span>
        </span>
    </div>

    <!-- Stat Cards -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-3">
            <div class="stat-card bg-primary-gradient">
                <div class="stat-value" id="totalProducts">-</div>
                <div class="stat-label">Total Products</div>
                <i class="fas fa-boxes stat-icon"></i>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-3">
            <div class="stat-card bg-success-gradient">
                <div class="stat-value" id="totalStock">-</div>
                <div class="stat-label">Stock Items</div>
                <i class="fas fa-cubes stat-icon"></i>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-3">
            <div class="stat-card bg-warning-gradient">
                <div class="stat-value" id="totalPO">-</div>
                <div class="stat-label">Purchase Orders</div>
                <i class="fas fa-file-invoice stat-icon"></i>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-3">
            <div class="stat-card bg-info-gradient">
                <div class="stat-value" id="totalSettlement">-</div>
                <div class="stat-label">Settlements</div>
                <i class="fas fa-handshake stat-icon"></i>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="row">
        <div class="col-lg-6 mb-4">
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-bolt mr-2 text-warning"></i>Quick Actions
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-6 mb-3">
                            <a href="/inbound/purchase-orders" class="btn btn-outline-primary btn-block py-3">
                                <i class="fas fa-plus-circle d-block mb-1 fa-lg"></i>
                                <small>New PO</small>
                            </a>
                        </div>
                        <div class="col-6 mb-3">
                            <a href="/inbound/goods-receipt" class="btn btn-outline-success btn-block py-3">
                                <i class="fas fa-clipboard-check d-block mb-1 fa-lg"></i>
                                <small>Goods Receipt</small>
                            </a>
                        </div>
                        <div class="col-6 mb-3">
                            <a href="/outbound/sales-orders" class="btn btn-outline-info btn-block py-3">
                                <i class="fas fa-file-invoice-dollar d-block mb-1 fa-lg"></i>
                                <small>Sales Order</small>
                            </a>
                        </div>
                        <div class="col-6 mb-3">
                            <a href="/pos/transactions" class="btn btn-outline-warning btn-block py-3">
                                <i class="fas fa-cash-register d-block mb-1 fa-lg"></i>
                                <small>POS Sales</small>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6 mb-4">
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-link mr-2 text-info"></i>Service Status
                </div>
                <div class="card-body p-0">
                    <table class="table table-sm mb-0">
                        <tbody id="serviceStatusBody">
                            <tr><td><i class="fas fa-circle text-muted mr-2" style="font-size:8px"></i> Master Data</td><td class="text-right"><span class="badge badge-secondary">Checking...</span></td></tr>
                            <tr><td><i class="fas fa-circle text-muted mr-2" style="font-size:8px"></i> Inventory</td><td class="text-right"><span class="badge badge-secondary">Checking...</span></td></tr>
                            <tr><td><i class="fas fa-circle text-muted mr-2" style="font-size:8px"></i> Inbound</td><td class="text-right"><span class="badge badge-secondary">Checking...</span></td></tr>
                            <tr><td><i class="fas fa-circle text-muted mr-2" style="font-size:8px"></i> Settlement</td><td class="text-right"><span class="badge badge-secondary">Checking...</span></td></tr>
                            <tr><td><i class="fas fa-circle text-muted mr-2" style="font-size:8px"></i> Reports</td><td class="text-right"><span class="badge badge-secondary">Checking...</span></td></tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</main>

<jsp:include page="common/footer.jsp"/>
<script src="/static/js/dashboard.js"></script>
<script>
    // Set current date
    $('#currentDate').text(new Date().toLocaleDateString('id-ID', { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' }));
</script>
