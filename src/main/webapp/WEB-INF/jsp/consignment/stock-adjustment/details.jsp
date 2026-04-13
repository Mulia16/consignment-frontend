<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consignment Stock Adjustment Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
<div class="main-content">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="pageTitle" value="Consignment Stock Adjustment Details"/>
    </jsp:include>

    <div class="container-fluid mt-3">
        <!-- Breadcrumb -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                    <li class="breadcrumb-item">Consignment</li>
                    <li class="breadcrumb-item">Transaction</li>
                    <li class="breadcrumb-item"><a href="/consignment/stock-adjustment">Consignment Stock Adjustment</a></li>
                    <li class="breadcrumb-item active" aria-current="page" id="breadcrumbAction">Add New</li>
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
                    <button type="button" class="btn btn-success btn-sm ml-2 d-none" id="btnRelease" onclick="releaseDocument()">Release</button>
                </div>
            </div>
            <div class="card-body">
                <form id="detailsForm">
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Company <span class="text-danger">*</span></label>
                            <select class="form-control" name="company" id="company" required>
                                <option value="">Select Company</option>
                            </select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Store <span class="text-danger">*</span></label>
                            <select class="form-control" name="store" id="store" required>
                                <option value="">Select Store</option>
                            </select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Supplier Code <span class="text-danger">*</span></label>
                            <select class="form-control" name="supplierCode" id="supplierCode" required>
                                <option value="">Select Supplier</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Supplier Contract <span class="text-danger">*</span></label>
                            <select class="form-control" name="supplierContract" id="supplierContract" required>
                                <option value="">Select Contract</option>
                            </select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Transaction Type <span class="text-danger">*</span></label>
                            <select class="form-control" name="transactionType" id="transactionType" required onchange="handleTransactionTypeChange()">
                                <option value="">Select Type</option>
                                <option value="ADJ_IN">ADJ IN</option>
                                <option value="ADJ_OUT">ADJ OUT</option>
                            </select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Reason Code <span class="text-danger">*</span></label>
                            <select class="form-control" name="reasonCode" id="reasonCode" required>
                                <option value="">Select Reason</option>
                                <option value="RECOUNT">RECOUNT</option>
                                <option value="DAMAGE">DAMAGE</option>
                                <option value="LOSS">LOSS</option>
                                <option value="FOUND">FOUND</option>
                                <option value="CORRECTION">CORRECTION</option>
                                <option value="OTHER">OTHER</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Reference Number</label>
                            <input type="text" class="form-control" name="referenceNo" id="referenceNo">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Created Date</label>
                            <input type="text" class="form-control bg-light" name="createdAt" id="createdAt" readonly>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Created By</label>
                            <input type="text" class="form-control bg-light" name="createdBy" id="createdBy" readonly>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-8 mb-3">
                            <label class="small text-muted mb-1">Remarks</label>
                            <textarea class="form-control" name="remark" id="remark" rows="2" maxlength="150"></textarea>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Status</label>
                            <input type="text" class="form-control bg-light" name="status" id="status" value="NEW" readonly>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Items Table -->
        <div class="card shadow-sm mt-4 d-none" id="itemsCard">
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                <h6 class="m-0 font-weight-bold">Item Details</h6>
                <div>
                    <span class="mr-3 font-weight-bold text-primary">Total SKU: <span id="totalSkuCount">0</span></span>
                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="addItemRow()" id="btnAddRow"><i class="fas fa-plus"></i> Add Row</button>
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-bordered mb-0">
                        <thead class="bg-light">
                            <tr>
                                <th width="50">No.</th>
                                <th width="180">Item Code</th>
                                <th>Item Name</th>
                                <th width="120">Quantity</th>
                                <th width="100">UOM</th>
                                <th width="220">Settlement Decision</th>
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
<script src="/static/js/services/consignment-service.js"></script>
<script src="/static/js/consignment-master-data.js"></script>

<script>
var isReadOnly = false;
var docId = null;

