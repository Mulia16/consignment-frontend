<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Payments"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Payment Records"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-money-check-alt mr-2 text-success"></i>Payment Records</h5><small class="text-muted">Settlement / Payments</small></div>
        <button class="btn btn-success btn-sm" data-toggle="modal" data-target="#paymentModal" onclick="resetForm()"><i class="fas fa-plus mr-1"></i> Record Payment</button>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="paymentTable">
                <thead><tr><th>#</th><th>Payment No</th><th>Settlement Ref</th><th>Partner</th><th>Amount</th><th>Payment Date</th><th>Method</th><th>Status</th></tr></thead>
                <tbody><tr><td colspan="8" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="paymentPagination"></div>
    </div>
</main>

<div class="modal fade" id="paymentModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"><h6 class="modal-title">Record Payment</h6><button type="button" class="close" data-dismiss="modal">&times;</button></div>
            <form id="paymentForm">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>Payment No *</label><input type="text" class="form-control form-control-sm" id="paymentNo" required></div></div>
                        <div class="col-md-6"><div class="form-group"><label>Settlement Ref</label><input type="text" class="form-control form-control-sm" id="paymentSettRef"></div></div>
                    </div>
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>Amount *</label><input type="number" class="form-control form-control-sm" id="paymentAmount" step="0.01" required></div></div>
                        <div class="col-md-6"><div class="form-group"><label>Payment Date *</label><input type="date" class="form-control form-control-sm" id="paymentDate" required></div></div>
                    </div>
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>Partner</label><input type="text" class="form-control form-control-sm" id="paymentPartner"></div></div>
                        <div class="col-md-6"><div class="form-group"><label>Method</label><select class="form-control form-control-sm" id="paymentMethod"><option value="BANK_TRANSFER">Bank Transfer</option><option value="CASH">Cash</option><option value="CHECK">Check</option><option value="GIRO">Giro</option></select></div></div>
                    </div>
                    <div class="form-group"><label>Notes</label><textarea class="form-control form-control-sm" id="paymentNotes" rows="2"></textarea></div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button><button type="submit" class="btn btn-sm btn-success"><i class="fas fa-save mr-1"></i>Save</button></div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
document.addEventListener('configLoaded', function() { if (!Auth.requireAuth()) return; loadData(); $('#paymentForm').on('submit', function(e) { e.preventDefault(); saveData(); }); });

async function loadData(page) {
    currentPage = page || 0;
    try {
        var data = await ApiClient.get('SETTLEMENT', '/payments?page=' + currentPage + '&size=15');
        if (data && data.data) {
            var items = data.data.content || [];
            AppUtils.buildTable('paymentTable', [
                { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
                { field: 'paymentNumber' }, { field: 'settlementReference' }, { field: 'partnerName' },
                { field: 'amount', formatter: function(v) { return '<strong>' + AppUtils.formatCurrency(v) + '</strong>'; } },
                { field: 'paymentDate', formatter: function(v) { return AppUtils.formatDate(v); } },
                { field: 'paymentMethod' },
                { field: 'status', formatter: function(v) {
                    var cls = { 'PENDING': 'warning', 'VERIFIED': 'success', 'REJECTED': 'danger' }[v] || 'secondary';
                    return '<span class="badge badge-' + cls + ' badge-status">' + (v || '-') + '</span>';
                }}
            ], items);
            AppUtils.buildPagination('paymentPagination', currentPage, data.data.totalPages || 1, loadData);
        }
    } catch (e) { $('#paymentTable tbody').html('<tr><td colspan="8" class="text-center text-muted py-4">Failed to load data</td></tr>'); }
}

function resetForm() { $('#paymentForm')[0].reset(); }
async function saveData() { var body = { paymentNumber: $('#paymentNo').val(), settlementReference: $('#paymentSettRef').val(), partnerName: $('#paymentPartner').val(), amount: parseFloat($('#paymentAmount').val()), paymentDate: $('#paymentDate').val(), paymentMethod: $('#paymentMethod').val(), notes: $('#paymentNotes').val() }; try { await ApiClient.post('SETTLEMENT', '/payments', body); AppUtils.showToast('Payment recorded', 'success'); $('#paymentModal').modal('hide'); loadData(currentPage); } catch (e) {} }
</script>
