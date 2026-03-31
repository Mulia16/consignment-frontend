<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Return Orders"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Return Orders"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-reply mr-2 text-warning"></i>Return Orders</h5><small class="text-muted">Returns & Adj / Return Orders</small></div>
        <button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#returnModal" onclick="resetForm()"><i class="fas fa-plus mr-1"></i> New Return</button>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="returnTable">
                <thead><tr><th>#</th><th>Return No</th><th>Type</th><th>Reference</th><th>Reason</th><th>Date</th><th>Total Items</th><th>Status</th><th class="text-center">Actions</th></tr></thead>
                <tbody><tr><td colspan="9" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="returnPagination"></div>
    </div>
</main>

<div class="modal fade" id="returnModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"><h6 class="modal-title" id="returnModalTitle">New Return Order</h6><button type="button" class="close" data-dismiss="modal">&times;</button></div>
            <form id="returnForm">
                <div class="modal-body">
                    <input type="hidden" id="returnId">
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>Return Number *</label><input type="text" class="form-control form-control-sm" id="returnNumber" required></div></div>
                        <div class="col-md-6"><div class="form-group"><label>Type *</label><select class="form-control form-control-sm" id="returnType" required><option value="RETURN_TO_SUPPLIER">Return to Supplier</option><option value="RETURN_FROM_CUSTOMER">Return from Customer</option></select></div></div>
                    </div>
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>Reference No</label><input type="text" class="form-control form-control-sm" id="returnRef"></div></div>
                        <div class="col-md-6"><div class="form-group"><label>Date *</label><input type="date" class="form-control form-control-sm" id="returnDate" required></div></div>
                    </div>
                    <div class="form-group"><label>Reason *</label><textarea class="form-control form-control-sm" id="returnReason" rows="2" required></textarea></div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button><button type="submit" class="btn btn-sm btn-warning"><i class="fas fa-save mr-1"></i>Save</button></div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
document.addEventListener('configLoaded', function() { if (!Auth.requireAuth()) return; loadData(); $('#returnForm').on('submit', function(e) { e.preventDefault(); saveData(); }); });

async function loadData(page) {
    currentPage = page || 0;
    try {
        var data = await ApiClient.get('TRANSACTION', '/return-orders?page=' + currentPage + '&size=15');
        if (data && data.data) {
            var items = data.data.content || [];
            AppUtils.buildTable('returnTable', [
                { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
                { field: 'returnNumber' }, { field: 'returnType' }, { field: 'referenceNo' }, { field: 'reason' },
                { field: 'returnDate', formatter: function(v) { return AppUtils.formatDate(v); } },
                { field: 'totalItems' },
                { field: 'status', formatter: function(v) {
                    var cls = { 'DRAFT': 'secondary', 'APPROVED': 'primary', 'COMPLETED': 'success', 'REJECTED': 'danger' }[v] || 'secondary';
                    return '<span class="badge badge-' + cls + ' badge-status">' + (v || '-') + '</span>';
                }}
            ], items, function(row) {
                return '<button class="btn btn-sm btn-outline-info btn-action"><i class="fas fa-eye"></i></button>';
            });
            AppUtils.buildPagination('returnPagination', currentPage, data.data.totalPages || 1, loadData);
        }
    } catch (e) { $('#returnTable tbody').html('<tr><td colspan="9" class="text-center text-muted py-4">Failed to load data</td></tr>'); }
}

function resetForm() { $('#returnModalTitle').text('New Return Order'); $('#returnForm')[0].reset(); $('#returnId').val(''); }
async function saveData() { var body = { returnNumber: $('#returnNumber').val(), returnType: $('#returnType').val(), referenceNo: $('#returnRef').val(), returnDate: $('#returnDate').val(), reason: $('#returnReason').val() }; try { await ApiClient.post('TRANSACTION', '/return-orders', body); AppUtils.showToast('Return order created', 'success'); $('#returnModal').modal('hide'); loadData(currentPage); } catch (e) {} }
</script>
