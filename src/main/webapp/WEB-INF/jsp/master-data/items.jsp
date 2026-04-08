<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Items"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Item Management"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div>
            <h5><i class="fas fa-boxes mr-2 text-primary"></i>Items</h5>
            <small class="text-muted">Master Data / Items</small>
        </div>
    </div>

    <div class="card">
        <div class="card-header bg-white">
            <div class="row align-items-center">
                <div class="col-md-2">
                    <label class="mb-0 small">Company</label>
                    <select class="form-control form-control-sm" id="filterCompany" onchange="onCompanyChange()">
                        <option value="">Select Company</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="mb-0 small">Store</label>
                    <select class="form-control form-control-sm" id="filterStore" onchange="onStoreChange()" disabled>
                        <option value="">Select Store</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="mb-0 small">Supplier</label>
                    <select class="form-control form-control-sm" id="filterSupplier" onchange="onSupplierChange()" disabled>
                        <option value="">Select Supplier</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="mb-0 small">Contract</label>
                    <select class="form-control form-control-sm" id="filterContract" onchange="loadData()" disabled>
                        <option value="">Select Contract</option>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button class="btn btn-sm btn-outline-secondary mr-2" onclick="resetFilters()">
                        <i class="fas fa-redo mr-1"></i>Reset
                    </button>
                </div>
            </div>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="itemsTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Item Code</th>
                        <th>Company</th>
                        <th>Store</th>
                        <th>Supplier</th>
                        <th>Contract</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td colspan="6" class="text-center py-4 text-muted">Select filters to load items</td></tr>
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
var currentCompany = '';
var currentStore = '';
var currentSupplier = '';
var currentContract = '';

document.addEventListener('configLoaded', function() {
    if (!Auth.requireAuth()) return;
    initFilters();
});

async function initFilters() {
    try {
        // Load companies for filter dropdown
        var response = await ApiClient.get('CONSIGNMENT', '/master-data/companies');
        var companies = response.data || response || [];
        
        var options = '<option value="">Select Company</option>';
        companies.forEach(function(company) {
            options += '<option value="' + company + '">' + company + '</option>';
        });
        $('#filterCompany').html(options);
        
        // Check URL params for pre-selected values
        var urlParams = new URLSearchParams(window.location.search);
        var companyParam = urlParams.get('company');
        var storeParam = urlParams.get('store');
        var supplierParam = urlParams.get('supplierCode');
        var contractParam = urlParams.get('supplierContract');
        
        if (companyParam) {
            $('#filterCompany').val(companyParam);
            await onCompanyChange();
            if (storeParam) {
                $('#filterStore').val(storeParam);
                await onStoreChange();
                if (supplierParam) {
                    $('#filterSupplier').val(supplierParam);
                    await onSupplierChange();
                    if (contractParam) {
                        $('#filterContract').val(contractParam);
                        loadData();
                    }
                }
            }
        }
    } catch (e) {
        console.error('Failed to initialize filters:', e);
    }
}

async function onCompanyChange() {
    var company = $('#filterCompany').val();
    $('#filterStore').html('<option value="">Select Store</option>').prop('disabled', !company);
    $('#filterSupplier').html('<option value="">Select Supplier</option>').prop('disabled', true);
    $('#filterContract').html('<option value="">Select Contract</option>').prop('disabled', true);
    $('#itemsTable tbody').html('<tr><td colspan="6" class="text-center py-4 text-muted">Select Store</td></tr>');
    $('#totalInfo').text('Showing 0 of 0 records');
    $('#paginationContainer').empty();
    
    if (company) {
        try {
            var response = await ApiClient.get('CONSIGNMENT', '/master-data/stores?company=' + encodeURIComponent(company));
            var stores = response.data || response || [];
            
            var options = '<option value="">Select Store</option>';
            stores.forEach(function(store) {
                options += '<option value="' + store + '">' + store + '</option>';
            });
            $('#filterStore').html(options);
        } catch (e) {
            console.error('Failed to load stores:', e);
        }
    }
}

async function onStoreChange() {
    var company = $('#filterCompany').val();
    var store = $('#filterStore').val();
    $('#filterSupplier').html('<option value="">Select Supplier</option>').prop('disabled', !store);
    $('#filterContract').html('<option value="">Select Contract</option>').prop('disabled', true);
    $('#itemsTable tbody').html('<tr><td colspan="6" class="text-center py-4 text-muted">Select Supplier</td></tr>');
    $('#totalInfo').text('Showing 0 of 0 records');
    $('#paginationContainer').empty();
    
    if (company && store) {
        try {
            var response = await ApiClient.get('CONSIGNMENT', '/master-data/suppliers?company=' + encodeURIComponent(company) + '&store=' + encodeURIComponent(store));
            var suppliers = response.data || response || [];
            
            var options = '<option value="">Select Supplier</option>';
            suppliers.forEach(function(supplier) {
                options += '<option value="' + supplier + '">' + supplier + '</option>';
            });
            $('#filterSupplier').html(options);
        } catch (e) {
            console.error('Failed to load suppliers:', e);
        }
    }
}

