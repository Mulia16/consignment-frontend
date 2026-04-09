<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Consignment Stock Return</title>
        <!-- CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="/static/css/style.css">
    </head>

    <body>

        <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
        <div class="main-content">
            <jsp:include page="/WEB-INF/jsp/common/header.jsp">
                <jsp:param name="pageTitle" value="Consignment Stock Return" />
            </jsp:include>

            <div class="container-fluid mt-3">
                <!-- Breadcrumb & Top Actions -->
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb bg-transparent p-0 m-0">
                            <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                            <li class="breadcrumb-item">Consignment</li>
                            <li class="breadcrumb-item">Transaction</li>
                            <li class="breadcrumb-item active" aria-current="page">Consignment Stock Return</li>
                        </ol>
                    </nav>
                    <button class="btn btn-primary"
                        onclick="window.location.href='/consignment/stock-return/details'"><i class="fas fa-plus"></i>
                        Add New</button>
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
                                    <div class="col-md-4 mb-3">
                                        <label class="small text-muted mb-1">Company</label>
                                        <select class="form-control" name="company" id="company">
                                            <option value="">All Companies</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="small text-muted mb-1">Store</label>
                                        <select class="form-control" name="store" id="store">
                                            <option value="">All Stores</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="small text-muted mb-1">Consignment Stock Return Number</label>
                                        <input type="text" class="form-control" name="docNo">
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label class="small text-muted mb-1">Reason</label>
                                        <input type="text" class="form-control" name="reasonCode">
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="small text-muted mb-1">Created By</label>
                                        <input type="text" class="form-control" name="createdBy">
                                    </div>
                                    <div class="col-md-4 mb-3"></div>
                                </div>

                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label class="small text-muted mb-1">Supplier</label>
                                        <select class="form-control" name="supplierCode" id="supplierCode">
                                            <option value="">All Suppliers</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="small text-muted mb-1">Supplier Contract</label>
                                        <select class="form-control" name="supplierContract" id="supplierContract">
                                            <option value="">All Contracts</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="small text-muted mb-1">Internal Supplier Store</label>
                                        <input type="text" class="form-control" name="internalSupplierStore">
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label class="small text-muted mb-1">Created Date</label>
                                        <div class="input-group">
                                            <input type="date" class="form-control" name="createdDateFrom"
                                                placeholder="From">
                                            <input type="date" class="form-control" name="createdDateTo"
                                                placeholder="To">
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="small text-muted mb-1">Released Date</label>
                                        <div class="input-group">
                                            <input type="date" class="form-control" name="releasedDateFrom"
                                                placeholder="From">
                                            <input type="date" class="form-control" name="releasedDateTo"
                                                placeholder="To">
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="small text-muted mb-1">Completed Date</label>
                                        <div class="input-group">
                                            <input type="date" class="form-control" name="completedDateFrom"
                                                placeholder="From">
                                            <input type="date" class="form-control" name="completedDateTo"
                                                placeholder="To">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label class="small text-muted mb-1">Return Status</label>
                                        <select class="form-control" name="status">
                                            <option value="">All</option>
                                            <option value="Held">Held</option>
                                            <option value="Released">Released</option>
                                            <option value="Completed">Completed</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="small text-muted mb-1">Reference Number</label>
                                        <input type="text" class="form-control" name="referenceNumber">
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="small text-muted mb-1">Item Code</label>
                                        <select class="form-control" name="itemCode" id="itemCode">
                                            <option value="">All Items</option>
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
                                        <th>Return Number</th>
                                        <th>Store</th>
                                        <th>Supplier</th>
                                        <th>Supplier Confirm Note</th>
                                        <th>Created By</th>
                                        <th>Status</th>
                                        <th width="60"></th>
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
                                <button class="btn btn-dark mr-2" onclick="batchComplete()">Completed</button>
                                <button class="btn btn-outline-secondary mr-2" onclick="batchPrint()"><i
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
                $('#nav-consignment-stockreturn').addClass('active');
                $('#menu-returns').addClass('active');
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
                        if (key === 'supplier') key = 'supplierCode';
                        params.append(key, value.trim());
                    }
                }

                params.append('page', currentPage + 1);
                params.append('perPage', perPage);

                try {
                    var res = await ConsignmentService.searchCSR(params);
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
                        returnNumber: item.docNo || '-',
                        store: item.store || '-',
                        supplier: item.supplierCode || '-',
                        supplierConfirmNote: item.supplierConfirmNote || '-',
                        createdBy: item.createdBy || '-',
                        status: item.status ? item.status.toUpperCase() : 'HELD'
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
                    tbody.append('<tr><td colspan="8" class="text-center py-4">No records found.</td></tr>');
                    $('#totalInfo').text('Showing 0 of 0 records');
                    $('#paginationContainer').empty();
                    return;
                }

                data.forEach(function (row) {
                    var badgeClass = '';
                    if (row.status === 'Held') badgeClass = 'badge-warning';
                    else if (row.status === 'Released') badgeClass = 'badge-success';
                    else if (row.status === 'Completed') badgeClass = 'badge-secondary';

                    var actionHtml = '<a href="/consignment/stock-return/details?id=' + row.id + '"><i class="fas fa-edit text-primary"></i></a>';

                    var supplierFormatted = row.supplier.replace(/\n/g, '<br>');

                    var tr = `<tr>
            <td><input type="checkbox" class="row-checkbox" value="\${row.id}"></td>
            <td><a href="/consignment/stock-return/details?id=\${row.id}">\${row.returnNumber}</a></td>
            <td class="text-primary font-weight-bold">\${row.store}</td>
            <td><small>\${supplierFormatted}</small></td>
            <td>\${row.supplierConfirmNote}</td>
            <td>\${row.createdBy}</td>
            <td><span class="badge \${badgeClass}">\${row.status}</span></td>
            <td>\${actionHtml}</td>
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
                    if (ids.includes(d.id.toString()) && d.status !== 'HELD') {
                        isValid = false;
                    }
                });

                if (!isValid) {
                    AppUtils.showToast('Only HELD documents can be released.', 'warning');
                    return;
                }

                if (confirm('Are you sure you want to release the selected ' + ids.length + ' document(s)?')) {
                    AppUtils.showLoading();
                    Promise.all(ids.map(id => ConsignmentService.releaseCSR(id)))
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

            function batchComplete() {
                var ids = getSelectedIds();
                if (ids.length === 0) { AppUtils.showToast('Please select at least one document', 'warning'); return; }

                var isValid = true;
                allData.forEach(function (d) {
                    if (ids.includes(d.id.toString()) && d.status !== 'RELEASED') {
                        isValid = false;
                    }
                });

                if (!isValid) {
                    AppUtils.showToast('Only RELEASED documents can be completed.', 'warning');
                    return;
                }

                if (confirm('Are you sure you want to complete the selected ' + ids.length + ' document(s)?')) {
                    AppUtils.showLoading();
                    Promise.all(ids.map(id => ConsignmentService.completeCSR(id)))
                        .then(() => {
                            AppUtils.showToast('Documents successfully completed.', 'success');
                            searchData(currentPage);
                            $('#selectAll').prop('checked', false);
                        })
                        .catch(e => {
                            console.error(e);
                            AppUtils.showToast('Error completing documents', 'danger');
                        })
                        .finally(() => AppUtils.hideLoading());
                }
            }

            function batchDelete() {
                // Delete API not explicitly provided in Postman JSON, mock for now
                var ids = getSelectedIds();
                if (ids.length === 0) { AppUtils.showToast('Please select at least one document', 'warning'); return; }

                var isValid = true;
                allData.forEach(function (d) {
                    if (ids.includes(d.id.toString()) && d.status !== 'HELD') {
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

            function batchPrint() {
                var ids = getSelectedIds();
                if (ids.length === 0) { AppUtils.showToast('Please select a document to print', 'warning'); return; }
                AppUtils.showToast('Printing listing...', 'info');
            }
        </script>

    </body>

    </html>