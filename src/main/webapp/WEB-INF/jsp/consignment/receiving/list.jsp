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
                            <select class="form-control form-control-sm" name="company">
                                <option value="">Select Company</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Receiving Store</label>
                            <input type="text" class="form-control form-control-sm" name="receivingStore">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Consignment Stock Receiving Number</label>
                            <input type="text" class="form-control form-control-sm" name="docNumber">
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
                            <select class="form-control form-control-sm" name="createMethod">
                                <option value="">Select</option>
                                <option value="Manual">Manual</option>
                                <option value="API">Trigger from ACMM through API</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Reference Number</label>
                            <input type="text" class="form-control form-control-sm" name="referenceNumber">
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
                            <label class="small text-muted mb-1">Received By</label>
                            <input type="text" class="form-control form-control-sm" name="receivedBy">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Created Date</label>
                            <div class="input-group input-group-sm">
                                <input type="date" class="form-control" name="createdDateFrom">
                                <input type="date" class="form-control" name="createdDateTo">
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Released By</label>
                            <input type="text" class="form-control form-control-sm" name="releasedBy">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Released Date</label>
                            <div class="input-group input-group-sm">
                                <input type="date" class="form-control" name="releasedDateFrom">
                                <input type="date" class="form-control" name="releasedDateTo">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Supplier</label>
                            <div class="input-group input-group-sm">
                                <input type="text" class="form-control" name="supplier">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="fas fa-truck"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Supplier Contract</label>
                            <input type="text" class="form-control form-control-sm" name="supplierContract">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Branch</label>
                            <input type="text" class="form-control form-control-sm" name="branch">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Internal Supplier Store</label>
                            <input type="text" class="form-control form-control-sm" name="internalSupplierStore">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Supplier DO Number</label>
                            <input type="text" class="form-control form-control-sm" name="supplierDO">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Delivery Date</label>
                            <div class="input-group input-group-sm">
                                <input type="date" class="form-control" name="deliveryDateFrom">
                                <input type="date" class="form-control" name="deliveryDateTo">
                            </div>
                        </div>
                        <div class="col-md-6 mb-3 d-flex align-items-end justify-content-end">
                            <button type="button" class="btn btn-sm btn-light mr-2" onclick="$('#filterForm')[0].reset(); loadData(0);">Clear Filter</button>
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
                            <th>Released By</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- JS Render -->
                    </tbody>
                </table>
            </div>
            <div class="card-footer bg-white d-flex justify-content-between align-items-center">
                <div id="paginationContainer"></div>
            </div>
        </div>

        <!-- Bulk Actions -->
        <div class="mt-3 d-flex justify-content-end">
            <button class="btn btn-sm btn-secondary font-weight-bold px-4 mr-2" onclick="batchRelease()">Release</button>
            <button class="btn btn-sm btn-outline-secondary font-weight-bold px-4 mr-2" onclick="batchPrint()"><i class="fas fa-print mr-1"></i> Print</button>
            <button class="btn btn-sm btn-outline-danger font-weight-bold px-4" onclick="batchDelete()"><i class="fas fa-trash-alt mr-1"></i> Delete</button>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />

<script>
var currentPage = 0;
var mockData = [
    { id: 1, docNumber: '000100006295', refNumber: '5576', supplier: '0000000725', contract: 'MD-00001', branch: '00', supplierDO: 'DO128454', createdDate: '2025-08-29', releasedBy: 'SYSTEM OPERATOR', status: 'RELEASED' },
    { id: 2, docNumber: '000100006294', refNumber: '000110013565', supplier: '0000000725', contract: 'MD-00001', branch: '00', supplierDO: 'DO2508261', createdDate: '2025-08-28', releasedBy: '', status: 'HELD' }
];

document.addEventListener('configLoaded', function() {
    loadData(0);

    $('#selectAll').on('change', function() {
        $('.row-checkbox').prop('checked', this.checked);
    });
});

async function loadData(page) {
    currentPage = page || 0;
    var tbody = $('#resultTable tbody');
    tbody.empty();
    
    if (mockData.length === 0) {
        tbody.html('<tr><td colspan="11" class="text-center py-4 text-muted">No records found</td></tr>');
        return;
    }

    mockData.forEach(item => {
        var statusBadge = item.status === 'RELEASED' ? '<span class="badge badge-success">Released</span>' : '<span class="badge badge-warning">Held</span>';
        var editIcon = item.status === 'HELD' ? '<a href="/consignment/receiving/details?id=' + item.id + '" class="text-primary" title="Edit"><i class="fas fa-pencil-alt"></i></a>' : '<a href="/consignment/receiving/details?id=' + item.id + '" class="text-secondary" title="View"><i class="fas fa-eye"></i></a>';
        
        var row = `<tr>
            <td class="text-center"><input type="checkbox" class="row-checkbox" value="\${item.id}" data-status="\${item.status}"></td>
            <td class="text-center">\${editIcon}</td>
            <td><a href="/consignment/receiving/details?id=\${item.id}">\${item.docNumber}</a></td>
            <td>\${item.refNumber}</td>
            <td>\${item.supplier}</td>
            <td>\${item.contract}</td>
            <td>\${item.branch}</td>
            <td>\${item.supplierDO}</td>
            <td>\${item.createdDate}</td>
            <td>\${item.releasedBy}</td>
            <td>\${statusBadge}</td>
        </tr>`;
        tbody.append(row);
    });

    AppUtils.buildPagination('paginationContainer', 0, 1, loadData); // Mock pagination
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
    selected.each(function() {
        if($(this).data('status') === 'RELEASED') valid = false;
    });

    if (!valid) { AppUtils.showToast('Cannot release already released documents.', 'danger'); return; }

    if (confirm('Release selected document(s)? System will post stock to supplier inventory.')) {
        selected.each(function() {
            var id = parseInt($(this).val());
            var item = mockData.find(i => i.id === id);
            if(item) {
                item.status = 'RELEASED';
                item.releasedBy = 'CURRENT USER';
            }
        });
        AppUtils.showToast('Document(s) successfully released and inventory posted.', 'success');
        $('#selectAll').prop('checked', false);
        loadData(currentPage);
    }
}

function batchPrint() {
    if (getSelectedIds().length === 0) { AppUtils.showToast('Please select a document to print', 'warning'); return; }
    AppUtils.showToast('Printing transaction listing report...', 'info');
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
        selected.each(function() {
            var id = parseInt($(this).val());
            mockData = mockData.filter(i => i.id !== id);
        });
        AppUtils.showToast('Document(s) successfully deleted.', 'success');
        $('#selectAll').prop('checked', false);
        loadData(currentPage);
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
