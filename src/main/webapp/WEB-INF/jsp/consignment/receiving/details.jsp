<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consignment Stock Receiving Details</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
<div class="main-content">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="pageTitle" value="Consignment Stock Receiving"/>
    </jsp:include>

    <div class="container-fluid mt-3">
        <!-- Breadcrumb & Top Actions -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                    <li class="breadcrumb-item">Consignment</li>
                    <li class="breadcrumb-item">Transaction</li>
                    <li class="breadcrumb-item"><a href="/consignment/receiving">Consignment Stock Receiving</a></li>
                    <li class="breadcrumb-item active" aria-current="page" id="breadcrumbDocNumber">New Document</li>
                </ol>
            </nav>
            <div id="topActions" style="display: none;">
               <button class="btn btn-sm btn-outline-secondary mr-2" onclick="printSlip()"><i class="fas fa-print mr-1"></i> Print Slip</button>
               <button class="btn btn-sm btn-success mr-2" id="btnRelease" onclick="releaseDocument()"><i class="fas fa-check-circle mr-1"></i> Release</button>
               <span id="headerStatusBadge" class="badge badge-warning" style="font-size: 0.9rem;">HELD</span>
            </div>
        </div>

        <!-- STAGE 1: HEADER FORM -->
        <div class="card shadow-sm" id="step1-header">
            <div class="card-header bg-white font-weight-bold d-flex justify-content-between align-items-center">
                <span><i class="fas fa-info-circle mr-2"></i> Header</span>
            </div>
            <div class="card-body">
                <form id="headerForm">
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Company <span class="text-danger">*</span></label>
                            <select class="form-control" name="company" required id="hCompany"></select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Receiving Store <span class="text-danger">*</span></label>
                            <select class="form-control" name="receivingStore" required id="hStore"></select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Document Number</label>
                            <input type="text" class="form-control bg-light" name="docNo" id="hDocNo" placeholder="Auto-generated" readonly>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Created Date</label>
                            <input type="datetime-local" class="form-control bg-light" name="createdDate" id="hCreatedDate" readonly>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Document Type</label>
                            <input type="text" class="form-control bg-light" value="Consignment Stock Receiving" readonly>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Supplier Code <span class="text-danger">*</span></label>
                            <select class="form-control" name="supplierCode" id="hSupplierCode" required></select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Supplier Contract <span class="text-danger">*</span></label>
                            <select class="form-control" name="supplierContract" id="hSupplierContract" required></select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Supplier DO Number <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="supplierDoNo" id="hSupplierDO" required placeholder="Enter supplier DO number">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Delivery Date</label>
                            <input type="date" class="form-control" name="deliveryDate" id="hDeliveryDate">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Created Method</label>
                            <select class="form-control" name="createdMethod" id="hCreatedMethod">
                                <option value="MANUAL">Manual</option>
                                <option value="AUTO">Auto (ACMM Integration)</option>
                            </select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Created By</label>
                            <input type="text" class="form-control" name="createdBy" id="hCreatedBy" value="user01">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Remark</label>
                            <textarea class="form-control" rows="2" name="remark" id="hRemark" maxlength="150" placeholder="Maximum 150 characters"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="card-footer bg-light d-flex justify-content-end">
                <button type="button" class="btn btn-outline-secondary mr-2" onclick="window.history.back()">Cancel</button>
                <button type="button" class="btn btn-light mr-2" onclick="resetHeaderForm()">Reset</button>
                <button type="button" class="btn btn-primary px-4" onclick="proceedToDetails()">Next</button>
            </div>
        </div>

        <!-- STAGE 2: ITEM DETAILS -->
        <div class="card shadow-sm" id="step2-items" style="display: none;">
            <div class="card-body bg-light border-bottom">
                <div class="row text-center text-md-left">
                    <div class="col-md-3 mb-2 mb-md-0">
                        <small class="text-muted d-block">Document Number</small>
                        <strong id="dispDocNo">-</strong>
                    </div>
                    <div class="col-md-3 mb-2 mb-md-0">
                        <small class="text-muted d-block">Receiving Store</small>
                        <strong id="dispStore">-</strong>
                    </div>
                    <div class="col-md-3 mb-2 mb-md-0">
                        <small class="text-muted d-block">Supplier</small>
                        <strong id="dispSupplier">-</strong>
                    </div>
                    <div class="col-md-3">
                        <small class="text-muted d-block">Supplier Contract</small>
                        <strong id="dispContract">-</strong>
                    </div>
                </div>
            </div>
            
            <div class="card-body p-0 table-responsive">
                <table class="table table-bordered mb-0 text-sm">
                    <thead class="bg-white">
                        <tr>
                            <th colspan="4" class="border-right-0 border-left-0"></th>
                            <th class="text-center bg-light border-bottom-0">Consignment Stock Request</th>
                            <th class="text-center bg-light border-bottom-0">Consignment Stock Receiving</th>
                        </tr>
                        <tr>
                            <th width="40" class="text-center">No.</th>
                            <th>Item Code</th>
                            <th class="text-right">Quantity Available</th>
                            <th class="text-center">UOM</th>
                            <th class="text-right bg-light w-15">Request Quantity</th>
                            <th class="text-center bg-light w-20">Received Quantity</th>
                        </tr>
                    </thead>
                    <tbody id="itemTableBody">
                        <!-- JS Render -->
                    </tbody>
                </table>
            </div>

            <!-- Add Item Row -->
            <div class="card-body bg-light border-top" id="addItemSection">
                <div class="row align-items-end">
                    <div class="col-md-3 mb-2">
                        <label class="small text-muted mb-1">Item Code <span class="text-danger">*</span></label>
                        <select class="form-control form-control-sm" id="newItemCode">
                            <option value="">-- Select Item --</option>
                        </select>
                    </div>
                    <div class="col-md-2 mb-2">
                        <label class="small text-muted mb-1">Request Qty</label>
                        <input type="number" class="form-control form-control-sm text-right" id="newRequestQty" value="0" step="0.0001">
                    </div>
                    <div class="col-md-2 mb-2">
                        <label class="small text-muted mb-1">Receiving Qty <span class="text-danger">*</span></label>
                        <input type="number" class="form-control form-control-sm text-right" id="newReceivingQty" value="0" step="0.0001">
                    </div>
                    <div class="col-md-2 mb-2">
                        <button type="button" class="btn btn-sm btn-outline-primary btn-block" onclick="addItemRow()"><i class="fas fa-plus mr-1"></i> Add Item</button>
                    </div>
                    <div class="col-md-3 mb-2">
                        <button type="button" class="btn btn-sm btn-outline-secondary btn-block" onclick="goBackToHeader()"><i class="fas fa-arrow-left mr-1"></i> Back to Header</button>
                    </div>
                </div>
            </div>
            
            <div class="card-footer bg-light d-flex justify-content-end" id="actionFooter">
                <button type="button" class="btn btn-outline-secondary mr-2" onclick="window.history.back()">Cancel</button>
                <button type="button" class="btn btn-primary px-4" id="btnSave" onclick="saveDocument()"><i class="fas fa-save mr-1"></i> <span id="btnSaveText">Create</span></button>
            </div>
        </div>

    </div>