document.addEventListener('configLoaded', function() {
    ConsignmentMasterData.init();

    var urlParams = new URLSearchParams(window.location.search);
    docId = urlParams.get('id');

    var today = new Date().toISOString().split('T')[0];
    document.getElementById('createdAt').value = today;
    if (window.Auth && window.Auth.getUser()) {
        document.getElementById('createdBy').value = window.Auth.getUser().username || 'OPR';
    } else {
        document.getElementById('createdBy').value = 'OPR';
    }

    if (docId) {
        document.getElementById('breadcrumbAction').textContent = 'Adjustment No: ' + docId;
        document.getElementById('headerTitle').textContent = 'Document Details';
        document.getElementById('btnNext').classList.add('d-none');
        document.getElementById('btnSave').classList.remove('d-none');
        document.getElementById('btnRelease').classList.remove('d-none');

        loadDocumentDetails(docId);
    } else {
        document.getElementById('breadcrumbAction').textContent = 'Add New';
        document.getElementById('headerTitle').textContent = 'Add New - Header';
        addEmptyRow();
    }
});

function handleTransactionTypeChange() {
    var type = document.getElementById('transactionType').value;
    updateSettlementOptions(type);
}

function updateSettlementOptions(transactionType) {
    var selects = document.querySelectorAll('.settlement-select');
    selects.forEach(function(select) {
        var currentValue = select.value;
        select.innerHTML = '<option value="">Select Settlement Decision</option>';
        if (transactionType === 'ADJ_IN') {
            select.innerHTML += '<option value="DIRECT_BV_INCREASE">Direct BV Increase</option>';
            select.innerHTML += '<option value="POST_TO_UNPOST_SALES_RETURN">Post to Unpost Sales Return</option>';
        } else if (transactionType === 'ADJ_OUT') {
            select.innerHTML += '<option value="DIRECT_BV_DECREASE">Direct BV Decrease</option>';
            select.innerHTML += '<option value="POST_TO_UNPOST_SALES">Post to Unpost Sales</option>';
        }
        if (currentValue) {
            select.value = currentValue;
        }
    });
}

function showItemDetails() {
    var form = document.getElementById('detailsForm');
    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }
    document.getElementById('itemsCard').classList.remove('d-none');
    document.getElementById('btnNext').classList.add('d-none');
    document.getElementById('btnSave').classList.remove('d-none');
}

async function loadDocumentDetails(id) {
    try {
        AppUtils.showLoading();
        var res = await ConsignmentService.getCSA(id);
        var data = res.data || res;

        // Populate header - set values and trigger cascade for master data dropdowns
        var company = data.company || '';
        var store = data.store || '';
        var supplierCode = data.supplierCode || '';
        var supplierContract = data.supplierContract || '';

        // Use setValues to cascade-load all dropdowns properly
        ConsignmentMasterData.setValues({
            company: company,
            store: store,
            supplier: supplierCode,
            contract: supplierContract
        });

        document.getElementById('transactionType').value = data.transactionType || '';
        document.getElementById('reasonCode').value = data.reasonCode || '';
        document.getElementById('referenceNo').value = data.referenceNo || '';
        document.getElementById('remark').value = data.remark || '';
        document.getElementById('createdAt').value = data.createdAt ? new Date(data.createdAt).toISOString().split('T')[0] : '';
        document.getElementById('createdBy').value = data.createdBy || '';
        document.getElementById('status').value = data.status || 'HELD';

        var status = data.status ? data.status.toUpperCase() : 'HELD';

        if (status === 'RELEASED' || status === 'COMPLETED') {
            isReadOnly = true;
            document.querySelectorAll('#detailsForm input, #detailsForm select, #detailsForm textarea').forEach(function(el) { el.disabled = true; });
            document.getElementById('btnAddRow').classList.add('d-none');
            document.getElementById('thAction').classList.add('d-none');
            document.getElementById('btnSave').classList.add('d-none');
            document.getElementById('btnRelease').classList.add('d-none');
        } else {
            isReadOnly = false;
        }

        // Show items
        document.getElementById('itemsCard').classList.remove('d-none');
        document.getElementById('btnNext').classList.add('d-none');

        // Render items
        var tbody = document.getElementById('itemsTableBody');
        tbody.innerHTML = '';
        var items = data.items || [];

        items.forEach(function(item, index) {
            renderItemRow(item, index + 1);
        });
        updateTotalSku();
    } catch (e) {
        console.error(e);
        AppUtils.showToast('Failed to load document details', 'danger');
    } finally {
        AppUtils.hideLoading();
    }
}

