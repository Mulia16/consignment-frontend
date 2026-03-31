<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Delivery Orders"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Delivery Orders"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-shipping-fast mr-2 text-info"></i>Delivery Orders</h5><small class="text-muted">Outbound / Delivery Orders</small></div>
        <button class="btn btn-info btn-sm" data-toggle="modal" data-target="#doModal" onclick="resetForm()"><i class="fas fa-plus mr-1"></i> New Delivery</button>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="doTable">
                <thead><tr><th>#</th><th>DO Number</th><th>SO Reference</th><th>Customer</th><th>Delivery Date</th><th>Driver</th><th>Status</th><th class="text-center">Actions</th></tr></thead>
                <tbody><tr><td colspan="8" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="doPagination"></div>
    </div>
</main>

<div class="modal fade" id="doModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"><h6 class="modal-title" id="doModalTitle">New Delivery Order</h6><button type="button" class="close" data-dismiss="modal">&times;</button></div>
            <form id="doForm">
                <div class="modal-body">
                    <input type="hidden" id="doId">
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>DO Number *</label><input type="text" class="form-control form-control-sm" id="doNumber" required></div></div>
                        <div class="col-md-6"><div class="form-group"><label>SO Reference</label><input type="text" class="form-control form-control-sm" id="doSoRef"></div></div>
                    </div>
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>Customer</label><input type="text" class="form-control form-control-sm" id="doCustomer"></div></div>
                        <div class="col-md-6"><div class="form-group"><label>Delivery Date</label><input type="date" class="form-control form-control-sm" id="doDate"></div></div>
                    </div>
                    <div class="form-group"><label>Driver Name</label><input type="text" class="form-control form-control-sm" id="doDriver"></div>
                    <div class="form-group"><label>Notes</label><textarea class="form-control form-control-sm" id="doNotes" rows="2"></textarea></div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button><button type="submit" class="btn btn-sm btn-info"><i class="fas fa-save mr-1"></i>Save</button></div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
document.addEventListener('configLoaded', function() { if (!Auth.requireAuth()) return; loadData(); $('#doForm').on('submit', function(e) { e.preventDefault(); saveData(); }); });

async function loadData(page) {
    currentPage = page || 0;
    try {
        var data = await ApiClient.get('TRANSACTION', '/delivery-orders?page=' + currentPage + '&size=15');
        if (data && data.data) {
            var items = data.data.content || [];
            AppUtils.buildTable('doTable', [
                { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
                { field: 'doNumber' }, { field: 'soReference' }, { field: 'customerName' },
                { field: 'deliveryDate', formatter: function(v) { return AppUtils.formatDate(v); } },
                { field: 'driverName' },
                { field: 'status', formatter: function(v) {
                    var cls = { 'PENDING': 'warning', 'IN_TRANSIT': 'info', 'DELIVERED': 'success', 'CANCELLED': 'danger' }[v] || 'secondary';
                    return '<span class="badge badge-' + cls + ' badge-status">' + (v || '-') + '</span>';
                }}
            ], items, function(row) {
                return '<button class="btn btn-sm btn-outline-info btn-action"><i class="fas fa-eye"></i></button>';
            });
            AppUtils.buildPagination('doPagination', currentPage, data.data.totalPages || 1, loadData);
        }
    } catch (e) { $('#doTable tbody').html('<tr><td colspan="8" class="text-center text-muted py-4">Failed to load data</td></tr>'); }
}

function resetForm() { $('#doModalTitle').text('New Delivery Order'); $('#doForm')[0].reset(); $('#doId').val(''); }
async function saveData() { var body = { doNumber: $('#doNumber').val(), soReference: $('#doSoRef').val(), customerName: $('#doCustomer').val(), deliveryDate: $('#doDate').val(), driverName: $('#doDriver').val(), notes: $('#doNotes').val() }; try { await ApiClient.post('TRANSACTION', '/delivery-orders', body); AppUtils.showToast('Delivery order created', 'success'); $('#doModal').modal('hide'); loadData(currentPage); } catch (e) {} }
</script>