</div>

<!-- Modal Batch -->
<div class="modal fade" id="batchModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="batchModalTitle">Batch Details</h6>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body p-0">
                <table class="table table-sm table-bordered mb-0" id="batchTable">
                    <thead class="bg-light">
                        <tr>
                            <th>Batch No.</th>
                            <th>Expiry Date</th>
                            <th width="120" class="text-right">Quantity</th>
                            <th width="60" class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- JS -->
                    </tbody>
                </table>
                <div class="p-2 bg-light border-top d-flex justify-content-between align-items-center mb-0">
                   <button class="btn btn-sm btn-outline-primary" onclick="addBatchRow()"><i class="fas fa-plus"></i> Add Batch</button>
                   <div class="font-weight-bold">
                       Total: <span id="batchTotalQty">0.000</span>
                   </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light btn-sm" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary btn-sm" onclick="saveBatchInfo()">Confirm</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />

<script src="/static/js/consignment-master-data.js?v=2"></script>
<script src="/static/js/services/consignment-service.js?v=2"></script>

<script>
var docId = new URLSearchParams(window.location.search).get('id');
var currentStatus = '';
var documentData = null;

var currentItems = [];
var availableItems = [];
var currentReceivedBatchInfo = [];
var activeItemRowIndex = -1;

