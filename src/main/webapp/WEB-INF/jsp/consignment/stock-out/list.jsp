<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consignment Stock Out</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
<div class="main-content">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="pageTitle" value="Consignment Stock Out"/>
    </jsp:include>

    <div class="container-fluid mt-3">
        <!-- Breadcrumb & Top Actions -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                    <li class="breadcrumb-item">Consignment</li>
                    <li class="breadcrumb-item">Transaction</li>
                    <li class="breadcrumb-item active" aria-current="page">Consignment Stock Out</li>
                </ol>
            </nav>
            <button class="btn btn-primary" onclick="window.location.href='/consignment/stock-out/details'"><i class="fas fa-plus"></i> Add New</button>
        </div>

        <!-- Filter Panel -->
        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-white font-weight-bold" data-toggle="collapse" data-target="#filterCollapse" style="cursor: pointer;">
                <i class="fas fa-filter mr-2"></i> Filter & Search
            </div>
            <div id="filterCollapse" class="collapse show">
                <div class="card-body">
                    <form id="filterForm">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Company</label>
                                <select class="form-control" name="company" id="company">
                                    <option value="">All Companies</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Store</label>
                                <select class="form-control" name="store" id="store">
                                    <option value="">All Stores</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Customer</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" name="customer">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button"><i class="fas fa-search-plus"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Customer Branch</label>
                                <input type="text" class="form-control" name="customerBranch">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Status</label>
                                <select class="form-control" name="status">
                                    <option value="">All</option>
                                    <option value="Held">Held</option>
                                    <option value="Released">Released</option>
                                    <option value="Error">Error</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Item Code</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" name="itemCode">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button"><i class="fas fa-search-plus"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Consignment Stock Out Number</label>
                                <input type="text" class="form-control" name="csoNumber">
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Reference Number</label>
                                <input type="text" class="form-control" name="refNumber">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Date</label>
                                <div class="input-group">
                                    <input type="date" class="form-control" name="dateFrom" placeholder="From">
                                    <input type="date" class="form-control" name="dateTo" placeholder="To">
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Created By</label>
                                <input type="text" class="form-control" name="createdBy">
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Released Date</label>
                                <div class="input-group">
                                    <input type="date" class="form-control" name="relDateFrom" placeholder="From">
                                    <input type="date" class="form-control" name="relDateTo" placeholder="To">
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Released By</label>
                                <input type="text" class="form-control" name="releasedBy">
                            </div>
                        </div>

                        <div class="d-flex justify-content-end mt-2">
                            <button type="button" class="btn btn-outline-secondary mr-2" onclick="document.getElementById('filterForm').reset()">Clear Filter</button>
                            <button type="button" class="btn btn-primary" onclick="searchData()"><i class="fas fa-search"></i> Search</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Data Table -->
        <div class="card shadow-sm">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="bg-light">
                            <tr>
                                <th width="40"><input type="checkbox" id="selectAll" onclick="toggleAll()"></th>
                                <th>Date</th>
                                <th>Store</th>
                                <th>Consignment Stock Out Number</th>
                                <th>Customer / Customer Branch</th>
                                <th>Created By</th>
                                <th>Status</th>
                                <th width="60"></th>
                            </tr>
                        </thead>
                        <tbody id="dataTableBody">
                            <!-- JS Render -->
                        </tbody>
                    </table>
                </div>
                
                <div class="d-flex justify-content-between align-items-center p-3 border-top bg-light">
                    <!-- Bulk Actions -->
                    <div>
                        <button class="btn btn-primary mr-2" onclick="batchRelease()">Release</button>
                        <button class="btn btn-outline-secondary mr-2" onclick="batchPrint()"><i class="fas fa-print"></i> Print</button>
                        <button class="btn btn-outline-danger" onclick="batchDelete()"><i class="fas fa-trash"></i> Delete</button>
                    </div>
                    <div>
                        <small class="text-muted" id="totalInfo">Showing 0 of 0 records</small>
                        <div id="paginationContainer"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
