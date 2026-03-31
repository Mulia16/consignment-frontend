<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Stock Balance"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Stock Balance"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-layer-group mr-2 text-primary"></i>Stock Balance</h5><small class="text-muted">Inventory / Stock Balance</small></div>
        <div>
            <button class="btn btn-outline-secondary btn-sm" onclick="loadData()"><i class="fas fa-sync-alt mr-1"></i>Refresh</button>
            <button class="btn btn-outline-success btn-sm"><i class="fas fa-file-excel mr-1"></i>Export</button>
        </div>
    </div>

    <!-- Filters -->
    <div class="card mb-3">
        <div class="card-body py-2">
            <div class="row align-items-center">
                <div class="col-md-3"><input type="text" class="form-control form-control-sm" id="filterProduct" placeholder="Filter by product..."></div>
                <div class="col-md-3"><input type="text" class="form-control form-control-sm" id="filterWarehouse" placeholder="Filter by warehouse..."></div>
                <div class="col-md-2"><select class="form-control form-control-sm" id="filterStatus"><option value="">All Status</option><option value="IN_STOCK">In Stock</option><option value="LOW_STOCK">Low Stock</option><option value="OUT_OF_STOCK">Out of Stock</option></select></div>
                <div class="col-md-2"><button class="btn btn-primary btn-sm btn-block" onclick="loadData()"><i class="fas fa-search mr-1"></i>Search</button></div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="stockTable">
                <thead><tr><th>#</th><th>Product</th><th>Warehouse</th><th>Qty On Hand</th><th>Qty Reserved</th><th>Qty Available</th><th>Unit</th><th>Last Updated</th></tr></thead>
                <tbody><tr><td colspan="8" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="stockPagination"></div>
    </div>
</main>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
document.addEventListener('configLoaded', function() { if (!Auth.requireAuth()) return; loadData(); });

async function loadData(page) {
    currentPage = page || 0;
    try {
        var data = await ApiClient.get('TRANSACTION', '/stock-balances?page=' + currentPage + '&size=15');
        if (data && data.data) {
            var items = data.data.content || [];
            AppUtils.buildTable('stockTable', [
                { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
                { field: 'productName' }, { field: 'warehouseName' },
                { field: 'quantityOnHand', formatter: function(v) { return '<strong>' + (v || 0) + '</strong>'; } },
                { field: 'quantityReserved' }, { field: 'quantityAvailable' }, { field: 'unit' },
                { field: 'updatedAt', formatter: function(v) { return AppUtils.formatDateTime(v); } }
            ], items);
            AppUtils.buildPagination('stockPagination', currentPage, data.data.totalPages || 1, loadData);
        }
    } catch (e) { $('#stockTable tbody').html('<tr><td colspan="8" class="text-center text-muted py-4">Failed to load data</td></tr>'); }
}
</script>
