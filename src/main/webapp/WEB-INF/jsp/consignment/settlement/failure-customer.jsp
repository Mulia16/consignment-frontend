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
                <div class="card-body py-2">
                    <form id="filterForm" class="form-inline flex-wrap">
                        <div class="form-group mr-3 mb-2">
                            <label class="small text-muted mr-1">Company</label>
                            <select class="form-control form-control-sm" id="company" name="company">
                                <option value="">All Companies</option>
                            </select>
                        </div>
                        <div class="form-group mr-3 mb-2">
                            <label class="small text-muted mr-1">Store</label>
                            <select class="form-control form-control-sm" id="store" name="store">
                                <option value="">All Stores</option>
                            </select>
                        </div>
                        <div class="form-group mr-3 mb-2">
                            <label class="small text-muted mr-1">Customer</label>
                            <input type="text" class="form-control form-control-sm" id="filterCustomerCode" placeholder="Customer Code" style="width: 150px;">
                        </div>
                        <div class="form-group mr-3 mb-2">
                            <label class="small text-muted mr-1">From</label>
                            <input type="date" class="form-control form-control-sm" id="filterFromDate" style="width: 150px;">
                        </div>
                        <div class="form-group mr-3 mb-2">
                            <label class="small text-muted mr-1">To</label>
                            <input type="date" class="form-control form-control-sm" id="filterToDate" style="width: 150px;">
                        </div>
                        <button type="button" class="btn btn-primary btn-sm mb-2" onclick="loadFailedList(1)"><i class="fas fa-search"></i> Search</button>
                        <button type="button" class="btn btn-outline-secondary btn-sm mb-2 ml-2" onclick="resetFilters()"><i class="fas fa-undo"></i> Reset</button>
                    </form>
                </div>
            </div>

            <!-- List Actions Row -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <button class="btn btn-success btn-sm px-3 mr-2" onclick="batchConfirm()"><i class="fas fa-check-circle"></i> Confirm</button>
                    <button class="btn btn-outline-danger btn-sm" onclick="batchDelete()"><i class="fas fa-trash"></i> Delete</button>
                </div>
                <div class="d-flex align-items-center">
                    <button class="btn btn-outline-secondary btn-sm" onclick="loadFailedList(currentPage)"><i class="fas fa-sync-alt"></i> Refresh</button>
                </div>
            </div>

            <!-- List Data -->
            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover table-bordered table-sm align-middle mb-0">
                            <thead class="bg-light">
                                <tr>
                                    <th class="text-center" width="40"><input type="checkbox" id="selectAll" onclick="toggleAll()"></th>
                                    <th>Doc No</th>
                                    <th>Process Date</th>
                                    <th>Company</th>
                                    <th>Store</th>
                                    <th>Customer</th>
                                    <th>Target Period</th>
                                    <th>Error Reason</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody id="dataTableBody">
                                <tr><td colspan="9" class="text-center py-4"><div class="spinner-border spinner-border-sm text-primary"></div> Loading...</td></tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="d-flex justify-content-between align-items-center p-3 border-top bg-light">
                        <div class="d-flex align-items-center">
                            <select class="form-control form-control-sm mr-2" id="perPageSelect" style="width: 70px;" onchange="loadFailedList(1)">
                                <option value="10">10</option>
                                <option value="20" selected>20</option>
                                <option value="50">50</option>
                            </select>
                            <span class="small text-muted" id="pageInfo">-</span>
                        </div>
                        <div id="paginationContainer"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
    <script src="/static/js/consignment-master-data.js"></script>
    <script src="/static/js/services/consignment-service.js?v=2"></script>
    <script>
        var currentPage = 1;
        var allData = [];

        // UI setup on DOMContentLoaded
        document.addEventListener('DOMContentLoaded', function () {
            $('#nav-consignment-failure-customer').addClass('active');
        });

        // API initialization - called by footer after config is loaded
        window.initPage = function () {
            ConsignmentMasterData.init();
            loadFailedList(1);
        };

        // Fallback: if configLoaded already fired before initPage was defined
        document.addEventListener('configLoaded', function () {
            if (typeof ConsignmentService !== 'undefined' && !window._pageInitialized) {
                window._pageInitialized = true;
                window.initPage();
            }
        });

        async function loadFailedList(page) {
            currentPage = page;
            var perPage = parseInt(document.getElementById('perPageSelect').value) || 20;
            var tbody = document.getElementById('dataTableBody');
            tbody.innerHTML = '<tr><td colspan="9" class="text-center py-4"><div class="spinner-border spinner-border-sm text-primary"></div> Loading...</td></tr>';

            var params = {
                page: page,
                perPage: perPage
            };

            // Add filters - use ConsignmentMasterData selectors
            var company = $('#company').val();
            var store = $('#store').val();
            var customerCode = document.getElementById('filterCustomerCode').value.trim();
            var fromDate = document.getElementById('filterFromDate').value;
            var toDate = document.getElementById('filterToDate').value;

            if (company) params.company = company;
            if (store) params.store = store;
            if (customerCode) params.customerCode = customerCode;
            if (fromDate) params.fromDate = fromDate;
            if (toDate) params.toDate = toDate;

            try {
                var response = await ConsignmentService.searchFailedCBR(params);
                allData = response.data || [];
                renderTable(allData);

                // Update pagination info
                var meta = response.meta || {};
                var totalData = meta.totalData || 0;
                var totalPage = meta.totalPage || 1;
                document.getElementById('pageInfo').textContent =
                    'Showing ' + allData.length + ' of ' + totalData + ' records | Page ' + page + ' of ' + totalPage;

                // Build pagination
                AppUtils.buildPagination('paginationContainer', page - 1, totalPage, function(p) {
                    loadFailedList(p + 1);
                });
            } catch (error) {
                tbody.innerHTML = '<tr><td colspan="9" class="text-center py-4 text-danger"><i class="fas fa-exclamation-circle"></i> ' + error.message + '</td></tr>';
                document.getElementById('pageInfo').textContent = 'Error loading data';
            }
        }

        function renderTable(data) {
            var tbody = document.getElementById('dataTableBody');
            tbody.innerHTML = '';

            if (!data || data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="9" class="text-center py-4 text-muted"><i class="fas fa-inbox fa-2x mb-2 d-block"></i>No failed records found.</td></tr>';
                return;
            }

            data.forEach(function (row) {
                var statusBadge = '';
                if (row.processStatus === 'FAILED') statusBadge = 'badge-danger';
                else if (row.status === 'HELD') statusBadge = 'badge-warning';
                else if (row.status === 'RELEASED') statusBadge = 'badge-success';
                else statusBadge = 'badge-secondary';

                var periodDisplay = '-';
                if (row.fromDate && row.toDate) {
                    periodDisplay = AppUtils.formatDate(row.fromDate) + ' to ' + AppUtils.formatDate(row.toDate);
                }

                var tr = document.createElement('tr');
                tr.innerHTML =
                    '<td class="text-center"><input type="checkbox" class="row-checkbox" data-id="' + row.id + '"></td>' +
                    '<td>' + (row.docNo || '-') + '</td>' +
                    '<td>' + AppUtils.formatDateTime(row.createdAt) + '</td>' +
                    '<td>' + (row.company || '-') + '</td>' +
                    '<td>' + (row.store || '-') + '</td>' +
                    '<td>' + (row.customerCode || '-') + '</td>' +
                    '<td>' + periodDisplay + '</td>' +
                    '<td><span class="text-danger"><i class="fas fa-exclamation-triangle mr-1"></i>' + (row.errorReason || 'Unknown error') + '</span></td>' +
                    '<td><span class="badge ' + statusBadge + '">' + (row.processStatus || row.status || '-') + '</span></td>';
                tbody.appendChild(tr);
            });
        }

        function toggleAll() {
            var isChecked = document.getElementById('selectAll').checked;
            document.querySelectorAll('.row-checkbox').forEach(function(cb) {
                cb.checked = isChecked;
            });
        }

        function getSelectedIds() {
            var ids = [];
            document.querySelectorAll('.row-checkbox:checked').forEach(function(cb) {
                ids.push(cb.getAttribute('data-id'));
            });
            return ids;
        }

        async function batchConfirm() {
            var selectedIds = getSelectedIds();
            if (selectedIds.length === 0) {
                AppUtils.showToast('Please select at least one record to confirm.', 'warning');
                return;
            }

            AppUtils.confirm('Confirm selected failed record(s)? This may flag them as acknowledged.', async function() {
                var successCount = 0;
                var failCount = 0;

                for (var i = 0; i < selectedIds.length; i++) {
                    try {
                        await ConsignmentService.confirmFailedCBR(selectedIds[i]);
                        successCount++;
                    } catch (err) {
                        failCount++;
                        console.error('Failed to confirm ' + selectedIds[i] + ':', err);
                    }
                }

                if (failCount === 0) {
                    AppUtils.showToast('All ' + successCount + ' record(s) confirmed successfully.', 'success');
                } else {
                    AppUtils.showToast(successCount + ' confirmed, ' + failCount + ' failed.', 'warning');
                }

                document.getElementById('selectAll').checked = false;
                loadFailedList(currentPage);
            });
        }

        async function batchDelete() {
            var selectedIds = getSelectedIds();
            if (selectedIds.length === 0) {
                AppUtils.showToast('Please select at least one record to delete.', 'warning');
                return;
            }

            AppUtils.confirm('Are you sure you want to delete ' + selectedIds.length + ' failed record(s)? This action cannot be undone.', async function() {
                var successCount = 0;
                var failCount = 0;

                for (var i = 0; i < selectedIds.length; i++) {
                    try {
                        await ConsignmentService.deleteFailedCBR(selectedIds[i]);
                        successCount++;
                    } catch (err) {
                        failCount++;
                        console.error('Failed to delete ' + selectedIds[i] + ':', err);
                    }
                }

                if (failCount === 0) {
                    AppUtils.showToast('All ' + successCount + ' record(s) deleted successfully.', 'success');
                } else {
                    AppUtils.showToast(successCount + ' deleted, ' + failCount + ' failed.', 'warning');
                }

                document.getElementById('selectAll').checked = false;
                loadFailedList(currentPage);
            });
        }

        function resetFilters() {
            $('#company').val('').trigger('change');
            $('#store').val('');
            document.getElementById('filterCustomerCode').value = '';
            document.getElementById('filterFromDate').value = '';
            document.getElementById('filterToDate').value = '';
            loadFailedList(1);
        }
    </script>
</body>
</html>
