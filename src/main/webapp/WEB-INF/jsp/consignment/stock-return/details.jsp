<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consignment Stock Return Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
<div class="main-content">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="pageTitle" value="Consignment Stock Return Details"/>
    </jsp:include>

    <div class="container-fluid mt-3">
        <!-- Breadcrumb -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                    <li class="breadcrumb-item">Consignment</li>
                    <li class="breadcrumb-item">Transaction</li>
                    <li class="breadcrumb-item"><a href="/consignment/stock-return">Consignment Stock Return</a></li>
                    <li class="breadcrumb-item active" aria-current="page" id="breadcrumbAction">Details</li>
                </ol>
            </nav>
        </div>

        <!-- Details Panel -->
        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                <h6 class="m-0 font-weight-bold" id="headerTitle">Add New - Header</h6>
                <div>
                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="window.history.back()">Cancel</button>
                    <button type="button" class="btn btn-primary btn-sm ml-2" id="btnNext" onclick="showItemDetails()">Next</button>
                    <button type="button" class="btn btn-primary btn-sm ml-2 d-none" id="btnSave" onclick="saveDocument()">Save</button>
                </div>
            </div>
            <div class="card-body">
                <form id="detailsForm">
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Company <span class="text-danger">*</span></label>
                            <select class="form-control" name="company" id="company" required>
                                <option value="">Select Company</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Store <span class="text-danger">*</span></label>
                            <select class="form-control" name="store" id="store" required>
                                <option value="">Select Store</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Supplier <span class="text-danger">*</span></label>
                            <select class="form-control" name="supplierCode" id="supplierCode" required>
                                <option value="">Select Supplier</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3 position-relative">
                            <label class="small text-muted mb-1">CSO Document No <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="csoDocNo" id="csoDocNo" required autocomplete="off" placeholder="Search CSO...">
                            <div id="csoSuggestions" class="list-group position-absolute w-100 shadow-sm" style="z-index: 1000; display: none; max-height: 200px; overflow-y: auto;"></div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Supplier Contract <span class="text-danger">*</span></label>
                            <select class="form-control" name="supplierContract" id="supplierContract" required>
                                <option value="">Select Contract</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Internal Supplier Store <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="internalSupplierStore" required>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Supplier Confirm Note</label>
                            <input type="text" class="form-control" name="supplierConfirmNote">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Reason <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="reason" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label class="small text-muted mb-1">Remark (Maximum 150 characters)</label>
                            <textarea class="form-control" name="remark" rows="2" maxlength="150"></textarea>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Items Table -->
        <div class="card shadow-sm mt-4 d-none" id="itemsCard">
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                <h6 class="m-0 font-weight-bold">Item Details</h6>
                <button type="button" class="btn btn-outline-primary btn-sm" onclick="addItemRow()" id="btnAddRow"><i class="fas fa-plus"></i> Add Row</button>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-bordered mb-0">
                        <thead class="bg-light">
                            <tr>
                                <th width="50">No.</th>
                                <th>Item Code</th>
                                <th>UOM</th>
                                <th width="120">Quantity</th>
                                <th id="thActualQuantity" class="d-none" width="120">Actual Quantity</th>
                                <th width="150">Batch ID</th>
                                <th width="150">Expiry Date</th>
                                <th width="60" id="thAction">Action</th>
                            </tr>
                        </thead>
                        <tbody id="itemsTableBody">
                            <!-- JS Render -->
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
var isReleased = false; // Mock status flag

document.addEventListener('configLoaded', function() {
    var urlParams = new URLSearchParams(window.location.search);
    var id = urlParams.get('id');

    setupCsoAutocomplete();

    if (id) {
        // For existing documents: only bind events, skip init() to avoid race condition.
        // loadDocumentData() will call setValues() which handles the full cascade.
        ConsignmentMasterData.bindEvents();
        document.getElementById('breadcrumbAction').textContent = 'Update';
        document.getElementById('headerTitle').textContent = 'Update - Header';
        document.getElementById('btnSave').textContent = 'Update';
        loadDocumentData(id);
    } else {
        ConsignmentMasterData.init();
        document.getElementById('breadcrumbAction').textContent = 'Create';
        document.getElementById('headerTitle').textContent = 'Create - Header';
        document.getElementById('btnSave').textContent = 'Create';
        addEmptyRow();
    }
});

