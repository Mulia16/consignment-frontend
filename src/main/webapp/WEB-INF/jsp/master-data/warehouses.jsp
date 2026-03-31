<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Warehouses"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Warehouse Management"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-warehouse mr-2 text-primary"></i>Warehouses</h5><small class="text-muted">Master Data / Warehouses</small></div>
        <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#warehouseModal" onclick="resetForm()"><i class="fas fa-plus mr-1"></i> Add Warehouse</button>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="warehousesTable">
                <thead><tr><th>#</th><th>Code</th><th>Name</th><th>Location</th><th>Type</th><th>Capacity</th><th>Status</th><th class="text-center">Actions</th></tr></thead>
                <tbody><tr><td colspan="8" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="warehousesPagination"></div>
    </div>
</main>

<div class="modal fade" id="warehouseModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"><h6 class="modal-title" id="warehouseModalTitle">Add Warehouse</h6><button type="button" class="close" data-dismiss="modal">&times;</button></div>
            <form id="warehouseForm">
                <div class="modal-body">
                    <input type="hidden" id="warehouseId">
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>Code *</label><input type="text" class="form-control form-control-sm" id="warehouseCode" required></div></div>
                        <div class="col-md-6"><div class="form-group"><label>Name *</label><input type="text" class="form-control form-control-sm" id="warehouseName" required></div></div>
                    </div>
                    <div class="row">
                        <div class="col-md-6"><div class="form-group"><label>Type</label><select class="form-control form-control-sm" id="warehouseType"><option value="MAIN">Main</option><option value="CONSIGNMENT">Consignment</option><option value="TRANSIT">Transit</option></select></div></div>
                        <div class="col-md-6"><div class="form-group"><label>Capacity</label><input type="number" class="form-control form-control-sm" id="warehouseCapacity"></div></div>
                    </div>
                    <div class="form-group"><label>Location</label><input type="text" class="form-control form-control-sm" id="warehouseLocation"></div>
                    <div class="form-group"><label>Address</label><textarea class="form-control form-control-sm" id="warehouseAddress" rows="2"></textarea></div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button><button type="submit" class="btn btn-sm btn-primary"><i class="fas fa-save mr-1"></i>Save</button></div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
document.addEventListener('configLoaded', function() { if (!Auth.requireAuth()) return; loadData(); $('#warehouseForm').on('submit', function(e) { e.preventDefault(); saveData(); }); });

async function loadData(page) {
    currentPage = page || 0;
    try { var data = await ApiClient.get('MASTER_SETUP', '/warehouses?page=' + currentPage + '&size=15'); if (data && data.data) renderTable(data.data); }
    catch (e) { $('#warehousesTable tbody').html('<tr><td colspan="8" class="text-center text-muted py-4">Failed to load data</td></tr>'); }
}

function renderTable(pagedData) {
    var items = pagedData.content || [];
    AppUtils.buildTable('warehousesTable', [
        { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
        { field: 'warehouseCode' }, { field: 'warehouseName' }, { field: 'location' }, { field: 'type' },
        { field: 'capacity' },
        { field: 'active', formatter: function(v) { return v !== false ? '<span class="badge badge-success badge-status">Active</span>' : '<span class="badge badge-secondary badge-status">Inactive</span>'; } }
    ], items, function(row) {
        return '<button class="btn btn-sm btn-outline-info btn-action" onclick="editData(' + row.id + ')"><i class="fas fa-edit"></i></button>' +
               '<button class="btn btn-sm btn-outline-danger btn-action" onclick="deleteData(' + row.id + ')"><i class="fas fa-trash"></i></button>';
    });
    AppUtils.buildPagination('warehousesPagination', currentPage, pagedData.totalPages || 1, loadData);
}

function resetForm() { $('#warehouseModalTitle').text('Add Warehouse'); $('#warehouseForm')[0].reset(); $('#warehouseId').val(''); }
async function editData(id) { try { var data = await ApiClient.get('MASTER_SETUP', '/warehouses/' + id); if (data && data.data) { var w = data.data; $('#warehouseModalTitle').text('Edit Warehouse'); $('#warehouseId').val(w.id); $('#warehouseCode').val(w.warehouseCode); $('#warehouseName').val(w.warehouseName); $('#warehouseType').val(w.type); $('#warehouseCapacity').val(w.capacity); $('#warehouseLocation').val(w.location); $('#warehouseAddress').val(w.address); $('#warehouseModal').modal('show'); } } catch (e) {} }
async function saveData() { var id = $('#warehouseId').val(); var body = { warehouseCode: $('#warehouseCode').val(), warehouseName: $('#warehouseName').val(), type: $('#warehouseType').val(), capacity: parseInt($('#warehouseCapacity').val()) || 0, location: $('#warehouseLocation').val(), address: $('#warehouseAddress').val() }; try { if (id) { await ApiClient.put('MASTER_SETUP', '/warehouses/' + id, body); AppUtils.showToast('Warehouse updated', 'success'); } else { await ApiClient.post('MASTER_SETUP', '/warehouses', body); AppUtils.showToast('Warehouse created', 'success'); } $('#warehouseModal').modal('hide'); loadData(currentPage); } catch (e) {} }
function deleteData(id) { AppUtils.confirm('Delete this warehouse?', async function() { try { await ApiClient.delete('MASTER_SETUP', '/warehouses/' + id); AppUtils.showToast('Deleted', 'success'); loadData(currentPage); } catch (e) {} }); }
</script>
