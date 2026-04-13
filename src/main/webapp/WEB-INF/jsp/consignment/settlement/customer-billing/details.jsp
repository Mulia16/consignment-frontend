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
                    <button id="btnRelease" class="btn btn-primary mr-2" onclick="processRelease()">Release</button>
                    <button class="btn btn-outline-secondary" onclick="window.location.href='/consignment/settlement/customer-billing'"><i class="fas fa-arrow-left"></i> Back</button>
                </div>
            </div>

            <!-- Detail Header Form -->
            <div class="card mb-4 shadow-sm">
                <div class="card-body">
                    <form id="detailForm">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Document Number</label>
                                <input type="text" class="form-control form-control-sm" name="documentNumber" id="documentNumber" value="CCBR-0000001" readonly>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Company</label>
                                <input type="text" class="form-control form-control-sm" name="company" id="company" value="001 - ALPRO PHARMACY SDN BHD" readonly>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Customer</label>
                                <input type="text" class="form-control form-control-sm" name="customer" id="customer" value="001 - ALPRO PHARMACY SDN BHD" readonly>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Customer Branch</label>
                                <input type="text" class="form-control form-control-sm" name="customerBranch" id="customerBranch" value="0001" readonly>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Customer Type</label>
                                <input type="text" class="form-control form-control-sm" name="customerType" id="customerType" value="Internal" readonly>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="small text-muted mb-1">Status</label>
                                <input type="text" class="form-control form-control-sm font-weight-bold text-warning" name="status" id="status" value="HELD" readonly>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Items List Table -->
            <div class="card shadow-sm">
                <div class="card-header bg-white font-weight-bold">
                    Items List
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="bg-light">
                                <tr>
                                    <th>Item Code</th>
                                    <th>UOM</th>
                                    <th class="text-right">Sales Qty</th>
                                    <th class="text-right">Sales Return Qty</th>
                                    <th class="text-right">Billing Qty</th>
                                    <th class="text-right">Unit Cost</th>
                                    <th class="text-right">Total Cost</th>
                                </tr>
                            </thead>
                            <tbody id="itemsTableBody">
                                <!-- JS Render -->
                            </tbody>
                            <tfoot class="bg-light">
                                <tr>
                                    <td colspan="6" class="text-right font-weight-bold">Total:</td>
                                    <td class="text-right font-weight-bold" id="grandTotal">0.00</td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
    <script>
        // MOCK DATA for ITEMS
        let itemData = [
            {
                itemCode: "0100100 AMOIXSAN 500MG CAP 10X10S",
                uom: "STRIP",
                salesQty: 41.5,
                salesReturnQty: 1,
                billingQty: 40.5,
                unitCost: 5.00,
                totalCost: 202.50
            },
            {
                itemCode: "100000181 PANADOL ACTIFAST 10X10S",
                uom: "BOX",
                salesQty: 4,
                salesReturnQty: 1,
                billingQty: 3,
                unitCost: 55.00,
                totalCost: 165.00
            }
        ];

        document.addEventListener('DOMContentLoaded', function () {
            $('#nav-consignment-customer-billing').addClass('active');

            // Parse URL params for simulating different statuses
            const urlParams = new URLSearchParams(window.location.search);
            const id = urlParams.get('id');

            if (id == '2') {
                document.getElementById('documentNumber').value = 'CCBR-0000002';
                document.getElementById('status').value = 'RELEASED';
                document.getElementById('status').classList.replace('text-warning', 'text-success');
                document.getElementById('btnRelease').style.display = 'none'; // Hide release button if already released
                
                itemData = [
                    { itemCode: "0200101 VITAMIN C 1000MG", uom: "BTL", salesQty: 10, salesReturnQty: 0, billingQty: 10, unitCost: 15.00, totalCost: 150.00 }
                ];
            }

            renderItemsTable(itemData);
        });

        function renderItemsTable(data) {
            const tbody = document.getElementById('itemsTableBody');
            tbody.innerHTML = '';
            
            let grandTotal = 0;

            data.forEach(function (row) {
                grandTotal += row.totalCost;
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>\${row.itemCode}</td>
                    <td>\${row.uom}</td>
                    <td class="text-right">\${row.salesQty}</td>
                    <td class="text-right">\${row.salesReturnQty}</td>
                    <td class="text-right font-weight-bold">\${row.billingQty}</td>
                    <td class="text-right">\${row.unitCost.toFixed(2)}</td>
                    <td class="text-right font-weight-bold">\${row.totalCost.toFixed(2)}</td>
                `;
                tbody.appendChild(tr);
            });

            document.getElementById('grandTotal').innerText = grandTotal.toFixed(2);
        }

        function processRelease() {
            if (confirm('Are you sure you want to release this document?')) {
                document.getElementById('status').value = 'RELEASED';
                document.getElementById('status').classList.replace('text-warning', 'text-success');
                document.getElementById('btnRelease').style.display = 'none';
                alert('Document released successfully. The system has automatically generated related invoices and API transactions.');
            }
        }
    </script>
</body>
</html>
