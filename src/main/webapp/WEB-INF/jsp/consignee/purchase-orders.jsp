<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Purchase Orders"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Purchase Orders"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div>
            <h5><i class="fas fa-shopping-cart mr-2 text-primary"></i>Purchase Orders</h5>
            <small class="text-muted">View purchase orders</small>
        </div>
    </div>

    <div class="card">
        <div class="card-header bg-white">
            <div class="row align-items-center">
                <div class="col-md-3">
                    <label class="mb-0 small">Search</label>
                    <input type="text" class="form-control form-control-sm" id="searchInput"
                           placeholder="Search by PO number or item..." oninput="onSearch()">
                </div>
                <div class="col-md-2">
                    <label class="mb-0 small">Store</label>
                    <select class="form-control form-control-sm" id="filterStore" onchange="applyFilters()">
                        <option value="">All Stores</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="mb-0 small">Status</label>
                    <select class="form-control form-control-sm" id="filterStatus" onchange="applyFilters()">
                        <option value="">All Status</option>
                        <option value="PENDING">Pending</option>
                        <option value="CONFIRMED">Confirmed</option>
                        <option value="DELIVERED">Delivered</option>
                        <option value="CANCELLED">Cancelled</option>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button class="btn btn-sm btn-outline-secondary mr-2" onclick="resetFilters()">
                        <i class="fas fa-redo mr-1"></i>Reset
                    </button>
                    <button class="btn btn-sm btn-outline-primary mr-2" onclick="loadData()">
                        <i class="fas fa-sync-alt mr-1"></i>Refresh
                    </button>
                    <button class="btn btn-sm btn-success" id="btnSync" onclick="syncData()">
                        <i class="fas fa-cloud-download-alt mr-1"></i>Re-sync
                    </button>
                </div>
            </div>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="poTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>PO Number</th>
                        <th>Store</th>
                        <th>Item Code</th>
                        <th>Item Name</th>
                        <th>Ordered Qty</th>
                        <th>Status</th>
                        <th>PO Date</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td colspan="8" class="text-center py-4 text-muted">Loading data...</td></tr>
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
});

async function loadData() {
    try {
        var response = await ApiClient.get('CONSIGNMENT', '/consignee/purchase-orders');
        allData = response.data || response || [];
        filteredData = allData.slice();
        populateFilters();
        renderPage(0);
    } catch (e) {
        $('#poTable tbody').html('<tr><td colspan="8" class="text-center text-muted py-4">Failed to load data</td></tr>');
        console.error('Failed to load purchase orders:', e);
    }
}

async function syncData() {
    var $btn = $('#btnSync');
    $btn.prop('disabled', true).html('<span class="spinner-border spinner-border-sm mr-1"></span>Syncing...');

    try {
        var response = await ApiClient.post('CONSIGNMENT', '/consignee/purchase-orders/sync');
        AppUtils.showToast('Purchase orders synced successfully', 'success');
        // Reload data after sync
        await loadData();
    } catch (e) {
        AppUtils.showToast('Failed to sync purchase orders: ' + e.message, 'danger');
        console.error('Sync error:', e);
    } finally {
        $btn.prop('disabled', false).html('<i class="fas fa-cloud-download-alt mr-1"></i>Re-sync');
    }
}

function populateFilters() {
    // Extract unique stores from data
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

function onSearch() {
    applyFilters();
}

function applyFilters() {
    var search = ($('#searchInput').val() || '').toLowerCase();
    var store = $('#filterStore').val();
    var status = $('#filterStatus').val();

    filteredData = allData.filter(function(item) {
        var matchSearch = !search ||
            (item.poNumber && item.poNumber.toLowerCase().indexOf(search) !== -1) ||
            (item.itemCode && item.itemCode.toLowerCase().indexOf(search) !== -1) ||
            (item.itemName && item.itemName.toLowerCase().indexOf(search) !== -1);
        var matchStore = !store || item.store === store;
        var matchStatus = !status || item.status === status;
        return matchSearch && matchStore && matchStatus;
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
        $('#poTable tbody').html('<tr><td colspan="8" class="text-center text-muted py-4">No data available</td></tr>');
        return;
    }

    var html = '';
    items.forEach(function(item, index) {
        var statusBadge = getStatusBadge(item.status);
        html += '<tr>' +
            '<td>' + (startIdx + index + 1) + '</td>' +
            '<td><span class="font-weight-semibold text-primary">' + AppUtils.escapeHtml(item.poNumber || '-') + '</span></td>' +
            '<td>' + AppUtils.escapeHtml(item.store || '-') + '</td>' +
            '<td>' + AppUtils.escapeHtml(item.itemCode || '-') + '</td>' +
            '<td>' + AppUtils.escapeHtml(item.itemName || '-') + '</td>' +
            '<td class="text-center">' + (item.orderedQty != null ? item.orderedQty : '-') + '</td>' +
            '<td>' + statusBadge + '</td>' +
            '<td>' + AppUtils.escapeHtml(item.poDate || '-') + '</td>' +
        '</tr>';
    });
    $('#poTable tbody').html(html);
}

function getStatusBadge(status) {
    if (!status) return '-';
    var statusUpper = status.toUpperCase();
    var badgeClass = 'secondary';
    switch (statusUpper) {
        case 'PENDING': badgeClass = 'warning'; break;
        case 'CONFIRMED': badgeClass = 'info'; break;
        case 'DELIVERED': badgeClass = 'success'; break;
        case 'CANCELLED': badgeClass = 'danger'; break;
        case 'COMPLETED': badgeClass = 'success'; break;
        case 'PROCESSING': badgeClass = 'primary'; break;
        default: badgeClass = 'secondary';
    }
    return '<span class="badge badge-' + badgeClass + '">' + AppUtils.escapeHtml(status) + '</span>';
}

function resetFilters() {
    $('#searchInput').val('');
    $('#filterStore').val('');
    $('#filterStatus').val('');
    filteredData = allData.slice();
    renderPage(0);
}
</script>
