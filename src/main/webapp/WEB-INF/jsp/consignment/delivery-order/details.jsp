<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consignment Stock Delivery Order Details</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
<div class="main-content">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="pageTitle" value="Consignment Stock Delivery Order"/>
    </jsp:include>

    <div class="container-fluid mt-3">
        <!-- Breadcrumb & Top Actions -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                    <li class="breadcrumb-item">Consignment</li>
                    <li class="breadcrumb-item">Transaction</li>
                    <li class="breadcrumb-item"><a href="/consignment/delivery-order">Consignment Stock Delivery Order</a></li>
                    <li class="breadcrumb-item active" aria-current="page" id="breadcrumbDocNumber">New Document</li>
                </ol>
            </nav>
            <div id="topActions" style="display: none;">
               <button class="btn btn-sm btn-outline-secondary mr-2" onclick="printSlip()"><i class="fas fa-print mr-1"></i> Print Slip</button>
               <span id="headerStatusBadge" class="badge badge-warning" style="font-size: 0.9rem;">HELD</span>
            </div>
        </div>

        <!-- STAGE 1: HEADER FORM -->
        <div id="step1-header">
            <form id="headerForm">
                <div class="row">

                    <!-- Document Details -->
                    <div class="col-md-4 mb-3">
                        <div class="card shadow-sm h-100">
                            <div class="card-header bg-white font-weight-bold" id="docDetailsTitle">
                                Document Details 
                            </div>
                            <div class="card-body">
                                <div class="form-group mb-3 pb-2 border-bottom" id="csoIdGroup" style="display: none;">
                                    <label class="small text-muted mb-1 font-weight-bold text-primary">Transfer From CSO ID / Document No <span class="text-danger">*</span></label>
                                    <input type="text" id="inputCsoId" class="form-control border-primary" placeholder="e.g. cso-001 or CSO-00001">
                                </div>
                                <div class="row mb-2">
                                    <div class="col-6">
                                        <label class="small text-muted mb-1">Company</label>
                                        <div class="font-weight-bold" id="lblCompany">COMP01</div>
                                    </div>
                                    <div class="col-6">
                                        <label class="small text-muted mb-1">Store</label>
                                        <div class="font-weight-bold" id="lblStore">STORE01</div>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-6">
                                        <label class="small text-muted mb-1">Date</label>
                                        <div class="font-weight-bold" id="lblDate">2025-08-27</div>
                                    </div>
                                    <div class="col-6">
                                        <label class="small text-muted mb-1">Created By</label>
                                        <div class="font-weight-bold" id="lblCreatedBy">OPR - OPR OPR</div>
                                    </div>
                                </div>
                                
                                <div class="form-group mb-3 pb-2 border-bottom">
                                    <label class="small text-muted mb-1 d-block">Require Generate CDO <span class="text-danger">*</span></label>
                                    <div class="custom-control custom-radio custom-control-inline">
                                      <input type="radio" id="cdoYes" name="cdoGen" class="custom-control-input" value="Yes" checked>
                                      <label class="custom-control-label" for="cdoYes">Yes</label>
                                    </div>
                                    <div class="custom-control custom-radio custom-control-inline">
                                      <input type="radio" id="cdoNo" name="cdoGen" class="custom-control-input" value="No">
                                      <label class="custom-control-label" for="cdoNo">No</label>
                                    </div>
                                </div>
                                
                                <div class="form-group mb-0">
                                    <label class="small text-muted mb-1">Note (Maximum 500 characters)</label>
                                    <textarea class="form-control" rows="3" maxlength="500"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Customer Details -->
                    <div class="col-md-4 mb-3">
                        <div class="card shadow-sm h-100 bg-light">
                            <div class="card-header bg-white font-weight-bold">
                                Customer Details (Transferred)
                            </div>
                            <div class="card-body">
                                <div class="form-group mb-3">
                                    <label class="small text-muted mb-1">Customer</label>
                                    <input type="text" class="form-control" value="10001 - test - test" readonly>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="small text-muted mb-1">Customer Branch</label>
                                    <input type="text" class="form-control" value="0001 - TTTBRANCH" readonly>
                                </div>
                                <div class="form-group mb-0">
                                    <label class="small text-muted mb-1">Email <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" value="ss@gmail.com" required>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Shipping Details -->
                    <div class="col-md-4 mb-3">
                        <div class="card shadow-sm h-100">
                            <div class="card-header bg-white font-weight-bold">
                                Shipping Details
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-6 mb-2">
                                        <label class="small text-muted mb-1">Shipping Term (Cargo)</label>
                                        <select class="form-control form-control-sm"><option>C</option></select>
                                    </div>
                                    <div class="col-6 mb-2">
                                        <label class="small text-muted mb-1">Delivery Date</label>
                                        <input type="date" class="form-control form-control-sm">
                                    </div>
                                    <div class="col-6 mb-2">
                                        <label class="small text-muted mb-1">Shipping Mode</label>
                                        <select class="form-control form-control-sm" id="shipMode"><option value="COURIER">Courier</option><option value="PICKUP">Pickup</option></select>
                                    </div>
                                    <div class="col-6 mb-2">
                                        <label class="small text-muted mb-1">Transporter <span class="text-danger">*</span></label>
                                        <select class="form-control form-control-sm" id="transporter" required><option value="JNE">JNE</option><option value="ABX Express">ABX Express</option><option value="POST">Post</option></select>
                                    </div>
                                </div>
                                <div class="form-group mb-2">
                                    <label class="small text-muted mb-1">Shipping ID <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control form-control-sm" value="TT12345MY" required>
                                </div>
                                <div class="form-group mb-2">
                                    <label class="small text-muted mb-1">Shipping Address <span class="text-danger">*</span></label>
                                    <textarea class="form-control form-control-sm" rows="1" required>JALAN TEKNO 10/3</textarea>
                                </div>
                                <div class="row">
                                    <div class="col-6 mb-2">
                                        <label class="small text-muted mb-1">Country <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control form-control-sm" value="Malaysia" required>
                                    </div>
                                    <div class="col-6 mb-2">
                                        <label class="small text-muted mb-1">State <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control form-control-sm" value="Selangor" required>
                                    </div>
                                    <div class="col-6 mb-2">
                                        <label class="small text-muted mb-1">City <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control form-control-sm" value="PJ" required>
                                    </div>
                                    <div class="col-6 mb-2">
                                        <label class="small text-muted mb-1">Postcode <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control form-control-sm" value="46150" required>
                                    </div>
                                </div>
                                <div class="form-group mb-2">
                                    <label class="small text-muted mb-1">Contact Number</label>
                                    <input type="text" class="form-control form-control-sm">
                                </div>
                                <div class="form-group mb-0">
                                    <label class="small text-muted mb-1">Customer Reference</label>
                                    <input type="text" class="form-control form-control-sm">
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                
                <div class="card shadow-sm mt-2">
                    <div class="card-footer bg-light d-flex justify-content-end">
                        <button type="button" class="btn btn-outline-secondary mr-2" onclick="window.history.back()">Cancel</button>
                        <button type="button" class="btn btn-primary px-4" onclick="proceedToDetails()">Next Data</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- STAGE 2: ITEM DETAILS -->
        <div class="card shadow-sm" id="step2-items" style="display: none;">
            
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                <strong>Item Details (from CSO)</strong>
                <a href="#" onclick="$('#step1-header').slideToggle();" class="small">Show Header <i class="fas fa-chevron-down"></i></a>
            </div>
            
            <div class="card-body p-0 table-responsive">
                <div class="p-2 border-bottom bg-light">
                    <button class="btn btn-sm btn-outline-primary" id="btnAddRow" onclick="addItemRow()">
                        <i class="fas fa-plus"></i> Add Row
                    </button>
                </div>
                <table class="table table-bordered mb-0 text-sm">
                    <thead class="bg-light">
                        <tr>
                            <th width="40" class="text-center">No.</th>
                            <th>Item Code</th>
                            <th width="200" class="text-right">Quantity</th>
                            <th width="150" class="text-center">UOM</th>
                            <th width="80" class="text-center bg-light">Action</th>
                        </tr>
                    </thead>
                    <tbody id="itemTableBody">
                        <!-- JS Render -->
                    </tbody>
                </table>
            </div>
            
            <div class="card-footer bg-light d-flex justify-content-end" id="actionFooter">
                <button type="button" class="btn btn-outline-secondary mr-2" onclick="window.history.back()">Cancel</button>
                <button id="btnCreate" type="button" class="btn btn-primary mr-2" onclick="saveDocument('HELD')">Create</button>
                <button id="btnCreateRelease" type="button" class="btn btn-success" onclick="saveDocument('RELEASED')">Create & Release</button>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />

