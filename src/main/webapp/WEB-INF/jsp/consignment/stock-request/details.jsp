<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consignment Stock Request Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <style>
        .required::after { content: " *"; color: red; }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
<div class="main-content">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="pageTitle" value="Consignment Stock Request - Details"/>
    </jsp:include>

    <div class="container-fluid mt-3">
        <!-- Breadcrumb & Top Actions -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                    <li class="breadcrumb-item">Consignment</li>
                    <li class="breadcrumb-item">Transaction</li>
                    <li class="breadcrumb-item"><a href="/consignment/stock-request">Consignment Stock Request</a></li>
                    <li class="breadcrumb-item active" aria-current="page" id="breadcrumbDocNo">New</li>
                </ol>
            </nav>
            <div>
                <button type="button" class="btn btn-sm btn-outline-secondary mr-2 d-none" id="btnPrintSlip" onclick="printSlip()"><i class="fas fa-print mr-1"></i> Print Slip</button>
                <span id="statusBadge" class="badge badge-secondary p-2 d-none" style="font-size: 14px;"></span>
            </div>
        </div>

        <form id="csrqForm" onsubmit="event.preventDefault(); return false;">
            <!-- Header Section -->
            <div class="card mb-4 shadow-sm">
                <div class="card-header bg-white font-weight-bold d-flex justify-content-between align-items-center" data-toggle="collapse" data-target="#headerCollapse" style="cursor: pointer;">
                    <span><i class="fas fa-file-alt mr-2"></i> Document Header</span>
                    <i class="fas fa-chevron-up"></i>
                </div>
                <div id="headerCollapse" class="collapse show">
                    <div class="card-body">
                        <div class="row">
                            <!-- Left Col -->
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label required">Company</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" name="company" id="company" required></select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label required">Supplier</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" name="supplierCode" id="supplierCode" required></select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label">Notes & Instruction</label>
                                    <div class="col-sm-8">
                                        <textarea class="form-control" name="notes" id="notes" rows="3" maxlength="200" placeholder="Maximum 200 characters"></textarea>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Right Col -->
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label required">Store</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" name="store" id="store" required></select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label required">Supplier Contract</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" name="supplierContract" id="supplierContract" required></select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label required">Branch</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" name="branch" id="branch" required placeholder="Mandatory">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label required">Internal Supplier Store</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" name="internalSupplierStore" id="internalSupplierStore" required placeholder="Mandatory">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Header Action Buttons -->
                        <div class="d-flex justify-content-end mt-3 header-actions">
                            <button type="button" class="btn btn-outline-secondary mr-2" onclick="resetHeader()">Reset</button>
                            <button type="button" class="btn btn-outline-secondary mr-2" onclick="window.location.href='/consignment/stock-request'">Cancel</button>
                            <button type="button" class="btn btn-primary" onclick="goToItems()">Next</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Item Details Section -->
            <div class="card shadow-sm" id="itemsCard" style="display: none;">
                <div class="card-header bg-white font-weight-bold d-flex justify-content-between align-items-center">
                    <span><i class="fas fa-list mr-2"></i> Item Details</span>
                    <button type="button" class="btn btn-sm btn-link" onclick="toggleHeader()">Show Header <i class="fas fa-chevron-down"></i></button>
                </div>
                <div class="card-body p-0">
                    <div class="p-3 bg-light border-bottom">
                        <button type="button" class="btn btn-outline-primary btn-sm" onclick="addItemRow()"><i class="fas fa-plus"></i> Add Row</button>
                    </div>
                    
                    <div class="table-responsive" style="overflow: visible;">
                        <table class="table table-hover mb-0" id="itemsTable">
                            <thead class="bg-light">
                                <tr>
                                    <th width="60">No.</th>
                                    <th>Item Code</th>
                                    <th width="200">Request Quantity</th>
                                    <th width="150">Request UOM</th>
                                    <th width="80">Action</th>
                                </tr>
                            </thead>
                            <tbody id="itemsBody">
                                <!-- JS items render here -->
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="d-flex justify-content-end p-3 border-top bg-light form-actions">
                        <button type="button" class="btn btn-outline-secondary mr-2" onclick="resetForm()">Reset</button>
                        <button type="button" class="btn btn-outline-secondary mr-2" onclick="window.location.href='/consignment/stock-request'">Cancel</button>
                        <button type="button" class="btn btn-primary mr-2" onclick="saveDocument('HELD')" id="btnSave">Create</button>
                        <button type="button" class="btn btn-success" onclick="saveDocument('RELEASED')" id="btnSaveRelease">Create & Release</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    </div>


