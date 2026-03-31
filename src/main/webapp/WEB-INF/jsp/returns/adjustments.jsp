<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Stock Adjustments"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Stock Adjustments"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-balance-scale mr-2 text-warning"></i>Stock Adjustments</h5><small class="text-muted">Returns & Adj / Stock Adjustments</small></div>
        <button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#adjModal" onclick="resetForm()"><i class="fas fa-plus mr-1"></i> New Adjustment</button>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="adjTable">
                <thead><tr><th>#</th><th>Adj Number</th><th>Product</th><th>Warehouse</th><th>Type</th><th>Qty</th><th>Reason</th><th>Date</th><th>Status</th></tr></thead>
                <tbody><tr><td colspan="9" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="adjPagination"></div>
    </div>
</main>

<div class="modal fade" id="adjModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"><h6 class="modal-title">New Stock Adjustment</h6><button type="button" class="close" data-dismiss="modal">&times;</button></div>
            <form id="adjForm">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>Adjustment No *</label><input type="text" class="form-control form-control-sm" id="adjNumber" required></div></div>
                        <div class="col-md-6"><div class="form-group"><label>Type *</label><select class="form-control form-control-sm" id="adjType"><option value="INCREASE">Increase</option><option value="DECREASE">Decrease</option></select></div></div>
                    </div>
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>Product *</label><input type="text" class="form-control form-control-sm" id="adjProduct" required></div></div>
                        <div class="col-md-6"><div class="form-group"><label>Quantity *</label><input type="number" class="form-control form-control-sm" id="adjQty" required></div></div>
                    </div>
                    <div class="form-group"><label>Warehouse</label><input type="text" class="form-control form-control-sm" id="adjWarehouse"></div>
                    <div class="form-group"><label>Reason *</label><textarea class="form-control form-control-sm" id="adjReason" rows="2" required></textarea></div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button><button type="submit" class="btn btn-sm btn-warning"><i class="fas fa-save mr-1"></i>Save</button></div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
document.addEventListener('configLoaded', function() { if (!Auth.requireAuth()) return; loadData(); $('#adjForm').on('submit', function(e) { e.preventDefault(); saveData(); }); });

async function loadData(page) {
    currentPage = page || 0;
    try {
        var data = await ApiClient.get('TRANSACTION', '/stock-adjustments?page=' + currentPage + '&size=15');
        if (data && data.data) {
            var items = data.data.content || [];
            AppUtils.buildTable('adjTable', [
                { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
                { field: 'adjustmentNumber' }, { field: 'productName' }, { field: 'warehouseName' },
                { field: 'adjustmentType', formatter: function(v) { return v === 'INCREASE' ? '<span class="badge badge-success badge-status">Increase</span>' : '<span class="badge badge-danger badge-status">Decrease</span>'; } },
                { field: 'quantity' }, { field: 'reason' },
                { field: 'adjustmentDate', formatter: function(v) { return AppUtils.formatDate(v); } },
                { field: 'status', formatter: function(v) { var cls = { 'PENDING': 'warning', 'APPROVED': 'success', 'REJECTED': 'danger' }[v] || 'secondary'; return '<span class="badge badge-' + cls + ' badge-status">' + (v || '-') + '</span>'; } }
            ], items);
            AppUtils.buildPagination('adjPagination', currentPage, data.data.totalPages || 1, loadData);
        }
    } catch (e) { $('#adjTable tbody').html('<tr><td colspan="9" class="text-center text-muted py-4">Failed to load data</td></tr>'); }
}

function resetForm() { $('#adjForm')[0].reset(); }
async function saveData() { var body = { adjustmentNumber: $('#adjNumber').val(), adjustmentType: $('#adjType').val(), productName: $('#adjProduct').val(), quantity: parseInt($('#adjQty').val()), warehouseName: $('#adjWarehouse').val(), reason: $('#adjReason').val() }; try { await ApiClient.post('TRANSACTION', '/stock-adjustments', body); AppUtils.showToast('Adjustment saved', 'success'); $('#adjModal').modal('hide'); loadData(currentPage); } catch (e) {} }
</script>
