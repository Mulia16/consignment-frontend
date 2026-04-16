<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consignment Stock Receiving</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
<div class="main-content">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="pageTitle" value="Consignment Stock Receiving"/>
    </jsp:include>

    <div class="container-fluid mt-3">
        <!-- Breadcrumb & Top Actions -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                    <li class="breadcrumb-item">Consignment</li>
                    <li class="breadcrumb-item">Transaction</li>
                    <li class="breadcrumb-item active" aria-current="page">Consignment Stock Receiving</li>
                </ol>
            </nav>
            <button class="btn btn-sm btn-primary" onclick="window.location.href='/consignment/receiving/details'">
                <i class="fas fa-plus mr-1"></i> Add New
            </button>
        </div>

        <!-- Filter & Search -->
        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-white font-weight-bold">
                <i class="fas fa-filter mr-2"></i> Filter & Search
            </div>
            <div class="card-body">
                <form id="filterForm">
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Company</label>
                            <select class="form-control form-control-sm" name="company" id="company">
                                <option value="">All Companies</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Receiving Store</label>
                            <select class="form-control form-control-sm" name="receivingStore" id="store">
                                <option value="">All Stores</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Consignment Stock Receiving Number</label>
                            <input type="text" class="form-control form-control-sm" name="docNo">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Status</label>
                            <select class="form-control form-control-sm" name="status">
                                <option value="">Select Status</option>
                                <option value="HELD">Held</option>
                                <option value="RELEASED">Released</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Create Method</label>
                            <select class="form-control form-control-sm" name="createdMethod">
                                <option value="">Select</option>
                                <option value="MANUAL">Manual</option>
                                <option value="AUTO">Trigger from ACMM through API</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Reference Number</label>
                            <input type="text" class="form-control form-control-sm" name="referenceNo">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Item Code</label>
                            <div class="input-group input-group-sm">
                                <input type="text" class="form-control" name="itemCode">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                           <!-- Placeholder for spacing -->
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Created By</label>
                            <input type="text" class="form-control form-control-sm" name="createdBy">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Created Date</label>
                            <div class="input-group input-group-sm">
                                <input type="date" class="form-control" name="createdDateFrom">
                                <input type="date" class="form-control" name="createdDateTo">
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Supplier</label>
                            <select class="form-control form-control-sm" name="supplierCode" id="supplierCode">
                                <option value="">All Suppliers</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Supplier Contract</label>
                            <select class="form-control form-control-sm" name="supplierContract" id="supplierContract">
                                <option value="">All Contracts</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Branch</label>
                            <input type="text" class="form-control form-control-sm" name="branch">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Supplier DO Number</label>
                            <input type="text" class="form-control form-control-sm" name="supplierDoNo">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Delivery Date</label>
                            <div class="input-group input-group-sm">
                                <input type="date" class="form-control" name="deliveryDateFrom">
                                <input type="date" class="form-control" name="deliveryDateTo">
                            </div>
                        </div>
                        <div class="col-md-3 mb-3 d-flex align-items-end justify-content-end">
                            <button type="button" class="btn btn-sm btn-light mr-2" onclick="clearFilter()">Clear Filter</button>
                            <button type="button" class="btn btn-sm btn-primary" onclick="loadData(0)"><i class="fas fa-search mr-1"></i> Search</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Table Result -->
        <div class="card shadow-sm">
            <div class="card-body p-0 table-responsive">
                <table class="table table-hover mb-0 text-sm" id="resultTable">
                    <thead class="bg-light">
                        <tr>
                            <th width="40" class="text-center"><input type="checkbox" id="selectAll"></th>
                            <th width="40"></th> <!-- Edit Icon Column -->
                            <th>Consignment Stock<br>Receiving Number</th>
                            <th>Reference Number</th>
                            <th>Supplier</th>
                            <th>Contract</th>
                            <th>Branch</th>
                            <th>Supplier DO Number</th>
                            <th>Created Date</th>
                            <th>Created By</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- JS Render -->
                    </tbody>
                </table>
            </div>
            <div class="card-footer bg-white d-flex justify-content-between align-items-center">
                <small class="text-muted" id="totalInfo">Showing 0 of 0 records</small>
                <div id="paginationContainer"></div>
            </div>
        </div>

        <!-- Bulk Actions -->
        <div class="mt-3 d-flex justify-content-end">
            <button class="btn btn-sm btn-primary font-weight-bold px-4 mr-2" onclick="batchRelease()">Release</button>
            <button class="btn btn-sm btn-primary font-weight-bold px-4 mr-2" onclick="batchPrint()"><i class="fas fa-print mr-1"></i> Print</button>
            <button class="btn btn-sm btn-outline-danger font-weight-bold px-4" onclick="batchDelete()"><i class="fas fa-trash-alt mr-1"></i> Delete</button>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />

