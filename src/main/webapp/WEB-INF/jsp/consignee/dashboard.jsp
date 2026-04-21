<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Dashboard"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Dashboard"/></jsp:include>

<main class="main-content fade-in">

    <!-- Welcome -->
    <div class="content-header">
        <div>
            <h5><i class="fas fa-tachometer-alt mr-2 text-primary"></i>Dashboard</h5>
            <small class="text-muted">Stock Overview</small>
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
                <div class="stat-value" id="totalItems">-</div>
                <div class="stat-label">Total Items</div>
                <i class="fas fa-boxes stat-icon"></i>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-3">
            <div class="stat-card bg-success-gradient">
                <div class="stat-value" id="totalStock">-</div>
                <div class="stat-label">Total Stock</div>
                <i class="fas fa-cubes stat-icon"></i>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-3">
            <div class="stat-card bg-warning-gradient">
                <div class="stat-value" id="totalSales">-</div>
                <div class="stat-label">Total Sales Qty</div>
                <i class="fas fa-chart-line stat-icon"></i>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-3">
            <div class="stat-card bg-info-gradient">
                <div class="stat-value" id="totalStores">-</div>
                <div class="stat-label">Stores</div>
                <i class="fas fa-store stat-icon"></i>
            </div>
        </div>
    </div>

    <!-- Stock Overview Table -->
    <div class="card">
        <div class="card-header bg-white">
            <div class="row align-items-center">
                <div class="col-md-4">
                    <h6 class="mb-0"><i class="fas fa-warehouse mr-2 text-primary"></i>Stock Overview</h6>
                </div>
                <div class="col-md-3">
                    <label class="mb-0 small">Store</label>
                    <select class="form-control form-control-sm" id="filterStore" onchange="applyFilters()">
                        <option value="">All Stores</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="mb-0 small">Search</label>
                    <input type="text" class="form-control form-control-sm" id="searchInput"
                           placeholder="Search item..." oninput="applyFilters()">
                </div>
                <div class="col-md-2 d-flex align-items-end justify-content-end">
                    <button class="btn btn-sm btn-outline-primary" onclick="loadData()">
                        <i class="fas fa-sync-alt mr-1"></i>Refresh
                    </button>
                </div>
            </div>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="stockTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Item Code</th>
                        <th>Item Name</th>
                        <th>Store</th>
                        <th class="text-center">Current Stock</th>
                        <th class="text-center">Sales Qty</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td colspan="6" class="text-center py-4 text-muted">Loading data...</td></tr>
                </tbody>
            </table>
        </div>
        <div class="card-footer bg-white d-flex justify-content-between align-items-center">
            <small class="text-muted" id="totalInfo">Showing 0 of 0 records</small>
            <div id="paginationContainer"></div>
        </div>
    </div>

</main>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
var perPage = 10;
var allData = [];
var filteredData = [];

document.addEventListener('configLoaded', function() {
    if (!Auth.requireAuth()) return;
    loadData();
    $('#currentDate').text(new Date().toLocaleDateString('id-ID', { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' }));
});

async function loadData() {
    try {
        var response = await ApiClient.get('CONSIGNMENT', '/consignee/dashboard');
        allData = response.data || response || [];
        filteredData = allData.slice();
        updateStats();
        populateFilters();
        renderPage(0);
    } catch (e) {
        $('#stockTable tbody').html('<tr><td colspan="6" class="text-center text-muted py-4">Failed to load data</td></tr>');
        console.error('Failed to load dashboard:', e);
    }
}

function updateStats() {
    var totalItems = allData.length;
    var totalStock = 0;
    var totalSales = 0;
    var stores = {};

    allData.forEach(function(item) {
        totalStock += (item.currentStockQty || 0);
        totalSales += (item.salesQty || 0);
        if (item.store) stores[item.store] = true;
    });

    $('#totalItems').text(totalItems);
    $('#totalStock').text(totalStock.toLocaleString('id-ID'));
    $('#totalSales').text(totalSales.toLocaleString('id-ID'));
    $('#totalStores').text(Object.keys(stores).length);
}

function populateFilters() {
    var stores = {};
    allData.forEach(function(item) {
        if (item.store) stores[item.store] = true;
    });

    var currentStore = $('#filterStore').val();
    var storeOptions = '<option value="">All Stores</option>';
    Object.keys(stores).sort().forEach(function(store) {
        storeOptions += '<option value="' + store + '">' + store + '</option>';
    });
    $('#filterStore').html(storeOptions).val(currentStore);
}

function applyFilters() {
    var search = ($('#searchInput').val() || '').toLowerCase();
    var store = $('#filterStore').val();

    filteredData = allData.filter(function(item) {
        var matchSearch = !search ||
            (item.itemCode && item.itemCode.toLowerCase().indexOf(search) !== -1) ||
            (item.itemName && item.itemName.toLowerCase().indexOf(search) !== -1);
        var matchStore = !store || item.store === store;
        return matchSearch && matchStore;
    });

    renderPage(0);
}

function renderPage(page) {
    currentPage = page;
    var totalRecords = filteredData.length;
    var totalPages = Math.ceil(totalRecords / perPage);
    var startIdx = page * perPage;
    var endIdx = Math.min(startIdx + perPage, totalRecords);
    var pageData = filteredData.slice(startIdx, endIdx);

    renderTable(pageData, startIdx);

    var from = totalRecords > 0 ? startIdx + 1 : 0;
    var to = endIdx;
    $('#totalInfo').text('Showing ' + from + '-' + to + ' of ' + totalRecords + ' records');

    if (totalPages > 1) {
        AppUtils.buildPagination('paginationContainer', currentPage, totalPages, renderPage);
    } else {
        $('#paginationContainer').empty();
    }
}

function renderTable(items, startIdx) {
    if (!items || items.length === 0) {
        $('#stockTable tbody').html('<tr><td colspan="6" class="text-center text-muted py-4">No data available</td></tr>');
        return;
    }

    var html = '';
    items.forEach(function(item, index) {
        var stockBadge = getStockBadge(item.currentStockQty);
        html += '<tr>' +
            '<td>' + (startIdx + index + 1) + '</td>' +
            '<td><span class="font-weight-semibold text-primary">' + AppUtils.escapeHtml(item.itemCode || '-') + '</span></td>' +
            '<td>' + AppUtils.escapeHtml(item.itemName || '-') + '</td>' +
            '<td>' + AppUtils.escapeHtml(item.store || '-') + '</td>' +
            '<td class="text-center">' + stockBadge + '</td>' +
            '<td class="text-center">' + (item.salesQty != null ? item.salesQty : '-') + '</td>' +
        '</tr>';
    });
    $('#stockTable tbody').html(html);
}

function getStockBadge(qty) {
    if (qty == null) return '-';
    var badgeClass = 'success';
    if (qty === 0) badgeClass = 'danger';
    else if (qty <= 10) badgeClass = 'warning';
    return '<span class="badge badge-' + badgeClass + '">' + qty.toLocaleString('id-ID') + '</span>';
}
</script>