function renderItemRow(item, rowIndex) {
    var tbody = document.getElementById('itemsTableBody');
    var tr = document.createElement('tr');
    tr.innerHTML = '\
        <td class="text-center align-middle sr-no">' + rowIndex + '</td>\
        <td>\
            <select class="form-control form-control-sm item-code-select" name="itemCode" ' + (isReadOnly ? 'disabled' : '') + '>\
                <option value="' + (item.itemCode || '') + '">' + (item.itemCode || 'Select Item') + '</option>\
            </select>\
        </td>\
        <td class="align-middle item-name-td">' + (item.itemName || '-') + '</td>\
        <td>\
            <input type="number" class="form-control form-control-sm text-right qty-input" name="quantity" value="' + (item.qty || 1) + '" step="0.01" ' + (isReadOnly ? 'disabled' : '') + ' onchange="updateTotalSku()" />\
        </td>\
        <td class="align-middle uom-td">' + (item.uom || 'PCS') + '</td>\
        <td>\
            <select class="form-control form-control-sm settlement-select" name="settlementDecision" ' + (isReadOnly ? 'disabled' : '') + '>\
                <option value="' + (item.settlementDecision || '') + '">' + (item.settlementDecision || 'Select Settlement Decision') + '</option>\
            </select>\
        </td>';

    if (!isReadOnly) {
        tr.innerHTML += '<td class="text-center align-middle"><button type="button" class="btn btn-sm text-danger" onclick="removeRow(this)"><i class="fas fa-trash"></i></button></td>';
    }

    tbody.appendChild(tr);

    // Populate settlement options based on transaction type
    var select = tr.querySelector('.settlement-select');
    var type = document.getElementById('transactionType').value;
    var currVal = item.settlementDecision || select.value;

    select.innerHTML = '<option value="">Select Settlement Decision</option>';
    if (type === 'ADJ_IN') {
        select.innerHTML += '<option value="DIRECT_BV_INCREASE">Direct BV Increase</option>';
        select.innerHTML += '<option value="POST_TO_UNPOST_SALES_RETURN">Post to Unpost Sales Return</option>';
    } else if (type === 'ADJ_OUT') {
        select.innerHTML += '<option value="DIRECT_BV_DECREASE">Direct BV Decrease</option>';
        select.innerHTML += '<option value="POST_TO_UNPOST_SALES">Post to Unpost Sales</option>';
    }

    if (currVal) {
        select.value = currVal;
    }

    // Bind item code change to load item details
    if (!isReadOnly) {
        bindItemSelect(tr);
    }
}

/**
 * Bind item code select to load item details from master data
 */
function bindItemSelect(tr) {
    var itemSelect = tr.querySelector('.item-code-select');
    if (!itemSelect) return;

    // Load available items based on current supplier/contract selection
    loadAvailableItems(itemSelect);

    itemSelect.addEventListener('change', function(e) {
        var itemCode = e.target.value;
        if (itemCode) {
            // Auto-populate item name and UOM from the selected option data
            var selectedOption = e.target.options[e.target.selectedIndex];
            var itemName = selectedOption.getAttribute('data-item-name') || itemCode;
            var uom = selectedOption.getAttribute('data-uom') || 'PCS';
            tr.querySelector('.item-name-td').textContent = itemName;
            tr.querySelector('.uom-td').textContent = uom;
        } else {
            tr.querySelector('.item-name-td').textContent = '-';
            tr.querySelector('.uom-td').textContent = 'PCS';
        }
    });
}

/**
 * Load available items into a select element based on current company/store/supplier/contract
 */
async function loadAvailableItems(selectElement) {
    var company = document.getElementById('company').value;
    var store = document.getElementById('store').value;
    var supplierCode = document.getElementById('supplierCode').value;
    var supplierContract = document.getElementById('supplierContract').value;

    if (!company || !store || !supplierCode || !supplierContract) return;

    try {
        var res = await ApiClient.get('CONSIGNMENT', '/master-data/items?company=' + encodeURIComponent(company) +
            '&store=' + encodeURIComponent(store) +
            '&supplierCode=' + encodeURIComponent(supplierCode) +
            '&supplierContract=' + encodeURIComponent(supplierContract));
        var items = res.data || res || [];
        var currentVal = selectElement.value;

        selectElement.innerHTML = '<option value="">Select Item</option>';
        items.forEach(function(item) {
            // Items may be strings (item codes) or objects
            var itemCode, itemName, uom;
            if (typeof item === 'string') {
                itemCode = item;
                itemName = item;
                uom = 'PCS';
            } else {
                itemCode = item.itemCode || item.code || '';
                itemName = item.itemName || item.name || itemCode;
                uom = item.uom || 'PCS';
            }
            var option = document.createElement('option');
            option.value = itemCode;
            option.textContent = itemCode + ' - ' + itemName;
            option.setAttribute('data-item-name', itemName);
            option.setAttribute('data-uom', uom);
            selectElement.appendChild(option);
        });

        if (currentVal) selectElement.value = currentVal;
    } catch (e) {
        console.error('Failed to load items:', e);
    }
}

