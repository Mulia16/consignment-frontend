<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compute Customer Consignment Billing Request</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>

<body>

    <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
    <div class="main-content">
        <jsp:include page="/WEB-INF/jsp/common/header.jsp">
            <jsp:param name="pageTitle" value="Compute Customer Consignment Billing Request" />
        </jsp:include>

        <div class="container-fluid mt-3">
            <!-- Breadcrumb & Top Actions -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb bg-transparent p-0 m-0">
                        <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                        <li class="breadcrumb-item">Consignment</li>
                        <li class="breadcrumb-item">Settlement</li>
                        <li class="breadcrumb-item active" aria-current="page">Compute Customer Consignment Billing Request</li>
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
                                <label class="small text-muted mb-1">Period Type <span class="text-danger">*</span></label>
                                <select class="form-control" name="periodType" id="periodType">
                                    <option value="MONTHLY">Monthly</option>
                                    <option value="WEEKLY">Weekly</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Customer Code</label>
                                <input type="text" class="form-control" name="customerCode" id="customerCode" placeholder="Leave empty for all customers">
                            </div>
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
    <script src="/static/js/services/consignment-service.js?v=2"></script>
    <script>
        // UI setup on DOMContentLoaded
        document.addEventListener('DOMContentLoaded', function () {
            $('#nav-consignment-customer-compute').addClass('active');

            // Set default dates (current month)
            var today = new Date();
            var firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
            document.getElementById('fromDate').value = firstDay.toISOString().split('T')[0];
            document.getElementById('toDate').value = today.toISOString().split('T')[0];

            // Company change → load stores
            document.getElementById('company').addEventListener('change', function () {
                loadStores(this.value);
            });
        });

        // API initialization - called by footer after config is loaded
        window.initPage = function () {
            var user = Auth.getUser();
            if (user && user.username) {
                document.getElementById('createdBy').value = user.username;
            }
            loadCompanies();
        };

        // Fallback: if configLoaded already fired before initPage was defined
        document.addEventListener('configLoaded', function () {
            if (typeof ConsignmentService !== 'undefined' && !window._pageInitialized) {
                window._pageInitialized = true;
                window.initPage();
            }
        });

        async function loadCompanies() {
            try {
                var response = await ConsignmentService.getCompanies();
                var companySelect = document.getElementById('company');
                companySelect.innerHTML = '<option value="">Select Company</option>';
                if (response.data && Array.isArray(response.data)) {
                    response.data.forEach(function(company) {
                        var opt = document.createElement('option');
                        opt.value = company;
                        opt.textContent = company;
                        companySelect.appendChild(opt);
                    });
                }
            } catch (err) {
                appendLog('Warning: Could not load companies from API. ' + err.message);
            }
        }

        async function loadStores(company) {
            var storeSelect = document.getElementById('store');
            storeSelect.innerHTML = '<option value="">Select Store</option>';

            if (!company) return;

            try {
                var response = await ConsignmentService.getStores(company);
                if (response.data && Array.isArray(response.data)) {
                    response.data.forEach(function(store) {
                        var opt = document.createElement('option');
                        opt.value = store;
                        opt.textContent = store;
                        storeSelect.appendChild(opt);
                    });
                }
            } catch (err) {
                appendLog('Warning: Could not load stores from API. ' + err.message);
            }
        }

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
            var fromDate = document.getElementById('fromDate').value;
            var toDate = document.getElementById('toDate').value;
            var periodType = document.getElementById('periodType').value;
            var customerCode = document.getElementById('customerCode').value || null;
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
            if (!fromDate || !toDate) {
                AppUtils.showToast('Please select From Date and To Date.', 'warning');
                return;
            }

            var btnProcess = document.getElementById('btnProcess');
            btnProcess.disabled = true;
            btnProcess.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';

            clearLog();
            appendLog('Starting computation...');
            appendLog('Company: ' + company);
            appendLog('Store: ' + store);
            appendLog('Period: ' + fromDate + ' to ' + toDate + ' (' + periodType + ')');
            if (customerCode) {
                appendLog('Customer: ' + customerCode);
            } else {
                appendLog('Customer: ALL (all customers under this store)');
            }
            appendLog('---');
            appendLog('Analyzing unsettled consignment_unpost data...');

            try {
                var payload = {
                    company: company,
                    store: store,
                    fromDate: fromDate,
                    toDate: toDate,
                    periodType: periodType,
                    customerCode: customerCode,
                    createdBy: createdBy
                };

                var response = await ConsignmentService.computeCustomerBilling(payload);

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
                            appendLog('  [' + (idx + 1) + '] ' + detail.itemCode +
                                ' | Sales: ' + detail.salesQty +
                                ' | Return: ' + detail.returnQty +
                                ' | Billing: ' + detail.billingQty +
                                ' | Amount: ' + AppUtils.formatCurrency(detail.lineAmount));
                        });
                    }

                    appendLog('---');
                    AppUtils.showToast('Computation completed successfully! Document: ' + (data.docNo || ''), 'success');

                    // Redirect to billing list after a short delay
                    setTimeout(function() {
                        window.location.href = '/consignment/settlement/customer-billing';
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
