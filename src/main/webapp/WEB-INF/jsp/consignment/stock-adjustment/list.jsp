<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consignment Stock Adjustment</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>

<body>

    <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
    <div class="main-content">
        <jsp:include page="/WEB-INF/jsp/common/header.jsp">
            <jsp:param name="pageTitle" value="Consignment Stock Adjustment" />
        </jsp:include>

        <div class="container-fluid mt-3">
            <!-- Breadcrumb & Top Actions -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb bg-transparent p-0 m-0">
                        <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                        <li class="breadcrumb-item">Consignment</li>
                        <li class="breadcrumb-item">Transaction</li>
                        <li class="breadcrumb-item active" aria-current="page">Consignment Stock Adjustment</li>
                    </ol>
                </nav>
                <div>
                    <button class="btn btn-primary mr-2" onclick="batchPrint()"><i class="fas fa-print"></i>
                        Print</button>
                    <button class="btn btn-primary" onclick="window.location.href='/consignment/stock-adjustment/details'">
                        <i class="fas fa-plus"></i> Add New
                    </button>
                </div>
            </div>

            <!-- Filter Panel -->
            <div class="card mb-4 shadow-sm">
                <div class="card-header bg-white font-weight-bold" data-toggle="collapse"
                    data-target="#filterCollapse" style="cursor: pointer;">
                    <i class="fas fa-filter mr-2"></i> Filter & Search
                </div>
                <div id="filterCollapse" class="collapse show">
                    <div class="card-body">
                        <form id="filterForm">
                            <div class="row">
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Company</label>
                                    <select class="form-control" name="company" id="company">
                                        <option value="">All Companies</option>
                                    </select>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Store</label>
                                    <select class="form-control" name="store" id="store">
                                        <option value="">All Stores</option>
                                    </select>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Adjustment Number</label>
                                    <input type="text" class="form-control" name="docNo">
                                </div>
                                <div class="col-md-3 mb-3"></div>
                            </div>

                            <div class="row">
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Transaction Type</label>
                                    <select class="form-control" name="transactionType">
                                        <option value="">All</option>
                                        <option value="ADJ_IN">ADJ IN</option>
                                        <option value="ADJ_OUT">ADJ OUT</option>
                                    </select>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Create From</label>
                                    <select class="form-control" name="createFrom">
                                        <option value="">All</option>
                                        <option value="Stock Take">ACMM Stock Take</option>
                                        <option value="Bin Adjustment">ACMM Bin Adjustment</option>
                                        <option value="Implode Explode">ACMM Implode & Explode</option>
                                        <option value="Disposal">ACMM Disposal</option>
                                        <option value="Material Requisition">ACMM Material Requisition</option>
                                        <option value="Inventory Variance Adjustment">ACMM Inventory Variance Adjustmen</option>
                                        <option value="Manual">Manual</option>
                                    </select>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Reason</label>
                                    <input type="text" class="form-control" name="reasonCode">
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Reference Number</label>
                                    <input type="text" class="form-control" name="referenceNo">
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Created Date</label>
                                    <div class="input-group">
                                        <input type="date" class="form-control" name="createdDateFrom" placeholder="From">
                                        <input type="date" class="form-control" name="createdDateTo" placeholder="To">
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Created By</label>
                                    <input type="text" class="form-control" name="createdBy">
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Released Date</label>
                                    <div class="input-group">
                                        <input type="date" class="form-control" name="releasedDateFrom" placeholder="From">
                                        <input type="date" class="form-control" name="releasedDateTo" placeholder="To">
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Released By</label>
                                    <input type="text" class="form-control" name="releasedBy">
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Item Code</label>
                                    <select class="form-control" name="itemCode" id="itemCode">
                                        <option value="">All Items</option>
                                    </select>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Remarks</label>
                                    <input type="text" class="form-control" name="remarks">
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Status</label>
                                    <select class="form-control" name="status">
                                        <option value="">All</option>
                                        <option value="Held">Held</option>
                                        <option value="Released">Released</option>
                                    </select>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end mt-2">
                                <button type="button" class="btn btn-outline-secondary mr-2"
                                    onclick="document.getElementById('filterForm').reset()">Clear Filter</button>
                                <button type="button" class="btn btn-primary" onclick="searchData()"><i
                                        class="fas fa-search"></i> Search</button>
                            </div>
                        </form>
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
                                    <th>Store</th>
                                    <th>Store Short Name</th>
                                    <th>Adjustment Number</th>
                                    <th>Transaction Type</th>
                                    <th>Create From</th>
                                    <th>Adjustment Reason</th>
                                    <th>Created Date</th>
                                    <th>Created By</th>
                                    <th>Status</th>
                                    <th>Remark</th>
                                </tr>
                            </thead>
                            <tbody id="dataTableBody">
                                <!-- JS Render -->
                            </tbody>
                        </table>
                    </div>

                    <div class="d-flex justify-content-between align-items-center p-3 border-top bg-light">
                        <!-- Bulk Actions -->
                        <div>
                            <button class="btn btn-primary mr-2" onclick="batchRelease()">Release</button>
                            <button class="btn btn-primary mr-2" onclick="batchPrint()"><i
                                    class="fas fa-print"></i> Print</button>
                            <button class="btn btn-outline-danger" onclick="batchDelete()"><i
                                    class="fas fa-trash"></i> Delete</button>
                        </div>
                        <div>
                            <small class="text-muted" id="totalInfo">Showing 0 of 0 records</small>
                            <div id="paginationContainer"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
    <script src="/static/js/services/consignment-service.js"></script>
    <script src="/static/js/consignment-master-data.js"></script>
    <script>
        var allData = [];
        var currentPage = 0;
        var perPage = 10;

        document.addEventListener('configLoaded', function () {
            ConsignmentMasterData.init();
            searchData(0);
            $('#nav-consignment-stockadjustment').addClass('active');
            $('#menu-transaction').addClass('active'); // If we have a transaction dropdown
        });

        async function searchData(page) {
            currentPage = page || 0;
            AppUtils.showLoading();

            var form = document.getElementById('filterForm');
            var formData = new FormData(form);
            var params = new URLSearchParams();

            for (var pair of formData.entries()) {
                var key = pair[0];
                var value = pair[1];
                if (value && value.trim() !== '') {
                    params.append(key, value.trim());
                }
            }

            params.append('page', currentPage + 1);
            params.append('perPage', perPage);

            try {
                var res = await ConsignmentService.searchCSA(params);
                var data = [];
                var meta = res.meta || { page: 1, perPage: perPage, totalData: 0, totalPage: 1 };

                if (res.data && Array.isArray(res.data)) {
                    data = res.data;
                } else if (res.items && Array.isArray(res.items)) {
                    data = res.items;
                } else if (Array.isArray(res)) {
                    data = res;
                }

                allData = data.map(item => ({
                    id: item.id || item.docNo,
                    store: item.store || '-',
                    storeShortName: item.storeShortName || '-', // Not in mock API usually, placeholder
                    docNo: item.docNo || '-',
                    transactionType: item.transactionType || '-',
                    createFrom: item.createFrom || 'Manual',
                    adjustmentReason: item.reasonCode || '-',
                    createdDate: item.createdAt ? new Date(item.createdAt).toISOString().split('T')[0] : '-',
                    createdBy: item.createdBy || 'SYSTEM OPERATOR',
                    status: item.status ? item.status.toUpperCase() : 'HELD',
                    remark: item.remark || '-'
                }));

                renderTable(allData, meta);
            } catch (e) {
                console.error(e);
                AppUtils.showToast('Failed to load data', 'danger');
                renderTable([], { page: 1, perPage: perPage, totalData: 0, totalPage: 1 });
            } finally {
                AppUtils.hideLoading();
            }
        }

        function renderTable(data, meta) {
            var tbody = $('#dataTableBody');
            tbody.empty();

            if (data.length === 0) {
                tbody.append('<tr><td colspan="11" class="text-center py-4">No records found.</td></tr>');
                $('#totalInfo').text('Showing 0 of 0 records');
                $('#paginationContainer').empty();
                return;
            }

            data.forEach(function (row) {
                var badgeClass = '';
                var displayStatus = row.status.toLowerCase() === 'held' ? 'Held' : (row.status.toLowerCase() === 'released' ? 'Released' : row.status);
                
                if (displayStatus === 'Held') badgeClass = 'badge-warning';
                else if (displayStatus === 'Released') badgeClass = 'badge-success';
                else badgeClass = 'badge-secondary';

                var typeFormatted = row.transactionType === 'ADJ_IN' ? 'Adjustment In' : (row.transactionType === 'ADJ_OUT' ? 'Adjustment Out' : row.transactionType);

                var tr = `<tr>
        <td><input type="checkbox" class="row-checkbox" value="\${row.id}"></td>
        <td>\${row.store}</td>
        <td>\${row.storeShortName}</td>
        <td><a href="/consignment/stock-adjustment/details?id=\${row.id}">\${row.docNo}</a></td>
        <td>\${typeFormatted}</td>
        <td>\${row.createFrom}</td>
        <td>\${row.adjustmentReason}</td>
        <td>\${row.createdDate}</td>
        <td>\${row.createdBy}</td>
        <td><span class="badge \${badgeClass}">\${displayStatus}</span></td>
        <td>\${row.remark}</td>
    </tr>`;
                tbody.append(tr);
            });

            // Update pagination info
            var from = (meta.page - 1) * meta.perPage + 1;
            var to = Math.min(meta.page * meta.perPage, meta.totalData);
            $('#totalInfo').text('Showing ' + from + '-' + to + ' of ' + meta.totalData + ' records');

            // Build pagination
            if (meta.totalPage > 1) {
                AppUtils.buildPagination('paginationContainer', currentPage, meta.totalPage, searchData);
            } else {
                $('#paginationContainer').empty();
            }
        }

        function toggleAll() {
            var isChecked = $('#selectAll').prop('checked');
            $('.row-checkbox').prop('checked', isChecked);
        }

        function getSelectedIds() {
            var ids = [];
            $('.row-checkbox:checked').each(function () {
                ids.push($(this).val());
            });
            return ids;
        }

        function batchRelease() {
            var ids = getSelectedIds();
            if (ids.length === 0) { AppUtils.showToast('Please select at least one document', 'warning'); return; }

            var isValid = true;
            allData.forEach(function (d) {
                if (ids.includes(d.id.toString()) && d.status.toLowerCase() !== 'held') {
                    isValid = false;
                }
            });

            if (!isValid) {
                AppUtils.showToast('Only HELD documents can be released.', 'warning');
                return;
            }

            if (confirm('Are you sure you want to release the selected ' + ids.length + ' document(s)?')) {
                AppUtils.showLoading();
                Promise.all(ids.map(id => ConsignmentService.releaseCSA(id, Auth.getUser().username)))
                    .then(() => {
                        AppUtils.showToast('Documents successfully released.', 'success');
                        searchData(currentPage);
                        $('#selectAll').prop('checked', false);
                    })
                    .catch(e => {
                        console.error(e);
                        AppUtils.showToast('Error releasing documents', 'danger');
                    })
                    .finally(() => AppUtils.hideLoading());
            }
        }

        function batchDelete() {
            var ids = getSelectedIds();
            if (ids.length === 0) { AppUtils.showToast('Please select at least one document', 'warning'); return; }

            var isValid = true;
            allData.forEach(function (d) {
                if (ids.includes(d.id.toString()) && d.status.toLowerCase() !== 'held') {
                    isValid = false;
                }
            });

            if (!isValid) {
                AppUtils.showToast('Only HELD documents can be deleted.', 'warning');
                return;
            }

            if (confirm('Confirm delete selected ' + ids.length + ' document(s)?')) {
                AppUtils.showToast('Documents successfully deleted.', 'success');
                allData = allData.filter(d => !ids.includes(d.id.toString()));
                renderTable(allData, { page: 1, perPage: perPage, totalData: allData.length, totalPage: 1 });
            }
        }

        async function batchPrint() {
            var ids = getSelectedIds();
            if (ids.length === 0) { AppUtils.showToast('Please select a document to print', 'warning'); return; }
            AppUtils.showLoading();
            var successCount = 0;
            for (var i = 0; i < ids.length; i++) {
                try {
                    await ConsignmentService.printCSASlip(ids[i]);
                    successCount++;
                    if (i < ids.length - 1) await new Promise(function(r) { setTimeout(r, 500); });
                } catch (e) {
                    console.error('Print error for ID ' + ids[i] + ':', e);
                }
            }
            AppUtils.hideLoading();
            if (successCount > 0) {
                AppUtils.showToast(successCount + ' PDF slip(s) downloaded successfully', 'success');
            }
            $('#selectAll').prop('checked', false);
        }
    </script>
</body>

</html>