</div>

<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
<script src="/static/js/consignment-master-data.js?v=2"></script>
<script src="/static/js/services/consignment-service.js?v=2"></script>

<script>
let itemIdCounter = 1;
let documentId = new URLSearchParams(window.location.search).get('id');
let currentStatus = 'NEW';
let itemsData = [];
let availableItems = [];

document.addEventListener('configLoaded', function() {
    $('#nav-consignment-stock-request').addClass('active');
    $('#menu-outbound').addClass('active');
    
    if (documentId) {
        // For existing documents: only bind events, skip init() to avoid race condition.
        // loadDocumentDetails() will populate dropdowns and call triggerCascade() -> setValues().
        ConsignmentMasterData.bindEvents();
        loadDocumentDetails(documentId);
    } else {
        ConsignmentMasterData.init();
        addItemRow(); // Default one empty row
    }
});

function resetHeader() {
    $('#company').val('');
    $('#supplierCode').val('');
    $('#notes').val('');
    $('#store').val('');
    $('#supplierContract').val('');
    $('#branch').val('');
    $('#internalSupplierStore').val('');
}

function resetForm() {
    resetHeader();
    $('#itemsBody').empty();
    itemIdCounter = 1;
    addItemRow();
}

async function goToItems() {
    // Validate required header fields
    let isValid = true;
    const requiredFields = ['company', 'store', 'supplierCode', 'supplierContract', 'branch', 'internalSupplierStore'];
    requiredFields.forEach(f => {
        if(!$('#' + f).val()) {
            isValid = false;
            $('#' + f).addClass('is-invalid');
        } else {
            $('#' + f).removeClass('is-invalid');
        }
    });

    if(!isValid) {
        AppUtils.showToast('Please fill all mandatory fields', 'warning');
        return;
    }

    // Fetch available items from master-data API using header values
    await loadAvailableItems();

    $("#headerCollapse").collapse('hide');
    $(".header-actions").hide();
    $("#itemsCard").show();
}

async function loadAvailableItems() {
    let company = $('#company').val();
    let store = $('#store').val();
    let supplierCode = $('#supplierCode').val();
    let supplierContract = $('#supplierContract').val();

    if(!company || !store || !supplierCode || !supplierContract) return;

    try {
        AppUtils.showLoading();
        let url = '/master-data/items?company=' + encodeURIComponent(company) +
                  '&store=' + encodeURIComponent(store) +
                  '&supplierCode=' + encodeURIComponent(supplierCode) +
                  '&supplierContract=' + encodeURIComponent(supplierContract);
        let res = await ApiClient.get('CONSIGNMENT', url);
        let data = res.data || res;
        availableItems = Array.isArray(data) ? data : [];
        console.log('Loaded available items:', availableItems);

        // Refresh all existing item-code dropdowns with new options
        refreshItemCodeDropdowns();
    } catch(e) {
        console.error('Failed to load available items:', e);
        AppUtils.showToast('Failed to load items for this supplier/contract', 'warning');
    } finally {
        AppUtils.hideLoading();
    }
}

function refreshItemCodeDropdowns() {
    // Update all existing item-code <select> elements with availableItems
    $('#itemsBody tr').each(function() {
        let $select = $(this).find('.item-code');
        let currentVal = $select.val();
        let options = '<option value="">-- Select Item --</option>';
        availableItems.forEach(function(item) {
            let selected = (item === currentVal) ? 'selected' : '';
            options += '<option value="' + item + '" ' + selected + '>' + item + '</option>';
        });
        $select.html(options);
    });
}

