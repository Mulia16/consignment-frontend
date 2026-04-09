<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consignment Stock Out Details</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
<div class="main-content">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="pageTitle" value="Consignment Stock Out"/>
    </jsp:include>

    <div class="container-fluid mt-3">
        <!-- Breadcrumb & Top Actions -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                    <li class="breadcrumb-item">Consignment</li>
                    <li class="breadcrumb-item">Transaction</li>
                    <li class="breadcrumb-item"><a href="/consignment/stock-out">Consignment Stock Out</a></li>
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
                            <div class="card-header bg-white font-weight-bold">
                                Document Details
                            </div>
                            <div class="card-body">
                                <div class="form-group mb-3">
                                    <label class="small text-muted mb-1">Company <span class="text-danger">*</span></label>
                                    <select class="form-control" name="company" id="company" required></select>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="small text-muted mb-1">Store <span class="text-danger">*</span></label>
                                    <select class="form-control" name="store" id="store" required></select>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="small text-muted mb-1">Supplier <span class="text-danger">*</span></label>
                                    <select class="form-control" name="supplierCode" id="supplierCode" required></select>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="small text-muted mb-1">Supplier Contract <span class="text-danger">*</span></label>
                                    <select class="form-control" name="supplierContract" id="supplierContract" required></select>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="small text-muted mb-1">Date</label>
                                    <input type="datetime-local" class="form-control" id="hDate" required>
                                </div>
                                
                                <div class="form-group mb-3">
                                    <label class="small text-muted mb-1 d-block">Auto Generate CSDO <span class="text-danger">*</span></label>
                                    <div class="custom-control custom-radio custom-control-inline">
                                      <input type="radio" id="csdoAuto" name="csdoGen" class="custom-control-input" value="Auto" checked>
                                      <label class="custom-control-label" for="csdoAuto">Auto</label>
                                    </div>
                                    <div class="custom-control custom-radio custom-control-inline">
                                      <input type="radio" id="csdoManual" name="csdoGen" class="custom-control-input" value="Manual">
                                      <label class="custom-control-label" for="csdoManual">Manual</label>
                                    </div>
                                </div>
                                
                                <div class="form-group mb-0">
                                    <label class="small text-muted mb-1">Note (Maximum 500 characters)</label>
                                    <textarea class="form-control" rows="4" maxlength="500"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Customer Details -->
                    <div class="col-md-4 mb-3">
                        <div class="card shadow-sm h-100">
                            <div class="card-header bg-white font-weight-bold">
                                Customer Details
                            </div>
                            <div class="card-body">
                                <div class="form-group mb-3">
                                    <label class="small text-muted mb-1">Customer <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" required>
                                        <div class="input-group-append">
                                            <button class="btn btn-outline-secondary" type="button"><i class="fas fa-search"></i></button>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="small text-muted mb-1">Customer Branch <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" required>
                                </div>
                                <div class="form-group mb-0">
                                    <label class="small text-muted mb-1">Email <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" required>
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
                                        <select class="form-control form-control-sm"><option>Chilled</option></select>
                                    </div>
                                    <div class="col-6 mb-2">
                                        <label class="small text-muted mb-1">Transporter <span class="text-danger">*</span></label>
                                        <select class="form-control form-control-sm" required><option>Line Clear</option></select>
                                    </div>
                                </div>
                                <div class="form-group mb-2">
                                    <label class="small text-muted mb-1">Shipping ID <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control form-control-sm" required>
                                </div>
                                <div class="form-group mb-2">
                                    <label class="small text-muted mb-1">Shipping Address <span class="text-danger">*</span></label>
                                    <textarea class="form-control form-control-sm" rows="2" required></textarea>
                                </div>
                                <div class="row">
                                    <div class="col-6 mb-2">
                                        <label class="small text-muted mb-1">Country <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control form-control-sm" required>
                                    </div>
                                    <div class="col-6 mb-2">
                                        <label class="small text-muted mb-1">State <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control form-control-sm" required>
                                    </div>
                                    <div class="col-6 mb-2">
                                        <label class="small text-muted mb-1">City <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control form-control-sm" required>
                                    </div>
                                    <div class="col-6 mb-2">
                                        <label class="small text-muted mb-1">Postcode <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control form-control-sm" required>
                                    </div>
                                </div>
                                <div class="form-group mb-2">
                                    <label class="small text-muted mb-1">Contact Number</label>
                                    <input type="text" class="form-control form-control-sm">
                                </div>
                                <div class="form-group mb-2">
                                    <label class="small text-muted mb-1">Customer Reference</label>
                                    <input type="text" class="form-control form-control-sm">
                                </div>
                                <div class="form-group mb-0">
                                    <label class="small text-muted mb-1">Transport</label>
                                    <input type="text" class="form-control form-control-sm" placeholder="Shipping Information">
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                
                <div class="card shadow-sm mt-2">
                    <div class="card-footer bg-light d-flex justify-content-end">
                        <button type="button" class="btn btn-outline-secondary mr-2" onclick="window.history.back()">Cancel</button>
                        <button type="button" class="btn btn-light mr-2" onclick="$('#headerForm')[0].reset()">Reset</button>
                        <button type="button" class="btn btn-primary px-4" onclick="proceedToDetails()">Next</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- STAGE 2: ITEM DETAILS -->
        <div class="card shadow-sm" id="step2-items" style="display: none;">
            
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                <strong>Item Details</strong>
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
                <button type="button" class="btn btn-light mr-2" onclick="resetItems()">Reset</button>
                <button type="button" class="btn btn-primary mr-2" onclick="saveDocument('HELD')">Create</button>
                <button type="button" class="btn btn-success" onclick="saveDocument('RELEASED')">Create & Release</button>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
