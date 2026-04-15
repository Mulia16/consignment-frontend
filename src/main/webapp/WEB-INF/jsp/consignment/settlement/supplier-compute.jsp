<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compute Supplier Consignment Billing Request</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>

<body>

    <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
    <div class="main-content">
        <jsp:include page="/WEB-INF/jsp/common/header.jsp">
            <jsp:param name="pageTitle" value="Compute Supplier Consignment Billing Request" />
        </jsp:include>

        <div class="container-fluid mt-3">
            <!-- Breadcrumb & Top Actions -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb bg-transparent p-0 m-0">
                        <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                        <li class="breadcrumb-item">Consignment</li>
                        <li class="breadcrumb-item">Settlement</li>
                        <li class="breadcrumb-item active" aria-current="page">Compute Supplier Consignment Billing Request</li>
                    </ol>
                </nav>
                <div>
                    <button class="btn btn-primary mr-2" id="btnProcess" onclick="processCompute()"><i class="fas fa-cogs"></i> Process</button>
                    <button class="btn btn-outline-secondary" onclick="viewLog()"><i class="fas fa-file-alt"></i> View Log</button>
                </div>
            </div>

            <!-- Compute Form -->
            <div class="card mb-4 shadow-sm">
                <div class="card-body">
                    <form id="computeForm">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Company <span class="text-danger">*</span></label>
                                <select class="form-control" name="company" id="company" required>
                                    <option value="">Select Company</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Store <span class="text-danger">*</span></label>
                                <select class="form-control" name="store" id="store" required>
                                    <option value="">Select Store</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">From Date <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" name="fromDate" id="fromDate" required>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">To Date <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" name="toDate" id="toDate" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Supplier <span class="text-danger">*</span></label>
                                <select class="form-control" name="supplierCode" id="supplierCode" required>
                                    <option value="">Select Supplier</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Supplier Contract <span class="text-danger">*</span></label>
                                <select class="form-control" name="supplierContract" id="supplierContract" required>
                                    <option value="">Select Contract</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Period Type <span class="text-danger">*</span></label>
                                <select class="form-control" name="periodType" id="periodType">
                                    <option value="MONTHLY">Monthly</option>
                                    <option value="WEEKLY">Weekly</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1 d-block">Billing Qty Carry Forward Decimal To Next Month</label>
                                <div class="custom-control custom-radio custom-control-inline mt-1">
                                    <input type="radio" id="carryFwdYes" name="carryForwardDecimal" class="custom-control-input" value="true" checked>
                                    <label class="custom-control-label" for="carryFwdYes">Yes</label>
                                </div>
                                <div class="custom-control custom-radio custom-control-inline mt-1">
                                    <input type="radio" id="carryFwdNo" name="carryForwardDecimal" class="custom-control-input" value="false">
                                    <label class="custom-control-label" for="carryFwdNo">No</label>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Created By</label>
                                <input type="text" class="form-control" name="createdBy" id="createdBy" value="admin">
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Log Area -->
            <div class="card shadow-sm">
                <div class="card-header bg-white font-weight-bold d-flex justify-content-between align-items-center">
                    <span>LOG</span>
                    <button class="btn btn-sm btn-outline-secondary" onclick="clearLog()"><i class="fas fa-eraser"></i> Clear</button>
                </div>
                <div class="card-body p-0">
                    <textarea id="logArea" class="form-control border-0 bg-light p-3" rows="14" readonly placeholder="Click [Process] to compute billing or [View Log] for latest log."></textarea>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
    <script src="/static/js/consignment-master-data.js?v=3"></script>
    <script src="/static/js/services/consignment-service.js?v=3"></script>
    <script>
        // UI setup on DOMContentLoaded
        document.addEventListener('DOMContentLoaded', function () {
            $('#nav-consignment-supplier-compute').addClass('active');

            // Set default dates (current month)
            var today = new Date();
            var firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
            document.getElementById('fromDate').value = firstDay.toISOString().split('T')[0];
            document.getElementById('toDate').value = today.toISOString().split('T')[0];
        });

        // API initialization - called by footer after config is loaded
        window.initPage = function () {
            var user = Auth.getUser();
            if (user && user.username) {
                document.getElementById('createdBy').value = user.username;
            }
            ConsignmentMasterData.init();
        };

        // Fallback: if configLoaded already fired before initPage was defined
        document.addEventListener('configLoaded', function () {
            if (typeof ConsignmentService !== 'undefined' && !window._pageInitialized) {
                window._pageInitialized = true;
                window.initPage();
            }
        });

        function clearLog() {
            document.getElementById('logArea').value = '';
        }

        function appendLog(message) {
            var logArea = document.getElementById('logArea');
            var time = new Date().toLocaleTimeString();
            logArea.value += '[' + time + '] ' + message + '\n';
            logArea.scrollTop = logArea.scrollHeight;
        }

        function viewLog() {
            clearLog();
            appendLog('System is ready.');
            appendLog('No previous computation logs available.');
        }

        async function processCompute() {
            var company = document.getElementById('company').value;
            var store = document.getElementById('store').value;
            var supplierCode = document.getElementById('supplierCode').value;
            var supplierContract = document.getElementById('supplierContract').value;
            var fromDate = document.getElementById('fromDate').value;
            var toDate = document.getElementById('toDate').value;
            var periodType = document.getElementById('periodType').value;
            var carryForwardDecimal = document.querySelector('input[name="carryForwardDecimal"]:checked').value === 'true';
            var createdBy = document.getElementById('createdBy').value || 'admin';

            // Validation
            if (!company) {
                AppUtils.showToast('Please select a Company.', 'warning');
                return;
            }
            if (!store) {
                AppUtils.showToast('Please select a Store.', 'warning');
                return;
            }
            if (!supplierCode) {
                AppUtils.showToast('Please select a Supplier.', 'warning');
                return;
            }
            if (!supplierContract) {
                AppUtils.showToast('Please select a Supplier Contract.', 'warning');
                return;
            }
            if (!fromDate || !toDate) {
                AppUtils.showToast('Please select From Date and To Date.', 'warning');
                return;
            }

            var btnProcess = document.getElementById('btnProcess');
            btnProcess.disabled = true;
            btnProcess.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';

            clearLog();
            appendLog('Starting supplier computation...');
            appendLog('Company: ' + company);
            appendLog('Store: ' + store);
            appendLog('Supplier: ' + supplierCode);
            appendLog('Contract: ' + supplierContract);
            appendLog('Period: ' + fromDate + ' to ' + toDate + ' (' + periodType + ')');
            appendLog('Carry Forward Decimal: ' + (carryForwardDecimal ? 'Yes' : 'No'));
            appendLog('---');
            appendLog('Analyzing sales and sales return against supplier consignment inventory...');

            try {
                var payload = {
                    company: company,
                    store: store,
                    supplierCode: supplierCode,
                    supplierContract: supplierContract,
                    periodType: periodType,
                    fromDate: fromDate,
                    toDate: toDate,
                    carryForwardDecimal: carryForwardDecimal,
                    createdBy: createdBy
                };

                var response = await ConsignmentService.computeSupplierBilling(payload);

                appendLog('Computing billing quantities (salesQty - returnQty per SKU)...');
                appendLog('---');

                if (response.data) {
                    var data = response.data;
                    appendLog('Computation COMPLETED successfully.');
                    appendLog('Document No: ' + (data.docNo || '-'));
                    appendLog('Status: ' + (data.status || '-'));
                    appendLog('Process Status: ' + (data.processStatus || '-'));

                    if (data.details && data.details.length > 0) {
                        appendLog('Total detail lines: ' + data.details.length);
                        data.details.forEach(function(detail, idx) {
                            appendLog('  [' + (idx + 1) + '] ' + (detail.itemCode || '-') +
                                ' | Sales: ' + (detail.salesQty || 0) +
                                ' | Return: ' + (detail.salesReturnQty || 0) +
                                ' | BF: ' + (detail.bfQty || 0) +
                                ' | Billing: ' + (detail.billingQty || 0) +
                                ' | CF: ' + (detail.cfQty || 0) +
                                ' | Cost: ' + AppUtils.formatCurrency(detail.unitCost));
                        });
                    }

                    appendLog('---');
                    AppUtils.showToast('Computation completed successfully! Document: ' + (data.docNo || data.id || ''), 'success');

                    // Redirect to billing list after a short delay
                    setTimeout(function() {
                        window.location.href = '/consignment/settlement/supplier-billing';
                    }, 2000);
                }
            } catch (error) {
                appendLog('ERROR: ' + error.message);
                appendLog('Computation FAILED.');
                AppUtils.showToast('Computation failed: ' + error.message, 'danger');
            } finally {
                btnProcess.disabled = false;
                btnProcess.innerHTML = '<i class="fas fa-cogs"></i> Process';
            }
        }
    </script>
</body>
</html>