<script>
var docId = new URLSearchParams(window.location.search).get('id');
var currentStatus = '';

var itemsList = [];

document.addEventListener('configLoaded', function() {
    if (docId) {
        // Edit/View Mode
        loadDocument(docId);
    } else {
        // Create Mode
        currentStatus = 'NEW';
        $('#docDetailsTitle').html('New Delivery Order Transfer');
        $('#csoIdGroup').show();
        $('#lblDate').text(new Date().toISOString().substring(0,10));
        $('#lblCreatedBy').text('Current User');
    }
});

function proceedToDetails() {
    if (!$('#headerForm')[0].checkValidity()) {
        $('#headerForm')[0].reportValidity();
        return;
    }
    
    $('#step1-header').hide();
    $('#step2-items').show();
    
    renderItems();
}

function addItemRow() {
    if(currentStatus === 'RELEASED') return;
    itemsList.push({ itemCode: '', itemName: '', qty: 0.0, uom: 'UNIT' });
    renderItems();
}

function removeItem(index) {
    if(currentStatus === 'RELEASED') return;
    itemsList.splice(index, 1);
    renderItems();
}

function updateItem(index, field, value) {
    itemsList[index][field] = value;
}

function renderItems() {
    var tbody = $('#itemTableBody');
    tbody.empty();
    
    var isReadOnly = currentStatus === 'RELEASED';
    var disableInputs = isReadOnly ? 'disabled' : '';
    
    if (itemsList.length === 0) {
        tbody.append('<tr><td colspan="5" class="text-center py-3">No items.</td></tr>');
        return;
    }
    
    itemsList.forEach((item, index) => {
        var htmlItemCode = isReadOnly ? 
            "<strong>" + (item.itemCode || "-") + "</strong><br><small class='text-muted'>" + item.itemName + "</small>" : 
            `<div class="position-relative">
                <input type="text" class="form-control form-control-sm item-code" placeholder="Search Item Code..." value="\${item.itemCode || ''}" onkeyup="handleItemSearch(this, \${index})" autocomplete="off">
                <div class="dropdown-menu w-100 shadow autocomplete-dropdown" id="itemDropdown-\${index}" style="max-height: 250px; overflow-y: auto; position: absolute; top: 100%; left: 0; z-index: 1000;"></div>
            </div>`;

        var htmlUom = isReadOnly ? 
            item.uom : 
            "<input type='text' class='form-control form-control-sm text-center' value='" + item.uom + "' onchange=\"updateItem(" + index + ", 'uom', this.value)\">";

        var htmlAction = !isReadOnly ? 
            "<button class='btn btn-sm text-danger border-0 bg-transparent' onclick=\"removeItem(" + index + ")\"><i class='fas fa-trash'></i></button>" : 
            "<i class='fas fa-lock text-muted'></i>";

        var row = `<tr>
            <td class="text-center align-middle">\${index + 1}</td>
            <td class="align-middle">\${htmlItemCode}</td>
            <td class="text-right align-middle">
                <input type="number" step="0.01" class="form-control form-control-sm text-right mx-auto" 
                    value="\${item.qty.toFixed(6)}" \${disableInputs}
                    onchange="updateItem(\${index}, 'qty', parseFloat(this.value)||0)">
            </td>
            <td class="text-center align-middle">\${htmlUom}</td>
            <td class="text-center align-middle bg-light">\${htmlAction}</td>
        </tr>`;
        tbody.append(row);
    });
}