function showItemDetails() {
    document.getElementById('itemsCard').classList.remove('d-none');
    document.getElementById('btnNext').classList.add('d-none');
    document.getElementById('btnSave').classList.remove('d-none');
}

async function loadDocumentData(id) {
    AppUtils.showLoading();
    try {
        var res = await ConsignmentService.getCSRN(id);
        var data = res.data || res;
        
        document.getElementById('breadcrumbAction').textContent = 'Update - ' + (data.docNo || id);
        document.getElementById('headerTitle').textContent = 'Update - ' + (data.docNo || id);
        
        isReleased = (data.status === 'RELEASED' || data.status === 'COMPLETED');
        
        if (isReleased) {
            document.getElementById('thActualQuantity').classList.remove('d-none');
            document.getElementById('btnAddRow').classList.add('d-none');
            document.getElementById('thAction').classList.add('d-none');
        }
        
        // Fill base form
        var form = document.getElementById('detailsForm');
        if (form.querySelector('input[name="csoDocNo"]')) form.querySelector('input[name="csoDocNo"]').value = data.csoDocNo || '';
        form.querySelector('input[name="internalSupplierStore"]').value = data.internalSupplierStore || '';
        form.querySelector('input[name="supplierConfirmNote"]').value = data.supplierConfirmNote || '';
        form.querySelector('input[name="reason"]').value = data.reasonCode || data.reason || '';
        form.querySelector('textarea[name="remark"]').value = data.remark || '';
        
        if (isReleased) {
            // Disable all form inputs
            var inputs = form.querySelectorAll('input, select, textarea');
            inputs.forEach(input => input.disabled = true);
        }
        
        ConsignmentMasterData.setValues({
            company: data.company,
            store: data.store,
            supplier: data.supplierCode,
            contract: data.supplierContract
        });
        
        // Populate items table
        var tbody = document.getElementById('itemsTableBody');
        tbody.innerHTML = '';
        if (data.items && data.items.length > 0) {
            data.items.forEach((item, index) => {
                var tr = document.createElement('tr');
                tr.innerHTML = `
                    <td class="text-center align-middle">\${index + 1}</td>
                    <td>
                        <select class="form-control form-control-sm item-code-dropdown" data-name="itemCode" data-selected="\${item.itemCode}" \${isReleased ? 'disabled' : ''}>
                            <option value="\${item.itemCode}" selected>\${item.itemCode}</option>
                        </select>
                    </td>
                    <td class="align-middle">
                        <input type="text" class="form-control form-control-sm text-center" name="uom" value="\${item.uom || 'UNIT'}" \${isReleased ? 'disabled' : ''} />
                    </td>
                    <td>
                        <input type="number" class="form-control form-control-sm text-right" name="quantity" value="\${item.qty || 0}" \${isReleased ? 'disabled' : ''} />
                    </td>
                `;
                if (isReleased) {
                    tr.innerHTML += `<td><input type="number" class="form-control form-control-sm text-right" name="actualQuantity" value="\${item.actualQty || 0}" /></td>`;
                }
                tr.innerHTML += `
                    <td>
                        <input type="text" class="form-control form-control-sm" name="batchId" placeholder="Batch ID" value="\${item.batchId || ''}" \${isReleased ? 'disabled' : ''} />
                    </td>
                    <td>
                        <input type="date" class="form-control form-control-sm" name="expiryDate" value="\${item.expiryDate ? item.expiryDate.substring(0, 10) : ''}" \${isReleased ? 'disabled' : ''} />
                    </td>
                `;
                if (!isReleased) {
                    tr.innerHTML += `<td class="text-center align-middle"><button type="button" class="btn btn-sm text-danger" onclick="this.closest('tr').remove()"><i class="fas fa-trash"></i></button></td>`;
                }
                tbody.appendChild(tr);
            });
        }
        
        showItemDetails();
        
        // Load available items so the dropdowns have full options instead of only the selected one
        setTimeout(loadAvailableItems, 500);
    } catch(e) {
        console.error('Failed to load document data:', e);
        AppUtils.showToast('Failed to load document data.', 'danger');
    } finally {
        AppUtils.hideLoading();
    }
}