<script src="/static/js/consignment-master-data.js"></script>
<script src="/static/js/services/consignment-service.js"></script>

<script>
var currentPage = 0;
var totalRecords = 0;

document.addEventListener('configLoaded', function() {
    ConsignmentMasterData.init();
    loadData(0);

    $('#selectAll').on('change', function() {
        $('.row-checkbox').prop('checked', this.checked);
    });
});

function getFilterParams() {
    var params = {};
    var formData = $('#filterForm').serializeArray();
    formData.forEach(function(field) {
        if (field.value) params[field.name] = field.value;
    });
    return params;
}

function clearFilter() {
    $('#filterForm')[0].reset();
    loadData(0);
}

async function loadData(page) {
    currentPage = page || 0;
    var tbody = $('#resultTable tbody');
    tbody.html('<tr><td colspan="11" class="text-center py-4"><div class="spinner-border text-primary" role="status"><span class="sr-only">Loading...</span></div></td></tr>');
    
    var params = getFilterParams();
    params.page = currentPage + 1; // API uses 1-based page
    params.perPage = 10;

    try {
        var response = await ConsignmentService.searchCSRV(params);
        var data = response.data || [];
        var meta = response.meta || { page: 1, perPage: 20, totalData: 0, totalPage: 1 };
        totalRecords = meta.totalData || 0;

        if (data.length === 0) {
            tbody.html('<tr><td colspan="11" class="text-center py-4 text-muted"><i class="fas fa-inbox fa-2x mb-2 d-block"></i>No records found</td></tr>');
            $('#totalInfo').text('Showing 0 of 0 records');
            $('#paginationContainer').empty();
            return;
        }

        tbody.empty(); // Clear spinner before rendering data

        data.forEach(function(item) {
            var statusBadge = item.status === 'RELEASED' 
                ? '<span class="badge badge-success">Released</span>' 
                : '<span class="badge badge-warning">Held</span>';
            var editIcon = item.status === 'HELD' 
                ? '<a href="/consignment/receiving/details?id=' + item.id + '" class="text-primary" title="Edit"><i class="fas fa-pencil-alt"></i></a>' 
                : '<a href="/consignment/receiving/details?id=' + item.id + '" class="text-secondary" title="View"><i class="fas fa-eye"></i></a>';
            
            var createdDate = item.createdAt ? AppUtils.formatDateTime(item.createdAt) : '-';
            
            var row = '<tr>' +
                '<td class="text-center"><input type="checkbox" class="row-checkbox" value="' + item.id + '" data-status="' + item.status + '"></td>' +
                '<td class="text-center">' + editIcon + '</td>' +
                '<td><a href="/consignment/receiving/details?id=' + item.id + '">' + (item.docNo || '-') + '</a></td>' +
                '<td>' + (item.referenceNo || '-') + '</td>' +
                '<td>' + (item.supplierCode || '-') + '</td>' +
                '<td>' + (item.supplierContract || '-') + '</td>' +
                '<td>' + (item.branch || '-') + '</td>' +
                '<td>' + (item.supplierDoNo || '-') + '</td>' +
                '<td>' + createdDate + '</td>' +
                '<td>' + (item.createdBy || '-') + '</td>' +
                '<td>' + statusBadge + '</td>' +
                '</tr>';
            tbody.append(row);
        });

        var from = (meta.page - 1) * meta.perPage + 1;
        var to = Math.min(meta.page * meta.perPage, meta.totalData);
        $('#totalInfo').text('Showing ' + from + '-' + to + ' of ' + meta.totalData + ' records');

        AppUtils.buildPagination('paginationContainer', currentPage, meta.totalPage, loadData);
    } catch (error) {
        console.error('Error loading CSRV data:', error);
        tbody.html('<tr><td colspan="11" class="text-center py-4 text-danger"><i class="fas fa-exclamation-triangle fa-2x mb-2 d-block"></i>Failed to load data. Please try again.</td></tr>');
    }
}