function resetItems() {
    if(currentStatus === 'RELEASED') return;
    itemsList = [{ itemCode: '0100012', itemName: 'ACITRAL SUSPENSI 120ML', qty: 2.0, uom: 'UNIT' }];
    renderItems();
}

async function loadDocument(id) {
    AppUtils.showLoading();
    try {
        var data = await ApiClient.get('CONSIGNMENT', `/csdo/${id}`);
        // Map details
        currentStatus = data.status ? data.status.toUpperCase() : 'HELD';
        $('#breadcrumbDocNumber').text('Doc #' + data.docNo);
        $('#docDetailsTitle').html(`Document Details ${data.docNo} <small class="text-muted ml-2">(Ref: ${data.csoDocNo || data.csoId})</small>`);
        
        $('#lblCompany').text(data.company || '-');
        $('#lblStore').text(data.store || '-');
        $('#lblDate').text(data.createdAt ? data.createdAt.substring(0,10) : '-');
        $('#lblCreatedBy').text(data.createdBy || '-');
        
        if (data.requireGenerateCdo) { $('#cdoYes').prop('checked', true); } else { $('#cdoNo').prop('checked', true); }
        $('#shipMode').val((data.shippingMode || 'COURIER').toUpperCase());
        
        if(data.transporter && !$('#transporter option[value="'+data.transporter+'"]').length) {
            $('#transporter').append(new Option(data.transporter, data.transporter, true, true));
        } else {
            $('#transporter').val(data.transporter);
        }
        
        var badgeClass = currentStatus === 'RELEASED' ? 'badge-success' : 'badge-warning';
        if (currentStatus === 'REVERSED') badgeClass = 'badge-secondary';
        
        $('#headerStatusBadge').text(currentStatus).attr('class', 'badge ' + badgeClass);
        $('#topActions').show();
        
        itemsList = data.items || [];
        
        // Hide/disable rules
        if (currentStatus === 'RELEASED' || currentStatus === 'REVERSED') {
            $('#headerForm :input').prop('disabled', true);
            $('#actionFooter').hide();
            $('#btnAddRow').hide();
        } else if (currentStatus === 'HELD') {
            $('#headerForm :input').prop('disabled', true);
            $('#btnAddRow').hide();
            $('#btnCreate').hide();
            $('#btnCreateRelease').text('Release');
            $('#btnCreateRelease').removeClass('btn-success').addClass('btn-primary');
            $('#btnCreateRelease').attr('onclick', "saveDocument('RELEASED')");
        }
        
    } catch(e) {
        console.error(e);
        AppUtils.showToast("Failed to load document", "danger");
    } finally {
        AppUtils.hideLoading();
        $('#step1-header').hide();
        $('#step2-items').show();
        renderItems();
    }
}