document.addEventListener('configLoaded', function() {
    var now = new Date();
    now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
    document.getElementById('hCreatedDate').value = now.toISOString().slice(0,16);

    if (docId) {
        // For existing documents: only bind events, skip init() to avoid race condition.
        // loadDocument() will populate dropdowns and call triggerCascade() -> setValues().
        ConsignmentMasterData.bindEvents();
        loadDocument(docId);
    } else {
        ConsignmentMasterData.init();
    }
});

function resetHeaderForm() {
    $('#headerForm')[0].reset();
    var now = new Date();
    now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
    document.getElementById('hCreatedDate').value = now.toISOString().slice(0,16);
}

async function proceedToDetails() {
    if (!$('#headerForm')[0].checkValidity()) {
        $('#headerForm')[0].reportValidity();
        return;
    }
    
    // If editing existing document, keep existing items
    if (!docId) {
        currentItems = [];
    }
    
    // Display summary info
    $('#dispDocNo').text($('#hDocNo').val() || 'Will be generated upon save');
    $('#dispStore').text($('#hStore option:selected').text());
    $('#dispSupplier').text($('#hSupplierCode').val() || '-');
    $('#dispContract').text($('#hSupplierContract').val() || '-');
    
    // Fetch available items from master-data API
    await loadAvailableItems();

    $('#step1-header').hide();
    $('#step2-items').show();
    
    renderItems();
}

async function loadAvailableItems() {
    var company = $('#hCompany').val();
    var store = $('#hStore').val();
    var supplierCode = $('#hSupplierCode').val();
    var supplierContract = $('#hSupplierContract').val();

    if(!company || !store || !supplierCode || !supplierContract) return;

    try {
        AppUtils.showLoading();
        var url = '/master-data/items?company=' + encodeURIComponent(company) +
                  '&store=' + encodeURIComponent(store) +
                  '&supplierCode=' + encodeURIComponent(supplierCode) +
                  '&supplierContract=' + encodeURIComponent(supplierContract);
        var res = await ApiClient.get('CONSIGNMENT', url);
        var data = res.data || res;
        availableItems = Array.isArray(data) ? data : [];
        console.log('Loaded available items:', availableItems);

        // Populate the item code dropdown
        refreshItemCodeDropdown();
    } catch(e) {
        console.error('Failed to load available items:', e);
        AppUtils.showToast('Failed to load items for this supplier/contract', 'warning');
    } finally {
        AppUtils.hideLoading();
    }
}

function refreshItemCodeDropdown() {
    var $select = $('#newItemCode');
    $select.empty().append('<option value="">-- Select Item --</option>');
    availableItems.forEach(function(item) {
        $select.append('<option value="' + item + '">' + item + '</option>');
    });
}

function goBackToHeader() {
    $('#step2-items').hide();
    $('#step1-header').show();
}

function addItemRow() {
    var itemCode = $('#newItemCode').val().trim();
    var requestQty = parseFloat($('#newRequestQty').val()) || 0;
    var receivingQty = parseFloat($('#newReceivingQty').val()) || 0;

    if (!itemCode) {
        AppUtils.showToast('Item code is required', 'warning');
        return;
    }
    if (receivingQty <= 0) {
        AppUtils.showToast('Receiving quantity must be greater than 0', 'warning');
        return;
    }

    // Check duplicate
    var exists = currentItems.find(function(item) { return item.itemCode === itemCode; });
    if (exists) {
        AppUtils.showToast('Item code already exists in the list', 'warning');
        return;
    }

    currentItems.push({
        itemCode: itemCode,
        availableQty: 0,
        requestQty: requestQty,
        receivingQty: receivingQty,
        batches: []
    });

    $('#newItemCode').val('');
    $('#newRequestQty').val('0');
    $('#newReceivingQty').val('0');

    renderItems();
    AppUtils.showToast('Item added successfully', 'success');
}