async function onSupplierChange() {
    var company = $('#filterCompany').val();
    var store = $('#filterStore').val();
    var supplier = $('#filterSupplier').val();
    $('#filterContract').html('<option value="">Select Contract</option>').prop('disabled', !supplier);
    $('#itemsTable tbody').html('<tr><td colspan="6" class="text-center py-4 text-muted">Select Contract</td></tr>');
    $('#totalInfo').text('Showing 0 of 0 records');
    $('#paginationContainer').empty();
    
    if (company && store && supplier) {
        try {
            var response = await ApiClient.get('CONSIGNMENT', '/master-data/contracts?company=' + encodeURIComponent(company) + '&store=' + encodeURIComponent(store) + '&supplierCode=' + encodeURIComponent(supplier));
            var contracts = response.data || response || [];
            
            var options = '<option value="">Select Contract</option>';
            contracts.forEach(function(contract) {
                options += '<option value="' + contract + '">' + contract + '</option>';
            });
            $('#filterContract').html(options);
        } catch (e) {
            console.error('Failed to load contracts:', e);
        }
    }
}

async function loadData() {
    currentCompany = $('#filterCompany').val();
    currentStore = $('#filterStore').val();
    currentSupplier = $('#filterSupplier').val();
    currentContract = $('#filterContract').val();
    
    if (!currentCompany || !currentStore || !currentSupplier || !currentContract) {
        $('#itemsTable tbody').html('<tr><td colspan="6" class="text-center py-4 text-muted">Please select all filters</td></tr>');
        $('#totalInfo').text('Showing 0 of 0 records');
        $('#paginationContainer').empty();
        return;
    }
    
    try {
        var url = '/master-data/items?company=' + encodeURIComponent(currentCompany) + 
                  '&store=' + encodeURIComponent(currentStore) + 
                  '&supplierCode=' + encodeURIComponent(currentSupplier) +
                  '&supplierContract=' + encodeURIComponent(currentContract);
        var response = await ApiClient.get('CONSIGNMENT', url);
        allData = response.data || response || [];
        renderPage(0);
    } catch (e) {
        $('#itemsTable tbody').html('<tr><td colspan="6" class="text-center text-muted py-4">Failed to load data</td></tr>');
        console.error('Failed to load items:', e);
    }
}

function renderPage(page) {
    currentPage = page;
    var totalRecords = allData.length;
    var totalPages = Math.ceil(totalRecords / perPage);
    var startIdx = page * perPage;
    var endIdx = Math.min(startIdx + perPage, totalRecords);
    var pageData = allData.slice(startIdx, endIdx);
    
    renderTable(pageData, currentCompany, currentStore, currentSupplier, currentContract, startIdx);
    
    var from = totalRecords > 0 ? startIdx + 1 : 0;
    var to = endIdx;
    $('#totalInfo').text('Showing ' + from + '-' + to + ' of ' + totalRecords + ' records');
    
    if (totalPages > 1) {
        AppUtils.buildPagination('paginationContainer', currentPage, totalPages, renderPage);
    } else {
        $('#paginationContainer').empty();
    }
}

function renderTable(items, company, store, supplier, contract, startIdx) {
    if (!items || items.length === 0) {
        $('#itemsTable tbody').html('<tr><td colspan="6" class="text-center text-muted py-4">No data available</td></tr>');
        return;
    }
    
    var html = '';
    items.forEach(function(item, index) {
        html += '<tr>' +
            '<td>' + (startIdx + index + 1) + '</td>' +
            '<td><span class="font-weight-semibold text-primary">' + item + '</span></td>' +
            '<td>' + company + '</td>' +
            '<td>' + store + '</td>' +
            '<td>' + supplier + '</td>' +
            '<td>' + contract + '</td>' +
        '</tr>';
    });
    $('#itemsTable tbody').html(html);
}

function resetFilters() {
    $('#filterCompany').val('');
    $('#filterStore').html('<option value="">Select Store</option>').prop('disabled', true);
    $('#filterSupplier').html('<option value="">Select Supplier</option>').prop('disabled', true);
    $('#filterContract').html('<option value="">Select Contract</option>').prop('disabled', true);
    $('#itemsTable tbody').html('<tr><td colspan="6" class="text-center py-4 text-muted">Select filters to load items</td></tr>');
    $('#totalInfo').text('Showing 0 of 0 records');
    $('#paginationContainer').empty();
}
</script>
