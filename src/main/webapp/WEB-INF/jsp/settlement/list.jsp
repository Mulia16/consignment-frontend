<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Settlement List"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Settlement"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-file-contract mr-2 text-primary"></i>Settlement List</h5><small class="text-muted">Settlement / Settlement List</small></div>
        <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#settlementModal" onclick="resetForm()"><i class="fas fa-plus mr-1"></i> New Settlement</button>
    </div>

    <div class="card mb-3">
        <div class="card-body py-2">
            <div class="row align-items-center">
                <div class="col-md-3"><select class="form-control form-control-sm" id="filterSettStatus"><option value="">All Status</option><option value="DRAFT">Draft</option><option value="SUBMITTED">Submitted</option><option value="APPROVED">Approved</option><option value="SETTLED">Settled</option></select></div>
                <div class="col-md-3"><input type="text" class="form-control form-control-sm" id="filterSettPartner" placeholder="Partner name..."></div>
                <div class="col-md-2"><button class="btn btn-primary btn-sm btn-block" onclick="loadData()"><i class="fas fa-search mr-1"></i>Search</button></div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="settlementTable">
                <thead><tr><th>#</th><th>Settlement No</th><th>Period</th><th>Partner</th><th>Total Sales</th><th>Commission</th><th>Net Amount</th><th>Status</th><th class="text-center">Actions</th></tr></thead>
                <tbody><tr><td colspan="9" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="settlementPagination"></div>
    </div>
</main>

<div class="modal fade" id="settlementModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header"><h6 class="modal-title" id="settlementModalTitle">New Settlement</h6><button type="button" class="close" data-dismiss="modal">&times;</button></div>
            <form id="settlementForm">
                <div class="modal-body">
                    <input type="hidden" id="settlementId">
                    <div class="row">
                        <div class="col-md-4"><div class="form-group"><label>Settlement No *</label><input type="text" class="form-control form-control-sm" id="settlementNo" required></div></div>
                        <div class="col-md-4"><div class="form-group"><label>Partner *</label><input type="text" class="form-control form-control-sm" id="settlementPartner" required></div></div>
                        <div class="col-md-4"><div class="form-group"><label>Period *</label><input type="month" class="form-control form-control-sm" id="settlementPeriod" required></div></div>
                    </div>
                    <div class="row">
                        <div class="col-md-4"><div class="form-group"><label>Total Sales</label><input type="number" class="form-control form-control-sm" id="settlementSales" step="0.01"></div></div>
                        <div class="col-md-4"><div class="form-group"><label>Commission (%)</label><input type="number" class="form-control form-control-sm" id="settlementComm" step="0.01"></div></div>
                        <div class="col-md-4"><div class="form-group"><label>Net Amount</label><input type="number" class="form-control form-control-sm" id="settlementNet" step="0.01" readonly></div></div>
                    </div>
                    <div class="form-group"><label>Notes</label><textarea class="form-control form-control-sm" id="settlementNotes" rows="2"></textarea></div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button><button type="submit" class="btn btn-sm btn-primary"><i class="fas fa-save mr-1"></i>Save</button></div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
document.addEventListener('configLoaded', function() {
    if (!Auth.requireAuth()) return;
    loadData();
    $('#settlementForm').on('submit', function(e) { e.preventDefault(); saveData(); });
    // Auto calc net
    $('#settlementSales, #settlementComm').on('input', function() {
        var sales = parseFloat($('#settlementSales').val()) || 0;
        var comm = parseFloat($('#settlementComm').val()) || 0;
        $('#settlementNet').val((sales - (sales * comm / 100)).toFixed(2));
    });
});

async function loadData(page) {
    currentPage = page || 0;
    try {
        var data = await ApiClient.get('SETTLEMENT', '/settlements?page=' + currentPage + '&size=15');
        if (data && data.data) {
            var items = data.data.content || [];
            AppUtils.buildTable('settlementTable', [
                { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
                { field: 'settlementNumber' }, { field: 'period' }, { field: 'partnerName' },
                { field: 'totalSales', formatter: function(v) { return AppUtils.formatCurrency(v); } },
                { field: 'commissionAmount', formatter: function(v) { return AppUtils.formatCurrency(v); } },
                { field: 'netAmount', formatter: function(v) { return '<strong>' + AppUtils.formatCurrency(v) + '</strong>'; } },
                { field: 'status', formatter: function(v) {
                    var cls = { 'DRAFT': 'secondary', 'SUBMITTED': 'primary', 'APPROVED': 'info', 'SETTLED': 'success' }[v] || 'secondary';
                    return '<span class="badge badge-' + cls + ' badge-status">' + (v || '-') + '</span>';
                }}
            ], items, function(row) {
                return '<button class="btn btn-sm btn-outline-info btn-action"><i class="fas fa-eye"></i></button>' +
                       '<button class="btn btn-sm btn-outline-warning btn-action" onclick="editData(' + row.id + ')"><i class="fas fa-edit"></i></button>';
            });
            AppUtils.buildPagination('settlementPagination', currentPage, data.data.totalPages || 1, loadData);
        }
    } catch (e) { $('#settlementTable tbody').html('<tr><td colspan="9" class="text-center text-muted py-4">Failed to load data</td></tr>'); }
}

function resetForm() { $('#settlementModalTitle').text('New Settlement'); $('#settlementForm')[0].reset(); $('#settlementId').val(''); }
async function editData(id) { try { var data = await ApiClient.get('SETTLEMENT', '/settlements/' + id); if (data && data.data) { var s = data.data; $('#settlementModalTitle').text('Edit Settlement'); $('#settlementId').val(s.id); $('#settlementNo').val(s.settlementNumber); $('#settlementPartner').val(s.partnerName); $('#settlementPeriod').val(s.period); $('#settlementSales').val(s.totalSales); $('#settlementComm').val(s.commissionRate); $('#settlementNet').val(s.netAmount); $('#settlementNotes').val(s.notes); $('#settlementModal').modal('show'); } } catch (e) {} }
async function saveData() { var id = $('#settlementId').val(); var body = { settlementNumber: $('#settlementNo').val(), partnerName: $('#settlementPartner').val(), period: $('#settlementPeriod').val(), totalSales: parseFloat($('#settlementSales').val()) || 0, commissionRate: parseFloat($('#settlementComm').val()) || 0, netAmount: parseFloat($('#settlementNet').val()) || 0, notes: $('#settlementNotes').val() }; try { if (id) { await ApiClient.put('SETTLEMENT', '/settlements/' + id, body); } else { await ApiClient.post('SETTLEMENT', '/settlements', body); } AppUtils.showToast('Settlement saved', 'success'); $('#settlementModal').modal('hide'); loadData(currentPage); } catch (e) {} }
</script>
