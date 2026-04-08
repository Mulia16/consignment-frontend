<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consignment Stock Delivery Order</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
<div class="main-content">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="pageTitle" value="Consignment Stock Delivery Order"/>
    </jsp:include>

    <div class="container-fluid mt-3">
        <!-- Breadcrumb & Top Actions -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                    <li class="breadcrumb-item">Consignment</li>
                    <li class="breadcrumb-item">Transaction</li>
                    <li class="breadcrumb-item active" aria-current="page">Consignment Stock Delivery Order</li>
                </ol>
            </nav>
            <button class="btn btn-primary font-weight-bold" onclick="window.location.href='/consignment/delivery-order/details'">Transfer From...</button>
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
                                <label class="small text-muted mb-1">Consignment Stock Delivery Order Number</label>
                                <input type="text" class="form-control" name="csdoNumber">
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Transfer From (CSO)</label>
                                <input type="text" class="form-control" name="transferFrom">
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
                                <label class="small text-muted mb-1">Shipping Mode</label>
                                <select class="form-control" name="shippingMode">
                                    <option value="">All</option>
                                    <option value="Pickup">Pickup</option>
                                    <option value="Courier">Courier</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Transporter</label>
                                <input type="text" class="form-control" name="transporter">
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Created By</label>
                                <input type="text" class="form-control" name="createdBy">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Reference Number</label>
                                <input type="text" class="form-control" name="refNumber">
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
                    <table class="table table-hover mb-0 text-sm">
                        <thead class="bg-light">
                            <tr>
                                <th width="40"><input type="checkbox" id="selectAll" onclick="toggleAll()"></th>
                                <th>Date</th>
                                <th>Store</th>
                                <th>CSDO Number</th>
                                <th>Transfer From</th>
                                <th width="200">Customer / Branch</th>
                                <th>Shipping Mode</th>
                                <th>Transporter</th>
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
                        <button class="btn btn-warning mr-2" onclick="batchReverse()">Reverse</button>
                        <button class="btn btn-outline-secondary mr-2" onclick="batchPrint()"><i class="fas fa-print"></i> Print</button>
                        <button class="btn btn-outline-danger" onclick="batchDelete()"><i class="fas fa-trash"></i> Delete</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />

<script src="/static/js/consignment-master-data.js"></script>

<script>
var currentData = [];

document.addEventListener('configLoaded', function() {
    ConsignmentMasterData.init();
    searchData();
    $('#nav-consignment-delivery-order').addClass('active');
    $('#menu-outbound').addClass('active');
});

async function searchData() {
    AppUtils.showLoading();
    var form = document.getElementById('filterForm');
    var formData = new FormData(form);
    var params = new URLSearchParams();
    
    for (var pair of formData.entries()) {
        var key = pair[0];
        var value = pair[1];
        if (value && value.trim() !== '') {
            if (key === 'customer') key = 'customerCode';
            params.append(key, value.trim());
        }
    }
    
    var qs = params.toString() ? '?' + params.toString() : '';
    
    try {
        var res = await ApiClient.get('CONSIGNMENT', '/csdo' + qs);
        var data = [];
        if (res.data && Array.isArray(res.data)) {
            data = res.data;
        } else if (res.items && Array.isArray(res.items)) {
            data = res.items;
        } else if (Array.isArray(res)) {
            data = res;
        } else if (res.id || res.docNo) {
            data = [res]; // In case API returns single object
        }
        
        currentData = data.map(item => ({
            id: item.id || item.docNo,
            date: item.createdAt ? item.createdAt.substring(0, 10) : '-',
            store: item.store || '-',
            csdoNo: item.docNo || '-',
            transferFrom: item.csoDocNo || item.csoId || '-',
            customer: item.customerCode || '-',
            branch: item.customerBranch || '-',
            shipMode: item.shippingMode || '-',
            transporter: item.transporter || '-',
            createdBy: item.createdBy || '-',
            status: item.status ? item.status.charAt(0).toUpperCase() + item.status.slice(1).toLowerCase() : 'Held'
        }));
        renderTable(currentData);
    } catch (e) {
        console.error(e);
        AppUtils.showToast('Failed to load data', 'danger');
        renderTable([]);
    } finally {
        AppUtils.hideLoading();
    }
}

