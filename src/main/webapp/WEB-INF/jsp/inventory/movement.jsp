<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Stock Movement"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Stock Movement"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-exchange-alt mr-2 text-primary"></i>Stock Movement</h5><small class="text-muted">Inventory / Stock Movement</small></div>
        <button class="btn btn-outline-secondary btn-sm" onclick="loadData()"><i class="fas fa-sync-alt mr-1"></i>Refresh</button>
    </div>

    <div class="card mb-3">
        <div class="card-body py-2">
            <div class="row align-items-center">
                <div class="col-md-3"><input type="date" class="form-control form-control-sm" id="filterDateFrom" title="From Date"></div>
                <div class="col-md-3"><input type="date" class="form-control form-control-sm" id="filterDateTo" title="To Date"></div>
                <div class="col-md-3"><select class="form-control form-control-sm" id="filterType"><option value="">All Types</option><option value="IN">Stock In</option><option value="OUT">Stock Out</option><option value="ADJUSTMENT">Adjustment</option><option value="TRANSFER">Transfer</option></select></div>
                <div class="col-md-2"><button class="btn btn-primary btn-sm btn-block" onclick="loadData()"><i class="fas fa-search mr-1"></i>Search</button></div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="movementTable">
                <thead><tr><th>#</th><th>Date</th><th>Product</th><th>Type</th><th>Qty</th><th>From</th><th>To</th><th>Reference</th><th>Remarks</th></tr></thead>
                <tbody><tr><td colspan="9" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="movementPagination"></div>
    </div>
</main>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
document.addEventListener('configLoaded', function() { if (!Auth.requireAuth()) return; loadData(); });

async function loadData(page) {
    currentPage = page || 0;
    try {
        var data = await ApiClient.get('TRANSACTION', '/stock-movements?page=' + currentPage + '&size=15');
        if (data && data.data) {
            var items = data.data.content || [];
            AppUtils.buildTable('movementTable', [
                { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
                { field: 'movementDate', formatter: function(v) { return AppUtils.formatDate(v); } },
                { field: 'productName' },
                { field: 'movementType', formatter: function(v) {
                    var cls = { 'IN': 'success', 'OUT': 'danger', 'ADJUSTMENT': 'warning', 'TRANSFER': 'info' }[v] || 'secondary';
                    return '<span class="badge badge-' + cls + ' badge-status">' + (v || '-') + '</span>';
                }},
                { field: 'quantity' }, { field: 'fromWarehouse' }, { field: 'toWarehouse' }, { field: 'referenceNo' }, { field: 'remarks' }
            ], items);
            AppUtils.buildPagination('movementPagination', currentPage, data.data.totalPages || 1, loadData);
        }
    } catch (e) { $('#movementTable tbody').html('<tr><td colspan="9" class="text-center text-muted py-4">Failed to load data</td></tr>'); }
}
</script>
