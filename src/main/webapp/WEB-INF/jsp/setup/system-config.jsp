<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="System Config"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="System Configuration"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-sliders-h mr-2 text-primary"></i>System Configuration</h5><small class="text-muted">Setup / System Config</small></div>
        <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#configModal" onclick="resetForm()"><i class="fas fa-plus mr-1"></i> Add Config</button>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="configTable">
                <thead><tr><th>#</th><th>Config Key</th><th>Config Value</th><th>Description</th><th>Module</th><th>Updated At</th><th class="text-center">Actions</th></tr></thead>
                <tbody><tr><td colspan="7" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="configPagination"></div>
    </div>
</main>

<div class="modal fade" id="configModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"><h6 class="modal-title" id="configModalTitle">Add Config</h6><button type="button" class="close" data-dismiss="modal">&times;</button></div>
            <form id="configForm">
                <div class="modal-body">
                    <input type="hidden" id="configId">
                    <div class="form-group"><label>Config Key *</label><input type="text" class="form-control form-control-sm" id="configKey" required></div>
                    <div class="form-group"><label>Config Value *</label><input type="text" class="form-control form-control-sm" id="configValue" required></div>
                    <div class="form-group"><label>Module</label><input type="text" class="form-control form-control-sm" id="configModule"></div>
                    <div class="form-group"><label>Description</label><textarea class="form-control form-control-sm" id="configDesc" rows="2"></textarea></div>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button><button type="submit" class="btn btn-sm btn-primary"><i class="fas fa-save mr-1"></i>Save</button></div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
document.addEventListener('configLoaded', function() { if (!Auth.requireAuth()) return; loadData(); $('#configForm').on('submit', function(e) { e.preventDefault(); saveData(); }); });

async function loadData(page) { currentPage = page || 0; try { var data = await ApiClient.get('MASTER_SETUP', '/system-configs?page=' + currentPage + '&size=15'); if (data && data.data) renderTable(data.data); } catch (e) { $('#configTable tbody').html('<tr><td colspan="7" class="text-center text-muted py-4">Failed to load</td></tr>'); } }

function renderTable(pagedData) {
    var items = pagedData.content || [];
    AppUtils.buildTable('configTable', [
        { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
        { field: 'configKey' }, { field: 'configValue' }, { field: 'description' }, { field: 'module' },
        { field: 'updatedAt', formatter: function(v) { return AppUtils.formatDateTime(v); } }
    ], items, function(row) {
        return '<button class="btn btn-sm btn-outline-info btn-action" onclick="editData(' + row.id + ')"><i class="fas fa-edit"></i></button>' +
               '<button class="btn btn-sm btn-outline-danger btn-action" onclick="deleteData(' + row.id + ')"><i class="fas fa-trash"></i></button>';
    });
    AppUtils.buildPagination('configPagination', currentPage, pagedData.totalPages || 1, loadData);
}

function resetForm() { $('#configModalTitle').text('Add Config'); $('#configForm')[0].reset(); $('#configId').val(''); }
async function editData(id) { try { var data = await ApiClient.get('MASTER_SETUP', '/system-configs/' + id); if (data && data.data) { var c = data.data; $('#configModalTitle').text('Edit Config'); $('#configId').val(c.id); $('#configKey').val(c.configKey); $('#configValue').val(c.configValue); $('#configModule').val(c.module); $('#configDesc').val(c.description); $('#configModal').modal('show'); } } catch (e) {} }
async function saveData() { var id = $('#configId').val(); var body = { configKey: $('#configKey').val(), configValue: $('#configValue').val(), module: $('#configModule').val(), description: $('#configDesc').val() }; try { if (id) { await ApiClient.put('MASTER_SETUP', '/system-configs/' + id, body); AppUtils.showToast('Config updated', 'success'); } else { await ApiClient.post('MASTER_SETUP', '/system-configs', body); AppUtils.showToast('Config created', 'success'); } $('#configModal').modal('hide'); loadData(currentPage); } catch (e) {} }
function deleteData(id) { AppUtils.confirm('Delete this config?', async function() { try { await ApiClient.delete('MASTER_SETUP', '/system-configs/' + id); AppUtils.showToast('Deleted', 'success'); loadData(currentPage); } catch (e) {} }); }
</script>