function toggleHeader() {
    $("#headerCollapse").collapse('toggle');
}

$('#headerCollapse').on('hidden.bs.collapse', function () {
    $(".header-actions").hide();
})
$('#headerCollapse').on('shown.bs.collapse', function () {
    $(".header-actions").show();
})

function addItemRow(data = {}) {
    let rowId = itemIdCounter++;
    let itemCode = data.itemCode || '';
    let requestQty = data.requestQty || 1;
    let requestUom = data.requestUom || 'UNIT';
    
    // Check if readonly mode
    let isReadOnly = (currentStatus === 'RELEASED');
    let attrRead = isReadOnly ? 'readonly' : '';
    let attrDisabled = isReadOnly ? 'disabled' : '';
    
    let actionBtn = isReadOnly ? '' : `<button type="button" class="btn btn-sm text-danger" onclick="$(this).closest('tr').remove()"><i class="fas fa-trash"></i></button>`;

    // Build item code options from availableItems
    let options = '<option value="">-- Select Item --</option>';
    if(availableItems && availableItems.length > 0) {
        availableItems.forEach(function(item) {
            let selected = (item === itemCode) ? 'selected' : '';
            options += `<option value="\${item}" \${selected}>\${item}</option>`;
        });
    } else if(itemCode) {
        // Fallback for edit mode before items are loaded
        options += `<option value="\${itemCode}" selected>\${itemCode}</option>`;
    }

    let tr = `<tr data-id="\${rowId}">
        <td class="align-middle">\${rowId}</td>
        <td>
            <select class="form-control item-code" required \${attrDisabled}>\${options}</select>
        </td>
        <td><input type="number" class="form-control item-qty" value="\${requestQty}" min="1" step="0.0001" required \${attrRead}></td>
        <td><input type="text" class="form-control item-uom" value="\${requestUom}" required \${attrRead}></td>
        <td class="align-middle text-center">\${actionBtn}</td>
    </tr>`;
    $('#itemsBody').append(tr);
}


async function loadDocumentDetails(id) {
    AppUtils.showLoading();
    try {
        const res = await ApiClient.get('CONSIGNMENT', `/csrq/\${id}`);
        const data = res.data || res; // Handle standard API wrapper
        populateForm(data);
    } catch(e) {
        console.error(e);
        // Fallback or handle via ApiClient
        window.location.href='/consignment/stock-request';
    } finally {
        AppUtils.hideLoading();
    }
}

async function populateForm(data) {
    if(data.company) $('#company').html(`<option value="\${data.company}">\${data.company}</option>`);
    if(data.store) $('#store').html(`<option value="\${data.store}">\${data.store}</option>`);
    if(data.supplierCode) $('#supplierCode').html(`<option value="\${data.supplierCode}">\${data.supplierCode}</option>`);
    if(data.supplierContract) $('#supplierContract').html(`<option value="\${data.supplierContract}">\${data.supplierContract}</option>`);
    // Once values are set, trigger cascade to load remaining sibling options correctly
    setTimeout(() => { ConsignmentMasterData.triggerCascade(); }, 100);

    $('#branch').val(data.branch || '');
    $('#internalSupplierStore').val(data.internalSupplierStore || '');
    $('#notes').val(data.notes || '');

    $('#breadcrumbDocNo').text('Update - ' + (data.docNo || data.id));
    currentStatus = data.status || 'NEW';
    
    // Status Badge
    let badgeClass = 'badge-secondary';
    if(currentStatus === 'HELD') badgeClass = 'badge-warning';
    else if(currentStatus === 'RELEASED') badgeClass = 'badge-success';
    
    $('#statusBadge').text(currentStatus).removeClass('d-none').addClass(badgeClass);
    $('#btnPrintSlip').removeClass('d-none');

    $('#itemsBody').empty();
    itemIdCounter = 1;

    // Load available items first, then add rows
    await loadAvailableItems();

    if (data.items && data.items.length > 0) {
        data.items.forEach(item => addItemRow(item));
    }

    if(currentStatus === 'RELEASED') {
        setReadOnlyForm();
    } else {
        // HELD config - change button text to "Update"
        $('#btnSave').text('Update');
        $('#btnSaveRelease').text('Update & Release');
    }
    
    goToItems();
}

