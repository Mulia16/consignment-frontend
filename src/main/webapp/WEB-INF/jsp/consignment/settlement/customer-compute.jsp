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
                                    <option value="COMP1">Alpro Pharmacy SDN BHD</option>
                                    <option value="COMP2">Alpro Plus SDN BHD</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Store</label>
                                <select class="form-control" name="store" id="store">
                                    <option value="">Select Store</option>
                                    <option value="1001">1001 - Main Store</option>
                                    <option value="1002">1002 - Branch 1</option>
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
                        </div>

                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Billing Cycle</label>
                                <select class="form-control" name="billingCycle" id="billingCycle">
                                    <option value="ALL">All</option>
                                    <option value="MONTHLY">Monthly</option>
                                    <option value="WEEKLY">Weekly</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Customer</label>
                                <select class="form-control" name="customer" id="customer">
                                    <option value="">Select Customer</option>
                                    <option value="CUST01">0000000659 - BLUE SKY SJ</option>
                                    <option value="CUST02">0000000660 - RED SEA KL</option>
                                </select>
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
            $('#nav-consignment-customer-compute').addClass('active');
            
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
            
            if (!company || !store) {
                alert('Please select Company and Store.');
                return;
            }

            // Simulate processing
            clearLog();
            appendLog(`Starting computation for Company: \${company}, Store: \${store}...`);
            
            setTimeout(() => {
                appendLog('Analyzing Unpost Sales and Sales Return inventory...');
            }, 800);
            
            setTimeout(() => {
                appendLog(`Computing billing quantities for selected customers...`);
            }, 1500);
            
            setTimeout(() => {
                appendLog(`Successfully generated Customer Consignment Billing Request Document: CCBR-${Math.floor(Math.random() * 10000)}`);
                appendLog('Computation completed.');
                alert('Computation completed successfully.');
                
                // Redirect to billing list after a short delay
                setTimeout(() => {
                    window.location.href = '/consignment/settlement/customer-billing';
                }, 1500);
            }, 2500);
        }
    </script>
</body>
</html>
