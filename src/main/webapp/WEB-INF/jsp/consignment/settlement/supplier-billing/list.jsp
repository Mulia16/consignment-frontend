<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supplier Consignment Billing Request</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>

<body>

    <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
    <div class="main-content">
        <jsp:include page="/WEB-INF/jsp/common/header.jsp">
            <jsp:param name="pageTitle" value="Supplier Consignment Billing Request" />
        </jsp:include>

        <div class="container-fluid mt-3">
            <nav aria-label="breadcrumb" class="mb-3">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                    <li class="breadcrumb-item">Consignment</li>
                    <li class="breadcrumb-item">Settlement</li>
                    <li class="breadcrumb-item active" aria-current="page">Supplier Consignment Billing Request</li>
                </ol>
            </nav>

            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <!-- Actions -->
                    <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                        <div class="btn-group">
                            <button class="btn btn-outline-secondary btn-sm"><i class="fas fa-filter"></i></button>
                            <button class="btn btn-outline-secondary btn-sm"><i class="fas fa-sync-alt"></i></button>
                        </div>
                        <div>
                            <button class="btn btn-primary btn-sm px-4 mr-2" onclick="actionRelease()"><i class="fas fa-check"></i> Release</button>
                            <button class="btn btn-outline-secondary btn-sm mr-2" onclick="actionPrint()"><i class="fas fa-print"></i> Print</button>
                            <button class="btn btn-outline-danger btn-sm" onclick="actionDelete()"><i class="fas fa-trash"></i> Delete</button>
                        </div>
                    </div>

                    <!-- Filter summary -->
                    <div class="text-muted small mb-2"><i class="fas fa-info-circle"></i> Filtering and search able to filter by all column on this screen</div>

                    <!-- Data Table -->
                    <div class="table-responsive">
                        <table class="table table-hover table-bordered table-sm align-middle">
                            <thead class="bg-light">
                                <tr>
                                    <th class="text-center" width="40"><input type="checkbox" id="selectAll"></th>
                                    <th>Doc No</th>
                                    <th>Period Type</th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                    <th>Store</th>
                                    <th>Supplier</th>
                                    <th>Supplier Contract</th>
                                    <th>Status</th>
                                    <th>Process Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Mock Row 1 -->
                                <tr>
                                    <td class="text-center"><input type="checkbox" class="row-checkbox" value="SCBR-0000001"></td>
                                    <td><a href="/consignment/settlement/supplier-billing/details?id=SCBR-0000001">SCBR-0000001</a></td>
                                    <td>Monthly</td>
                                    <td>2023-08-08</td>
                                    <td>2023-08-08</td>
                                    <td>1001</td>
                                    <td>0000040174 - DKSH (M) SDN BHD</td>
                                    <td>MC-00001 - SJ TAX 3</td>
                                    <td><span class="badge badge-warning">Held</span></td>
                                    <td><span class="badge badge-success">Completed</span></td>
                                </tr>
                                <!-- Mock Row 2 -->
                                <tr>
                                    <td class="text-center"><input type="checkbox" class="row-checkbox" value="SCBR-0000002"></td>
                                    <td><a href="/consignment/settlement/supplier-billing/details?id=SCBR-0000002">SCBR-0000002</a></td>
                                    <td>Monthly</td>
                                    <td>2023-08-22</td>
                                    <td>2023-08-22</td>
                                    <td>1001</td>
                                    <td>0000055521 - ZUELLIG PHARMA</td>
                                    <td>MC-00002 - SJ TAX</td>
                                    <td><span class="badge badge-primary">Released</span></td>
                                    <td><span class="badge badge-success">Completed</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="d-flex justify-content-between align-items-center mt-2">
                        <div class="d-flex align-items-center">
                            <select class="form-control form-control-sm mr-2" style="width: auto;">
                                <option>10</option>
                                <option>20</option>
                                <option>50</option>
                            </select>
                            <span class="small text-muted">rows per page</span>
                        </div>
                        <div>
                            <ul class="pagination pagination-sm m-0">
                                <li class="page-item disabled"><a class="page-link" href="#"><i class="fas fa-fast-backward"></i></a></li>
                                <li class="page-item disabled"><a class="page-link" href="#"><i class="fas fa-chevron-left"></i></a></li>
                                <li class="page-item"><a class="page-link" href="#"><i class="fas fa-chevron-right"></i></a></li>
                                <li class="page-item"><a class="page-link" href="#"><i class="fas fa-fast-forward"></i></a></li>
                            </ul>
                        </div>
                        <span class="small text-muted">PAGE 1 / 1</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            $('#nav-consignment-supplier-billing').addClass('active');

            $('#selectAll').on('change', function() {
                $('.row-checkbox').prop('checked', $(this).prop('checked'));
            });
        });

        function actionRelease() {
            if($('.row-checkbox:checked').length === 0) {
                alert('Please select at least one document to release.');
                return;
            }
            if(confirm('Are you sure you want to release selected document(s)?')) {
                alert('Document(s) successfully released.');
            }
        }

        function actionPrint() {
           if($('.row-checkbox:checked').length === 0) {
               alert('Please select a document to print.');
               return;
           }
           alert('Printing document slip...');
        }

        function actionDelete() {
            if($('.row-checkbox:checked').length === 0) {
               alert('Please select a document to delete.');
               return;
           }
           if(confirm('Are you sure you want to delete selected document(s)? Only "Held" status can be deleted.')) {
               alert('Document(s) deleted.');
           }
        }
    </script>
</body>
</html>