function removeItemRow(index) {
    if (currentStatus === 'RELEASED') {
        AppUtils.showToast("Cannot remove items from RELEASED document.", "warning");
        return;
    }
    currentItems.splice(index, 1);
    renderItems();
}

function renderItems() {
    var tbody = $('#itemTableBody');
    tbody.empty();
    
    if (currentItems.length === 0) {
        tbody.html('<tr><td colspan="6" class="text-center py-3 text-muted">No items added. Use the form below to add items.</td></tr>');
        return;
    }
    
    currentItems.forEach(function(item, index) {
        var isReleased = currentStatus === 'RELEASED';
        var inputDisabled = isReleased ? 'disabled' : '';
        var linkState = isReleased ? 'text-muted' : 'text-primary';
        var removeBtn = isReleased ? '' : '<button class="btn btn-sm btn-outline-danger py-0 px-1" onclick="removeItemRow(' + index + ')" title="Remove"><i class="fas fa-trash-alt"></i></button>';
        
        var row = '<tr>' +
            '<td class="text-center">' + (index + 1) + '</td>' +
            '<td>' +
                '<div class="font-weight-bold">' + item.itemCode + '</div>' +
            '</td>' +
            '<td class="text-right">' + (item.availableQty || 0).toFixed(4) + '</td>' +
            '<td class="text-center">UNIT</td>' +
            '<td class="text-right bg-light font-weight-bold">' + (item.requestQty || 0).toFixed(4) + '</td>' +
            '<td class="text-center align-middle">' +
                '<div class="d-flex align-items-center justify-content-center">' +
                    '<input type="number" class="form-control form-control-sm text-right received-qty" ' +
                        'style="width:100px" value="' + (item.receivingQty || 0).toFixed(4) + '" ' + inputDisabled +
                        ' onchange="updateReceivingQty(' + index + ', this.value)">' +
                    removeBtn +
                '</div>' +
                '<div class="mt-1">' +
                    '<a href="javascript:void(0)" class="' + linkState + ' small font-weight-bold" onclick="openBatchModal(' + index + ')" style="text-decoration:none;">' +
                        '<i class="fas fa-edit"></i> Batch Details' +
                    '</a>' +
                '</div>' +
            '</td>' +
            '</tr>';
        tbody.append(row);
    });
}

function updateReceivingQty(index, val) {
    currentItems[index].receivingQty = parseFloat(val) || 0;
}

function openBatchModal(index) {
    if (currentStatus === 'RELEASED') {
        AppUtils.showToast("Cannot edit batch info for RELEASED document.", "warning");
        return;
    }
    
    activeItemRowIndex = index;
    var item = currentItems[index];
    currentReceivedBatchInfo = JSON.parse(JSON.stringify(item.batches || []));
    
    $('#batchModalTitle').text('Batch Details - ' + item.itemCode);
    renderBatchRows();
    $('#batchModal').modal('show');
}

function renderBatchRows() {
    var tbody = $('#batchTable tbody');
    tbody.empty();
    
    var total = 0;
    currentReceivedBatchInfo.forEach(function(b, i) {
        total += parseFloat(b.qty) || 0;
        var row = '<tr>' +
            '<td><input type="text" class="form-control form-control-sm border-0" value="' + (b.batchNo || '') + '" onchange="updateBatchField(' + i + ', \'batchNo\', this.value)"></td>' +
            '<td><input type="date" class="form-control form-control-sm border-0" value="' + (b.expiry || '') + '" onchange="updateBatchField(' + i + ', \'expiry\', this.value)"></td>' +
            '<td><input type="number" class="form-control form-control-sm border-0 text-right" value="' + (b.qty || 0) + '" onchange="updateBatchField(' + i + ', \'qty\', this.value); renderBatchRows();"></td>' +
            '<td class="text-center"><i class="fas fa-trash-alt text-danger" style="cursor:pointer" onclick="removeBatchRow(' + i + ')"></i></td>' +
            '</tr>';
        tbody.append(row);
    });
    $('#batchTotalQty').text(total.toFixed(3));
}

