<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Reports"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Reports"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div><h5><i class="fas fa-chart-bar mr-2 text-primary"></i>Reports</h5><small class="text-muted">Report Center</small></div>
    </div>

    <div class="row">
        <!-- Inventory Reports -->
        <div class="col-md-4 mb-4">
            <div class="card h-100">
                <div class="card-header"><i class="fas fa-cubes mr-2 text-primary"></i>Inventory Reports</div>
                <div class="card-body">
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" onclick="generateReport('stock-balance')">
                            Stock Balance Report <span class="badge badge-primary badge-pill"><i class="fas fa-download"></i></span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" onclick="generateReport('stock-movement')">
                            Stock Movement Report <span class="badge badge-primary badge-pill"><i class="fas fa-download"></i></span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" onclick="generateReport('stock-aging')">
                            Stock Aging Report <span class="badge badge-primary badge-pill"><i class="fas fa-download"></i></span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Transaction Reports -->
        <div class="col-md-4 mb-4">
            <div class="card h-100">
                <div class="card-header"><i class="fas fa-exchange-alt mr-2 text-success"></i>Transaction Reports</div>
                <div class="card-body">
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" onclick="generateReport('purchase-order')">
                            Purchase Order Report <span class="badge badge-success badge-pill"><i class="fas fa-download"></i></span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" onclick="generateReport('sales-order')">
                            Sales Order Report <span class="badge badge-success badge-pill"><i class="fas fa-download"></i></span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" onclick="generateReport('pos-sales')">
                            POS Sales Report <span class="badge badge-success badge-pill"><i class="fas fa-download"></i></span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Settlement Reports -->
        <div class="col-md-4 mb-4">
            <div class="card h-100">
                <div class="card-header"><i class="fas fa-handshake mr-2 text-info"></i>Settlement Reports</div>
                <div class="card-body">
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" onclick="generateReport('settlement-summary')">
                            Settlement Summary <span class="badge badge-info badge-pill"><i class="fas fa-download"></i></span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" onclick="generateReport('payment-history')">
                            Payment History <span class="badge badge-info badge-pill"><i class="fas fa-download"></i></span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" onclick="generateReport('consignment-performance')">
                            Consignment Performance <span class="badge badge-info badge-pill"><i class="fas fa-download"></i></span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Report Parameters -->
    <div class="card" id="reportParams" style="display:none">
        <div class="card-header">
            <i class="fas fa-filter mr-2"></i>Report Parameters — <span id="reportName"></span>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-3"><div class="form-group"><label>From Date</label><input type="date" class="form-control form-control-sm" id="reportFrom"></div></div>
                <div class="col-md-3"><div class="form-group"><label>To Date</label><input type="date" class="form-control form-control-sm" id="reportTo"></div></div>
                <div class="col-md-3"><div class="form-group"><label>Format</label><select class="form-control form-control-sm" id="reportFormat"><option value="PDF">PDF</option><option value="EXCEL">Excel</option><option value="CSV">CSV</option></select></div></div>
                <div class="col-md-3 d-flex align-items-end">
                    <button class="btn btn-primary btn-block" onclick="downloadReport()"><i class="fas fa-download mr-1"></i>Generate Report</button>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="../common/footer.jsp"/>
<script>
document.addEventListener('configLoaded', function() { if (!Auth.requireAuth()) return; });

var selectedReport = '';

function generateReport(reportType) {
    selectedReport = reportType;
    $('#reportName').text(reportType.replace(/-/g, ' ').replace(/\b\w/g, function(l) { return l.toUpperCase(); }));
    $('#reportParams').slideDown();

    // Set default dates
    var today = new Date();
    var firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
    $('#reportTo').val(today.toISOString().split('T')[0]);
    $('#reportFrom').val(firstDay.toISOString().split('T')[0]);
}

async function downloadReport() {
    var params = '?reportType=' + selectedReport +
        '&fromDate=' + $('#reportFrom').val() +
        '&toDate=' + $('#reportTo').val() +
        '&format=' + $('#reportFormat').val();

    try {
        var url = API_CONFIG.getUrl('REPORT', '/generate' + params);
        var token = ApiClient.getToken();

        // Use direct fetch for file download
        var response = await fetch(url, {
            headers: { 'Authorization': 'Bearer ' + token }
        });

        if (response.ok) {
            var blob = await response.blob();
            var link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = selectedReport + '.' + $('#reportFormat').val().toLowerCase();
            link.click();
            AppUtils.showToast('Report downloaded', 'success');
        } else {
            AppUtils.showToast('Failed to generate report', 'danger');
        }
    } catch (e) {
        AppUtils.showToast('Report service unavailable', 'danger');
        console.error(e);
    }
}
</script>
