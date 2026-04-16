<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Consignment Stock Request</title>
        <!-- CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="/static/css/style.css">
    </head>

    <body>

        <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
        <div class="main-content">
            <jsp:include page="/WEB-INF/jsp/common/header.jsp">
                <jsp:param name="pageTitle" value="Consignment Stock Request" />
            </jsp:include>

            <div class="container-fluid mt-3">
                <!-- Breadcrumb & Top Actions -->
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb bg-transparent p-0 m-0">
                            <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                            <li class="breadcrumb-item">Consignment</li>
                            <li class="breadcrumb-item">Transaction</li>
                            <li class="breadcrumb-item active" aria-current="page">Consignment Stock Request</li>
                        </ol>
                    </nav>
                    <button class="btn btn-primary"
                        onclick="window.location.href='/consignment/stock-request/details'"><i class="fas fa-plus"></i>
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
                                        <label class="small text-muted mb-1">Supplier</label>
                                        <select class="form-control" name="supplierCode" id="supplierCode">
                                            <option value="">All Suppliers</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="small text-muted mb-1">Supplier Contract</label>
                                        <select class="form-control" name="supplierContract" id="supplierContract">
                                            <option value="">All Contracts</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <label class="small text-muted mb-1">Branch</label>
                                        <input type="text" class="form-control" name="branch">
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="small text-muted mb-1">Internal Supplier Store</label>
                                        <input type="text" class="form-control" name="internalSupplierStore">
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="small text-muted mb-1">Created Date</label>
                                        <div class="input-group">
                                            <input type="date" class="form-control" name="createdDateFrom"
                                                placeholder="From">
                                            <input type="date" class="form-control" name="createdDateTo"
                                                placeholder="To">
                                        </div>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="small text-muted mb-1">Create Method</label>
                                        <select class="form-control" name="createdMethod">
                                            <option value="">All</option>
                                            <option value="MANUAL">Manual</option>
                                            <option value="ACMM">Trigger from ACMM through API</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <label class="small text-muted mb-1">Created By</label>
                                        <input type="text" class="form-control" name="createdBy">
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="small text-muted mb-1">Reference Number</label>
                                        <input type="text" class="form-control" name="referenceNo">
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="small text-muted mb-1">Item Code</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" name="itemCode">
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary" type="button"><i
                                                        class="fas fa-search-plus"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="small text-muted mb-1">Status</label>
                                        <select class="form-control" name="status">
                                            <option value="">All</option>
                                            <option value="HELD">Held</option>
                                            <option value="RELEASED">Released</option>
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
                                        <th>Order Number</th>
                                        <th>Created Date</th>
                                        <th>Created By</th>
                                        <th>Supplier</th>
                                        <th>Store</th>
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
        <script src="/static/js/consignment-master-data.js"></script>
        <script src="/static/js/services/consignment-service.js?v=2"></script>

        <script>
            var tableData = [];
            var currentPage = 0;
            var perPage = 10;
            
            document.addEventListener('configLoaded', function () {
                ConsignmentMasterData.init();
                $('#nav-consignment-stock-request').addClass('active');
                $('#menu-outbound').addClass('active');
                loadData(0);
            });
            
            async function loadData(page) {
                currentPage = page || 0;
                AppUtils.showLoading();
                try {
                    // Fallback to empty filter if none
                    let company = document.querySelector('[name="company"]').value || '';
                    let store = document.querySelector('[name="store"]').value || '';
                    let status = document.querySelector('[name="status"]').value || '';
                    
                    let timestamp = new Date().getTime();
                    let path = `/csrq?company=\${company}&store=\${store}&status=\${status}&page=\${currentPage + 1}&perPage=\${perPage}&_t=\${timestamp}`;
                    
                    let result = await ApiClient.get('CONSIGNMENT', path);
                    
                    let data = [];
                    let meta = result.meta || { page: 1, perPage: perPage, totalData: 0, totalPage: 1 };
                    
                    if (result.data && Array.isArray(result.data)) {
                        data = result.data;
                    } else if (Array.isArray(result)) {
                        data = result;
                    } else {
                        data = [result]; // if it returns single object inadvertently
                    }
                    
                    tableData = data;
                    renderTable(tableData, meta);
                } catch (e) {
                    console.error('API Error, using mock data as fallback', e);
                    useMockData();
                } finally {
                    AppUtils.hideLoading();
                }
            }

            function useMockData() {
                tableData = [
                    { id: "53dd495b-9c98-497b-9727-63de21cce434", docNo: "CSRQ-00001", createdAt: "2026-04-07T04:10:23.057878Z", createdBy: "user01", supplierCode: "SUPP001", store: "STORE01", status: "HELD" },
                    { id: "csrq-002", docNo: "CSRQ-00002", createdAt: "2026-04-07T05:10:23.057Z", createdBy: "user02", supplierCode: "SUPP002", store: "STORE02", status: "RELEASED" }
                ];
                renderTable(tableData);
            }

            function searchData() {
                loadData(currentPage);
            }

            function renderTable(data, meta) {
                var tbody = $('#dataTableBody');
                tbody.empty();
                
                if (!data || data.length === 0) {
                    tbody.append('<tr><td colspan="8" class="text-center py-4">No records found.</td></tr>');
                    $('#totalInfo').text('Showing 0 of 0 records');
                    $('#paginationContainer').empty();
                    return;
                }

                data.forEach(function (row) {
                    var badgeClass = '';
                    if (row.status === 'HELD') badgeClass = 'badge-warning';
                    else if (row.status === 'RELEASED') badgeClass = 'badge-success';

                    var showEdit = row.status === 'HELD';

                    var actionHtml = showEdit ?
                        '<a href="/consignment/stock-request/details?id=' + row.id + '"><i class="fas fa-edit text-primary"></i></a>' :
                        '<a href="/consignment/stock-request/details?id=' + row.id + '"><i class="fas fa-eye text-primary"></i></a>';

                    var displayDate = row.createdAt ? new Date(row.createdAt).toLocaleDateString() : '';

                    var tr = `<tr>
            <td><input type="checkbox" class="row-checkbox" value="\${row.id}"></td>
            <td>\${row.docNo || row.orderNumber || ''}</td>
            <td>\${displayDate}</td>
            <td>\${row.createdBy || ''}</td>
            <td>\${row.supplierCode || ''}</td>
            <td class="text-primary font-weight-bold">\${row.store || ''}</td>
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
                    AppUtils.buildPagination('paginationContainer', currentPage, meta.totalPage, loadData);
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

            async function batchRelease() {
                var ids = getSelectedIds();
                if (ids.length === 0) { AppUtils.showToast('Please select at least one document', 'warning'); return; }

                var isValid = true;
                tableData.forEach(function (d) {
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
                    let successCount = 0;

                    for (let id of ids) {
                        try {
                            await ApiClient.put('CONSIGNMENT', `/csrq/\${id}/release`, {});
                            successCount++;
                        } catch (e) {
                            console.error(e);
                        }
                    }

                    AppUtils.hideLoading();
                    if (successCount > 0) {
                        AppUtils.showToast(successCount + ' Documents successfully released.', 'success');
                        loadData(currentPage);
                    }
                    $('#selectAll').prop('checked', false);
                }
            }

            async function batchDelete() {
                var ids = getSelectedIds();
                if (ids.length === 0) { AppUtils.showToast('Please select at least one document', 'warning'); return; }

                var isValid = true;
                tableData.forEach(function (d) {
                    if (ids.includes(d.id.toString()) && d.status === 'RELEASED') {
                        isValid = false;
                    }
                });

                if (!isValid) {
                    AppUtils.showToast('Cannot delete RELEASED documents.', 'warning');
                    return;
                }

                if (confirm('Confirm delete selected ' + ids.length + ' document(s)?')) {
                    AppUtils.showLoading();
                    let successCount = 0;

                    for (let id of ids) {
                        try {
                            await ApiClient.delete('CONSIGNMENT', `/csrq/\${id}`);
                            successCount++;
                        } catch (e) {
                            console.error(e);
                        }
                    }

                    AppUtils.hideLoading();
                    if (successCount > 0) {
                        AppUtils.showToast(successCount + ' Documents successfully deleted.', 'success');
                        loadData(currentPage);
                    }
                    $('#selectAll').prop('checked', false);
                }
            }

            async function batchPrint() {
                var ids = getSelectedIds();
                if (ids.length === 0) { AppUtils.showToast('Please select a document to print', 'warning'); return; }
                AppUtils.showLoading();
                var successCount = 0;
                for (var i = 0; i < ids.length; i++) {
                    try {
                        await ConsignmentService.printCSRQSlip(ids[i]);
                        successCount++;
                        // Small delay between downloads to prevent browser blocking
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