function updateBatchField(index, field, val) {
    currentReceivedBatchInfo[index][field] = val;
}

function addBatchRow() {
    currentReceivedBatchInfo.push({ batchNo: '', expiry: '', qty: 0 });
    renderBatchRows();
}

function removeBatchRow(index) {
    currentReceivedBatchInfo.splice(index, 1);
    renderBatchRows();
}

function saveBatchInfo() {
    var item = currentItems[activeItemRowIndex];
    item.batches = currentReceivedBatchInfo;
    var total = currentReceivedBatchInfo.reduce(function(sum, b) { return sum + (parseFloat(b.qty) || 0); }, 0);
    if (total > 0) {
        item.receivingQty = total;
        renderItems();
    }
    $('#batchModal').modal('hide');
}

async function loadDocument(id) {
    try {
        AppUtils.showToast('Loading document...', 'info');
        var response = await ConsignmentService.getCSRV(id);
        var data = response.data;
        
        if (!data) {
            AppUtils.showToast('Document not found', 'danger');
            return;
        }

        documentData = data;
        currentStatus = data.status || 'HELD';

        // Populate header form
        if(data.company) $('#hCompany').html(`<option value="\${data.company}">\${data.company}</option>`);
        if(data.receivingStore) $('#hStore').html(`<option value="\${data.receivingStore}">\${data.receivingStore}</option>`);
        if(data.supplierCode) $('#hSupplierCode').html(`<option value="\${data.supplierCode}">\${data.supplierCode}</option>`);
        if(data.supplierContract) $('#hSupplierContract').html(`<option value="\${data.supplierContract}">\${data.supplierContract}</option>`);
        setTimeout(() => { ConsignmentMasterData.triggerCascade(); }, 100);

        $('#hDocNo').val(data.docNo || '');
        $('#hSupplierDO').val(data.supplierDoNo || '');
        $('#hDeliveryDate').val(data.deliveryDate || '');
        $('#hRemark').val(data.remark || '');
        $('#hCreatedMethod').val(data.createdMethod || 'MANUAL');
        $('#hCreatedBy').val(data.createdBy || '');

        if (data.createdAt) {
            var d = new Date(data.createdAt);
            d.setMinutes(d.getMinutes() - d.getTimezoneOffset());
            $('#hCreatedDate').val(d.toISOString().slice(0, 16));
        }

        // Update breadcrumb
        $('#breadcrumbDocNumber').text('Update - ' + (data.docNo || 'Document'));

        // Update status badge
        $('#headerStatusBadge').text(currentStatus)
            .removeClass('badge-warning badge-success')
            .addClass(currentStatus === 'RELEASED' ? 'badge-success' : 'badge-warning');
        $('#topActions').show();

        // Populate items
        currentItems = (data.items || []).map(function(item) {
            return {
                id: item.id,
                itemCode: item.itemCode,
                availableQty: item.availableQty || 0,
                requestQty: item.requestQty || 0,
                receivingQty: item.receivingQty || 0,
                batches: []
            };
        });

        // Display summary info
        $('#dispDocNo').text(data.docNo || '-');
        $('#dispStore').text(data.receivingStore || '-');
        $('#dispSupplier').text(data.supplierCode || '-');
        $('#dispContract').text(data.supplierContract || '-');

        if (currentStatus === 'RELEASED') {
            // Read-only mode
            $('#headerForm :input').prop('disabled', true);
            $('#btnSave').hide();
            $('#btnRelease').hide();
            $('#addItemSection').hide();
        } else {
            $('#btnRelease').show();
            $('#btnSave').show();
            $('#btnSaveText').text('Update');
            $('#addItemSection').show();
        }

        // Load available items for dropdown
        await loadAvailableItems();

        // Jump to step 2
        $('#step1-header').hide();
        $('#step2-items').show();
        
        renderItems();
    } catch (error) {
        console.error('Error loading document:', error);
        AppUtils.showToast('Failed to load document', 'danger');
    }
}