function setReadOnlyForm() {
    $('input, textarea, select').attr('readonly', true);
    $('.btn-search').attr('disabled', true);
    $('.form-actions').hide();
    $('#headerCollapse').collapse('hide');
    $('.header-actions').hide();
    $('.btn-outline-primary').hide(); // Add row button
}

async function saveDocument(postActionStatus) {
    // Collect Data
    let payload = {
        company: $('#company').val(),
        store: $('#store').val(),
        supplierCode: $('#supplierCode').val(),
        supplierContract: $('#supplierContract').val(),
        branch: $('#branch').val(),
        internalSupplierStore: $('#internalSupplierStore').val(),
        notes: $('#notes').val(),
        createdBy: "user01",
        createdMethod: "MANUAL",
        items: []
    };

    let hasErrors = false;
    $('#itemsBody tr').each(function() {
        let code = $(this).find('.item-code').val();
        let qty = $(this).find('.item-qty').val();
        let uom = $(this).find('.item-uom').val();
        
        if(!code || !qty || !uom) {
            hasErrors = true;
        }

        payload.items.push({
            itemCode: code,
            requestQty: parseFloat(qty),
            requestUom: uom
        });
    });

    if(hasErrors || payload.items.length === 0) {
        AppUtils.showToast('Please ensure item code, qty and uom are valid for all rows', 'warning');
        return;
    }

    // Disable buttons & show loading
    let $btnSave = $('#btnSave');
    let $btnSaveRelease = $('#btnSaveRelease');
    let originalBtnText = $btnSave.html();
    let isUpdate = !!documentId;
    let spinnerText = isUpdate ? 'Updating...' : 'Creating...';
    $btnSave.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> ' + spinnerText);
    $btnSaveRelease.prop('disabled', true);

    try {
        let result;
        if (isUpdate) {
            result = await ConsignmentService.updateCSRQ(documentId, payload);
        } else {
            result = await ConsignmentService.createCSRQ(payload);
        }

        let savedId = isUpdate ? documentId : (result.id || (result.data ? result.data.id : null));
        
        if(postActionStatus === 'RELEASED') {
            if(!savedId) {
                savedId = documentId || "csrq-mock-123";
            }
            
            // Call Release API
            try {
                await ConsignmentService.releaseCSRQ(savedId);
                AppUtils.showToast(isUpdate ? "Successfully updated and released CSRQ." : "Successfully created and released CSRQ.", "success");
                window.location.href = '/consignment/stock-request';
            } catch (relErr) {
                AppUtils.showToast(isUpdate ? "Updated but error during Release." : "Created but error during Release.", "warning");
                window.location.href = '/consignment/stock-request/details?id=' + savedId;
            }
        } else {
            AppUtils.showToast(isUpdate ? "Successfully updated CSRQ." : "Successfully created CSRQ.", "success");
            setTimeout(() => {
                window.location.href = '/consignment/stock-request';
            }, 1000);
        }
    } catch(e) {
        console.error(e);
        // Error shown by ApiClient
        $btnSave.prop('disabled', false).html(originalBtnText);
        $btnSaveRelease.prop('disabled', false);
    }
}

function printSlip() {
    var id = documentId || '';
    if (!id) {
        AppUtils.showToast('No document to print', 'warning');
        return;
    }
    AppUtils.showLoading();
    ConsignmentService.printCSRQSlip(id).then(function() {
        AppUtils.showToast('PDF slip downloaded successfully', 'success');
    }).catch(function(err) {
        console.error('Print slip error:', err);
    }).finally(function() {
        AppUtils.hideLoading();
    });
}
</script>

</body>
</html>
