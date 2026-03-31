<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Goods Receipt"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Goods Receipt"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-clipboard-check mr-2 text-success"></i>Goods Receipt</h5><small class="text-muted">Inbound / Goods Receipt</small></div>
        <button class="btn btn-success btn-sm" data-toggle="modal" data-target="#grModal" onclick="resetForm()"><i class="fas fa-plus mr-1"></i> New Receipt</button>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="grTable">
                <thead><tr><th>#</th><th>GR Number</th><th>PO Reference</th><th>Supplier</th><th>Receipt Date</th><th>Total Items</th><th>Status</th><th class="text-center">Actions</th></tr></thead>
                <tbody><tr><td colspan="8" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="grPagination"></div>
    </div>
</main>

<div class="modal fade" id="grModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"><h6 class="modal-title" id="grModalTitle">New Goods Receipt</h6><button type="button" class="close" data-dismiss="modal">&times;</button></div>
            <form id="grForm">
                <div class="modal-body">
                    <input type="hidden" id="grId">
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>GR Number *</label><input type="text" class="form-control form-control-sm" id="grNumber" required></div></div>
                        <div class="col-md-6"><div class="form-group"><label>PO Reference</label><input type="text" class="form-control form-control-sm" id="grPoRef"></div></div>
                    </div>
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>Supplier</label><input type="text" class="form-control form-control-sm" id="grSupplier"></div></div>
                        <div class="col-md-6"><div class="form-group"><label>Receipt Date *</label><input type="date" class="form-control form-control-sm" id="grDate" required></div></div>
                    </div>
                    <div class="form-group"><label>Notes</label><textarea class="form-control form-control-sm" id="grNotes" rows="2"></textarea></div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button><button type="submit" class="btn btn-sm btn-success"><i class="fas fa-save mr-1"></i>Save</button></div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
document.addEventListener('configLoaded', function() { if (!Auth.requireAuth()) return; loadData(); $('#grForm').on('submit', function(e) { e.preventDefault(); saveData(); }); });

async function loadData(page) {
    currentPage = page || 0;
    try {
        var data = await ApiClient.get('TRANSACTION', '/goods-receipts?page=' + currentPage + '&size=15');
        if (data && data.data) {
            var items = data.data.content || [];
            AppUtils.buildTable('grTable', [
                { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
                { field: 'grNumber' }, { field: 'poReference' }, { field: 'supplierName' },
                { field: 'receiptDate', formatter: function(v) { return AppUtils.formatDate(v); } },
                { field: 'totalItems' },
                { field: 'status', formatter: function(v) {
                    var cls = { 'PENDING': 'warning', 'VERIFIED': 'success', 'REJECTED': 'danger' }[v] || 'secondary';
                    return '<span class="badge badge-' + cls + ' badge-status">' + (v || '-') + '</span>';
                }}
            ], items, function(row) {
                return '<button class="btn btn-sm btn-outline-info btn-action"><i class="fas fa-eye"></i></button>';
            });
            AppUtils.buildPagination('grPagination', currentPage, data.data.totalPages || 1, loadData);
        }
    } catch (e) { $('#grTable tbody').html('<tr><td colspan="8" class="text-center text-muted py-4">Failed to load data</td></tr>'); }
}

function resetForm() { $('#grModalTitle').text('New Goods Receipt'); $('#grForm')[0].reset(); $('#grId').val(''); }
async function saveData() { var id = $('#grId').val(); var body = { grNumber: $('#grNumber').val(), poReference: $('#grPoRef').val(), supplierName: $('#grSupplier').val(), receiptDate: $('#grDate').val(), notes: $('#grNotes').val() }; try { if (id) { await ApiClient.put('TRANSACTION', '/goods-receipts/' + id, body); } else { await ApiClient.post('TRANSACTION', '/goods-receipts', body); } AppUtils.showToast('Goods receipt saved', 'success'); $('#grModal').modal('hide'); loadData(currentPage); } catch (e) {} }
</script>