function addEmptyRow() {
    var tbody = document.getElementById('itemsTableBody');
    var rowCount = tbody.rows.length + 1;
    renderItemRow({ qty: 1 }, rowCount);
    updateTotalSku();
}

function addItemRow() {
    addEmptyRow();
}

function removeRow(btn) {
    btn.closest('tr').remove();
    updateTotalSku();
    // Re-number
    document.querySelectorAll('.sr-no').forEach(function(td, idx) { td.textContent = idx + 1; });
}

function updateTotalSku() {
    document.getElementById('totalSkuCount').textContent = document.querySelectorAll('#itemsTableBody tr').length;
}

/**
 * Collect form data and submit to CSA API
 * POST /consignment/api/csa
 */
async function saveDocument() {
    var form = document.getElementById('detailsForm');
    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }

    var btn = document.getElementById('btnSave');
    var originalBtnText = btn.innerHTML;
    btn.disabled = true;
    btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Saving...';

    // Collect items from table
    var items = [];
    var rows = document.querySelectorAll('#itemsTableBody tr');

    rows.forEach(function(tr) {
        var itemCode = tr.querySelector('select[name="itemCode"]').value;
        var itemName = tr.querySelector('.item-name-td').textContent.trim();
        var quantity = parseFloat(tr.querySelector('input[name="quantity"]').value) || 0;
        var uom = tr.querySelector('.uom-td').textContent.trim();
        var settlementDecision = tr.querySelector('select[name="settlementDecision"]').value;

        if (itemCode && quantity > 0) {
            items.push({
                itemCode: itemCode,
                itemName: itemName !== '-' ? itemName : '',
                qty: quantity,
                uom: uom || 'PCS',
                settlementDecision: settlementDecision || undefined
            });
        }
    });

    if (items.length === 0) {
        AppUtils.showToast('Please add at least one item with quantity > 0', 'warning');
        btn.disabled = false;
        btn.innerHTML = originalBtnText;
        return;
    }

    // Build payload matching API format
    var payload = {
        company: document.getElementById('company').value,
        store: document.getElementById('store').value,
        supplierCode: document.getElementById('supplierCode').value,
        supplierContract: document.getElementById('supplierContract').value,
        transactionType: document.getElementById('transactionType').value,
        referenceNo: document.getElementById('referenceNo').value || null,
        reasonCode: document.getElementById('reasonCode').value,
        remark: document.getElementById('remark').value || null,
        createFrom: null,
        createdBy: document.getElementById('createdBy').value,
        items: items
    };

    try {
        var result = await ConsignmentService.createCSA(payload);
        var docNo = (result.data && result.data.docNo) ? result.data.docNo : 'Document';
        AppUtils.showToast('Document created successfully! Doc No: ' + docNo + ' - Status: HELD', 'success');
        setTimeout(function() { window.location.href = '/consignment/stock-adjustment'; }, 1500);
    } catch (e) {
        console.error('Error saving CSA:', e);
        AppUtils.showToast('Failed to save document: ' + (e.message || 'Unknown error'), 'danger');
        btn.disabled = false;
        btn.innerHTML = originalBtnText;
    }
}

async function releaseDocument() {
    if (!docId) {
        AppUtils.showToast('Cannot release a new document without saving. Please save first.', 'warning');
        return;
    }

    if (confirm("Are you sure you want to release this document?")) {
        AppUtils.showLoading();
        try {
            var username = (window.Auth && window.Auth.getUser()) ? Auth.getUser().username : 'OPR';
            await ConsignmentService.releaseCSA(docId, username);
            AppUtils.showToast('Document released successfully!', 'success');
            setTimeout(function() { window.location.reload(); }, 1000);
        } catch(e) {
            console.error('Error releasing document:', e);
            AppUtils.showToast('Failed to release document.', 'danger');
        } finally {
            AppUtils.hideLoading();
        }
    }
}

</script>

</body>
</html>