function renderTable(data) {
    var tbody = $('#dataTableBody');
    tbody.empty();
    
    if (data.length === 0) {
        tbody.append('<tr><td colspan="11" class="text-center py-4">No records found.</td></tr>');
        return;
    }
    
    data.forEach(function(row) {
        var badgeClass = '';
        if (row.status === 'Held') badgeClass = 'badge-warning';
        else if (row.status === 'Released') badgeClass = 'badge-success';
        else if (row.status === 'Reversed') badgeClass = 'badge-secondary';
        
        var showEdit = row.status === 'Held';
        
        var actionHtml = showEdit ? 
            '<a href="/consignment/delivery-order/details?id=' + row.id + '"><i class="fas fa-edit text-primary"></i></a>' : 
            '<a href="/consignment/delivery-order/details?id=' + row.id + '"><i class="fas fa-eye text-primary"></i></a>';
            
        var tr = `<tr>
            <td><input type="checkbox" class="row-checkbox" value="\${row.id}"></td>
            <td>\${row.date}</td>
            <td class="text-primary font-weight-bold">\${row.store}</td>
            <td>\${row.csdoNo}</td>
            <td>\${row.transferFrom}</td>
            <td>
                <div>\${row.customer}</div>
                <small class="text-muted">\${row.branch}</small>
            </td>
            <td>\${row.shipMode}</td>
            <td>\${row.transporter}</td>
            <td>\${row.createdBy}</td>
            <td><span class="badge \${badgeClass}">\${row.status}</span></td>
            <td>\${actionHtml}</td>
        </tr>`;
        tbody.append(tr);
    });
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
    
    var isValid = true;
    currentData.forEach(function(d) {
        if(ids.includes(d.id.toString()) && d.status.toUpperCase() !== 'HELD') {
            isValid = false;
        }
    });

    if(!isValid) {
        AppUtils.showToast('Only HELD documents can be released.', 'warning');
        return;
    }

    if (confirm('Release selected ' + ids.length + ' document(s)?')) {
        AppUtils.showLoading();
        
        Promise.all(ids.map(id => ApiClient.put('CONSIGNMENT', `/csdo/\${id}/release`)))
            .then(() => {
                AppUtils.showToast('Documents successfully released.', 'success');
                searchData();
                $('#selectAll').prop('checked', false);
            })
            .catch(e => {
                console.error(e);
                AppUtils.showToast('Error releasing documents', 'danger');
            })
            .finally(() => AppUtils.hideLoading());
    }
}

function batchReverse() {
    var ids = getSelectedIds();
    if (ids.length === 0) { AppUtils.showToast('Please select at least one document', 'warning'); return; }
    
    var isValid = true;
    currentData.forEach(function(d) {
        if(ids.includes(d.id.toString()) && d.status.toUpperCase() !== 'RELEASED') {
            isValid = false;
        }
    });

    if(!isValid) {
        AppUtils.showToast('Only RELEASED documents can be reversed.', 'warning');
        return;
    }

    if (confirm('Confirm reverse selected ' + ids.length + ' document(s)?')) {
        AppUtils.showLoading();
        Promise.all(ids.map(id => ApiClient.put('CONSIGNMENT', `/csdo/\${id}/reverse`)))
            .then(() => {
                AppUtils.showToast('Documents successfully reversed.', 'success');
                searchData();
                $('#selectAll').prop('checked', false);
            })
            .catch(e => {
                console.error(e);
                AppUtils.showToast('Error reversing documents', 'danger');
            })
            .finally(() => AppUtils.hideLoading());
    }
}

function batchDelete() {
    var ids = getSelectedIds();
    if (ids.length === 0) { AppUtils.showToast('Please select at least one document', 'warning'); return; }
    
    var isValid = true;
    currentData.forEach(function(d) {
        // usually delete allowed for HELD
        if(ids.includes(d.id.toString()) && d.status.toUpperCase() === 'RELEASED') isValid = false;
    });

    if(!isValid) {
        AppUtils.showToast('Cannot delete RELEASED documents.', 'warning');
        return;
    }

    if (confirm('Confirm delete selected ' + ids.length + ' document(s)?')) {
        AppUtils.showLoading();
        Promise.all(ids.map(id => ApiClient.delete('CONSIGNMENT', `/csdo/\${id}`)))
            .then(() => {
                AppUtils.showToast('Documents successfully removed.', 'success');
                searchData();
                $('#selectAll').prop('checked', false);
            })
            .catch(e => {
                console.error(e);
                AppUtils.showToast('Error deleting documents', 'danger');
            })
            .finally(() => AppUtils.hideLoading());
    }
}

function batchPrint() {
    var ids = getSelectedIds();
    if (ids.length === 0) { AppUtils.showToast('Please select a document to print', 'warning'); return; }
    AppUtils.showToast('Printing listing...', 'info');
}
</script>

<style>
.text-sm { font-size: 0.85rem; }
</style>

</body>
</html>
