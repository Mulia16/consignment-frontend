<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Companies"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Company Management"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div>
            <h5><i class="fas fa-building mr-2 text-primary"></i>Companies</h5>
            <small class="text-muted">Master Data / Companies</small>
        </div>
    </div>

    <div class="card">
        <div class="card-header bg-white">
            <h6 class="mb-0"><i class="fas fa-info-circle mr-2 text-info"></i>Company List</h6>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="companiesTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Company Code</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td colspan="3" class="text-center py-4 text-muted">Loading...</td></tr>
                </tbody>
            </table>
        </div>
    </div>
</main>

<jsp:include page="../common/footer.jsp"/>
<script>
document.addEventListener('configLoaded', function() {
    if (!Auth.requireAuth()) return;
    loadData();
});

async function loadData() {
    try {
        var response = await ApiClient.get('CONSIGNMENT', '/master-data/companies');
        var data = response.data || response || [];
        renderTable(data);
    } catch (e) {
        $('#companiesTable tbody').html('<tr><td colspan="3" class="text-center text-muted py-4">Failed to load data</td></tr>');
        console.error('Failed to load companies:', e);
    }
}

function renderTable(items) {
    if (!items || items.length === 0) {
        $('#companiesTable tbody').html('<tr><td colspan="3" class="text-center text-muted py-4">No data available</td></tr>');
        return;
    }
    
    var html = '';
    items.forEach(function(item, index) {
        html += '<tr>' +
            '<td>' + (index + 1) + '</td>' +
            '<td><span class="font-weight-semibold">' + item + '</span></td>' +
            '<td class="text-center">' +
                '<button class="btn btn-sm btn-outline-info btn-action" title="View Stores" onclick="viewStores(\'' + item + '\')">' +
                    '<i class="fas fa-store"></i>' +
                '</button>' +
            '</td>' +
        '</tr>';
    });
    $('#companiesTable tbody').html(html);
}

function viewStores(companyCode) {
    window.location.href = '/master-data/stores?company=' + encodeURIComponent(companyCode);
}
</script>
