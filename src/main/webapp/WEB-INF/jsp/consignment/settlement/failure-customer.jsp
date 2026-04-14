<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Failed Customer Consignment Compute</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>

<body>

    <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
    <div class="main-content">
        <jsp:include page="/WEB-INF/jsp/common/header.jsp">
            <jsp:param name="pageTitle" value="Failed Customer Consignment Compute" />
        </jsp:include>

        <div class="container-fluid mt-3">
            <nav aria-label="breadcrumb" class="mb-3">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                    <li class="breadcrumb-item">Consignment</li>
                    <li class="breadcrumb-item">Settlement</li>
                    <li class="breadcrumb-item active" aria-current="page">Failed Customer Consignment Compute</li>
                </ol>
            </nav>

            <!-- Search Filters -->
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <h6 class="card-title text-muted mb-3"><i class="fas fa-filter"></i> Search Screen Filter</h6>
                    <div class="row">
                        <div class="col-md-3 mb-2">
                            <label class="small text-muted mb-1">Company</label>
                            <select class="form-control form-control-sm">
                                <option value="">All Companies</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-2">
                            <label class="small text-muted mb-1">Store</label>
                            <input type="text" class="form-control form-control-sm" placeholder="Store Code">
                        </div>
                        <div class="col-md-3 mb-2">
                            <label class="small text-muted mb-1">Customer</label>
                            <input type="text" class="form-control form-control-sm" placeholder="Customer Name/Code">
                        </div>
                        <div class="col-md-3 mb-2 align-self-end">
                            <button class="btn btn-primary btn-sm btn-block"><i class="fas fa-search"></i> Search</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- List Data -->
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="m-0"><i class="fas fa-list"></i> Failed Records</h6>
                        <div>
                            <button class="btn btn-success btn-sm px-3 mr-2" onclick="actionConfirm()"><i class="fas fa-check-circle"></i> Confirm</button>
                            <button class="btn btn-outline-secondary btn-sm mr-2" onclick="actionPrint()"><i class="fas fa-print"></i> Print Report</button>
                            <button class="btn btn-outline-danger btn-sm" onclick="actionDelete()"><i class="fas fa-trash"></i> Delete</button>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover table-bordered table-sm align-middle">
                            <thead class="bg-light">
                                <tr>
                                    <th class="text-center" width="40"><input type="checkbox" id="selectAll"></th>
                                    <th>Process Date</th>
                                    <th>Company</th>
                                    <th>Store</th>
                                    <th>Customer</th>
                                    <th>Target Period</th>
                                    <th>Error Reason</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Mock Row 1 -->
                                <tr>
                                    <td class="text-center"><input type="checkbox" class="row-checkbox" value="1"></td>
                                    <td>2023-08-30 10:15</td>
                                    <td>Alpro Pharmacy SDN BHD</td>
                                    <td>1001</td>
                                    <td>0000000659 - BLUE SKY SJ</td>
                                    <td>2023-08-01 to 2023-08-31</td>
                                    <td><span class="text-danger">Insufficient inventory tracking data</span></td>
                                    <td><span class="badge badge-warning">Pending Review</span></td>
                                </tr>
                                <!-- Mock Row 2 -->
                                <tr>
                                    <td class="text-center"><input type="checkbox" class="row-checkbox" value="2"></td>
                                    <td>2023-08-30 10:16</td>
                                    <td>Alpro Pharmacy SDN BHD</td>
                                    <td>1002</td>
                                    <td>0000000660 - RED SEA KL</td>
                                    <td>2023-08-01 to 2023-08-31</td>
                                    <td><span class="text-danger">Cost mapping misaligned</span></td>
                                    <td><span class="badge badge-warning">Pending Review</span></td>
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
            $('#nav-consignment-failure-customer').addClass('active');

            $('#selectAll').on('change', function() {
                $('.row-checkbox').prop('checked', $(this).prop('checked'));
            });
        });

        function actionConfirm() {
            if($('.row-checkbox:checked').length === 0) {
                alert('Please select at least one record to confirm.');
                return;
            }
            if(confirm('Confirm selected failed record(s)? This may flag them as acknowledged.')) {
                alert('Record(s) confirmed.');
            }
        }

        function actionPrint() {
           alert('Printing failed customer compute report...');
        }

        function actionDelete() {
            if($('.row-checkbox:checked').length === 0) {
               alert('Please select a record to delete.');
               return;
           }
           if(confirm('Are you sure you want to delete selected failed record(s)?')) {
               alert('Record(s) deleted.');
           }
        }
    </script>
</body>
</html>
