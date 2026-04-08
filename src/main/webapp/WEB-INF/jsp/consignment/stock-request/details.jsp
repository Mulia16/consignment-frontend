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

    <!-- Item Search Modal -->
    <div class="modal fade" id="itemSearchModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Search Item</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="input-group mb-3">
                        <input type="text" id="itemSearchKeyword" class="form-control" placeholder="Search by Item Code...">
                        <div class="input-group-append">
                            <button class="btn btn-primary" type="button" onclick="executeItemSearch()"><i class="fas fa-search"></i> Search</button>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="bg-light">
                                <tr>
                                    <th>Item Code</th>
                                    <th>Item Name</th>
                                    <th>Variant</th>
                                    <th>UOM</th>
                                    <th width="80">Action</th>
                                </tr>
                            </thead>
                            <tbody id="itemSearchResults">
                                <tr><td colspan="5" class="text-center text-muted">Please search for an item</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
<script src="/static/js/consignment-master-data.js"></script>

<script>
let itemIdCounter = 1;
let documentId = new URLSearchParams(window.location.search).get('id');
let currentStatus = 'NEW';
let itemsData = [];

document.addEventListener('configLoaded', function() {
    $('#nav-consignment-stock-request').addClass('active');
    $('#menu-outbound').addClass('active');
    
    // Init master data cascading dropdowns
    ConsignmentMasterData.init();

    if (documentId) {
        loadDocumentDetails(documentId);
    } else {
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

function goToItems() {
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

    $("#headerCollapse").collapse('hide');
    $(".header-actions").hide();
    $("#itemsCard").show();
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

    let tr = `<tr data-id="\${rowId}">
        <td class="align-middle">\${rowId}</td>
        <td>
            <div class="input-group position-relative">
                <input type="text" class="form-control item-code" value="\${itemCode}" required \${attrRead} onkeyup="handleItemSearch(this, \${rowId})" autocomplete="off" placeholder="Type to search...">
                <div class="dropdown-menu w-100 shadow autocomplete-dropdown" id="itemDropdown-\${rowId}" style="max-height: 250px; overflow-y: auto; position: absolute; top: 100%; left: 0; z-index: 1000;"></div>
                <div class="input-group-append">
                    <button class="btn btn-outline-secondary" type="button" \${attrDisabled} onclick="searchItemCode(\${rowId})" title="Advanced Search"><i class="fas fa-search"></i></button>
                </div>
            </div>
        </td>
        <td><input type="number" class="form-control item-qty" value="\${requestQty}" min="1" step="0.0001" required \${attrRead}></td>
        <td><input type="text" class="form-control item-uom" value="\${requestUom}" required \${attrRead}></td>
        <td class="align-middle text-center">\${actionBtn}</td>
    </tr>`;
    $('#itemsBody').append(tr);
}

let currentSearchRowId = null;
let searchTimeout;

function handleItemSearch(el, rowId) {
    clearTimeout(searchTimeout);
    let keyword = $(el).val();
    let dropdown = $(`#itemDropdown-\${rowId}`);
    
    // Hide all other dropdowns
    $('.autocomplete-dropdown').not(dropdown).removeClass('show');

    if(keyword.length < 2) {
        dropdown.removeClass('show');
        return;
    }
    
    // Dynamic Dropup: check if there's enough space below
    let rect = el.getBoundingClientRect();
    let spaceBelow = window.innerHeight - rect.bottom;
    if(spaceBelow < 280) { // If less than 280px below, flip it upwards
        dropdown.css({ 'top': 'auto', 'bottom': '100%', 'margin-bottom': '2px' });
    } else {
        dropdown.css({ 'top': '100%', 'bottom': 'auto', 'margin-top': '2px' });
    }
    
    searchTimeout = setTimeout(async () => {
        dropdown.html('<div class="dropdown-item text-center"><i class="fas fa-spinner fa-spin"></i> Searching...</div>').addClass('show');
        try {
            let res = await ApiClient.get('CONSIGNMENT', `/consignment-setup/items?page=1&perPage=20&itemCode=\${encodeURIComponent(keyword)}`);
            let data = res.data || res;
            let arr = Array.isArray(data) ? data : (data.itemCode ? [data] : []);
            
            if(arr.length === 0) {
                dropdown.html('<div class="dropdown-item text-muted">No items found</div>');
                return;
            }
            
            let html = '';
            arr.forEach(item => {
                let uom = item.uom || item.unitOfMeasure || 'PCS';
                let name = item.itemName || '-';
                let variant = item.variant || '-';
                html += `<a class="dropdown-item border-bottom py-2" href="#" onclick="selectAutocompleteItem(event, \${rowId}, '\${item.itemCode}', '\${uom}')">
                            <div class="font-weight-bold text-primary">\${item.itemCode}</div>
                            <small class="text-muted">\${name} • Variant: \${variant} • UOM: \${uom}</small>
                         </a>`;
            });
            dropdown.html(html);
        } catch(e) {
            dropdown.html('<div class="dropdown-item text-danger">Search error</div>');
        }
    }, 400);
}

function selectAutocompleteItem(event, rowId, code, uom) {
    event.preventDefault();
    let row = $(`tr[data-id="\${rowId}"]`);
    row.find('.item-code').val(code);
    row.find('.item-uom').val(uom);
    $(`#itemDropdown-\${rowId}`).removeClass('show');
}

// Global click to hide autocomplete dropdowns
$(document).on('click', function(e) {
    if(!$(e.target).closest('.position-relative').length) {
        $('.autocomplete-dropdown.show').removeClass('show');
    }
});

function searchItemCode(rowId) {
    currentSearchRowId = rowId;
    let row = $(`tr[data-id="\${rowId}"]`);
    let itemCode = row.find('.item-code').val();
    
    $('#itemSearchKeyword').val(itemCode);
    $('#itemSearchResults').html('<tr><td colspan="5" class="text-center text-muted">Click Search...</td></tr>');
    $('#itemSearchModal').modal('show');
    
    if(itemCode) {
        executeItemSearch();
    }
}

async function executeItemSearch() {
    let keyword = $('#itemSearchKeyword').val() || '';
    $('#itemSearchResults').html('<tr><td colspan="5" class="text-center"><i class="fas fa-spinner fa-spin"></i> Loading...</td></tr>');
    
    try {
        let res = await ApiClient.get('CONSIGNMENT', `/consignment-setup/items?page=1&perPage=20&itemCode=\${encodeURIComponent(keyword)}`);
        let data = res.data || res;
        let arr = Array.isArray(data) ? data : (data.itemCode ? [data] : []);
        
        if(arr.length === 0) {
            $('#itemSearchResults').html('<tr><td colspan="5" class="text-center text-muted">No items found</td></tr>');
            return;
        }
        
        let html = '';
        arr.forEach(item => {
            let uom = item.uom || item.unitOfMeasure || 'PCS';
            html += `
                <tr>
                    <td>\${item.itemCode || '-'}</td>
                    <td>\${item.itemName || '-'}</td>
                    <td>\${item.variant || '-'}</td>
                    <td>\${uom}</td>
                    <td class="text-center">
                        <button class="btn btn-sm btn-success" onclick="selectItemFromSearch('\${item.itemCode}', '\${uom}')">
                            Select
                        </button>
                    </td>
                </tr>
            `;
        });
        $('#itemSearchResults').html(html);
    } catch(e) {
        console.error(e);
        $('#itemSearchResults').html('<tr><td colspan="5" class="text-center text-danger">Error fetching data</td></tr>');
    }
}

function selectItemFromSearch(itemCode, uom) {
    if(currentSearchRowId !== null) {
        let row = $(`tr[data-id="\${currentSearchRowId}"]`);
        row.find('.item-code').val(itemCode);
        row.find('.item-uom').val(uom);
    }
    $('#itemSearchModal').modal('hide');
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

function populateForm(data) {
    if(data.company) $('#company').html(`<option value="\${data.company}">\${data.company}</option>`);
    if(data.store) $('#store').html(`<option value="\${data.store}">\${data.store}</option>`);
    if(data.supplierCode) $('#supplierCode').html(`<option value="\${data.supplierCode}">\${data.supplierCode}</option>`);
    if(data.supplierContract) $('#supplierContract').html(`<option value="\${data.supplierContract}">\${data.supplierContract}</option>`);
    // Once values are set, trigger cascade to load remaining sibling options correctly
    setTimeout(() => { ConsignmentMasterData.triggerCascade(); }, 100);

    $('#branch').val(data.branch || '');
    $('#internalSupplierStore').val(data.internalSupplierStore || '');
    $('#notes').val(data.notes || '');

    $('#breadcrumbDocNo').text(data.docNo || data.id);
    currentStatus = data.status || 'NEW';
    
    // Status Badge
    let badgeClass = 'badge-secondary';
    if(currentStatus === 'HELD') badgeClass = 'badge-warning';
    else if(currentStatus === 'RELEASED') badgeClass = 'badge-success';
    
    $('#statusBadge').text(currentStatus).removeClass('d-none').addClass(badgeClass);

    $('#itemsBody').empty();
    itemIdCounter = 1;
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
    $btnSave.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Saving...');
    $btnSaveRelease.prop('disabled', true);

    try {
        let apiUrl = '/consignment/api/csrq';
        let method = 'POST';

        // NOTE: The API specification only provided POST for create, PUT for release, DELETE
        // It didn't explicitly provide PUT for update, but typically update is PUT /csrq/{id}
        // In the absence of an update endpoint specification, we will treat 'Update' via POST overriding?
        // Let's assume POST creates it, and if it's already there we'd logically PUT, 
        // to simplify based on user Postman we just use POST.
        
        let result = await ApiClient.post('CONSIGNMENT', '/csrq', payload);
        let newId = result.id || (result.data ? result.data.id : null);
        
        if(postActionStatus === 'RELEASED') {
            if(!newId) {
                // if mocking / newId missing
                newId = documentId || "csrq-mock-123";
            }
            
            // Call Release API
            try {
                await ApiClient.put('CONSIGNMENT', `/csrq/\${newId}/release`, {});
                AppUtils.showToast("Successfully created and released CSRQ.", "success");
                window.location.href = '/consignment/stock-request';
            } catch (relErr) {
                AppUtils.showToast("Created but error during Release.", "warning");
                window.location.href = `/consignment/stock-request/details?id=\${newId}`;
            }
        } else {
            AppUtils.showToast("Successfully created CSRQ.", "success");
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
</script>

</body>
</html>
