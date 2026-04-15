<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - Consignment System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
<div class="main-content">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="pageTitle" value="Reports"/>
    </jsp:include>

    <div class="container-fluid mt-3">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb bg-transparent p-0 m-0">
                <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Reports</li>
            </ol>
        </nav>

        <!-- Report Type Selection -->
        <div class="card shadow-sm mb-4">
            <div class="card-header bg-white font-weight-bold">
                <i class="fas fa-chart-bar mr-2 text-primary"></i> Report Center
            </div>
            <div class="card-body">
                <div class="row">
                    <!-- Transaction Reports -->
                    <div class="col-md-3 mb-3">
                        <h6 class="text-muted mb-2"><i class="fas fa-exchange-alt mr-1"></i> Transaction Reports</h6>
                        <div class="list-group list-group-flush">
                            <button class="list-group-item list-group-item-action report-btn" data-report="csrq">
                                <small class="text-muted">R01</small> CSRQ Report
                            </button>
                            <button class="list-group-item list-group-item-action report-btn" data-report="csrv">
                                <small class="text-muted">R02</small> CSRV Report
                            </button>
                            <button class="list-group-item list-group-item-action report-btn" data-report="cso">
                                <small class="text-muted">R03</small> CSO Report
                            </button>
                            <button class="list-group-item list-group-item-action report-btn" data-report="csdo">
                                <small class="text-muted">R04</small> CSDO Report
                            </button>
                            <button class="list-group-item list-group-item-action report-btn" data-report="csr">
                                <small class="text-muted">R05</small> CSR Report
                            </button>
                            <button class="list-group-item list-group-item-action report-btn" data-report="csa">
                                <small class="text-muted">R06</small> CSA Report
                            </button>
                        </div>
                    </div>

                    <!-- Settlement Reports -->
                    <div class="col-md-3 mb-3">
                        <h6 class="text-muted mb-2"><i class="fas fa-handshake mr-1"></i> Settlement Reports</h6>
                        <div class="list-group list-group-flush">
                            <button class="list-group-item list-group-item-action report-btn" data-report="settlement-summary">
                                <small class="text-muted">R07</small> Settlement Summary
                            </button>
                            <button class="list-group-item list-group-item-action report-btn" data-report="settlement-detail">
                                <small class="text-muted">R08</small> Settlement Detail
                            </button>
                        </div>
                    </div>

                    <!-- Inventory Reports -->
                    <div class="col-md-3 mb-3">
                        <h6 class="text-muted mb-2"><i class="fas fa-cubes mr-1"></i> Inventory Reports</h6>
                        <div class="list-group list-group-flush">
                            <button class="list-group-item list-group-item-action report-btn" data-report="supplier-book-value">
                                <small class="text-muted">R09</small> Supplier Book Value
                            </button>
                            <button class="list-group-item list-group-item-action report-btn" data-report="customer-inventory">
                                <small class="text-muted">R10</small> Customer Inventory
                            </button>
                            <button class="list-group-item list-group-item-action report-btn" data-report="reservations">
                                <small class="text-muted">R11</small> Reservations
                            </button>
                        </div>
                    </div>

                    <!-- Setup Reports -->
                    <div class="col-md-3 mb-3">
                        <h6 class="text-muted mb-2"><i class="fas fa-cogs mr-1"></i> Setup Reports</h6>
                        <div class="list-group list-group-flush">
                            <button class="list-group-item list-group-item-action report-btn" data-report="consignment-setup">
                                <small class="text-muted">R12</small> Consignment Setup
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Report Filter Panel -->
        <div class="card shadow-sm mb-4" id="reportFilterPanel" style="display:none">
            <div class="card-header bg-white font-weight-bold d-flex justify-content-between align-items-center">
                <span><i class="fas fa-filter mr-2 text-primary"></i> Filter — <span id="reportTitle" class="text-primary"></span></span>
                <button class="btn btn-sm btn-outline-secondary" onclick="toggleFilterBody()">
                    <i class="fas fa-chevron-up" id="filterToggleIcon"></i>
                </button>
            </div>
            <div class="card-body" id="filterBody">
                <!-- Dynamic filter form rendered by JS -->
                <div id="filterFormContainer"></div>
            </div>
        </div>

        <!-- Report Result Table -->
        <div class="card shadow-sm" id="reportResultPanel" style="display:none">
            <div class="card-header bg-white font-weight-bold">
                <i class="fas fa-table mr-2 text-success"></i> Results — <span id="resultTitle" class="text-success"></span>
            </div>
            <div class="card-body p-0 table-responsive">
                <table class="table table-hover table-sm mb-0 text-sm" id="reportTable">
                    <thead class="bg-light" id="reportTableHead">
                        <!-- Dynamic headers rendered by JS -->
                    </thead>
                    <tbody id="reportTableBody">
                        <!-- Dynamic data rendered by JS -->
                    </tbody>
                </table>
            </div>
            <div class="card-footer bg-white d-flex justify-content-between align-items-center">
                <small class="text-muted" id="reportTotalInfo">Showing 0 records</small>
                <div id="reportPagination"></div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
