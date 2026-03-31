<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Purchase Orders"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Purchase Orders"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-file-invoice mr-2 text-primary"></i>Purchase Orders</h5><small class="text-muted">Inbound / Purchase Orders</small></div>
        <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#poModal" onclick="resetForm()"><i class="fas fa-plus mr-1"></i> New PO</button>
    </div>

    <div class="card mb-3">
        <div class="card-body py-2">
            <div class="row align-items-center">
                <div class="col-md-3"><input type="text" class="form-control form-control-sm" id="filterPO" placeholder="Search PO number..."></div>
                <div class="col-md-3"><select class="form-control form-control-sm" id="filterPOStatus"><option value="">All Status</option><option value="DRAFT">Draft</option><option value="APPROVED">Approved</option><option value="RECEIVED">Received</option><option value="CANCELLED">Cancelled</option></select></div>
                <div class="col-md-2"><button class="btn btn-primary btn-sm btn-block" onclick="loadData()"><i class="fas fa-search mr-1"></i>Search</button></div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="poTable">
                <thead><tr><th>#</th><th>PO Number</th><th>Supplier</th><th>PO Date</th><th>Total Items</th><th>Total Amount</th><th>Status</th><th class="text-center">Actions</th></tr></thead>
                <tbody><tr><td colspan="8" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="poPagination"></div>
    </div>
</main>

<div class="modal fade" id="poModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header"><h6 class="modal-title" id="poModalTitle">New Purchase Order</h6><button type="button" class="close" data-dismiss="modal">&times;</button></div>
            <form id="poForm">
                <div class="modal-body">
                    <input type="hidden" id="poId">
                    <div class="row">
                        <div class="col-md-4"><div class="form-group"><label>PO Number *</label><input type="text" class="form-control form-control-sm" id="poNumber" required></div></div>
                        <div class="col-md-4"><div class="form-group"><label>Supplier *</label><input type="text" class="form-control form-control-sm" id="poSupplier" required></div></div>
                        <div class="col-md-4"><div class="form-group"><label>PO Date *</label><input type="date" class="form-control form-control-sm" id="poDate" required></div></div>
                    </div>
                    <div class="form-group"><label>Notes</label><textarea class="form-control form-control-sm" id="poNotes" rows="2"></textarea></div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button><button type="submit" class="btn btn-sm btn-primary"><i class="fas fa-save mr-1"></i>Save</button></div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
document.addEventListener('configLoaded', function() { if (!Auth.requireAuth()) return; loadData(); $('#poForm').on('submit', function(e) { e.preventDefault(); saveData(); }); });

async function loadData(page) {
    currentPage = page || 0;
    try {
        var data = await ApiClient.get('TRANSACTION', '/purchase-orders?page=' + currentPage + '&size=15');
        if (data && data.data) {
            var items = data.data.content || [];
            AppUtils.buildTable('poTable', [
                { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
                { field: 'poNumber' }, { field: 'supplierName' },
                { field: 'poDate', formatter: function(v) { return AppUtils.formatDate(v); } },
                { field: 'totalItems' },
                { field: 'totalAmount', formatter: function(v) { return AppUtils.formatCurrency(v); } },
                { field: 'status', formatter: function(v) {
                    var cls = { 'DRAFT': 'secondary', 'APPROVED': 'primary', 'RECEIVED': 'success', 'CANCELLED': 'danger' }[v] || 'secondary';
                    return '<span class="badge badge-' + cls + ' badge-status">' + (v || '-') + '</span>';
                }}
            ], items, function(row) {
                return '<button class="btn btn-sm btn-outline-info btn-action" onclick="viewPO(' + row.id + ')"><i class="fas fa-eye"></i></button>' +
                       '<button class="btn btn-sm btn-outline-warning btn-action" onclick="editData(' + row.id + ')"><i class="fas fa-edit"></i></button>';
            });
            AppUtils.buildPagination('poPagination', currentPage, data.data.totalPages || 1, loadData);
        }
    } catch (e) { $('#poTable tbody').html('<tr><td colspan="8" class="text-center text-muted py-4">Failed to load data</td></tr>'); }
}

function resetForm() { $('#poModalTitle').text('New Purchase Order'); $('#poForm')[0].reset(); $('#poId').val(''); }
function viewPO(id) { window.location.href = '/inbound/purchase-orders/' + id; }
async function editData(id) { try { var data = await ApiClient.get('TRANSACTION', '/purchase-orders/' + id); if (data && data.data) { var po = data.data; $('#poModalTitle').text('Edit PO'); $('#poId').val(po.id); $('#poNumber').val(po.poNumber); $('#poSupplier').val(po.supplierName); $('#poDate').val(po.poDate); $('#poNotes').val(po.notes); $('#poModal').modal('show'); } } catch (e) {} }
async function saveData() { var id = $('#poId').val(); var body = { poNumber: $('#poNumber').val(), supplierName: $('#poSupplier').val(), poDate: $('#poDate').val(), notes: $('#poNotes').val() }; try { if (id) { await ApiClient.put('TRANSACTION', '/purchase-orders/' + id, body); AppUtils.showToast('PO updated', 'success'); } else { await ApiClient.post('TRANSACTION', '/purchase-orders', body); AppUtils.showToast('PO created', 'success'); } $('#poModal').modal('hide'); loadData(currentPage); } catch (e) {} }
</script>