function addEmptyRow() {
    var tbody = document.getElementById('itemsTableBody');
    var rowCount = tbody.rows.length + 1;
    
    var tr = document.createElement('tr');
    tr.innerHTML = `
        <td class="text-center align-middle">\${rowCount}</td>
        <td>
            <select class="form-control form-control-sm item-code-dropdown" data-name="itemCode">
                <option value="">Select Item</option>
            </select>
        </td>
        <td class="align-middle">
            <input type="text" class="form-control form-control-sm text-center" name="uom" value="UNIT" />
        </td>
        <td>
            <input type="number" class="form-control form-control-sm text-right" name="quantity" value="0.000000" />
        </td>
    `;
    if (isReleased) {
        tr.innerHTML += `<td class="d-none"><input type="number" class="form-control form-control-sm text-right" name="actualQuantity" value="0.000000" /></td>`;
    }
    tr.innerHTML += `
        <td>
            <input type="text" class="form-control form-control-sm" name="batchId" placeholder="Batch ID" />
        </td>
        <td>
            <input type="date" class="form-control form-control-sm" name="expiryDate" />
        </td>
        <td class="text-center align-middle">
            <button type="button" class="btn btn-sm text-danger" onclick="this.closest('tr').remove()"><i class="fas fa-trash"></i></button>
        </td>
    `;
    tbody.appendChild(tr);
}

function addItemRow() {
    addEmptyRow();
    refreshItemCodeDropdowns();
}

var availableItems = [];

async function loadAvailableItems() {
    let company = $('#company').val();
    let store = $('#store').val();
    let supplierCode = $('#supplierCode').val();
    let supplierContract = $('#supplierContract').val();

    if(!company || !store || !supplierCode || !supplierContract) return;

    try {
        let url = '/master-data/items?company=' + encodeURIComponent(company) +
                  '&store=' + encodeURIComponent(store) +
                  '&supplierCode=' + encodeURIComponent(supplierCode) +
                  '&supplierContract=' + encodeURIComponent(supplierContract);
        let res = await ApiClient.get('CONSIGNMENT', url);
        let data = res.data || res;
        availableItems = Array.isArray(data) ? data : [];
        refreshItemCodeDropdowns();
    } catch(e) {
        console.error('Failed to load available items:', e);
    }
}

function refreshItemCodeDropdowns() {
    $('#itemsTableBody tr').each(function() {
        let $select = $(this).find('.item-code-dropdown');
        let currentVal = $select.attr('data-selected') || $select.val();
        let options = '<option value="">Select Item</option>';
        availableItems.forEach(function(item) {
            let selected = (item === currentVal) ? 'selected' : '';
            options += '<option value="' + item + '" ' + selected + '>' + item + '</option>';
        });
        $select.html(options);
        if (currentVal && availableItems.includes(currentVal)) {
            $select.val(currentVal);
        }
    });
}

// When master data changes, refresh our customized item list
$(document).on('change', '#company, #store, #supplierCode, #supplierContract', function() {
    loadAvailableItems();
});

