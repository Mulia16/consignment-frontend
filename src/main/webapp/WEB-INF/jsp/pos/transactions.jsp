<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="POS Transactions"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="POS Sales"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-cash-register mr-2 text-primary"></i>POS Transactions</h5><small class="text-muted">POS Sales</small></div>
        <button class="btn btn-outline-secondary btn-sm" onclick="loadData()"><i class="fas fa-sync-alt mr-1"></i>Refresh</button>
    </div>

    <div class="card mb-3">
        <div class="card-body py-2">
            <div class="row align-items-center">
                <div class="col-md-3"><input type="date" class="form-control form-control-sm" id="filterFrom" title="From Date"></div>
                <div class="col-md-3"><input type="date" class="form-control form-control-sm" id="filterTo" title="To Date"></div>
                <div class="col-md-3"><input type="text" class="form-control form-control-sm" id="filterTrx" placeholder="Receipt number..."></div>
                <div class="col-md-2"><button class="btn btn-primary btn-sm btn-block" onclick="loadData()"><i class="fas fa-search mr-1"></i>Search</button></div>
            </div>
        </div>
    </div>

    <!-- Summary Cards -->
    <div class="row mb-3">
        <div class="col-md-3"><div class="card bg-light"><div class="card-body text-center py-2"><small class="text-muted">Today's Sales</small><h5 class="mb-0" id="todaySales">-</h5></div></div></div>
        <div class="col-md-3"><div class="card bg-light"><div class="card-body text-center py-2"><small class="text-muted">Total Transactions</small><h5 class="mb-0" id="totalTrx">-</h5></div></div></div>
        <div class="col-md-3"><div class="card bg-light"><div class="card-body text-center py-2"><small class="text-muted">Avg Transaction</small><h5 class="mb-0" id="avgTrx">-</h5></div></div></div>
        <div class="col-md-3"><div class="card bg-light"><div class="card-body text-center py-2"><small class="text-muted">Total Items Sold</small><h5 class="mb-0" id="itemsSold">-</h5></div></div></div>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="posTable">
                <thead><tr><th>#</th><th>Receipt No</th><th>Date/Time</th><th>Cashier</th><th>Items</th><th>Total</th><th>Payment</th><th>Status</th></tr></thead>
                <tbody><tr><td colspan="8" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="posPagination"></div>
    </div>
</main>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
document.addEventListener('configLoaded', function() { if (!Auth.requireAuth()) return; loadData(); });

async function loadData(page) {
    currentPage = page || 0;
    try {
        var data = await ApiClient.get('TRANSACTION', '/transactions?page=' + currentPage + '&size=15');
        if (data && data.data) {
            var items = data.data.content || [];
            AppUtils.buildTable('posTable', [
                { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
                { field: 'receiptNumber' },
                { field: 'transactionDate', formatter: function(v) { return AppUtils.formatDateTime(v); } },
                { field: 'cashierName' }, { field: 'totalItems' },
                { field: 'totalAmount', formatter: function(v) { return AppUtils.formatCurrency(v); } },
                { field: 'paymentMethod', formatter: function(v) { return '<span class="badge badge-light">' + (v || '-') + '</span>'; } },
                { field: 'status', formatter: function(v) {
                    var cls = { 'COMPLETED': 'success', 'VOID': 'danger', 'PENDING': 'warning' }[v] || 'secondary';
                    return '<span class="badge badge-' + cls + ' badge-status">' + (v || '-') + '</span>';
                }}
            ], items);
            AppUtils.buildPagination('posPagination', currentPage, data.data.totalPages || 1, loadData);
        }
    } catch (e) { $('#posTable tbody').html('<tr><td colspan="8" class="text-center text-muted py-4">Failed to load data</td></tr>'); }
}
</script>
