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
            <!-- Breadcrumb & Top Actions -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb bg-transparent p-0 m-0">
                        <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                        <li class="breadcrumb-item">Consignment</li>
                        <li class="breadcrumb-item">Settlement</li>
                        <li class="breadcrumb-item active" aria-current="page">Supplier Consignment Billing Request</li>
                    </ol>
                </nav>
            </div>

            <!-- Filter Section -->
            <div class="card mb-3 shadow-sm">
                <div class="card-body py-2">
                    <form id="filterForm" class="form-inline flex-wrap">
                        <div class="form-group mr-3 mb-2">
                            <label class="small text-muted mr-1">Company</label>
                            <select class="form-control form-control-sm" id="filterCompany">
                                <option value="">All</option>
                            </select>
                        </div>
                        <div class="form-group mr-3 mb-2">
                            <label class="small text-muted mr-1">Store</label>
                            <select class="form-control form-control-sm" id="filterStore">
                                <option value="">All</option>
                            </select>
                        </div>
                        <div class="form-group mr-3 mb-2">
                            <label class="small text-muted mr-1">Supplier</label>
                            <select class="form-control form-control-sm" id="filterSupplier">
                                <option value="">All</option>
                            </select>
                        </div>
                        <div class="form-group mr-3 mb-2">
                            <label class="small text-muted mr-1">Status</label>
                            <select class="form-control form-control-sm" id="filterStatus">
                                <option value="">All</option>
                                <option value="HELD">HELD</option>
                                <option value="RELEASED">RELEASED</option>
                            </select>
                        </div>
                        <button type="button" class="btn btn-primary btn-sm mb-2" onclick="loadBillingList(1)"><i class="fas fa-search"></i> Search</button>
                        <button type="button" class="btn btn-outline-secondary btn-sm mb-2 ml-2" onclick="resetFilters()"><i class="fas fa-undo"></i> Reset</button>
                    </form>
                </div>
            </div>

            <!-- List Actions Row -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <button class="btn btn-primary btn-sm mr-2" onclick="batchRelease()"><i class="fas fa-check-circle"></i> Release</button>
                    <button class="btn btn-outline-danger btn-sm" onclick="batchDelete()"><i class="fas fa-trash"></i> Delete</button>
                </div>
                <div class="d-flex align-items-center">
                    <button class="btn btn-outline-secondary btn-sm" onclick="loadBillingList(currentPage)"><i class="fas fa-sync-alt"></i> Refresh</button>
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
                                    <th>Supplier</th>
                                    <th>Supplier Contract</th>
                                    <th>Status</th>
                                    <th>Process Status</th>
                                    <th width="60"></th>
                                </tr>
                            </thead>
                            <tbody id="dataTableBody">
                                <tr><td colspan="11" class="text-center py-4"><div class="spinner-border spinner-border-sm text-primary"></div> Loading...</td></tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="d-flex justify-content-between align-items-center p-3 border-top bg-light">
                        <div class="d-flex align-items-center">
                            <select class="form-control form-control-sm mr-2" id="perPageSelect" style="width: 70px;" onchange="loadBillingList(1)">
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
    <script src="/static/js/services/consignment-service.js?v=3"></script>
    <script>
        var currentPage = 1;
        var allData = [];

        // UI setup on DOMContentLoaded
        document.addEventListener('DOMContentLoaded', function () {
            $('#nav-consignment-supplier-billing').addClass('active');

            // Company change → load stores for filter
            document.getElementById('filterCompany').addEventListener('change', function () {
                loadFilterStores(this.value);
            });
        });

        // API initialization - called by footer after config is loaded
        window.initPage = function () {
            loadFilterCompanies();
            loadBillingList(1);
        };

        // Fallback: if configLoaded already fired before initPage was defined
        document.addEventListener('configLoaded', function () {
            if (typeof ConsignmentService !== 'undefined' && !window._pageInitialized) {
                window._pageInitialized = true;
                window.initPage();
            }
        });

        // ── Filter Dropdown Loaders ──────────────────────────────

        async function loadFilterCompanies() {
            try {
                var response = await ConsignmentService.getCompanies();
                var select = document.getElementById('filterCompany');
                select.innerHTML = '<option value="">All</option>';
                if (response.data && Array.isArray(response.data)) {
                    response.data.forEach(function(item) {
                        var opt = document.createElement('option');
                        opt.value = item;
                        opt.textContent = item;
                        select.appendChild(opt);
                    });
                }
            } catch (err) {
                console.error('Failed to load companies:', err);
            }
        }

        async function loadFilterStores(company) {
            var select = document.getElementById('filterStore');
            select.innerHTML = '<option value="">All</option>';
            if (!company) return;

            try {
                var response = await ConsignmentService.getStores(company);
                if (response.data && Array.isArray(response.data)) {
                    response.data.forEach(function(item) {
                        var opt = document.createElement('option');
                        opt.value = item;
                        opt.textContent = item;
                        select.appendChild(opt);
                    });
                }
            } catch (err) {
                console.error('Failed to load stores:', err);
            }
        }

        // ── Data Loading ─────────────────────────────────────────

        async function loadBillingList(page) {
            currentPage = page;
            var perPage = parseInt(document.getElementById('perPageSelect').value) || 20;
            var tbody = document.getElementById('dataTableBody');
            tbody.innerHTML = '<tr><td colspan="11" class="text-center py-4"><div class="spinner-border spinner-border-sm text-primary"></div> Loading...</td></tr>';

            var params = {
                page: page,
                perPage: perPage
            };

            // Add filters
            var company = document.getElementById('filterCompany').value;
            var store = document.getElementById('filterStore').value;
            var supplierCode = document.getElementById('filterSupplier').value;
            var status = document.getElementById('filterStatus').value;

            if (company) params.company = company;
            if (store) params.store = store;
            if (supplierCode) params.supplierCode = supplierCode;
            if (status) params.status = status;

            try {
                var response = await ConsignmentService.listSupplierBilling(params);
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
                    loadBillingList(p + 1);
                });
            } catch (error) {
                tbody.innerHTML = '<tr><td colspan="11" class="text-center py-4 text-danger"><i class="fas fa-exclamation-circle"></i> ' + error.message + '</td></tr>';
                document.getElementById('pageInfo').textContent = 'Error loading data';
            }
        }

        function renderTable(data) {
            var tbody = document.getElementById('dataTableBody');
            tbody.innerHTML = '';

            if (!data || data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="11" class="text-center py-4 text-muted"><i class="fas fa-inbox fa-2x mb-2 d-block"></i>No records found.</td></tr>';
                return;
            }

            data.forEach(function (row) {
                var statusBadge = '';
                if (row.status === 'HELD') statusBadge = 'badge-warning';
                else if (row.status === 'RELEASED') statusBadge = 'badge-success';
                else statusBadge = 'badge-secondary';

                var processBadge = '';
                if (row.processStatus === 'COMPLETED') processBadge = 'badge-info';
                else if (row.processStatus === 'FAILED') processBadge = 'badge-danger';
                else processBadge = 'badge-secondary';

                var tr = document.createElement('tr');
                tr.innerHTML =
                    '<td><input type="checkbox" class="row-checkbox" data-id="' + row.id + '" data-status="' + row.status + '"></td>' +
                    '<td><a href="/consignment/settlement/supplier-billing/details?id=' + row.id + '">' + (row.docNo || '-') + '</a></td>' +
                    '<td>' + (row.periodType || '-') + '</td>' +
                    '<td>' + AppUtils.formatDate(row.fromDate) + '</td>' +
                    '<td>' + AppUtils.formatDate(row.toDate) + '</td>' +
                    '<td>' + (row.store || '-') + '</td>' +
                    '<td><small>' + (row.supplierCode || '-') + '</small></td>' +
                    '<td><small>' + (row.supplierContract || '-') + '</small></td>' +
                    '<td><span class="badge ' + statusBadge + '">' + (row.status || '-') + '</span></td>' +
                    '<td><span class="badge ' + processBadge + '">' + (row.processStatus || '-') + '</span></td>' +
                    '<td class="text-center"><a href="/consignment/settlement/supplier-billing/details?id=' + row.id + '" title="View Details"><i class="fas fa-eye text-primary"></i></a></td>';
                tbody.appendChild(tr);
            });
        }

        // ── Selection Helpers ─────────────────────────────────────

        function toggleAll() {
            var isChecked = document.getElementById('selectAll').checked;
            document.querySelectorAll('.row-checkbox').forEach(function(cb) {
                cb.checked = isChecked;
            });
        }

        function getSelectedCheckboxes() {
            var checkboxes = [];
            document.querySelectorAll('.row-checkbox:checked').forEach(function(cb) {
                checkboxes.push({
                    id: cb.getAttribute('data-id'),
                    status: cb.getAttribute('data-status')
                });
            });
            return checkboxes;
        }

        // ── Batch Actions ─────────────────────────────────────────

        async function batchRelease() {
            var selected = getSelectedCheckboxes();
            if (selected.length === 0) {
                AppUtils.showToast('Please select at least one document.', 'warning');
                return;
            }

            var nonHeld = selected.filter(function(s) { return s.status !== 'HELD'; });
            if (nonHeld.length > 0) {
                AppUtils.showToast('Only HELD documents can be released.', 'danger');
                return;
            }

            AppUtils.confirm('Are you sure you want to release ' + selected.length + ' document(s)?', async function() {
                var successCount = 0;
                var failCount = 0;

                for (var i = 0; i < selected.length; i++) {
                    try {
                        await ConsignmentService.releaseSupplierBilling(selected[i].id);
                        successCount++;
                    } catch (err) {
                        failCount++;
                        console.error('Failed to release ' + selected[i].id + ':', err);
                    }
                }

                if (failCount === 0) {
                    AppUtils.showToast('All ' + successCount + ' document(s) released successfully.', 'success');
                } else {
                    AppUtils.showToast(successCount + ' released, ' + failCount + ' failed.', 'warning');
                }

                document.getElementById('selectAll').checked = false;
                loadBillingList(currentPage);
            });
        }

        async function batchDelete() {
            var selected = getSelectedCheckboxes();
            if (selected.length === 0) {
                AppUtils.showToast('Please select at least one document.', 'warning');
                return;
            }

            var nonHeld = selected.filter(function(s) { return s.status !== 'HELD'; });
            if (nonHeld.length > 0) {
                AppUtils.showToast('Only HELD documents can be deleted.', 'danger');
                return;
            }

            AppUtils.confirm('Are you sure you want to delete ' + selected.length + ' document(s)? This action cannot be undone.', async function() {
                var successCount = 0;
                var failCount = 0;

                for (var i = 0; i < selected.length; i++) {
                    try {
                        await ConsignmentService.deleteSupplierBilling(selected[i].id);
                        successCount++;
                    } catch (err) {
                        failCount++;
                        console.error('Failed to delete ' + selected[i].id + ':', err);
                    }
                }

                if (failCount === 0) {
                    AppUtils.showToast('All ' + successCount + ' document(s) deleted successfully.', 'success');
                } else {
                    AppUtils.showToast(successCount + ' deleted, ' + failCount + ' failed.', 'warning');
                }

                document.getElementById('selectAll').checked = false;
                loadBillingList(currentPage);
            });
        }

        function resetFilters() {
            document.getElementById('filterCompany').value = '';
            document.getElementById('filterStore').innerHTML = '<option value="">All</option>';
            document.getElementById('filterSupplier').value = '';
            document.getElementById('filterStatus').value = '';
            loadBillingList(1);
        }
    </script>
</body>
</html>