<script src="/static/js/consignment-master-data.js"></script>
<script src="/static/js/services/consignment-service.js?v=2"></script>

<script>
var allData = [];
var currentPage = 0;
var perPage = 10;

document.addEventListener('configLoaded', function() {
    ConsignmentMasterData.init();
    searchData(0);
    $('#nav-consignment-stockout').addClass('active');
    $('#menu-outbound').addClass('active');
});

async function searchData(page) {
    currentPage = page || 0;
    AppUtils.showLoading();
    var form = document.getElementById('filterForm');
    var formData = new FormData(form);
    var params = new URLSearchParams();
    
    for (var pair of formData.entries()) {
        var key = pair[0];
        var value = pair[1];
        if (value && value.trim() !== '') {
            // Map specific UI fields to Postman backend fields if needed
            if (key === 'customer') key = 'customerCode';
            
            params.append(key, value.trim());
        }
    }
    
    // Add pagination parameters
    params.append('page', currentPage + 1);
    params.append('perPage', perPage);
    
    var qs = params.toString() ? '?' + params.toString() : '';
    
    try {
        var res = await ApiClient.get('CONSIGNMENT', '/cso' + qs);
        var data = [];
        var meta = res.meta || { page: 1, perPage: perPage, totalData: 0, totalPage: 1 };
        // The mock ApiClient might return data inside .data or just directly an array or object
        // Based on Postman, the API returns {"items": [...]} or something, wait no, Search CSO doesn't have response example for list. 
        // Postman only shows Get CSO by ID. Let's assume response.data is the list or the response is a list.
        if (res.data && Array.isArray(res.data)) {
            data = res.data;
        } else if (res.items && Array.isArray(res.items)) {
            data = res.items;
        } else if (Array.isArray(res)) {
            data = res;
        }
        
        // Map API response to table fields if necessary
        allData = data.map(item => ({
            id: item.id || item.docNo,
            date: item.createdAt ? item.createdAt.substring(0, 10) : '-',
            store: item.store || '-',
            csoNo: item.docNo || '-',
            customer: item.customerCode || '-',
            branch: item.customerBranch || '-',
            createdBy: item.createdBy || '-',
            status: item.status ? item.status.charAt(0).toUpperCase() + item.status.slice(1).toLowerCase() : 'Held'
        }));
        renderTable(allData, meta);
    } catch (e) {
        console.error(e);
        AppUtils.showToast('Failed to load data', 'danger');
        renderTable([], { page: 1, perPage: perPage, totalData: 0, totalPage: 1 });
    } finally {
        AppUtils.hideLoading();
    }
}

function renderTable(data, meta) {
    var tbody = $('#dataTableBody');
    tbody.empty();
    
    if (data.length === 0) {
        tbody.append('<tr><td colspan="8" class="text-center py-4">No records found.</td></tr>');
        $('#totalInfo').text('Showing 0 of 0 records');
        $('#paginationContainer').empty();
        return;
    }
    
    data.forEach(function(row) {
        var badgeClass = '';
        if (row.status === 'Held') badgeClass = 'badge-warning';
        else if (row.status === 'Released') badgeClass = 'badge-success';
        else if (row.status === 'Error') badgeClass = 'badge-danger';
        
        var showEdit = row.status === 'Held';
        
        var actionHtml = showEdit ? 
            '<a href="/consignment/stock-out/details?id=' + row.id + '"><i class="fas fa-edit text-primary"></i></a>' : 
            '<a href="/consignment/stock-out/details?id=' + row.id + '"><i class="fas fa-eye text-primary"></i></a>';
            
        var tr = `<tr>
            <td><input type="checkbox" class="row-checkbox" value="\${row.id}"></td>
            <td>\${row.date}</td>
            <td class="text-primary font-weight-bold">\${row.store}</td>
            <td>\${row.csoNo}</td>
            <td>
                <div>\${row.customer}</div>
                <small class="text-muted">\${row.branch}</small>
            </td>
            <td>\${row.createdBy}</td>
            <td><span class="badge \${badgeClass}">\${row.status}</span></td>
            <td>\${actionHtml}</td>
        </tr>`;
        tbody.append(tr);
    });
    
    // Update pagination info
    var from = (meta.page - 1) * meta.perPage + 1;
    var to = Math.min(meta.page * meta.perPage, meta.totalData);
    $('#totalInfo').text('Showing ' + from + '-' + to + ' of ' + meta.totalData + ' records');
    
    // Build pagination
    if (meta.totalPage > 1) {
        AppUtils.buildPagination('paginationContainer', currentPage, meta.totalPage, searchData);
    } else {
        $('#paginationContainer').empty();
    }
}

