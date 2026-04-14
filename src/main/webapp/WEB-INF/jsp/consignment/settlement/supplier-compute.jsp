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
                    <button class="btn btn-primary mr-2" onclick="processCompute()"><i class="fas fa-cogs"></i> Process</button>
                    <button class="btn btn-outline-secondary" onclick="viewLog()"><i class="fas fa-file-alt"></i> View Log</button>
                </div>
            </div>

            <!-- Compute Form Form -->
            <div class="card mb-4 shadow-sm">
                <div class="card-body">
                    <form id="computeForm">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Company</label>
                                <select class="form-control" name="company" id="company">
                                    <option value="">Select Company</option>
                                    <option value="COMP1" selected>Alpro Pharmacy SDN BHD</option>
                                    <option value="COMP2">Alpro Plus SDN BHD</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">From Date</label>
                                <input type="date" class="form-control" name="fromDate" id="fromDate">
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">To Date</label>
                                <input type="date" class="form-control" name="toDate" id="toDate">
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Billing Cycle</label>
                                <select class="form-control" name="billingCycle" id="billingCycle">
                                    <option value="ALL">All</option>
                                    <option value="MONTHLY">Monthly</option>
                                    <option value="WEEKLY">Weekly</option>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Store</label>
                                <select class="form-control" name="store" id="store">
                                    <option value="">Select Store</option>
                                    <option value="1001" selected>1001 - Main Store</option>
                                    <option value="1002">1002 - Branch 1</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Supplier</label>
                                <select class="form-control" name="supplier" id="supplier">
                                    <option value="">Select Supplier</option>
                                    <option value="SUP01">0000040174 - DKSH (M) SDN BHD</option>
                                    <option value="SUP02">0000055521 - ZUELLIG PHARMA</option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="small text-muted mb-1 d-block">Billing Qty Carry Forward Decimal To Next Month</label>
                                <div class="custom-control custom-radio custom-control-inline mt-1">
                                    <input type="radio" id="carryFwdYes" name="carryFwd" class="custom-control-input" value="YES" checked>
                                    <label class="custom-control-label" for="carryFwdYes">Yes</label>
                                </div>
                                <div class="custom-control custom-radio custom-control-inline mt-1">
                                    <input type="radio" id="carryFwdNo" name="carryFwd" class="custom-control-input" value="NO">
                                    <label class="custom-control-label" for="carryFwdNo">No</label>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Log Area -->
            <div class="card shadow-sm">
                <div class="card-header bg-white font-weight-bold">
                    LOG
                </div>
                <div class="card-body p-0">
                    <textarea id="logArea" class="form-control border-0 bg-light p-3" rows="12" readonly placeholder="Click [View Log] button for latest log."></textarea>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            $('#nav-consignment-supplier-compute').addClass('active');
            
            // Set default dates
            const today = new Date();
            const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
            document.getElementById('fromDate').value = firstDay.toISOString().split('T')[0];
            document.getElementById('toDate').value = today.toISOString().split('T')[0];
        });

        function clearLog() {
            document.getElementById('logArea').value = '';
        }

        function appendLog(message) {
            const logArea = document.getElementById('logArea');
            const time = new Date().toLocaleTimeString();
            logArea.value += `[\${time}] \${message}\n`;
            logArea.scrollTop = logArea.scrollHeight;
        }

        function viewLog() {
            clearLog();
            appendLog('Fetching latest logs...');
            setTimeout(() => {
                appendLog('System is ready.');
                appendLog('Previous computation completed successfully.');
            }, 500);
        }

        function processCompute() {
            const company = document.getElementById('company').value;
            const store = document.getElementById('store').value;
            const supplier = document.getElementById('supplier').value;
            const carryFwd = document.querySelector('input[name="carryFwd"]:checked').value;
            
            if (!company || !store) {
                alert('Please select Company and Store.');
                return;
            }

            // Simulate processing
            clearLog();
            appendLog(`Starting supplier computation for Company: \${company}, Store: \${store}...`);
            
            setTimeout(() => {
                appendLog('Analyzing sales and sales return against supplier consignment inventory...');
                if (supplier) {
                    appendLog(`Filtering by specific Supplier: \${supplier}`);
                }
                appendLog(`Decimal Carry Forward Strategy: \${carryFwd}`);
            }, 800);
            
            setTimeout(() => {
                appendLog(`Computing billing quantities...`);
            }, 1500);
            
            setTimeout(() => {
                appendLog(`Successfully generated Supplier Consignment Billing Request Document: SCBR-\${Math.floor(Math.random() * 10000)}`);
                appendLog('Computation completed.');
                alert('Computation completed successfully.');
                
                // Redirect to billing list after a short delay
                setTimeout(() => {
                    window.location.href = '/consignment/settlement/supplier-billing';
                }, 1500);
            }, 2500);
        }
    </script>
</body>
</html>