async function saveDocument(status) {
    if (currentStatus === 'RELEASED' || currentStatus === 'REVERSED') return;
    
    // Release action for an existing HELD document
    if (currentStatus === 'HELD' && status === 'RELEASED') {
        AppUtils.showLoading();
        try {
            await ApiClient.put('CONSIGNMENT', `/csdo/${docId}/release`);
            AppUtils.showToast("Document released successfully.", "success");
            setTimeout(() => { window.location.href = '/consignment/delivery-order'; }, 1000);
        } catch(e) {
            console.error(e);
            AppUtils.showToast("Error releasing document", "danger");
        } finally { AppUtils.hideLoading(); }
        return;
    }

    // Create action for entirely new document transfer
    if (currentStatus === 'NEW') {
        var csoId = $('#inputCsoId').val();
        if (!csoId || !csoId.trim()) {
            AppUtils.showToast("Please enter CSO ID to transfer from.", "warning");
            $('#step2-items').hide();
            $('#step1-header').show();
            $('#inputCsoId').focus();
            return;
        }

        var payload = {
            requireGenerateCdo: $('#cdoYes').is(':checked'),
            shippingMode: $('#shipMode').val() || 'COURIER',
            transporter: $('#transporter').val() || 'JNE',
            createdBy: 'user01' // Mock logged in user
        };
        
        AppUtils.showLoading();
        try {
            var transRes = await ApiClient.post('CONSIGNMENT', `/csdo/transfer/${csoId.trim()}`, payload);
            var newId = transRes.id || transRes.docNo || csoId;
            
            if (status === 'RELEASED') {
                await ApiClient.put('CONSIGNMENT', `/csdo/${newId}/release`);
                AppUtils.showToast("CSDO created & released successfully.", "success");
            } else {
                AppUtils.showToast("CSDO created successfully.", "success");
            }
            setTimeout(() => { window.location.href = '/consignment/delivery-order'; }, 1000);
        } catch(e) {
            console.error(e);
            AppUtils.showToast("Error transferring CSDO: " + e.message, "danger");
        } finally {
            AppUtils.hideLoading();
        }
    }
}