function toggleAll() {
    var isChecked = $('#selectAll').prop('checked');
    $('.row-checkbox').prop('checked', isChecked);
}

function getSelectedIds() {
    var ids = [];
    $('.row-checkbox:checked').each(function() {
        ids.push($(this).val());
    });
    return ids;
}

function batchRelease() {
    var ids = getSelectedIds();
    if (ids.length === 0) { AppUtils.showToast('Please select at least one document', 'warning'); return; }
    
    // Check if any selected is already Released or Error
    var isValid = true;
    allData.forEach(function(d) {
        if(ids.includes(d.id.toString()) && d.status.toUpperCase() !== 'HELD') {
            isValid = false;
        }
    });

    if(!isValid) {
        AppUtils.showToast('Only HELD documents can be released.', 'warning');
        return;
    }

    if (confirm('Are you sure you want to release the selected ' + ids.length + ' document(s)?')) {
        AppUtils.showLoading();
        
        Promise.all(ids.map(id => ApiClient.put('CONSIGNMENT', `/cso/${id}/release`)))
            .then(() => {
                AppUtils.showToast('Documents successfully released.', 'success');
                searchData(currentPage); // Refresh list
                $('#selectAll').prop('checked', false);
            })
            .catch(e => {
                console.error(e);
                AppUtils.showToast('Error releasing documents', 'danger');
            })
            .finally(() => AppUtils.hideLoading());
    }
}

function batchDelete() {
    var ids = getSelectedIds();
    if (ids.length === 0) { AppUtils.showToast('Please select at least one document', 'warning'); return; }
    
    // According to reqs: Only allow delete for "Held" or "Error" status document
    var isValid = true;
    allData.forEach(function(d) {
        if(ids.includes(d.id.toString()) && d.status.toUpperCase() === 'RELEASED') {
            isValid = false;
        }
    });

    if(!isValid) {
        AppUtils.showToast('Cannot delete RELEASED documents.', 'warning');
        return;
    }

    if (confirm('Confirm delete selected ' + ids.length + ' document(s)?')) {
        AppUtils.showLoading();
        
        Promise.all(ids.map(id => ApiClient.delete('CONSIGNMENT', `/cso/${id}`)))
            .then(() => {
                AppUtils.showToast('Documents successfully deleted.', 'success');
                searchData(currentPage);
                $('#selectAll').prop('checked', false);
            })
            .catch(e => {
                console.error(e);
                AppUtils.showToast('Error deleting documents', 'danger');
            })
            .finally(() => AppUtils.hideLoading());
    }
}

async function batchPrint() {
    var ids = getSelectedIds();
    if (ids.length === 0) { AppUtils.showToast('Please select a document to print', 'warning'); return; }
    AppUtils.showLoading();
    var successCount = 0;
    for (var i = 0; i < ids.length; i++) {
        try {
            await ConsignmentService.printCSOSlip(ids[i]);
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
    $('#selectAll').prop('checked', false);
}
</script>

</body>
</html>
