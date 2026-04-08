<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Stores"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Store Management"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div>
            <h5><i class="fas fa-store mr-2 text-primary"></i>Stores</h5>
            <small class="text-muted">Master Data / Stores</small>
        </div>
    </div>

    <div class="card">
        <div class="card-header bg-white">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h6 class="mb-0"><i class="fas fa-filter mr-2 text-info"></i>Filter by Company</h6>
                </div>
                <div class="col-md-6">
                    <select class="form-control form-control-sm" id="filterCompany" onchange="loadData()">
                        <option value="">All Companies</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="storesTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Store Code</th>
                        <th>Company</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td colspan="4" class="text-center py-4 text-muted">Loading...</td></tr>
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

document.addEventListener('configLoaded', function() {
    if (!Auth.requireAuth()) return;
    initFilters();
});

async function initFilters() {
    try {
        // Load companies for filter dropdown
        var response = await ApiClient.get('CONSIGNMENT', '/master-data/companies');
        var companies = response.data || response || [];
        
        var options = '<option value="">All Companies</option>';
        companies.forEach(function(company) {
            options += '<option value="' + company + '">' + company + '</option>';
        });
        $('#filterCompany').html(options);
        
        // Check URL params for pre-selected company
        var urlParams = new URLSearchParams(window.location.search);
        var companyParam = urlParams.get('company');
        if (companyParam) {
            $('#filterCompany').val(companyParam);
        }
        
        loadData();
    } catch (e) {
        console.error('Failed to load companies:', e);
        loadData();
    }
}

async function loadData() {
    currentCompany = $('#filterCompany').val();
    
    try {
        var url = '/master-data/stores';
        if (currentCompany) {
            url += '?company=' + encodeURIComponent(currentCompany);
        }
        var response = await ApiClient.get('CONSIGNMENT', url);
        allData = response.data || response || [];
        renderPage(0);
    } catch (e) {
        $('#storesTable tbody').html('<tr><td colspan="4" class="text-center text-muted py-4">Failed to load data</td></tr>');
        console.error('Failed to load stores:', e);
    }
}

function renderPage(page) {
    currentPage = page;
    var totalRecords = allData.length;
    var totalPages = Math.ceil(totalRecords / perPage);
    var startIdx = page * perPage;
    var endIdx = Math.min(startIdx + perPage, totalRecords);
    var pageData = allData.slice(startIdx, endIdx);
    
    renderTable(pageData, currentCompany, startIdx);
    
    var from = totalRecords > 0 ? startIdx + 1 : 0;
    var to = endIdx;
    $('#totalInfo').text('Showing ' + from + '-' + to + ' of ' + totalRecords + ' records');
    
    if (totalPages > 1) {
        AppUtils.buildPagination('paginationContainer', currentPage, totalPages, renderPage);
    } else {
        $('#paginationContainer').empty();
    }
}

function renderTable(items, company, startIdx) {
    if (!items || items.length === 0) {
        $('#storesTable tbody').html('<tr><td colspan="4" class="text-center text-muted py-4">No data available</td></tr>');
        return;
    }
    
    var html = '';
    items.forEach(function(item, index) {
        html += '<tr>' +
            '<td>' + (startIdx + index + 1) + '</td>' +
            '<td><span class="font-weight-semibold">' + item + '</span></td>' +
            '<td>' + (company || '-') + '</td>' +
            '<td class="text-center">' +
                '<button class="btn btn-sm btn-outline-info btn-action" title="View Suppliers" onclick="viewSuppliers(\'' + company + '\', \'' + item + '\')">' +
                    '<i class="fas fa-truck"></i>' +
                '</button>' +
            '</td>' +
        '</tr>';
    });
    $('#storesTable tbody').html(html);
}

function viewSuppliers(company, store) {
    window.location.href = '/master-data/suppliers?company=' + encodeURIComponent(company) + '&store=' + encodeURIComponent(store);
}
</script>
