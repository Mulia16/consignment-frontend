<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Audit & Trace Log"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Audit & Trace Log"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-history mr-2 text-primary"></i>Audit & Trace Log</h5><small class="text-muted">System / Audit Log</small></div>
        <button class="btn btn-outline-secondary btn-sm" onclick="loadData()"><i class="fas fa-sync-alt mr-1"></i>Refresh</button>
    </div>

    <div class="card mb-3">
        <div class="card-body py-2">
            <div class="row align-items-center">
                <div class="col-md-2"><input type="date" class="form-control form-control-sm" id="logDateFrom"></div>
                <div class="col-md-2"><input type="date" class="form-control form-control-sm" id="logDateTo"></div>
                <div class="col-md-2"><select class="form-control form-control-sm" id="logAction"><option value="">All Actions</option><option value="CREATE">Create</option><option value="UPDATE">Update</option><option value="DELETE">Delete</option><option value="LOGIN">Login</option></select></div>
                <div class="col-md-2"><input type="text" class="form-control form-control-sm" id="logUser" placeholder="Username"></div>
                <div class="col-md-2"><input type="text" class="form-control form-control-sm" id="logEntity" placeholder="Entity type"></div>
                <div class="col-md-1"><button class="btn btn-primary btn-sm btn-block" onclick="loadData()"><i class="fas fa-search"></i></button></div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover table-sm mb-0" id="logTable">
                <thead><tr><th>#</th><th>Timestamp</th><th>User</th><th>Action</th><th>Entity</th><th>Entity ID</th><th>IP Address</th><th>Details</th></tr></thead>
                <tbody><tr><td colspan="8" class="text-center py-4 text-muted">Loading...</td></tr></tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="logPagination"></div>
    </div>
</main>

<jsp:include page="../common/footer.jsp"/>
<script>
var currentPage = 0;
document.addEventListener('configLoaded', function() { if (!Auth.requireAuth()) return; loadData(); });

async function loadData(page) {
    currentPage = page || 0;
    try {
        var data = await ApiClient.get('TRACE_LOG', '/audit-trails?page=' + currentPage + '&size=20');
        if (data && data.data) {
            var items = data.data.content || [];
            AppUtils.buildTable('logTable', [
                { field: '_index', formatter: function(v, row) { return (currentPage * 20) + items.indexOf(row) + 1; } },
                { field: 'timestamp', formatter: function(v) { return AppUtils.formatDateTime(v); } },
                { field: 'username' },
                { field: 'action', formatter: function(v) {
                    var cls = { 'CREATE': 'success', 'UPDATE': 'info', 'DELETE': 'danger', 'LOGIN': 'primary' }[v] || 'secondary';
                    return '<span class="badge badge-' + cls + '">' + (v || '-') + '</span>';
                }},
                { field: 'entityType' }, { field: 'entityId' }, { field: 'ipAddress' },
                { field: 'details', formatter: function(v) { return v ? '<small class="text-muted">' + (v.length > 60 ? v.substring(0, 60) + '...' : v) + '</small>' : '-'; } }
            ], items);
            AppUtils.buildPagination('logPagination', currentPage, data.data.totalPages || 1, loadData);
        }
    } catch (e) { $('#logTable tbody').html('<tr><td colspan="8" class="text-center text-muted py-4">Failed to load data</td></tr>'); }
}
</script>
