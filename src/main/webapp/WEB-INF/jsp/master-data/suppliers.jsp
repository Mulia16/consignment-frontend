<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Suppliers"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Supplier Management"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div>
            <h5><i class="fas fa-truck mr-2 text-primary"></i>Suppliers</h5>
            <small class="text-muted">Master Data / Suppliers</small>
        </div>
        <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#supplierModal" onclick="resetForm()">
            <i class="fas fa-plus mr-1"></i> Add Supplier
        </button>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="suppliersTable">
                <thead>
                    <tr>
                        <th>#</th><th>Supplier Code</th><th>Supplier Name</th><th>Contact</th><th>Phone</th><th>City</th><th>Status</th><th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody><tr><td colspan="8" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="suppliersPagination"></div>
    </div>
</main>

<!-- Supplier Modal -->
<div class="modal fade" id="supplierModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="supplierModalTitle">Add Supplier</h6>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <form id="supplierForm">
                <div class="modal-body">
                    <input type="hidden" id="supplierId">
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>Supplier Code *</label><input type="text" class="form-control form-control-sm" id="supplierCode" required></div></div>
                        <div class="col-md-6"><div class="form-group"><label>Supplier Name *</label><input type="text" class="form-control form-control-sm" id="supplierName" required></div></div>
                    </div>
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>Contact Person</label><input type="text" class="form-control form-control-sm" id="contactPerson"></div></div>
                        <div class="col-md-6"><div class="form-group"><label>Phone</label><input type="text" class="form-control form-control-sm" id="supplierPhone"></div></div>
                    </div>
                    <div class="form-group"><label>Email</label><input type="email" class="form-control form-control-sm" id="supplierEmail"></div>
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>City</label><input type="text" class="form-control form-control-sm" id="supplierCity"></div></div>
                        <div class="col-md-6"><div class="form-group"><label>NPWP</label><input type="text" class="form-control form-control-sm" id="supplierNpwp"></div></div>
                    </div>
                    <div class="form-group"><label>Address</label><textarea class="form-control form-control-sm" id="supplierAddress" rows="2"></textarea></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-sm btn-primary"><i class="fas fa-save mr-1"></i>Save</button>
                </div>
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
    $('#supplierForm').on('submit', function(e) { e.preventDefault(); saveData(); });
});

async function loadData(page) {
    currentPage = page || 0;
    try {
        var data = await ApiClient.get('MASTER_SETUP', '/suppliers?page=' + currentPage + '&size=15');
        if (data && data.data) { renderTable(data.data); }
    } catch (e) { $('#suppliersTable tbody').html('<tr><td colspan="8" class="text-center text-muted py-4">Failed to load data</td></tr>'); }
}

function renderTable(pagedData) {
    var items = pagedData.content || [];
    var columns = [
        { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
        { field: 'supplierCode' }, { field: 'supplierName' }, { field: 'contactPerson' },
        { field: 'phone' }, { field: 'city' },
        { field: 'active', formatter: function(v) { return v !== false ? '<span class="badge badge-success badge-status">Active</span>' : '<span class="badge badge-secondary badge-status">Inactive</span>'; } }
    ];
    AppUtils.buildTable('suppliersTable', columns, items, function(row) {
        return '<button class="btn btn-sm btn-outline-info btn-action" onclick="editData(' + row.id + ')"><i class="fas fa-edit"></i></button>' +
               '<button class="btn btn-sm btn-outline-danger btn-action" onclick="deleteData(' + row.id + ')"><i class="fas fa-trash"></i></button>';
    });
    AppUtils.buildPagination('suppliersPagination', currentPage, pagedData.totalPages || 1, loadData);
}

function resetForm() { $('#supplierModalTitle').text('Add Supplier'); $('#supplierForm')[0].reset(); $('#supplierId').val(''); }

async function editData(id) {
    try {
        var data = await ApiClient.get('MASTER_SETUP', '/suppliers/' + id);
        if (data && data.data) {
            var s = data.data;
            $('#supplierModalTitle').text('Edit Supplier');
            $('#supplierId').val(s.id); $('#supplierCode').val(s.supplierCode); $('#supplierName').val(s.supplierName);
            $('#contactPerson').val(s.contactPerson); $('#supplierPhone').val(s.phone); $('#supplierEmail').val(s.email);
            $('#supplierCity').val(s.city); $('#supplierNpwp').val(s.npwp); $('#supplierAddress').val(s.address);
            $('#supplierModal').modal('show');
        }
    } catch (e) { console.error(e); }
}

async function saveData() {
    var id = $('#supplierId').val();
    var body = { supplierCode: $('#supplierCode').val(), supplierName: $('#supplierName').val(), contactPerson: $('#contactPerson').val(),
        phone: $('#supplierPhone').val(), email: $('#supplierEmail').val(), city: $('#supplierCity').val(), npwp: $('#supplierNpwp').val(), address: $('#supplierAddress').val() };
    try {
        if (id) { await ApiClient.put('MASTER_SETUP', '/suppliers/' + id, body); AppUtils.showToast('Supplier updated', 'success'); }
        else { await ApiClient.post('MASTER_SETUP', '/suppliers', body); AppUtils.showToast('Supplier created', 'success'); }
        $('#supplierModal').modal('hide'); loadData(currentPage);
    } catch (e) { console.error(e); }
}

function deleteData(id) {
    AppUtils.confirm('Delete this supplier?', async function() {
        try { await ApiClient.delete('MASTER_SETUP', '/suppliers/' + id); AppUtils.showToast('Supplier deleted', 'success'); loadData(currentPage); } catch (e) {}
    });
}
</script>