function setupCsoAutocomplete() {
    var csoInput = document.getElementById('csoDocNo');
    var suggestionsBox = document.getElementById('csoSuggestions');
    var timeout = null;

    csoInput.addEventListener('input', function() {
        var keyword = this.value.trim();
        
        clearTimeout(timeout);
        suggestionsBox.innerHTML = '';
        suggestionsBox.style.display = 'none';

        if (keyword.length < 2) return;

        timeout = setTimeout(async function() {
            try {
                var res = await ConsignmentService.searchCSO({
                    page: 1,
                    perPage: 20,
                    docNo: keyword
                });

                var dataList = [];
                if (res.data && Array.isArray(res.data)) dataList = res.data;
                else if (res.data && res.data.content) dataList = res.data.content;
                else if (Array.isArray(res)) dataList = res;

                if (dataList.length > 0) {
                    suggestionsBox.innerHTML = '';
                    dataList.forEach(cso => {
                        var csoHtml = `<a href="#" class="list-group-item list-group-item-action py-2" data-docno="\${cso.docNo}">
                            <div class="font-weight-bold">\${cso.docNo}</div>
                            <small class="text-muted">\${cso.company} - \${cso.store}</small>
                        </a>`;
                        suggestionsBox.insertAdjacentHTML('beforeend', csoHtml);
                    });
                    suggestionsBox.style.display = 'block';

                    // Attach click handlers
                    suggestionsBox.querySelectorAll('a').forEach(a => {
                        a.addEventListener('click', function(e) {
                            e.preventDefault();
                            csoInput.value = this.getAttribute('data-docno');
                            suggestionsBox.style.display = 'none';
                        });
                    });
                } else {
                    suggestionsBox.innerHTML = '<div class="list-group-item text-muted py-2">No results found</div>';
                    suggestionsBox.style.display = 'block';
                }
            } catch(e) {
                console.error('CSO Autocomplete Error:', e);
            }
        }, 500);
    });

    // Close on click outside
    document.addEventListener('click', function(e) {
        if (!csoInput.contains(e.target) && !suggestionsBox.contains(e.target)) {
            suggestionsBox.style.display = 'none';
        }
    });
}

async function saveDocument() {
    var form = document.getElementById('detailsForm');
    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }

    var btn = document.getElementById('btnSave');
    var originalBtnText = btn.innerHTML;
    var urlParams = new URLSearchParams(window.location.search);
    var id = urlParams.get('id');
    var isUpdate = !!id;
    btn.disabled = true;
    btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> ' + (isUpdate ? 'Updating...' : 'Creating...');

    var formData = new FormData(form);
    
    var items = [];
    var rows = document.querySelectorAll('#itemsTableBody tr');
    
    rows.forEach(function(tr) {
        var itemCodeSelect = tr.querySelector('.item-code-dropdown');
        var itemCode = itemCodeSelect ? itemCodeSelect.value : null;
        var uom = tr.querySelector('input[name="uom"]') ? tr.querySelector('input[name="uom"]').value : "UNIT";
        var quantity = tr.querySelector('input[name="quantity"]') ? parseFloat(tr.querySelector('input[name="quantity"]').value) : 0;
        var batchId = tr.querySelector('input[name="batchId"]') ? tr.querySelector('input[name="batchId"]').value : '';
        var expiryDate = tr.querySelector('input[name="expiryDate"]') ? tr.querySelector('input[name="expiryDate"]').value : null;
        
        if (itemCode && quantity > 0) {
            items.push({
                itemCode: itemCode,
                uom: uom,
                qty: quantity,
                batchId: batchId || undefined,
                expiryDate: expiryDate ? expiryDate + "T00:00:00Z" : undefined
            });
        }
    });

    if (items.length === 0) {
        AppUtils.showToast('Please add at least one item with quantity > 0', 'warning');
        btn.disabled = false;
        btn.innerHTML = originalBtnText;
        return;
    }

    var payload = {
        company: formData.get('company'),
        store: formData.get('store'),
        supplierCode: formData.get('supplierCode'),
        supplierContract: formData.get('supplierContract'),
        internalSupplierStore: formData.get('internalSupplierStore'),
        supplierConfirmNote: formData.get('supplierConfirmNote') || undefined,
        reason: formData.get('reason'),
        remark: formData.get('remark') || undefined,
        csoDocNo: formData.get('csoDocNo'),
        createdBy: "SYSTEM",
        items: items
    };

    try {
        if (isUpdate) {
            await ConsignmentService.updateCSRN(id, payload);
            AppUtils.showToast('Document updated successfully!', 'success');
            setTimeout(function() {
                window.location.href = '/consignment/stock-return';
            }, 1500);
        } else {
            await ConsignmentService.createCSRN(payload);
            AppUtils.showToast('Document created successfully!', 'success');
            setTimeout(function() {
                window.location.href = '/consignment/stock-return';
            }, 1500);
        }
    } catch (e) {
        console.error('Error saving CSRN:', e);
        AppUtils.showToast('Failed to save document. Please check the network log.', 'error');
        btn.disabled = false;
        btn.innerHTML = originalBtnText;
    }
}
</script>

</body>
</html>
