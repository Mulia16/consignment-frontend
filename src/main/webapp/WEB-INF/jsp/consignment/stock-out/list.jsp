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
                                <select class="form-control" name="company">
                                    <option value="">ALPRO PHARMACY SDN BHD</option>
                                    <option value="1">AUSTAR MARKETING</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Issue Store</label>
                                <input type="text" class="form-control" name="issueStore">
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
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />

<script>
var mockData = [
    { id: 1, date: '2025-08-28', store: 'NPDRM1', csoNo: 'SO-2508-000053', customer: '10036 - AB PHARMA SDN BHD', branch: '00001 - AB PHARMA IPOH PARADE', createdBy: 'OPR', status: 'Released' },
    { id: 2, date: '2025-08-28', store: 'NPDRM1', csoNo: 'SO-2508-000052', customer: '10036 - AB PHARMA SDN BHD', branch: '00001 - AB PHARMA IPOH PARADE', createdBy: 'YEE THONG CHAN', status: 'Released' },
    { id: 3, date: '2025-08-27', store: 'NPDRM1', csoNo: 'SO-2508-000051', customer: '005 - Q Academy Sdn. Bhd', branch: '5001 - Q ACADEMY', createdBy: 'OPR', status: 'Held' },
    { id: 4, date: '2025-08-27', store: 'NPDRM1', csoNo: 'SO-2508-000050', customer: '10036 - AB PHARMA SDN BHD', branch: '00002 - AB PHARMA SERAI', createdBy: 'OPR', status: 'Error' }
];

document.addEventListener('configLoaded', function() {
    renderTable(mockData);
    $('#nav-consignment-stockout').addClass('active');
    $('#menu-outbound').addClass('active');
});

function searchData() {
    AppUtils.showLoading();
    setTimeout(() => {
        renderTable(mockData);
        AppUtils.hideLoading();
    }, 400);
}

function renderTable(data) {
    var tbody = $('#dataTableBody');
    tbody.empty();
    
    if (data.length === 0) {
        tbody.append('<tr><td colspan="8" class="text-center py-4">No records found.</td></tr>');
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
    mockData.forEach(function(d) {
        if(ids.includes(d.id.toString()) && d.status !== 'Held') {
            isValid = false;
        }
    });

    if(!isValid) {
        AppUtils.showToast('Only HELD documents can be released.', 'warning');
        return;
    }

    if (confirm('Are you sure you want to release the selected ' + ids.length + ' document(s)?')) {
        AppUtils.showToast('Documents successfully released.', 'success');
        // Update mock state
        mockData.forEach(d => {
            if(ids.includes(d.id.toString())) d.status = 'Released';
        });
        renderTable(mockData);
        $('#selectAll').prop('checked', false);
    }
}

function batchDelete() {
    var ids = getSelectedIds();
    if (ids.length === 0) { AppUtils.showToast('Please select at least one document', 'warning'); return; }
    
    // According to reqs: Only allow delete for "Held" or "Error" status document
    var isValid = true;
    mockData.forEach(function(d) {
        if(ids.includes(d.id.toString()) && d.status === 'Released') {
            isValid = false;
        }
    });

    if(!isValid) {
        AppUtils.showToast('Cannot delete RELEASED documents.', 'warning');
        return;
    }

    if (confirm('Confirm delete selected ' + ids.length + ' document(s)?')) {
        mockData = mockData.filter(d => !ids.includes(d.id.toString()));
        renderTable(mockData);
        AppUtils.showToast('Documents successfully deleted.', 'success');
        $('#selectAll').prop('checked', false);
    }
}

function batchPrint() {
    var ids = getSelectedIds();
    if (ids.length === 0) { AppUtils.showToast('Please select a document to print', 'warning'); return; }
    AppUtils.showToast('Printing listing...', 'info');
    // Using standard print function call since user did not specify exact slip for CSO.
    // window.open('/consignment/stock-out/print?id=' + ids[0], '_blank'); 
}
</script>

</body>
</html>
