<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Sales Orders"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Sales Orders"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-file-invoice-dollar mr-2 text-info"></i>Sales Orders</h5><small class="text-muted">Outbound / Sales Orders</small></div>
        <button class="btn btn-info btn-sm" data-toggle="modal" data-target="#soModal" onclick="resetForm()"><i class="fas fa-plus mr-1"></i> New Sales Order</button>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="soTable">
                <thead><tr><th>#</th><th>SO Number</th><th>Customer</th><th>Order Date</th><th>Total Items</th><th>Total Amount</th><th>Status</th><th class="text-center">Actions</th></tr></thead>
                <tbody><tr><td colspan="8" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="soPagination"></div>
    </div>
</main>

<div class="modal fade" id="soModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header"><h6 class="modal-title" id="soModalTitle">New Sales Order</h6><button type="button" class="close" data-dismiss="modal">&times;</button></div>
            <form id="soForm">
                <div class="modal-body">
                    <input type="hidden" id="soId">
                    <div class="row">
                        <div class="col-md-4"><div class="form-group"><label>SO Number *</label><input type="text" class="form-control form-control-sm" id="soNumber" required></div></div>
                        <div class="col-md-4"><div class="form-group"><label>Customer *</label><input type="text" class="form-control form-control-sm" id="soCustomer" required></div></div>
                        <div class="col-md-4"><div class="form-group"><label>Order Date *</label><input type="date" class="form-control form-control-sm" id="soDate" required></div></div>
                    </div>
                    <div class="form-group"><label>Notes</label><textarea class="form-control form-control-sm" id="soNotes" rows="2"></textarea></div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button><button type="submit" class="btn btn-sm btn-info"><i class="fas fa-save mr-1"></i>Save</button></div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
document.addEventListener('configLoaded', function() { if (!Auth.requireAuth()) return; loadData(); $('#soForm').on('submit', function(e) { e.preventDefault(); saveData(); }); });

async function loadData(page) {
    currentPage = page || 0;
    try {
        var data = await ApiClient.get('TRANSACTION', '/sales-orders?page=' + currentPage + '&size=15');
        if (data && data.data) {
            var items = data.data.content || [];
            AppUtils.buildTable('soTable', [
                { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
                { field: 'soNumber' }, { field: 'customerName' },
                { field: 'orderDate', formatter: function(v) { return AppUtils.formatDate(v); } },
                { field: 'totalItems' },
                { field: 'totalAmount', formatter: function(v) { return AppUtils.formatCurrency(v); } },
                { field: 'status', formatter: function(v) {
                    var cls = { 'DRAFT': 'secondary', 'CONFIRMED': 'primary', 'SHIPPED': 'info', 'DELIVERED': 'success', 'CANCELLED': 'danger' }[v] || 'secondary';
                    return '<span class="badge badge-' + cls + ' badge-status">' + (v || '-') + '</span>';
                }}
            ], items, function(row) {
                return '<button class="btn btn-sm btn-outline-info btn-action"><i class="fas fa-eye"></i></button>' +
                       '<button class="btn btn-sm btn-outline-warning btn-action" onclick="editData(' + row.id + ')"><i class="fas fa-edit"></i></button>';
            });
            AppUtils.buildPagination('soPagination', currentPage, data.data.totalPages || 1, loadData);
        }
    } catch (e) { $('#soTable tbody').html('<tr><td colspan="8" class="text-center text-muted py-4">Failed to load data</td></tr>'); }
}

function resetForm() { $('#soModalTitle').text('New Sales Order'); $('#soForm')[0].reset(); $('#soId').val(''); }
async function editData(id) { try { var data = await ApiClient.get('TRANSACTION', '/sales-orders/' + id); if (data && data.data) { var so = data.data; $('#soModalTitle').text('Edit Sales Order'); $('#soId').val(so.id); $('#soNumber').val(so.soNumber); $('#soCustomer').val(so.customerName); $('#soDate').val(so.orderDate); $('#soNotes').val(so.notes); $('#soModal').modal('show'); } } catch (e) {} }
async function saveData() { var id = $('#soId').val(); var body = { soNumber: $('#soNumber').val(), customerName: $('#soCustomer').val(), orderDate: $('#soDate').val(), notes: $('#soNotes').val() }; try { if (id) { await ApiClient.put('TRANSACTION', '/sales-orders/' + id, body); } else { await ApiClient.post('TRANSACTION', '/sales-orders', body); } AppUtils.showToast('Sales order saved', 'success'); $('#soModal').modal('hide'); loadData(currentPage); } catch (e) {} }
</script>
