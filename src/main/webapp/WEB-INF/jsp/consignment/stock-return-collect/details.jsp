<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Stock Return Collect Details</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="/static/css/style.css">
    </head>

    <body>

        <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
        <div class="main-content">
            <jsp:include page="/WEB-INF/jsp/common/header.jsp">
                <jsp:param name="pageTitle" value="Consignment Stock Return Collect Details" />
            </jsp:include>

            <div class="container-fluid mt-3">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb bg-transparent p-0 m-0">
                            <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                            <li class="breadcrumb-item">Consignment</li>
                            <li class="breadcrumb-item">Transaction</li>
                            <li class="breadcrumb-item"><a href="/consignment/stock-return-collect">Consignment Stock
                                    Return Collect</a></li>
                            <li class="breadcrumb-item active" aria-current="page" id="breadcrumbAction">Details</li>
                        </ol>
                    </nav>
                </div>

                <div class="card mb-4 shadow-sm">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold" id="headerTitle">Document Details</h6>
                        <div>
                            <button type="button" class="btn btn-outline-secondary btn-sm"
                                onclick="window.history.back()">Back</button>
                            <button type="button" class="btn btn-primary btn-sm ml-2" id="btnSave"
                                onclick="saveDocument()">Save Actual Quantity</button>
                            <button type="button" class="btn btn-success btn-sm ml-2" id="btnUpdate"
                                onclick="updateDocument()">Update Status</button>
                            <button type="button" class="btn btn-outline-secondary btn-sm ml-2" onclick="printSlip()"><i
                                    class="fas fa-print"></i> Print Slip</button>
                        </div>
                    </div>
                    <div class="card-body">
                        <form id="detailsForm">
                            <div class="row">
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Company</label>
                                    <input type="text" class="form-control" name="company"
                                        value="ALPRO PHARMACY SDN BHD" disabled>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Store</label>
                                    <input type="text" class="form-control" name="store"
                                        value="0001 - Q PHARMACY IPOH MALL STORE" disabled>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="small text-muted mb-1">Supplier</label>
                                    <input type="text" class="form-control" name="supplier"
                                        value="0000001197 - EASY PHARMA SDN BHD" disabled>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Supplier Contract</label>
                                    <input type="text" class="form-control" name="supplierContract" value="CONT-001"
                                        disabled>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Internal Supplier Store</label>
                                    <input type="text" class="form-control" name="internalSupplierStore" value="INT-001"
                                        disabled>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="small text-muted mb-1">Status</label>
                                    <input type="text" class="form-control font-weight-bold" id="docStatus" value="Held"
                                        disabled>
                                </div>
                            </div>

                        </form>
                    </div>
                </div>

                <div class="card shadow-sm mt-4" id="itemsCard">
                    <div class="card-header bg-white">
                        <h6 class="m-0 font-weight-bold">Item Details - Input Actual Return Qty</h6>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-bordered mb-0">
                                <thead class="bg-light">
                                    <tr>
                                        <th width="50">No.</th>
                                        <th>Item Code</th>
                                        <th>UOM</th>
                                        <th width="120">Planned Qty</th>
                                        <th width="120" class="table-warning">Actual Qty</th>
                                        <th width="150">Batch ID</th>
                                        <th width="150">Expiry Date</th>
                                    </tr>
                                </thead>
                                <tbody id="itemsTableBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
        <script src="/static/js/services/consignment-service.js?v=2"></script>
        <script src="/static/js/consignment-master-data.js"></script>

        <script>
            var isUpdated = false;

            document.addEventListener('configLoaded', function () {
                var urlParams = new URLSearchParams(window.location.search);
                var id = urlParams.get('id');

                if (id) {
                    loadDocumentData(id);
                } else {
                    AppUtils.showToast("CSRN-C documents are auto-generated from CSRN. Cannot create manually.", 'warning');
                    window.history.back();
                }
            });

            async function loadDocumentData(id) {
                try {
                    AppUtils.showLoading();
                    let res = await ConsignmentService.getCSRNC(id);
                    let data = res.data || res;

                    document.getElementById('breadcrumbAction').textContent = 'CSRN-C No: ' + (data.docNo || id);

                    // Fill header mappings
                    document.querySelector('input[name="company"]').value = data.company || '';
                    document.querySelector('input[name="store"]').value = data.store || '';
                    document.querySelector('input[name="supplier"]').value = data.supplierCode || '';
                    document.querySelector('input[name="supplierContract"]').value = data.supplierContract || '';

                    document.getElementById('docStatus').value = data.status || 'HELD';

                    isUpdated = (data.status === 'RELEASED' || data.status === 'UPDATED' || data.status === 'COMPLETED');
                    if (isUpdated) {
                        document.getElementById('btnSave').classList.add('d-none');
                        document.getElementById('btnUpdate').classList.add('d-none');
                    }

                    renderItems(data.items || []);
                } catch (e) {
                    console.error('Failed to load document data:', e);
                    AppUtils.showToast('Failed to load document data.', 'danger');
                } finally {
                    AppUtils.hideLoading();
                }
            }

            function renderItems(items) {
                var tbody = document.getElementById('itemsTableBody');
                tbody.innerHTML = '';

                if (items.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="7" class="text-center py-4">No records found.</td></tr>';
                    return;
                }

                items.forEach((item, index) => {
                    var tr = document.createElement('tr');
                    var actualQty = item.actualQty !== null && item.actualQty !== undefined ? item.actualQty : 0.0;
                    tr.innerHTML = `
            <td class="text-center align-middle">\${index + 1}</td>
            <td>
                <input type="hidden" name="itemId" value="\${item.id}" />
                <input type="text" class="form-control form-control-sm" value="\${item.itemCode || ''}" disabled />
            </td>
            <td class="align-middle">\${item.uom || 'UNIT'}</td>
            <td>
                <input type="number" class="form-control form-control-sm text-right" value="\${parseFloat(item.qty || 0).toFixed(6)}" disabled />
            </td>
            <td class="table-warning">
                <input type="number" name="actualQuantity" class="form-control form-control-sm text-right border-warning input-actual-qty" value="\${parseFloat(actualQty).toFixed(6)}" \${isUpdated ? 'disabled' : ''} />
            </td>
            <td>
                <input type="text" class="form-control form-control-sm" value="\${item.batchId || ''}" disabled />
            </td>
            <td>
                <input type="date" class="form-control form-control-sm" value="\${item.expiryDate ? item.expiryDate.substring(0,10) : ''}" disabled />
            </td>
        `;
                    tbody.appendChild(tr);
                });
            }

            async function saveDocument() {
                var urlParams = new URLSearchParams(window.location.search);
                var id = urlParams.get('id');
                if (!id) return;

                var btn = document.getElementById('btnSave');
                var originalBtnText = btn.innerHTML;
                btn.disabled = true;
                btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Saving...';

                try {
                    var promises = [];
                    var rows = document.querySelectorAll('#itemsTableBody tr');
                    rows.forEach(tr => {
                        var inputItemId = tr.querySelector('input[name="itemId"]');
                        var inputActualQty = tr.querySelector('input[name="actualQuantity"]');
                        if (inputItemId && inputActualQty) {
                            var detailId = inputItemId.value;
                            var actualQty = parseFloat(inputActualQty.value) || 0;
                            promises.push(ConsignmentService.updateCSRNCActualQty(id, detailId, actualQty));
                        }
                    });

                    if (promises.length > 0) {
                        await Promise.all(promises);
                        AppUtils.showToast('Actual quantity saved successfully!', 'success');
                    } else {
                        AppUtils.showToast('No items to save.', 'warning');
                    }
                } catch (e) {
                    console.error('Error saving actual quantity:', e);
                    AppUtils.showToast("Failed to save actual quantity.", 'danger');
                } finally {
                    btn.disabled = false;
                    btn.innerHTML = originalBtnText;
                }
            }

            async function updateDocument() {
                if (confirm('Confirm update status to "Updated"? This will post the return to inventory.')) {
                    var urlParams = new URLSearchParams(window.location.search);
                    var id = urlParams.get('id');

                    var btn = document.getElementById('btnUpdate');
                    var originalBtnText = btn.innerHTML;
                    btn.disabled = true;
                    btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Updating...';

                    try {
                        if (id) {
                            await ConsignmentService.completeCSRNC(id);
                        }
                        AppUtils.showToast('Document updated and posted to inventory!', 'success');
                        setTimeout(() => { window.location.reload(); }, 1500);
                    } catch (e) {
                        console.error('Error updating status:', e);
                        AppUtils.showToast('Failed to update document status.', 'danger');
                    } finally {
                        btn.disabled = false;
                        btn.innerHTML = originalBtnText;
                    }
                }
            }

            function printSlip() {
                AppUtils.showToast('Printing slip...', 'info');
            }
        </script>

    </body>

    </html>