<script src="/static/js/consignment-master-data.js"></script>
<script src="/static/js/services/report-service.js"></script>

<script>
// ══════════════════════════════════════════════════════════
// REPORT CONFIGURATION
// ══════════════════════════════════════════════════════════
var REPORT_CONFIG = {
    'csrq': {
        title: 'R01 - CSRQ Report (Stock Requisition)',
        serviceMethod: 'getCSRQReport',
        filters: ['company', 'store', 'fromDate', 'toDate', 'supplierCode', 'status'],
        columns: [
            { key: 'docNo', label: 'Doc No' },
            { key: 'documentType', label: 'Doc Type' },
            { key: 'company', label: 'Company' },
            { key: 'store', label: 'Store' },
            { key: 'supplierCode', label: 'Supplier' },
            { key: 'supplierContract', label: 'Contract' },
            { key: 'itemCode', label: 'Item' },
            { key: 'qty', label: 'Qty', align: 'right' },
            { key: 'uom', label: 'UoM' },
            { key: 'status', label: 'Status', type: 'status' },
            { key: 'businessDate', label: 'Business Date', type: 'date' },
            { key: 'createdAt', label: 'Created At', type: 'datetime' }
        ]
    },
    'csrv': {
        title: 'R02 - CSRV Report (Stock Receiving)',
        serviceMethod: 'getCSRVReport',
        filters: ['company', 'store', 'fromDate', 'toDate'],
        columns: [
            { key: 'docNo', label: 'Doc No' },
            { key: 'documentType', label: 'Doc Type' },
            { key: 'company', label: 'Company' },
            { key: 'store', label: 'Store' },
            { key: 'supplierCode', label: 'Supplier' },
            { key: 'itemCode', label: 'Item' },
            { key: 'qty', label: 'Qty', align: 'right' },
            { key: 'status', label: 'Status', type: 'status' },
            { key: 'businessDate', label: 'Business Date', type: 'date' },
            { key: 'createdAt', label: 'Created At', type: 'datetime' }
        ]
    },
    'cso': {
        title: 'R03 - CSO Report (Stock Out)',
        serviceMethod: 'getCSOReport',
        filters: ['company', 'store', 'fromDate', 'toDate', 'customerCode'],
        columns: [
            { key: 'docNo', label: 'Doc No' },
            { key: 'documentType', label: 'Doc Type' },
            { key: 'company', label: 'Company' },
            { key: 'store', label: 'Store' },
            { key: 'customerCode', label: 'Customer' },
            { key: 'itemCode', label: 'Item' },
            { key: 'qty', label: 'Qty', align: 'right' },
            { key: 'uom', label: 'UoM' },
            { key: 'status', label: 'Status', type: 'status' },
            { key: 'businessDate', label: 'Business Date', type: 'date' },
            { key: 'createdAt', label: 'Created At', type: 'datetime' }
        ]
    },
    'csdo': {
        title: 'R04 - CSDO Report (Delivery Order)',
        serviceMethod: 'getCSDOReport',
        filters: ['company', 'store', 'fromDate', 'toDate'],
        columns: [
            { key: 'docNo', label: 'Doc No' },
            { key: 'documentType', label: 'Doc Type' },
            { key: 'company', label: 'Company' },
            { key: 'store', label: 'Store' },
            { key: 'customerCode', label: 'Customer' },
            { key: 'itemCode', label: 'Item' },
            { key: 'qty', label: 'Qty', align: 'right' },
            { key: 'uom', label: 'UoM' },
            { key: 'status', label: 'Status', type: 'status' },
            { key: 'businessDate', label: 'Business Date', type: 'date' },
            { key: 'createdAt', label: 'Created At', type: 'datetime' }
        ]
    },
    'csr': {
        title: 'R05 - CSR Report (Stock Return)',
        serviceMethod: 'getCSRReport',
        filters: ['company', 'store', 'fromDate', 'toDate'],
        columns: [
            { key: 'docNo', label: 'Doc No' },
            { key: 'documentType', label: 'Doc Type' },
            { key: 'company', label: 'Company' },
            { key: 'store', label: 'Store' },
            { key: 'supplierCode', label: 'Supplier' },
            { key: 'itemCode', label: 'Item' },
            { key: 'qty', label: 'Qty', align: 'right' },
            { key: 'uom', label: 'UoM' },
            { key: 'status', label: 'Status', type: 'status' },
            { key: 'businessDate', label: 'Business Date', type: 'date' },
            { key: 'createdAt', label: 'Created At', type: 'datetime' }
        ]
    },
    'csa': {
        title: 'R06 - CSA Report (Stock Adjustment)',
        serviceMethod: 'getCSAReport',
        filters: ['company', 'store', 'fromDate', 'toDate'],
        columns: [
            { key: 'docNo', label: 'Doc No' },
            { key: 'documentType', label: 'Doc Type' },
            { key: 'company', label: 'Company' },
            { key: 'store', label: 'Store' },
            { key: 'supplierCode', label: 'Supplier' },
            { key: 'itemCode', label: 'Item' },
            { key: 'qty', label: 'Qty', align: 'right' },
            { key: 'uom', label: 'UoM' },
            { key: 'status', label: 'Status', type: 'status' },
            { key: 'businessDate', label: 'Business Date', type: 'date' },
            { key: 'createdAt', label: 'Created At', type: 'datetime' }
        ]
    },
    'settlement-summary': {
        title: 'R07 - Settlement Summary',
        serviceMethod: 'getSettlementSummaryReport',
        filters: ['company', 'store', 'fromDate', 'toDate', 'settlementType'],
        columns: [
            { key: 'docNo', label: 'Doc No' },
            { key: 'documentType', label: 'Doc Type' },
            { key: 'company', label: 'Company' },
            { key: 'store', label: 'Store' },
            { key: 'customerCode', label: 'Customer' },
            { key: 'lineAmount', label: 'Amount', align: 'right', type: 'number' },
            { key: 'uom', label: 'Currency' },
            { key: 'status', label: 'Status', type: 'status' },
            { key: 'businessDate', label: 'Business Date', type: 'date' },
            { key: 'createdAt', label: 'Created At', type: 'datetime' }
        ]
    },
    'settlement-detail': {
        title: 'R08 - Settlement Detail',
        serviceMethod: 'getSettlementDetailReport',
        filters: ['settlementId'],
        columns: [
            { key: 'docNo', label: 'Doc No' },
            { key: 'documentType', label: 'Doc Type' },
            { key: 'company', label: 'Company' },
            { key: 'store', label: 'Store' },
            { key: 'itemCode', label: 'Item' },
            { key: 'qty', label: 'Qty', align: 'right' },
            { key: 'unitPrice', label: 'Unit Price', align: 'right', type: 'number' },
            { key: 'lineAmount', label: 'Line Amount', align: 'right', type: 'number' },
            { key: 'uom', label: 'UoM' },
            { key: 'businessDate', label: 'Business Date', type: 'date' },
            { key: 'createdAt', label: 'Created At', type: 'datetime' }
        ]
    },
    'supplier-book-value': {
        title: 'R09 - Supplier Book Value',
        serviceMethod: 'getSupplierBookValueReport',
        filters: ['store', 'supplierCode', 'supplierContract'],
        columns: [
            { key: 'store', label: 'Store' },
            { key: 'supplierCode', label: 'Supplier' },
            { key: 'supplierContract', label: 'Contract' },
            { key: 'itemCode', label: 'Item' },
            { key: 'purchaseQty', label: 'Purchase Qty', align: 'right' },
            { key: 'closingQty', label: 'Closing Qty', align: 'right' },
            { key: 'unbillQty', label: 'Unbill Qty', align: 'right' }
        ]
    },
    'customer-inventory': {
        title: 'R10 - Customer Inventory',
        serviceMethod: 'getCustomerInventoryReport',
        filters: ['store', 'customerCode'],
        columns: [
            { key: 'issueFromStore', label: 'Store' },
            { key: 'customerCode', label: 'Customer' },
            { key: 'branchCode', label: 'Branch' },
            { key: 'itemCode', label: 'Item' },
            { key: 'qty', label: 'Qty', align: 'right' }
        ]
    },
    'reservations': {
        title: 'R11 - Reservations',
        serviceMethod: 'getReservationsReport',
        filters: ['store', 'itemCode'],
        columns: [
            { key: 'docNo', label: 'Doc No' },
            { key: 'documentType', label: 'Doc Type' },
            { key: 'store', label: 'Store' },
            { key: 'itemCode', label: 'Item' },
            { key: 'qty', label: 'Qty', align: 'right' },
            { key: 'uom', label: 'UoM' },
            { key: 'businessDate', label: 'Business Date', type: 'date' },
            { key: 'createdAt', label: 'Created At', type: 'datetime' }
        ]
    },
    'consignment-setup': {
        title: 'R12 - Consignment Setup',
        serviceMethod: 'getConsignmentSetupReport',
        filters: ['company', 'store', 'supplierCode'],
        columns: [
            { key: 'itemCode', label: 'Item' },
            { key: 'company', label: 'Company' },
            { key: 'store', label: 'Store' },
            { key: 'supplierCode', label: 'Supplier' },
            { key: 'supplierContract', label: 'Contract' },
            { key: 'uom', label: 'UoM' },
            { key: 'createdAt', label: 'Created At', type: 'datetime' }
        ]
    }
};

