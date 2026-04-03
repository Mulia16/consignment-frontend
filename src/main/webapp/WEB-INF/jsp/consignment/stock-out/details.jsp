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
                                    <select class="form-control" name="company" required>
                                        <option value="ALPRO PHARMACY SDN BHD">ALPRO PHARMACY SDN BHD</option>
                                    </select>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="small text-muted mb-1">Store <span class="text-danger">*</span></label>
                                    <select class="form-control" name="store" id="hStore" required>
                                        <option value="">Select Store</option>
                                        <option value="IPOH_MALL">IPOH MALL STORE</option>
                                        <option value="NPDRM1">NPDRM1</option>
                                    </select>
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

<script>
var docId = new URLSearchParams(window.location.search).get('id');
var currentStatus = '';

var itemsList = [];

document.addEventListener('configLoaded', function() {
    var now = new Date();
    now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
    document.getElementById('hDate').value = now.toISOString().slice(0,16);

    if (docId) {
        // Edit/View Mode
        loadDocument(docId);
    } else {
        addItemRow(); // empty row
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
    var isError = currentStatus === 'ERROR';
    var disableInputs = isReadOnly ? 'disabled' : '';
    
    if (itemsList.length === 0) {
        tbody.append('<tr><td colspan="5" class="text-center py-3">No items added.</td></tr>');
        return;
    }
    
    itemsList.forEach((item, index) => {
        var htmlItemCode = isReadOnly ? 
            "<strong>" + (item.itemCode || "-") + "</strong><br><small class='text-muted'>" + item.itemName + "</small>" : 
            "<input type='text' class='form-control form-control-sm' placeholder='Search Item (e.g. 0100012)' value='" + item.itemCode + "' onchange=\"updateItem(" + index + ", 'itemCode', this.value)\">";

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

function loadDocument(id) {
    // Mock getting document details
    var parsedId = parseInt(id) || 1;
    // mock Status based on List logic:
    // id 1,2 = Released. id 3 = Held. id 4 = Error.
    if(parsedId === 1 || parsedId === 2) currentStatus = 'RELEASED';
    else if (parsedId === 3) currentStatus = 'HELD';
    else currentStatus = 'ERROR';
    
    $('#breadcrumbDocNumber').text('Doc #' + 'SO-2508-00005' + (4 - parsedId));
    
    var badgeClass = 'badge-warning';
    if(currentStatus === 'RELEASED') badgeClass = 'badge-success';
    if(currentStatus === 'ERROR') badgeClass = 'badge-danger';
    
    $('#headerStatusBadge').text(currentStatus).attr('class', 'badge ' + badgeClass);
    $('#topActions').show();
    
    if(currentStatus === 'RELEASED') {
        $('#headerForm :input').prop('disabled', true);
        $('#actionFooter').hide();
        $('#btnAddRow').hide();
    }
    
    // Mock Data
    itemsList = [{ itemCode: '0100012', itemName: 'ACITRAL SUSPENSI 120ML', qty: 2.0, uom: 'UNIT' }];
    
    $('#step1-header').hide();
    $('#step2-items').show();
    renderItems();
}

function saveDocument(status) { // 'HELD' or 'RELEASED'
    if (currentStatus === 'RELEASED') return;
    
    // Validation
    if(itemsList.length === 0 || !itemsList[0].itemCode) {
        AppUtils.showToast("Please add valid items first.", "warning");
        return;
    }
    
    if(status === 'RELEASED') {
        // Business Rule #7 & #8 Validation Mocking
        AppUtils.showToast("Validating against Consignment reservation inventory...", "info");
    }
    
    setTimeout(() => {
        AppUtils.showToast("Document saved with status: " + status, "success");
        currentStatus = status;
        var bClass = status === 'RELEASED' ? 'badge-success' : 'badge-warning';
        $('#headerStatusBadge').text(status).attr('class', 'badge ' + bClass);
        $('#topActions').show();
        
        setTimeout(() => { window.location.href = '/consignment/stock-out'; }, 1500);
    }, 600);
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
