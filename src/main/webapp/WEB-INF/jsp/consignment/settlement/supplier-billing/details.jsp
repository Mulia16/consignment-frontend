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
                <button class="btn btn-primary" onclick="actionRelease()">Release</button>
            </div>

            <div class="mb-3">
                <a href="/consignment/settlement/supplier-billing" class="btn btn-link px-0"><i class="fas fa-arrow-left"></i> Back</a>
            </div>

            <!-- Header Info -->
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <div class="header-label">Document Number</div>
                            <div class="header-value">SCBR-0000001</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="header-label">Company</div>
                            <div class="header-value">001 - ALPRO PHARMACY SDN BHD</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="header-label">Supplier</div>
                            <div class="header-value">0000040174 - DKSH (M) SDN BHD<br/><small>(HEALTHCARE)</small></div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="header-label">Supplier Contract</div>
                            <div class="header-value">MC-00001</div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="header-label">Supplier Type</div>
                            <div class="header-value">External</div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="header-label">Billing Qty Carry Forward Decimal To Next Month</div>
                            <div class="header-value">Yes</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Items -->
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white font-weight-bold">
                    Items List
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover table-sm">
                            <thead class="bg-light text-muted small">
                                <tr>
                                    <th>Item Code</th>
                                    <th>UOM</th>
                                    <th>Sales Qty</th>
                                    <th>Sales Return Qty</th>
                                    <th>BF Qty</th>
                                    <th>Billing Qty</th>
                                    <th>CF Qty</th>
                                    <th class="text-right">Unit Cost</th>
                                    <th class="text-right">Total Cost</th>
                                    <th class="text-center">Total Supplier Qty</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="font-weight-bold" style="font-size: 0.9rem;">0100138 AMOXSAN 500MG CAP 10X10S</td>
                                    <td>STRIP</td>
                                    <td><input type="text" class="form-control form-control-sm" value="41.5" readonly></td>
                                    <td><input type="text" class="form-control form-control-sm" value="1" readonly></td>
                                    <td>0.3</td>
                                    <td><input type="text" class="form-control form-control-sm" value="40" style="width:70px;"></td>
                                    <td><input type="text" class="form-control form-control-sm" value="0.8" readonly></td>
                                    <td class="text-right">5.00</td>
                                    <td class="text-right font-weight-bold">200.00</td>
                                    <td class="text-center">50</td>
                                </tr>
                                <tr>
                                    <td class="font-weight-bold" style="font-size: 0.9rem;">100000181 PANADOL ACTIFAST 10X10S</td>
                                    <td>BOX</td>
                                    <td><input type="text" class="form-control form-control-sm" value="4" readonly></td>
                                    <td><input type="text" class="form-control form-control-sm" value="1" readonly></td>
                                    <td>0</td>
                                    <td><input type="text" class="form-control form-control-sm" value="3" style="width:70px;"></td>
                                    <td><input type="text" class="form-control form-control-sm" value="0" readonly></td>
                                    <td class="text-right">55.00</td>
                                    <td class="text-right font-weight-bold">165.00</td>
                                    <td class="text-center">30</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            $('#nav-consignment-supplier-billing').addClass('active');
        });

        function actionRelease() {
            if(confirm('Are you sure you want to release this document?')) {
                alert('Document SCBR-0000001 successfully released.');
                window.location.href = '/consignment/settlement/supplier-billing';
            }
        }
    </script>
</body>
</html>