var currentReport = null;

// ══════════════════════════════════════════════════════════
// INITIALIZATION
// ══════════════════════════════════════════════════════════
document.addEventListener('configLoaded', function() {
    if (!Auth.requireAuth()) return;
    ConsignmentMasterData.init();

    // Report button click handler
    $('.report-btn').on('click', function() {
        var reportType = $(this).data('report');
        selectReport(reportType);
        // Highlight active button
        $('.report-btn').removeClass('active bg-primary text-white');
        $(this).addClass('active bg-primary text-white');
    });

    // Auto-select report from URL query param
    var urlParams = new URLSearchParams(window.location.search);
    var reportType = urlParams.get('type');
    if (reportType && REPORT_CONFIG[reportType]) {
        selectReport(reportType);
        $('.report-btn[data-report="' + reportType + '"]').addClass('active bg-primary text-white');
    }
});

// ══════════════════════════════════════════════════════════
// REPORT SELECTION & FILTER RENDERING
// ══════════════════════════════════════════════════════════
function selectReport(reportType) {
    currentReport = reportType;
    var config = REPORT_CONFIG[reportType];
    if (!config) return;

    // Update title
    $('#reportTitle').text(config.title);
    $('#resultTitle').text(config.title);

    // Show filter panel
    $('#reportFilterPanel').slideDown();
    $('#reportResultPanel').hide();

    // Render filter form
    renderFilterForm(config.filters);

    // Render table headers
    renderTableHeaders(config.columns);
}

