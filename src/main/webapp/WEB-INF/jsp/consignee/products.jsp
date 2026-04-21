<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Products"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Products"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div>
            <h5><i class="fas fa-boxes mr-2 text-primary"></i>Products</h5>
            <small class="text-muted">View product catalog</small>
        </div>
    </div>

    <div class="card">
        <div class="card-header bg-white">
            <div class="row align-items-center">
                <div class="col-md-3">
                    <label class="mb-0 small">Search</label>
                    <input type="text" class="form-control form-control-sm" id="searchInput"
                           placeholder="Search by item code or name..." oninput="onSearch()">
                </div>
                <div class="col-md-2">
                    <label class="mb-0 small">Store</label>
                    <select class="form-control form-control-sm" id="filterStore" onchange="loadData()">
                        <option value="">All Stores</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="mb-0 small">Supplier</label>
                    <select class="form-control form-control-sm" id="filterSupplier" onchange="loadData()">
                        <option value="">All Suppliers</option>
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
            <table class="table table-hover mb-0" id="productsTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Item Code</th>
                        <th>Item Name</th>
                        <th>Variant</th>
                        <th>Supplier Code</th>
                        <th>Supplier Contract</th>
                        <th>Consignee Store</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td colspan="7" class="text-center py-4 text-muted">Loading data...</td></tr>
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
    loadFilters();
    loadData();
});

async function loadFilters() {
    // Optionally load store/supplier filter options from API
    // For now, filters will be populated from data
}

async function loadData() {
    try {
        var response = await ApiClient.get('CONSIGNMENT', '/consignee/products');
        allData = response.data || response || [];
        filteredData = allData.slice();
        populateFilters();
        renderPage(0);
    } catch (e) {
        $('#productsTable tbody').html('<tr><td colspan="7" class="text-center text-muted py-4">Failed to load data</td></tr>');
        console.error('Failed to load products:', e);
    }
}

async function syncData() {
    var $btn = $('#btnSync');
    $btn.prop('disabled', true).html('<span class="spinner-border spinner-border-sm mr-1"></span>Syncing...');

    try {
        var response = await ApiClient.post('CONSIGNMENT', '/consignee/products/sync');
        AppUtils.showToast('Products synced successfully', 'success');
        // Reload data after sync
        await loadData();
    } catch (e) {
        AppUtils.showToast('Failed to sync products: ' + e.message, 'danger');
        console.error('Sync error:', e);
    } finally {
        $btn.prop('disabled', false).html('<i class="fas fa-cloud-download-alt mr-1"></i>Re-sync');
    }
}

function populateFilters() {
    // Extract unique stores
    var stores = {};
    var suppliers = {};
    allData.forEach(function(item) {
        if (item.consigneeStore) stores[item.consigneeStore] = true;
        if (item.supplierCode) suppliers[item.supplierCode] = true;
    });

    var currentStore = $('#filterStore').val();
    var currentSupplier = $('#filterSupplier').val();

    var storeOptions = '<option value="">All Stores</option>';
    Object.keys(stores).sort().forEach(function(store) {
        storeOptions += '<option value="' + store + '">' + store + '</option>';
    });
    $('#filterStore').html(storeOptions).val(currentStore);

    var supplierOptions = '<option value="">All Suppliers</option>';
    Object.keys(suppliers).sort().forEach(function(supplier) {
        supplierOptions += '<option value="' + supplier + '">' + supplier + '</option>';
    });
    $('#filterSupplier').html(supplierOptions).val(currentSupplier);
}

function onSearch() {
    applyFilters();
}

function applyFilters() {
    var search = ($('#searchInput').val() || '').toLowerCase();
    var store = $('#filterStore').val();
    var supplier = $('#filterSupplier').val();

    filteredData = allData.filter(function(item) {
        var matchSearch = !search ||
            (item.itemCode && item.itemCode.toLowerCase().indexOf(search) !== -1) ||
            (item.itemName && item.itemName.toLowerCase().indexOf(search) !== -1);
        var matchStore = !store || item.consigneeStore === store;
        var matchSupplier = !supplier || item.supplierCode === supplier;
        return matchSearch && matchStore && matchSupplier;
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
        $('#productsTable tbody').html('<tr><td colspan="7" class="text-center text-muted py-4">No data available</td></tr>');
        return;
    }

    var html = '';
    items.forEach(function(item, index) {
        var statusBadge = '<span class="badge badge-light">' + AppUtils.escapeHtml(item.variant || '-') + '</span>';
        html += '<tr>' +
            '<td>' + (startIdx + index + 1) + '</td>' +
            '<td><span class="font-weight-semibold text-primary">' + AppUtils.escapeHtml(item.itemCode || '-') + '</span></td>' +
            '<td>' + AppUtils.escapeHtml(item.itemName || '-') + '</td>' +
            '<td>' + statusBadge + '</td>' +
            '<td>' + AppUtils.escapeHtml(item.supplierCode || '-') + '</td>' +
            '<td>' + AppUtils.escapeHtml(item.supplierContract || '-') + '</td>' +
            '<td>' + AppUtils.escapeHtml(item.consigneeStore || '-') + '</td>' +
        '</tr>';
    });
    $('#productsTable tbody').html(html);
}

function resetFilters() {
    $('#searchInput').val('');
    $('#filterStore').val('');
    $('#filterSupplier').val('');
    filteredData = allData.slice();
    renderPage(0);
}
</script>
