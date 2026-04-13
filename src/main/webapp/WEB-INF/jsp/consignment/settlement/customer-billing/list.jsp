<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Consignment Billing Request</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>

<body>

    <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
    <div class="main-content">
        <jsp:include page="/WEB-INF/jsp/common/header.jsp">
            <jsp:param name="pageTitle" value="Customer Consignment Billing Request" />
        </jsp:include>

        <div class="container-fluid mt-3">
            <!-- Breadcrumb & Top Actions -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb bg-transparent p-0 m-0">
                        <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                        <li class="breadcrumb-item">Consignment</li>
                        <li class="breadcrumb-item">Settlement</li>
                        <li class="breadcrumb-item active" aria-current="page">Customer Consignment Billing Request</li>
                    </ol>
                </nav>
            </div>

            <!-- List Actions Row -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <button class="btn btn-primary btn-sm mr-2" onclick="batchRelease()">Release</button>
                    <button class="btn btn-outline-secondary btn-sm mr-2" onclick="batchPrint()"><i class="fas fa-print"></i> Print</button>
                    <button class="btn btn-outline-danger btn-sm" onclick="batchDelete()"><i class="fas fa-trash"></i> Delete</button>
                </div>
                <div class="d-flex align-items-center">
                    <div class="btn-group mr-3">
                        <button class="btn btn-outline-secondary btn-sm"><i class="fas fa-filter"></i></button>
                        <button class="btn btn-outline-secondary btn-sm"><i class="fas fa-sync-alt"></i></button>
                    </div>
                </div>
            </div>

            <!-- Data Table -->
            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="bg-light">
                                <tr>
                                    <th width="40"><input type="checkbox" id="selectAll" onclick="toggleAll()"></th>
                                    <th>Doc No</th>
                                    <th>Period Type</th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                    <th>Store</th>
                                    <th>Customer</th>
                                    <th>Customer Branch</th>
                                    <th>Status</th>
                                    <th>Process Status</th>
                                    <th width="40"></th>
                                </tr>
                            </thead>
                            <tbody id="dataTableBody">
                                <!-- JS Render -->
                            </tbody>
                        </table>
                    </div>

                    <div class="d-flex justify-content-between align-items-center p-3 border-top bg-light">
                        <div class="d-flex align-items-center">
                            <select class="form-control form-control-sm mr-2" style="width: 70px;">
                                <option value="10">10</option>
                                <option value="20">20</option>
                                <option value="50">50</option>
                            </select> 
                            <span>rows per page</span>
                        </div>
                        <div>
                            <span class="mr-3">PAGE 1/1</span>
                            <div class="btn-group">
                                <button class="btn btn-outline-secondary btn-sm"><i class="fas fa-angle-double-left"></i></button>
                                <button class="btn btn-outline-secondary btn-sm"><i class="fas fa-angle-left"></i></button>
                                <button class="btn btn-outline-secondary btn-sm"><i class="fas fa-angle-right"></i></button>
                                <button class="btn btn-outline-secondary btn-sm"><i class="fas fa-angle-double-right"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
    <script>
        // MOCK DATA
        let allData = [
            {
                id: 1,
                docNo: "CCBR-0000001",
                periodType: "Monthly",
                fromDate: "2025-08-01",
                toDate: "2025-08-31",
                store: "1001",
                customer: "0000000659 - BLUE SKY SJ",
                customerBranch: "MC-00001 - SJ TAX 3",
                status: "HELD",
                processStatus: "Completed"
            },
            {
                id: 2,
                docNo: "CCBR-0000002",
                periodType: "Monthly",
                fromDate: "2025-08-01",
                toDate: "2025-08-31",
                store: "1001",
                customer: "0000000659 - BLUE SKY SJ",
                customerBranch: "MC-00002 - SJ TAX 4",
                status: "RELEASED",
                processStatus: "Completed"
            }
        ];

        document.addEventListener('DOMContentLoaded', function () {
            $('#nav-consignment-customer-billing').addClass('active');
            renderTable(allData);
        });

        function renderTable(data) {
            const tbody = document.getElementById('dataTableBody');
            tbody.innerHTML = '';

            if (data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="11" class="text-center py-4">No records found.</td></tr>';
                return;
            }

            data.forEach(function (row) {
                let statusBadge = '';
                if (row.status === 'HELD') statusBadge = 'badge-warning';
                else if (row.status === 'RELEASED') statusBadge = 'badge-success';
                else statusBadge = 'badge-secondary';

                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td><input type="checkbox" class="row-checkbox" value="\${row.id}"></td>
                    <td><a href="/consignment/settlement/customer-billing/details?id=\${row.id}">\${row.docNo}</a></td>
                    <td>\${row.periodType}</td>
                    <td>\${row.fromDate}</td>
                    <td>\${row.toDate}</td>
                    <td>\${row.store}</td>
                    <td><small>\${row.customer}</small></td>
                    <td><small>\${row.customerBranch}</small></td>
                    <td><span class="badge \${statusBadge}">\${row.status}</span></td>
                    <td>\${row.processStatus}</td>
                    <td><a href="/consignment/settlement/customer-billing/details?id=\${row.id}"><i class="fas fa-edit text-primary"></i></a></td>
                `;
                tbody.appendChild(tr);
            });
        }

        function toggleAll() {
            const isChecked = $('#selectAll').prop('checked');
            $('.row-checkbox').prop('checked', isChecked);
        }

        function getSelectedIds() {
            let ids = [];
            $('.row-checkbox:checked').each(function () {
                ids.push(parseInt($(this).val()));
            });
            return ids;
        }

        function batchRelease() {
            const ids = getSelectedIds();
            if (ids.length === 0) { alert('Please select at least one document'); return; }

            let hasNonHeld = false;
            allData.forEach(function (d) {
                if (ids.includes(d.id) && d.status !== 'HELD') {
                    hasNonHeld = true;
                }
            });

            if (hasNonHeld) {
                alert('Only HELD documents can be released.');
                return;
            }

            if (confirm('Are you sure you want to release the selected document(s)?')) {
                allData = allData.map(d => {
                    if (ids.includes(d.id)) {
                        d.status = 'RELEASED';
                    }
                    return d;
                });
                renderTable(allData);
                $('#selectAll').prop('checked', false);
                alert('Documents successfully released.');
            }
        }

        function batchDelete() {
            const ids = getSelectedIds();
            if (ids.length === 0) { alert('Please select at least one document'); return; }

            let hasNonHeld = false;
            allData.forEach(function (d) {
                if (ids.includes(d.id) && d.status !== 'HELD') {
                    hasNonHeld = true;
                }
            });

            if (hasNonHeld) {
                alert('Only HELD documents can be deleted.');
                return;
            }

            if (confirm('Confirm delete selected document(s)?')) {
                allData = allData.filter(d => !ids.includes(d.id));
                renderTable(allData);
                $('#selectAll').prop('checked', false);
                alert('Documents successfully deleted.');
            }
        }

        function batchPrint() {
            const ids = getSelectedIds();
            if (ids.length === 0) { alert('Please select a document to print'); return; }
            alert('Printing...');
        }
    </script>
</body>
</html>