function getSelectedIds() {
    var ids = [];
    $('.row-checkbox:checked').each(function() { ids.push($(this).val()); });
    return ids;
}

async function batchRelease() {
    var selected = $('.row-checkbox:checked');
    if (selected.length === 0) { AppUtils.showToast('Please select at least one document', 'warning'); return; }
    
    var valid = true;
    var ids = [];
    selected.each(function() {
        if($(this).data('status') === 'RELEASED') valid = false;
        ids.push($(this).val());
    });

    if (!valid) { AppUtils.showToast('Cannot release already released documents.', 'danger'); return; }

    if (confirm('Release selected document(s)? System will post stock to supplier inventory.')) {
        var successCount = 0;
        var failCount = 0;
        
        for (var i = 0; i < ids.length; i++) {
            try {
                await ConsignmentService.releaseCSRV(ids[i]);
                successCount++;
            } catch (error) {
                failCount++;
                console.error('Failed to release CSRV ' + ids[i], error);
            }
        }
        
        if (failCount === 0) {
            AppUtils.showToast(successCount + ' document(s) successfully released and inventory posted.', 'success');
        } else {
            AppUtils.showToast(successCount + ' released, ' + failCount + ' failed.', 'warning');
        }
        
        $('#selectAll').prop('checked', false);
        loadData(currentPage);
    }
}

async function batchPrint() {
    var ids = getSelectedIds();
    if (ids.length === 0) { AppUtils.showToast('Please select a document to print', 'warning'); return; }
    AppUtils.showLoading();
    var successCount = 0;
    for (var i = 0; i < ids.length; i++) {
        try {
            await ConsignmentService.printCSRVSlip(ids[i]);
            successCount++;
            if (i < ids.length - 1) await new Promise(function(r) { setTimeout(r, 500); });
        } catch (e) {
            console.error('Print error for ID ' + ids[i] + ':', e);
        }
    }
    AppUtils.hideLoading();
    if (successCount > 0) {
        AppUtils.showToast(successCount + ' PDF slip(s) downloaded successfully', 'success');
    }
}

function batchDelete() {
    var selected = $('.row-checkbox:checked');
    if (selected.length === 0) { AppUtils.showToast('Please select at least one document to delete', 'warning'); return; }
    
    var valid = true;
    selected.each(function() {
        if($(this).data('status') === 'RELEASED') valid = false;
    });

    if (!valid) { AppUtils.showToast('Cannot delete released documents.', 'danger'); return; }

    if (confirm('Delete selected HELD document(s)?')) {
        // Delete is not available in the current API, show info message
        AppUtils.showToast('Delete functionality is not yet available via API.', 'info');
    }
}
</script>

<style>
.text-sm { font-size: 0.85rem; }
.card-header { padding: 0.75rem 1.25rem; font-size: 0.95rem; }
.form-control-sm { height: calc(1.5em + 0.5rem + 2px); }
</style>

</body>
</html>
