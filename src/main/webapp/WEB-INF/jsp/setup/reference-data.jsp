<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Reference Data"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Reference Data"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-tags mr-2 text-primary"></i>Reference Data</h5><small class="text-muted">Setup / Reference Data</small></div>
        <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#refModal" onclick="resetForm()"><i class="fas fa-plus mr-1"></i> Add Reference</button>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="refTable">
                <thead><tr><th>#</th><th>Type</th><th>Code</th><th>Name</th><th>Description</th><th>Order</th><th>Status</th><th class="text-center">Actions</th></tr></thead>
                <tbody><tr><td colspan="8" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="refPagination"></div>
    </div>
</main>

<div class="modal fade" id="refModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"><h6 class="modal-title" id="refModalTitle">Add Reference</h6><button type="button" class="close" data-dismiss="modal">&times;</button></div>
            <form id="refForm">
                <div class="modal-body">
                    <input type="hidden" id="refId">
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>Type *</label><input type="text" class="form-control form-control-sm" id="refType" required placeholder="e.g. CATEGORY, UOM"></div></div>
                        <div class="col-md-6"><div class="form-group"><label>Code *</label><input type="text" class="form-control form-control-sm" id="refCode" required></div></div>
                    </div>
                    <div class="form-group"><label>Name *</label><input type="text" class="form-control form-control-sm" id="refName" required></div>
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>Sort Order</label><input type="number" class="form-control form-control-sm" id="refOrder" value="0"></div></div>
                        <div class="col-md-6"><div class="form-group"><label>Status</label><select class="form-control form-control-sm" id="refStatus"><option value="true">Active</option><option value="false">Inactive</option></select></div></div>
                    </div>
                    <div class="form-group"><label>Description</label><textarea class="form-control form-control-sm" id="refDesc" rows="2"></textarea></div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button><button type="submit" class="btn btn-sm btn-primary"><i class="fas fa-save mr-1"></i>Save</button></div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
document.addEventListener('configLoaded', function() { if (!Auth.requireAuth()) return; loadData(); $('#refForm').on('submit', function(e) { e.preventDefault(); saveData(); }); });

async function loadData(page) { currentPage = page || 0; try { var data = await ApiClient.get('MASTER_SETUP', '/reference-data?page=' + currentPage + '&size=15'); if (data && data.data) renderTable(data.data); } catch (e) { $('#refTable tbody').html('<tr><td colspan="8" class="text-center text-muted py-4">Failed to load</td></tr>'); } }

function renderTable(pagedData) {
    var items = pagedData.content || [];
    AppUtils.buildTable('refTable', [
        { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
        { field: 'type' }, { field: 'code' }, { field: 'name' }, { field: 'description' }, { field: 'sortOrder' },
        { field: 'active', formatter: function(v) { return v !== false ? '<span class="badge badge-success badge-status">Active</span>' : '<span class="badge badge-secondary badge-status">Inactive</span>'; } }
    ], items, function(row) {
        return '<button class="btn btn-sm btn-outline-info btn-action" onclick="editData(' + row.id + ')"><i class="fas fa-edit"></i></button>' +
               '<button class="btn btn-sm btn-outline-danger btn-action" onclick="deleteData(' + row.id + ')"><i class="fas fa-trash"></i></button>';
    });
    AppUtils.buildPagination('refPagination', currentPage, pagedData.totalPages || 1, loadData);
}

function resetForm() { $('#refModalTitle').text('Add Reference'); $('#refForm')[0].reset(); $('#refId').val(''); }
async function editData(id) { try { var data = await ApiClient.get('MASTER_SETUP', '/reference-data/' + id); if (data && data.data) { var r = data.data; $('#refModalTitle').text('Edit Reference'); $('#refId').val(r.id); $('#refType').val(r.type); $('#refCode').val(r.code); $('#refName').val(r.name); $('#refOrder').val(r.sortOrder); $('#refStatus').val(String(r.active !== false)); $('#refDesc').val(r.description); $('#refModal').modal('show'); } } catch (e) {} }
async function saveData() { var id = $('#refId').val(); var body = { type: $('#refType').val(), code: $('#refCode').val(), name: $('#refName').val(), sortOrder: parseInt($('#refOrder').val()) || 0, active: $('#refStatus').val() === 'true', description: $('#refDesc').val() }; try { if (id) { await ApiClient.put('MASTER_SETUP', '/reference-data/' + id, body); AppUtils.showToast('Updated', 'success'); } else { await ApiClient.post('MASTER_SETUP', '/reference-data', body); AppUtils.showToast('Created', 'success'); } $('#refModal').modal('hide'); loadData(currentPage); } catch (e) {} }
function deleteData(id) { AppUtils.confirm('Delete this reference?', async function() { try { await ApiClient.delete('MASTER_SETUP', '/reference-data/' + id); AppUtils.showToast('Deleted', 'success'); loadData(currentPage); } catch (e) {} }); }
</script>