function printSlip() {
    AppUtils.showToast("Printing CSDO slip...", "info");
}

let searchTimeout;

function handleItemSearch(el, index) {
    clearTimeout(searchTimeout);
    let keyword = $(el).val();
    let dropdown = $(`#itemDropdown-\${index}`);
    
    $('.autocomplete-dropdown').not(dropdown).removeClass('show');

    if(keyword.length < 2) {
        dropdown.removeClass('show');
        return;
    }
    
    searchTimeout = setTimeout(async () => {
        dropdown.html('<div class="dropdown-item text-center"><i class="fas fa-spinner fa-spin"></i> Searching...</div>').addClass('show');
        try {
            let company = $('#lblCompany').text().split('-')[0].trim();
            if(!company || company === '-') company = 'COMP01';
            let store = $('#lblStore').text().trim();
            if(!store || store === '-') store = 'STORE01';
            
            // Following user specification URL format
            let qs = `?company=\${company}&store=\${store}&supplierCode=SUPP001&supplierContract=CONTRACT-2024-001&keyword=\${encodeURIComponent(keyword)}`;
            
            let res = await ApiClient.get('CONSIGNMENT', `/master-data/items\${qs}`);
            let data = res.data || res;
            let arr = Array.isArray(data) ? data : (data.itemCode ? [data] : []);
            
            if(arr.length === 0) {
                dropdown.html('<div class="dropdown-item text-muted">No items found</div>');
                return;
            }
            
            let html = '';
            arr.forEach(item => {
                let uom = item.uom || item.unitOfMeasure || 'UNIT';
                let name = item.itemName || '-';
                // Note: single quotes around strings
                let escapedName = name.replace(/'/g, "\\'");
                html += `<a class="dropdown-item border-bottom py-2" href="#" onclick="selectAutocompleteItem(event, \${index}, '\${item.itemCode}', '\${escapedName}', '\${uom}')">
                            <div class="font-weight-bold text-primary">\${item.itemCode}</div>
                            <small class="text-muted">\${name} • UOM: \${uom}</small>
                         </a>`;
            });
            dropdown.html(html);
        } catch(e) {
            console.error(e);
            dropdown.html('<div class="dropdown-item text-danger">Search error</div>');
        }
    }, 400);
}

function selectAutocompleteItem(event, index, code, name, uom) {
    event.preventDefault();
    itemsList[index]['itemCode'] = code;
    itemsList[index]['itemName'] = name;
    itemsList[index]['uom'] = uom;
    renderItems();
}

$(document).on('click', function(e) {
    if(!$(e.target).closest('.position-relative').length) {
        $('.autocomplete-dropdown.show').removeClass('show');
    }
});
</script>

<style>
.text-sm { font-size: 0.85rem; }
</style>

</body>
</html>