function renderFilterForm(filters) {
    var html = '<form id="reportFilterForm" onsubmit="return false;"><div class="row">';

    filters.forEach(function(filter) {
        html += '<div class="col-md-3 mb-3">';
        html += '<label class="small text-muted mb-1">' + getFilterLabel(filter) + '</label>';

        switch (filter) {
            case 'company':
                html += '<select class="form-control form-control-sm" name="company" id="company"><option value="">All Companies</option></select>';
                break;
            case 'store':
                html += '<select class="form-control form-control-sm" name="store" id="store"><option value="">All Stores</option></select>';
                break;
            case 'supplierCode':
                html += '<select class="form-control form-control-sm" name="supplierCode" id="supplierCode"><option value="">All Suppliers</option></select>';
                break;
            case 'supplierContract':
                html += '<select class="form-control form-control-sm" name="supplierContract" id="supplierContract"><option value="">All Contracts</option></select>';
                break;
            case 'customerCode':
                html += '<input type="text" class="form-control form-control-sm" name="customerCode" placeholder="Enter Customer Code">';
                break;
            case 'itemCode':
                html += '<input type="text" class="form-control form-control-sm" name="itemCode" placeholder="Enter Item Code">';
                break;
            case 'fromDate':
                html += '<input type="date" class="form-control form-control-sm" name="fromDate" id="fromDate">';
                break;
            case 'toDate':
                html += '<input type="date" class="form-control form-control-sm" name="toDate" id="toDate">';
                break;
            case 'status':
                html += '<select class="form-control form-control-sm" name="status">' +
                    '<option value="">All Status</option>' +
                    '<option value="HELD">Held</option>' +
                    '<option value="RELEASED">Released</option>' +
                    '<option value="COMPLETED">Completed</option>' +
                    '<option value="DRAFT">Draft</option>' +
                    '</select>';
                break;
            case 'settlementType':
                html += '<select class="form-control form-control-sm" name="settlementType">' +
                    '<option value="">All Types</option>' +
                    '<option value="SUPPLIER">Supplier</option>' +
                    '<option value="CUSTOMER">Customer</option>' +
                    '</select>';
                break;
            case 'settlementId':
                html += '<input type="text" class="form-control form-control-sm" name="settlementId" placeholder="Enter Settlement ID" required>';
                break;
        }

        html += '</div>';
    });

    // Add action buttons
    html += '<div class="col-md-3 mb-3 d-flex align-items-end">';
    html += '<button type="button" class="btn btn-sm btn-primary mr-2" onclick="runReport()"><i class="fas fa-search mr-1"></i> Generate</button>';
    html += '<button type="button" class="btn btn-sm btn-light" onclick="clearReportFilter()"><i class="fas fa-eraser mr-1"></i> Clear</button>';
    html += '</div>';

    html += '</div></form>';

    $('#filterFormContainer').html(html);

    // Set default dates
    var today = new Date();
    var firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
    if ($('#fromDate').length) $('#fromDate').val(firstDay.toISOString().split('T')[0]);
    if ($('#toDate').length) $('#toDate').val(today.toISOString().split('T')[0]);

    // Re-load master data for the newly created dropdowns
    // ConsignmentMasterData.init() already loaded companies on page load,
    // but renderFilterForm() replaces the DOM elements, so we need to reload
    if ($('#company').length) {
        ConsignmentMasterData.loadCompanies();
    }
}