function buildSavePayload() {
    return {
        company: $('#hCompany').val(),
        receivingStore: $('#hStore').val(),
        supplierCode: $('#hSupplierCode').val(),
        supplierContract: $('#hSupplierContract').val(),
        supplierDoNo: $('#hSupplierDO').val(),
        deliveryDate: $('#hDeliveryDate').val() || null,
        createdBy: $('#hCreatedBy').val() || 'user01',
        createdMethod: $('#hCreatedMethod').val() || 'MANUAL',
        remark: $('#hRemark').val() || null,
        items: currentItems.map(function(item) {
            return {
                itemCode: item.itemCode,
                availableQty: item.availableQty || 0,
                requestQty: item.requestQty || 0,
                receivingQty: item.receivingQty || 0
            };
        })
    };
}

async function saveDocument() {
    if (currentStatus === 'RELEASED') return;

    if (currentItems.length === 0) {
        AppUtils.showToast('Please add at least one item', 'warning');
        return;
    }

    var payload = buildSavePayload();
    var saveBtn = $('#btnSave');
    var isUpdate = !!docId;
    var btnText = isUpdate ? 'Update' : 'Create';
    var spinnerText = isUpdate ? 'Updating...' : 'Creating...';
    saveBtn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin mr-1"></i> ' + spinnerText);

    try {
        var response;
        if (isUpdate) {
            response = await ConsignmentService.updateCSRV(docId, payload);
        } else {
            response = await ConsignmentService.createCSRV(payload);
        }

        var savedData = response.data;
        AppUtils.showToast(isUpdate ? 'Document updated successfully.' : 'Document saved successfully with status HELD.', 'success');
        
        // Redirect to the saved document
        if (!isUpdate && savedData && savedData.id) {
            setTimeout(function() {
                window.location.href = '/consignment/receiving/details?id=' + savedData.id;
            }, 1000);
        } else {
            setTimeout(function() {
                window.location.href = '/consignment/receiving';
            }, 1500);
        }
    } catch (error) {
        console.error('Error saving document:', error);
        AppUtils.showToast('Failed to save document: ' + (error.message || 'Unknown error'), 'danger');
        saveBtn.prop('disabled', false).html('<i class="fas fa-save mr-1"></i> ' + btnText);
    }
}

async function releaseDocument() {
    if (!docId) {
        AppUtils.showToast('Please save the document first before releasing.', 'warning');
        return;
    }

    if (currentStatus === 'RELEASED') {
        AppUtils.showToast('Document is already released.', 'info');
        return;
    }

    if (!confirm('Release this document? System will post stock to supplier inventory.')) {
        return;
    }

    var releaseBtn = $('#btnRelease');
    releaseBtn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin mr-1"></i> Releasing...');

    try {
        var response = await ConsignmentService.releaseCSRV(docId);
        var data = response.data;

        AppUtils.showToast('Document successfully released and inventory posted.', 'success');
        
        // Reload document to reflect updated state
        currentStatus = 'RELEASED';
        loadDocument(docId);
    } catch (error) {
        console.error('Error releasing document:', error);
        AppUtils.showToast('Failed to release document: ' + (error.message || 'Unknown error'), 'danger');
        releaseBtn.prop('disabled', false).html('<i class="fas fa-check-circle mr-1"></i> Release');
    }
}

function printSlip() {
    var id = docId || '';
    if (!id) {
        AppUtils.showToast('No document to print', 'warning');
        return;
    }
    AppUtils.showLoading();
    ConsignmentService.printCSRVSlip(id).then(function() {
        AppUtils.showToast('PDF slip downloaded successfully', 'success');
    }).catch(function(err) {
        console.error('Print slip error:', err);
    }).finally(function() {
        AppUtils.hideLoading();
    });
}


</script>

<style>
.text-sm { font-size: 0.85rem; }
.w-15 { width: 15%; }
.w-20 { width: 20%; }
.received-qty { font-weight: bold; }

</style>

</body>
</html>
