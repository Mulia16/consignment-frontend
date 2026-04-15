<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supplier Consignment Billing Request Details</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <style>
        .header-value { font-weight: 600; font-size: 1.1rem; color: #333; }
        .header-label { font-size: 0.8rem; color: #6c757d; text-transform: uppercase; margin-bottom: 2px; }
    </style>
</head>

<body>

    <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
    <div class="main-content">
        <jsp:include page="/WEB-INF/jsp/common/header.jsp">
            <jsp:param name="pageTitle" value="Supplier Consignment Billing Request" />
        </jsp:include>

        <div class="container-fluid mt-3">
            <!-- Breadcrumb & Top Actions -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb bg-transparent p-0 m-0">
                        <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                        <li class="breadcrumb-item">Consignment</li>
                        <li class="breadcrumb-item">Settlement</li>
                        <li class="breadcrumb-item"><a href="/consignment/settlement/supplier-billing">Supplier Consignment Billing Request</a></li>
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
                    <button class="btn btn-outline-secondary" onclick="window.location.href='/consignment/settlement/supplier-billing'">
                        <i class="fas fa-arrow-left"></i> Back
                    </button>
                </div>
            </div>

            <!-- Header Info -->
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <div class="header-label">Document Number</div>
                            <div class="header-value" id="documentNumber">-</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="header-label">Company</div>
                            <div class="header-value" id="company">-</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="header-label">Store</div>
                            <div class="header-value" id="store">-</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="header-label">Supplier</div>
                            <div class="header-value" id="supplierCode">-</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="header-label">Supplier Contract</div>
                            <div class="header-value" id="supplierContract">-</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="header-label">Period Type</div>
                            <div class="header-value" id="periodType">-</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="header-label">From Date</div>
                            <div class="header-value" id="fromDate">-</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="header-label">To Date</div>
                            <div class="header-value" id="toDate">-</div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <div class="header-label">Status</div>
                            <div id="statusBadge"><span class="badge badge-secondary">-</span></div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="header-label">Process Status</div>
                            <div id="processStatusBadge"><span class="badge badge-secondary">-</span></div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="header-label">Carry Forward Decimal</div>
                            <div class="header-value" id="carryForwardDecimal">-</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="header-label">Created By</div>
                            <div class="header-value" id="createdBy">-</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Items List -->
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white font-weight-bold d-flex justify-content-between align-items-center">
                    <span>Items List</span>
                    <span class="badge badge-light" id="detailCount">0 items</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover table-sm mb-0">
                            <thead class="bg-light text-muted small">
                                <tr>
                                    <th width="40">#</th>
                                    <th>Item Code</th>
                                    <th>UOM</th>
                                    <th class="text-right">Sales Qty</th>
                                    <th class="text-right">Sales Return Qty</th>
                                    <th class="text-right">BF Qty</th>
                                    <th class="text-right">Billing Qty</th>
                                    <th class="text-right">CF Qty</th>
                                    <th class="text-right">Unit Cost</th>
                                    <th class="text-right">Total Cost</th>
                                    <th class="text-center">Total Supplier Qty</th>
                                </tr>
                            </thead>
                            <tbody id="itemsTableBody">
                                <tr><td colspan="11" class="text-center py-4"><div class="spinner-border spinner-border-sm text-primary"></div> Loading...</td></tr>
                            </tbody>
                            <tfoot class="bg-light">
                                <tr>
                                    <td colspan="9" class="text-right font-weight-bold">Grand Total:</td>
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
    <script src="/static/js/services/consignment-service.js?v=3"></script>
    <script>
        var billingId = null;
        var billingData = null;

        // UI setup on DOMContentLoaded
        document.addEventListener('DOMContentLoaded', function () {
            $('#nav-consignment-supplier-billing').addClass('active');

            // Parse URL params
            var urlParams = new URLSearchParams(window.location.search);
            billingId = urlParams.get('id');

            if (!billingId) {
                document.getElementById('itemsTableBody').innerHTML =
                    '<tr><td colspan="11" class="text-center py-4 text-danger">No billing ID specified.</td></tr>';
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
                var response = await ConsignmentService.getSupplierBilling(id);
                billingData = response.data;

                if (!billingData) {
                    document.getElementById('itemsTableBody').innerHTML =
                        '<tr><td colspan="11" class="text-center py-4 text-danger">Billing request not found.</td></tr>';
                    return;
                }

                // Populate header
                document.getElementById('documentNumber').textContent = billingData.docNo || '-';
                document.getElementById('company').textContent = billingData.company || '-';
                document.getElementById('store').textContent = billingData.store || '-';
                document.getElementById('supplierCode').textContent = billingData.supplierCode || '-';
                document.getElementById('supplierContract').textContent = billingData.supplierContract || '-';
                document.getElementById('periodType').textContent = billingData.periodType || '-';
                document.getElementById('fromDate').textContent = AppUtils.formatDate(billingData.fromDate);
                document.getElementById('toDate').textContent = AppUtils.formatDate(billingData.toDate);
                document.getElementById('carryForwardDecimal').textContent = billingData.carryForwardDecimal ? 'Yes' : 'No';
                document.getElementById('createdBy').textContent = billingData.createdBy || '-';

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
                    '<tr><td colspan="11" class="text-center py-4 text-danger"><i class="fas fa-exclamation-circle"></i> ' + error.message + '</td></tr>';
            }
        }

        function renderItemsTable(details) {
            var tbody = document.getElementById('itemsTableBody');
            tbody.innerHTML = '';

            document.getElementById('detailCount').textContent = details.length + ' items';

            if (!details || details.length === 0) {
                tbody.innerHTML = '<tr><td colspan="11" class="text-center py-4 text-muted">No detail lines.</td></tr>';
                document.getElementById('grandTotal').textContent = '0.00';
                return;
            }

            var grandTotal = 0;

            details.forEach(function (row, idx) {
                var totalCost = row.totalCost || 0;
                grandTotal += totalCost;

                var tr = document.createElement('tr');
                tr.innerHTML =
                    '<td>' + (idx + 1) + '</td>' +
                    '<td class="font-weight-bold" style="font-size: 0.9rem;">' + (row.itemCode || '-') + '</td>' +
                    '<td>' + (row.uom || '-') + '</td>' +
                    '<td class="text-right">' + (row.salesQty !== null && row.salesQty !== undefined ? row.salesQty : '-') + '</td>' +
                    '<td class="text-right">' + (row.salesReturnQty !== null && row.salesReturnQty !== undefined ? row.salesReturnQty : '-') + '</td>' +
                    '<td class="text-right">' + (row.bfQty !== null && row.bfQty !== undefined ? row.bfQty : '-') + '</td>' +
                    '<td class="text-right font-weight-bold">' + (row.billingQty !== null && row.billingQty !== undefined ? row.billingQty : '-') + '</td>' +
                    '<td class="text-right">' + (row.cfQty !== null && row.cfQty !== undefined ? row.cfQty : '-') + '</td>' +
                    '<td class="text-right">' + AppUtils.formatCurrency(row.unitCost) + '</td>' +
                    '<td class="text-right font-weight-bold">' + AppUtils.formatCurrency(row.totalCost) + '</td>' +
                    '<td class="text-center">' + (row.totalSupplierQty !== null && row.totalSupplierQty !== undefined ? row.totalSupplierQty : '-') + '</td>';
                tbody.appendChild(tr);
            });

            document.getElementById('grandTotal').textContent = AppUtils.formatCurrency(grandTotal);
        }

        async function processRelease() {
            if (!billingId) return;

            AppUtils.confirm('Are you sure you want to release this document? This will update the status to RELEASED and trigger downstream inventory and purchasing document creation.', async function() {
                try {
                    var response = await ConsignmentService.releaseSupplierBilling(billingId);
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

            AppUtils.confirm('Are you sure you want to delete this HELD billing request? The header and all associated detail lines will be removed. Corresponding consignment_unpost records will remain unsettled.', async function() {
                try {
                    await ConsignmentService.deleteSupplierBilling(billingId);
                    AppUtils.showToast('Document deleted successfully. Redirecting...', 'success');

                    // Redirect back to list
                    setTimeout(function() {
                        window.location.href = '/consignment/settlement/supplier-billing';
                    }, 1500);
                } catch (error) {
                    AppUtils.showToast('Delete failed: ' + error.message, 'danger');
                }
            });
        }
    </script>
</body>
</html>