function getFilterLabel(filter) {
    var labels = {
        'company': 'Company',
        'store': 'Store',
        'supplierCode': 'Supplier',
        'supplierContract': 'Contract',
        'customerCode': 'Customer Code',
        'itemCode': 'Item Code',
        'fromDate': 'From Date',
        'toDate': 'To Date',
        'status': 'Status',
        'settlementType': 'Settlement Type',
        'settlementId': 'Settlement ID'
    };
    return labels[filter] || filter;
}

function renderTableHeaders(columns) {
    var html = '<tr>';
    html += '<th width="40" class="text-center">#</th>';
    columns.forEach(function(col) {
        var align = col.align ? 'text-' + col.align : '';
        html += '<th class="' + align + '">' + col.label + '</th>';
    });
    html += '</tr>';
    $('#reportTableHead').html(html);
}

// ══════════════════════════════════════════════════════════
// REPORT EXECUTION
// ══════════════════════════════════════════════════════════
async function runReport() {
    if (!currentReport) return;

    var config = REPORT_CONFIG[currentReport];
    var params = getFilterParams();

    // Validate required params for settlement-detail
    if (currentReport === 'settlement-detail' && !params.settlementId) {
        AppUtils.showToast('Settlement ID is required', 'warning');
        return;
    }

    // Show loading
    $('#reportResultPanel').show();
    $('#reportTableBody').html('<tr><td colspan="20" class="text-center py-4"><div class="spinner-border text-primary" role="status"><span class="sr-only">Loading...</span></div></td></tr>');
    $('#reportTotalInfo').text('Loading...');

    try {
        var response;

        // Special handling for settlement-detail (uses path param)
        if (currentReport === 'settlement-detail') {
            var settlementId = params.settlementId;
            delete params.settlementId;
            response = await ReportService.getSettlementDetailReport(settlementId);
        } else {
            response = await ReportService[config.serviceMethod](params);
        }

        var data = response.data || response;

        // Handle single object response (settlement-detail)
        if (!Array.isArray(data)) {
            data = [data];
        }

        renderTableData(data, config.columns);
        $('#reportTotalInfo').text('Showing ' + data.length + ' record(s)');
        $('#reportPagination').empty();

        if (data.length === 0) {
            $('#reportTableBody').html('<tr><td colspan="20" class="text-center py-4 text-muted"><i class="fas fa-inbox fa-2x mb-2 d-block"></i>No records found</td></tr>');
        }

    } catch (error) {
        console.error('Error generating report:', error);
        $('#reportTableBody').html('<tr><td colspan="20" class="text-center py-4 text-danger"><i class="fas fa-exclamation-triangle fa-2x mb-2 d-block"></i>Failed to generate report. Please try again.</td></tr>');
        $('#reportTotalInfo').text('Error');
    }
}