<script src="/static/js/consignment-master-data.js"></script>

<script>
var docId = new URLSearchParams(window.location.search).get('id');
var currentStatus = '';

var itemsList = [];
var availableItems = [];

document.addEventListener('configLoaded', function() {
    var now = new Date();
    now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
    document.getElementById('hDate').value = now.toISOString().slice(0,16);

    ConsignmentMasterData.init();

    if (docId) {
        // Edit/View Mode
        loadDocument(docId);
    } else {
        addItemRow(); // empty row
    }
});

async function proceedToDetails() {
    if (!$('#headerForm')[0].checkValidity()) {
        $('#headerForm')[0].reportValidity();
        return;
    }
    
    // Fetch available items from master-data API using header values
    await loadAvailableItems();

    $('#step1-header').hide();
    $('#step2-items').show();
    
    renderItems();
}

async function loadAvailableItems() {
    var company = $('#company').val();
    var store = $('#store').val();
    var supplierCode = $('#supplierCode').val();
    var supplierContract = $('#supplierContract').val();

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
    } catch(e) {
        console.error('Failed to load available items:', e);
        AppUtils.showToast('Failed to load items for this supplier/contract', 'warning');
    } finally {
        AppUtils.hideLoading();
    }
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
    var isError = currentStatus === 'ERROR';
    var disableInputs = isReadOnly ? 'disabled' : '';
    
    if (itemsList.length === 0) {
        tbody.append('<tr><td colspan="5" class="text-center py-3">No items added.</td></tr>');
        return;
    }
    
    itemsList.forEach((item, index) => {
        var htmlItemCode = '';
        if(isReadOnly) {
            htmlItemCode = "<strong>" + (item.itemCode || "-") + "</strong><br><small class='text-muted'>" + item.itemName + "</small>";
        } else {
            // Build select dropdown from availableItems
            var opts = "<option value=''>-- Select Item --</option>";
            if(availableItems && availableItems.length > 0) {
                availableItems.forEach(function(ai) {
                    var sel = (ai === item.itemCode) ? 'selected' : '';
                    opts += "<option value='" + ai + "' " + sel + ">" + ai + "</option>";
                });
            } else if(item.itemCode) {
                opts += "<option value='" + item.itemCode + "' selected>" + item.itemCode + "</option>";
            }
            htmlItemCode = "<select class='form-control form-control-sm' onchange=\"updateItem(" + index + ", 'itemCode', this.value)\">" + opts + "</select>";
        }

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
    itemsList = [{ itemCode: '', itemName: '', qty: 0.0, uom: 'UNIT' }];
    renderItems();
}

async function loadDocument(id) {
    AppUtils.showLoading();
    try {
        var res = await ApiClient.get('CONSIGNMENT', `/cso/${id}`);
        var data = res.data || res;
        
        currentStatus = (data.status || 'ERROR').toUpperCase();
        
        $('#breadcrumbDocNumber').text('Doc #' + (data.docNo || id));
        
        var badgeClass = 'badge-warning';
        if(currentStatus === 'RELEASED') badgeClass = 'badge-success';
        if(currentStatus === 'ERROR') badgeClass = 'badge-danger';
        
        $('#headerStatusBadge').text(currentStatus).attr('class', 'badge ' + badgeClass);
        $('#topActions').show();
        
        // Populate header fields
        if(data.company) $('#company').html(`<option value="\${data.company}">\${data.company}</option>`);
        if(data.store) $('#store').html(`<option value="\${data.store}">\${data.store}</option>`);
        if(data.supplierCode) $('#supplierCode').html(`<option value="\${data.supplierCode}">\${data.supplierCode}</option>`);
        if(data.supplierContract) $('#supplierContract').html(`<option value="\${data.supplierContract}">\${data.supplierContract}</option>`);
        setTimeout(() => { ConsignmentMasterData.triggerCascade(); }, 100);

        if(data.customerCode) $('#headerForm input:eq(0)').val(data.customerCode);
        if(data.customerBranch) $('#headerForm input:eq(1)').val(data.customerBranch);
        if(data.customerEmail) $('#headerForm input[type="email"]').val(data.customerEmail);
        
        if(data.autoGenerateCsdo) {
            $('#csdoAuto').prop('checked', true);
        } else {
            $('#csdoManual').prop('checked', true);
        }
        
        if(data.note) $('#headerForm textarea:eq(0)').val(data.note);
        
        if(currentStatus === 'RELEASED') {
            $('#headerForm :input').prop('disabled', true);
            $('#actionFooter').hide();
            $('#btnAddRow').hide();
        }
        
        itemsList = [];
        if (data.items && data.items.length > 0) {
            data.items.forEach(item => {
                itemsList.push({
                    itemCode: item.itemCode,
                    itemName: item.itemName || 'Item Description',
                    qty: item.qty || 0,
                    uom: item.uom || 'UNIT'
                });
            });
        }
        
        // Fetch available items before rendering
        await loadAvailableItems();

        $('#step1-header').hide();
        $('#step2-items').show();
        renderItems();
    } catch (e) {
        console.error(e);
        AppUtils.showToast('Failed to load document details', 'danger');
    } finally {
        AppUtils.hideLoading();
    }
}

async function saveDocument(status) { // 'HELD' or 'RELEASED'
    if (currentStatus === 'RELEASED') return;
    
    // Validation
    if(itemsList.length === 0 || !itemsList[0].itemCode) {
        AppUtils.showToast("Please add valid items first.", "warning");
        return;
    }
    
    AppUtils.showLoading();
    
    try {
        var isAutoCsdo = $('#csdoAuto').is(':checked');
        var payload = {
            company: $('#company').val() || "COMP01",
            store: $('#store').val() || "STORE01",
            customerCode: $('#headerForm input:eq(0)').val() || "CUST001",
            customerBranch: $('#headerForm input:eq(1)').val() || "BRANCH01",
            customerEmail: $('#headerForm input[type="email"]').val() || "cust@example.com",
            supplierCode: $('#supplierCode').val() || "SUPP001",
            supplierContract: $('#supplierContract').val() || "CONTRACT-2024-001",
            autoGenerateCsdo: isAutoCsdo,
            note: $('#headerForm textarea:eq(0)').val() || "Note",
            createdBy: "user01",
            createdMethod: isAutoCsdo ? "AUTO" : "MANUAL",
            items: itemsList.map(i => ({
                itemCode: i.itemCode,
                qty: parseFloat(i.qty),
                uom: i.uom
            }))
        };

        var targetUrl = '/cso';
        if (payload.createdMethod === 'AUTO') {
             // as per postman, when AUTO we optionally use a different endpoint
             // we'll stick to targetUrl unless we specifically decide. The API collection says: auto-create endpoint /api/acmm/cso/auto-create
             // let's use standard CSO for now since it handles both in most microservices, or direct if requested. 
             // user prompt: API has POST /consignment/api/cso with autoGenerateCsdo: false. 
             // And POST /consignment/api/acmm/cso/auto-create with autoGenerateCsdo: true.
             if (isAutoCsdo) {
                 targetUrl = '/acmm/cso/auto-create';
             }
        }

        var res = await ApiClient.post('CONSIGNMENT', targetUrl, payload);
        var createdCsoId = (res.data && res.data.id) ? res.data.id : (res.id ? res.id : 'cso-created');
        
        if (status === 'RELEASED') {
            await ApiClient.put('CONSIGNMENT', `/cso/${createdCsoId}/release`);
        }
        
        AppUtils.showToast("Document saved with status: " + status, "success");
        setTimeout(() => { window.location.href = '/consignment/stock-out'; }, 1500);

    } catch (e) {
        console.error(e);
        AppUtils.showToast("Failed to save document", "danger");
    } finally {
        AppUtils.hideLoading();
    }
}

function printSlip() {
    AppUtils.showToast("Printing CSO slip...", "info");
}
</script>

<style>
.text-sm { font-size: 0.85rem; }
</style>

</body>
</html>
