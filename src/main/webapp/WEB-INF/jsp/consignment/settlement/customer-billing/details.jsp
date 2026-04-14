<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Consignment Billing Request Details</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <style>
        .editable-qty {
            background: #fff;
            border: 1px solid #ced4da;
            border-radius: 3px;
            padding: 2px 6px;
            width: 90px;
            text-align: right;
            font-size: 0.875rem;
        }
        .editable-qty:focus {
            outline: none;
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }
    </style>
</head>

<body>

    <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
    <div class="main-content">
        <jsp:include page="/WEB-INF/jsp/common/header.jsp">
            <jsp:param name="pageTitle" value="Customer Consignment Billing Request Details" />
        </jsp:include>

        <div class="container-fluid mt-3">
            <!-- Breadcrumb & Top Actions -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb bg-transparent p-0 m-0">
                        <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                        <li class="breadcrumb-item">Consignment</li>
                        <li class="breadcrumb-item">Settlement</li>
                        <li class="breadcrumb-item"><a href="/consignment/settlement/customer-billing">Customer Consignment Billing Request</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Details</li>
                    </ol>
                </nav>
                <div>
                    <button id="btnRelease" class="btn btn-primary mr-2 d-none" onclick="processRelease()">
                        <i class="fas fa-check-circle"></i> Release
                    </button>
                    <button id="btnDelete" class="btn btn-outline-danger mr-2 d-none" onclick="processDelete()">
                        <i class="fas fa-trash"></i> Delete
                    </button>
                    <button class="btn btn-outline-secondary" onclick="window.location.href='/consignment/settlement/customer-billing'">
                        <i class="fas fa-arrow-left"></i> Back
                    </button>
                </div>
            </div>

            <!-- Detail Header -->
            <div class="card mb-4 shadow-sm">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Document Number</label>
                            <div class="font-weight-bold" id="documentNumber">-</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Store</label>
                            <div id="store">-</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Customer Code</label>
                            <div id="customerCode">-</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Period Type</label>
                            <div id="periodType">-</div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">From Date</label>
                            <div id="fromDate">-</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">To Date</label>
                            <div id="toDate">-</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Status</label>
                            <div id="statusBadge"><span class="badge badge-secondary">-</span></div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Process Status</label>
                            <div id="processStatusBadge"><span class="badge badge-secondary">-</span></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Created By</label>
                            <div id="createdBy">-</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Released At</label>
                            <div id="releasedAt">-</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Items List Table -->
            <div class="card shadow-sm">
                <div class="card-header bg-white font-weight-bold d-flex justify-content-between align-items-center">
                    <span>Billing Details</span>
                    <span class="badge badge-light" id="detailCount">0 items</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="bg-light">
                                <tr>
                                    <th width="40">#</th>
                                    <th>Item Code</th>
                                    <th>UOM</th>
                                    <th class="text-right">Sales Qty</th>
                                    <th class="text-right">Return Qty</th>
                                    <th class="text-right">Billing Qty</th>
                                    <th class="text-right">Unit Price</th>
                                    <th class="text-right">Line Amount</th>
                                    <th class="text-right">Actual Return Qty</th>
                                </tr>
                            </thead>
                            <tbody id="itemsTableBody">
                                <tr><td colspan="9" class="text-center py-4"><div class="spinner-border spinner-border-sm text-primary"></div> Loading...</td></tr>
                            </tbody>
                            <tfoot class="bg-light">
                                <tr>
                                    <td colspan="7" class="text-right font-weight-bold">Grand Total:</td>
                                    <td class="text-right font-weight-bold" id="grandTotal">0.00</td>
                                    <td></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
    <script src="/static/js/services/consignment-service.js?v=2"></script>
    <script>
        var billingId = null;
        var billingData = null;

        // UI setup on DOMContentLoaded
        document.addEventListener('DOMContentLoaded', function () {
            $('#nav-consignment-customer-billing').addClass('active');

            // Parse URL params
            var urlParams = new URLSearchParams(window.location.search);
            billingId = urlParams.get('id');

            if (!billingId) {
                document.getElementById('itemsTableBody').innerHTML =
                    '<tr><td colspan="9" class="text-center py-4 text-danger">No billing ID specified.</td></tr>';
                return;
            }
        });

        // API initialization - called by footer after config is loaded
        window.initPage = function () {
            if (billingId) {
                loadBillingDetails(billingId);
            }
        };

        // Fallback: if configLoaded already fired before initPage was defined
        document.addEventListener('configLoaded', function () {
            if (typeof ConsignmentService !== 'undefined' && !window._pageInitialized) {
                window._pageInitialized = true;
                window.initPage();
            }
        });

        async function loadBillingDetails(id) {
            try {
                var response = await ConsignmentService.getCustomerBilling(id);
                billingData = response.data;

                if (!billingData) {
                    document.getElementById('itemsTableBody').innerHTML =
                        '<tr><td colspan="9" class="text-center py-4 text-danger">Billing request not found.</td></tr>';
                    return;
                }

                // Populate header
                document.getElementById('documentNumber').textContent = billingData.docNo || '-';
                document.getElementById('store').textContent = billingData.store || '-';
                document.getElementById('customerCode').textContent = billingData.customerCode || 'ALL';
                document.getElementById('periodType').textContent = billingData.periodType || '-';
                document.getElementById('fromDate').textContent = AppUtils.formatDate(billingData.fromDate);
                document.getElementById('toDate').textContent = AppUtils.formatDate(billingData.toDate);
                document.getElementById('createdBy').textContent = billingData.createdBy || '-';
                document.getElementById('releasedAt').textContent = AppUtils.formatDateTime(billingData.releasedAt);

                // Status badges
                var status = billingData.status || '-';
                var statusClass = status === 'HELD' ? 'badge-warning' : status === 'RELEASED' ? 'badge-success' : 'badge-secondary';
                document.getElementById('statusBadge').innerHTML = '<span class="badge ' + statusClass + '">' + status + '</span>';

                var processStatus = billingData.processStatus || '-';
                var processClass = processStatus === 'COMPLETED' ? 'badge-info' : processStatus === 'FAILED' ? 'badge-danger' : 'badge-secondary';
                document.getElementById('processStatusBadge').innerHTML = '<span class="badge ' + processClass + '">' + processStatus + '</span>';

                // Show/hide action buttons based on status
                if (status === 'HELD') {
                    document.getElementById('btnRelease').classList.remove('d-none');
                    document.getElementById('btnDelete').classList.remove('d-none');
                }

                // Render items
                renderItemsTable(billingData.details || []);

            } catch (error) {
                document.getElementById('itemsTableBody').innerHTML =
                    '<tr><td colspan="9" class="text-center py-4 text-danger"><i class="fas fa-exclamation-circle"></i> ' + error.message + '</td></tr>';
            }
        }

        function renderItemsTable(details) {
            var tbody = document.getElementById('itemsTableBody');
            tbody.innerHTML = '';

            document.getElementById('detailCount').textContent = details.length + ' items';

            if (!details || details.length === 0) {
                tbody.innerHTML = '<tr><td colspan="9" class="text-center py-4 text-muted">No detail lines.</td></tr>';
                document.getElementById('grandTotal').textContent = '0.00';
                return;
            }

            var grandTotal = 0;
            var isReleased = billingData && billingData.status === 'RELEASED';

            details.forEach(function (row, idx) {
                grandTotal += row.lineAmount || 0;

                var actualReturnQtyCell;
                if (isReleased) {
                    // Show editable input for actual return qty
                    var currentVal = row.actualReturnQty !== null && row.actualReturnQty !== undefined ? row.actualReturnQty : '';
                    actualReturnQtyCell = '<input type="number" class="editable-qty" step="0.01" min="0" ' +
                        'data-detail-id="' + row.id + '" ' +
                        'value="' + currentVal + '" ' +
                        'onchange="updateActualReturnQty(\'' + row.id + '\', this.value)" ' +
                        'placeholder="0">';
                } else {
                    actualReturnQtyCell = row.actualReturnQty !== null && row.actualReturnQty !== undefined ? row.actualReturnQty : '-';
                }

                var tr = document.createElement('tr');
                tr.innerHTML =
                    '<td>' + (idx + 1) + '</td>' +
                    '<td>' + (row.itemCode || '-') + '</td>' +
                    '<td>' + (row.uom || '-') + '</td>' +
                    '<td class="text-right">' + (row.salesQty !== null ? row.salesQty : '-') + '</td>' +
                    '<td class="text-right">' + (row.returnQty !== null ? row.returnQty : '-') + '</td>' +
                    '<td class="text-right font-weight-bold">' + (row.billingQty !== null ? row.billingQty : '-') + '</td>' +
                    '<td class="text-right">' + AppUtils.formatCurrency(row.unitPrice) + '</td>' +
                    '<td class="text-right font-weight-bold">' + AppUtils.formatCurrency(row.lineAmount) + '</td>' +
                    '<td class="text-right">' + actualReturnQtyCell + '</td>';
                tbody.appendChild(tr);
            });

            document.getElementById('grandTotal').textContent = AppUtils.formatCurrency(grandTotal);
        }

        async function updateActualReturnQty(detailId, value) {
            if (!billingId || !detailId) return;

            var actualQty = parseFloat(value);
            if (isNaN(actualQty)) actualQty = 0;

            try {
                await ConsignmentService.updateCustomerBillingActualReturnQty(billingId, detailId, actualQty);
                AppUtils.showToast('Actual return qty updated successfully.', 'success');
            } catch (error) {
                AppUtils.showToast('Failed to update: ' + error.message, 'danger');
            }
        }

        async function processRelease() {
            if (!billingId) return;

            AppUtils.confirm('Are you sure you want to release this document? This will mark all related consignment_unpost rows as settled.', async function() {
                try {
                    var response = await ConsignmentService.releaseCustomerBilling(billingId);
                    AppUtils.showToast('Document released successfully.', 'success');

                    // Reload details to reflect new status
                    setTimeout(function() {
                        loadBillingDetails(billingId);
                    }, 500);
                } catch (error) {
                    AppUtils.showToast('Release failed: ' + error.message, 'danger');
                }
            });
        }

        async function processDelete() {
            if (!billingId) return;

            AppUtils.confirm('Are you sure you want to delete this HELD billing request? This will allow recompute for the same period.', async function() {
                try {
                    await ConsignmentService.deleteCustomerBilling(billingId);
                    AppUtils.showToast('Document deleted successfully. Redirecting...', 'success');

                    // Redirect back to list
                    setTimeout(function() {
                        window.location.href = '/consignment/settlement/customer-billing';
                    }, 1500);
                } catch (error) {
                    AppUtils.showToast('Delete failed: ' + error.message, 'danger');
                }
            });
        }
    </script>
</body>
</html>