function renderTableData(data, columns) {
    var tbody = $('#reportTableBody');
    tbody.empty();

    data.forEach(function(row, idx) {
        var html = '<tr>';
        html += '<td class="text-center text-muted">' + (idx + 1) + '</td>';

        columns.forEach(function(col) {
            var val = row[col.key];
            var align = col.align ? 'text-' + col.align : '';
            var formatted = formatCellValue(val, col.type);

            html += '<td class="' + align + '">' + formatted + '</td>';
        });

        html += '</tr>';
        tbody.append(html);
    });
}

function formatCellValue(value, type) {
    if (value === null || value === undefined) return '<span class="text-muted">-</span>';

    switch (type) {
        case 'date':
            return AppUtils.formatDate(value);
        case 'datetime':
            return AppUtils.formatDateTime(value);
        case 'status':
            return formatStatusBadge(value);
        case 'number':
            return formatNumber(value);
        default:
            return escapeHtml(String(value));
    }
}

function formatStatusBadge(status) {
    if (!status) return '<span class="text-muted">-</span>';
    var cls = {
        'RELEASED': 'badge-success',
        'HELD': 'badge-warning',
        'COMPLETED': 'badge-info',
        'DRAFT': 'badge-secondary',
        'ACTIVE': 'badge-success',
        'INACTIVE': 'badge-danger'
    }[status] || 'badge-secondary';
    return '<span class="badge ' + cls + '">' + escapeHtml(status) + '</span>';
}

function formatNumber(num) {
    if (num === null || num === undefined) return '<span class="text-muted">-</span>';
    return parseFloat(num).toLocaleString('id-ID', { minimumFractionDigits: 0, maximumFractionDigits: 2 });
}

function escapeHtml(text) {
    var div = document.createElement('div');
    div.appendChild(document.createTextNode(text));
    return div.innerHTML;
}

// ══════════════════════════════════════════════════════════
// HELPERS
// ══════════════════════════════════════════════════════════
function getFilterParams() {
    var params = {};
    var formData = $('#reportFilterForm').serializeArray();
    formData.forEach(function(field) {
        if (field.value) params[field.name] = field.value;
    });
    return params;
}

function clearReportFilter() {
    if (!currentReport) return;
    var config = REPORT_CONFIG[currentReport];
    renderFilterForm(config.filters);
    $('#reportResultPanel').slideUp();
}

function toggleFilterBody() {
    var body = $('#filterBody');
    var icon = $('#filterToggleIcon');
    body.slideToggle(function() {
        icon.toggleClass('fa-chevron-up fa-chevron-down');
    });
}
</script>

<style>
.text-sm { font-size: 0.85rem; }
.card-header { padding: 0.75rem 1.25rem; font-size: 0.95rem; }
.report-btn { font-size: 0.85rem; padding: 0.4rem 0.75rem; cursor: pointer; border: none; text-align: left; }
.report-btn:hover { background-color: #e9ecef; }
.report-btn.active { font-weight: 500; }
.list-group-item + .list-group-item { border-top: 1px solid rgba(0,0,0,0.06); }
</style>

</body>
</html>
