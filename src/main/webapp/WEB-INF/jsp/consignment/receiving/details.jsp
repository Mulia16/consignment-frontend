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
                            <select class="form-control" name="company" required id="hCompany">
                                <option value="001 - ALPRO PHARMACY SDN BHD">001 - ALPRO PHARMACY SDN BHD</option>
                            </select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Receiving Store <span class="text-danger">*</span></label>
                            <select class="form-control" name="store" required id="hStore">
                                <option value="IPOH MALL">IPOH MALL STORE</option>
                                <option value="SERAI">SERAI STORE</option>
                            </select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Document Number <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <input type="text" class="form-control" name="docNumber" id="hDocNumber" placeholder="Search CSRQ prefix..." required>
                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary" type="button"><i class="fas fa-search"></i></button>
                                </div>
                            </div>
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
                            <label class="small text-muted mb-1">Supplier DO Number <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="supplierDO" id="hSupplierDO" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="small text-muted mb-1">Delivery Date</label>
                            <input type="date" class="form-control" name="deliveryDate" id="hDeliveryDate">
                        </div>
                        <div class="col-md-8 mb-3">
                            <label class="small text-muted mb-1">Remark</label>
                            <textarea class="form-control" rows="2" name="remark" id="hRemark" maxlength="150" placeholder="Maximum 150 characters"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="card-footer bg-light d-flex justify-content-end">
                <button type="button" class="btn btn-outline-secondary mr-2" onclick="window.history.back()">Cancel</button>
                <button type="button" class="btn btn-light mr-2" onclick="$('#headerForm')[0].reset()">Reset</button>
                <button type="button" class="btn btn-primary px-4" onclick="proceedToDetails()">Next</button>
            </div>
        </div>

        <!-- STAGE 2: ITEM DETAILS -->
        <div class="card shadow-sm" id="step2-items" style="display: none;">
            <div class="card-body bg-light border-bottom">
                <div class="row text-center text-md-left">
                    <div class="col-md-4 mb-2 mb-md-0">
                        <small class="text-muted d-block">Receipt Number</small>
                        <strong id="dispReceiptNumber">Will be generated upon save</strong>
                    </div>
                    <div class="col-md-4 mb-2 mb-md-0">
                        <small class="text-muted d-block">Receiving Store</small>
                        <strong id="dispStore">IPOH MALL STORE</strong>
                    </div>
                    <div class="col-md-4">
                        <small class="text-muted d-block">Supplier</small>
                        <strong id="dispSupplier">SUPP WON INDENT NON TAX</strong>
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
                            <th>Item</th>
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
            
            <div class="card-footer bg-light d-flex justify-content-end" id="actionFooter">
                <button type="button" class="btn btn-outline-secondary mr-2" onclick="window.history.back()">Cancel</button>
                <button type="button" class="btn btn-primary px-4" onclick="saveDocument()">Save</button>
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

<script>
var docId = new URLSearchParams(window.location.search).get('id');
var currentStatus = '';

var currentReceivedBatchInfo = [];
var activeItemRowIndex = -1;

var mockItemDetails = [
    { no: 1, itemCode: '100152275', itemName: 'ITEM WON INDENT GENERAL 1', qtyAvail: 110.00, uom: 'UNIT', reqQty: 22.00, recvQty: 22.00, batches: [] }
];

document.addEventListener('configLoaded', function() {
    var now = new Date();
    now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
    document.getElementById('hCreatedDate').value = now.toISOString().slice(0,16);

    if (docId) {
        // Edit/View Mode
        loadDocument(docId);
    }
});

function proceedToDetails() {
    if (!$('#headerForm')[0].checkValidity()) {
        $('#headerForm')[0].reportValidity();
        return;
    }
    
    // Simulate finding the Request and getting items
    $('#dispStore').text($('#hStore option:selected').text());
    
    $('#step1-header').hide();
    $('#step2-items').show();
    
    renderItems();
}

function renderItems() {
    var tbody = $('#itemTableBody');
    tbody.empty();
    
    mockItemDetails.forEach((item, index) => {
        var inputState = (currentStatus === 'RELEASED') ? 'disabled' : '';
        var linkState = (currentStatus === 'RELEASED') ? 'text-muted' : 'text-primary';
        
        var row = `<tr>
            <td class="text-center">\${item.no}</td>
            <td>
                <div>\${item.itemCode}</div>
                <small class="text-muted">\${item.itemName}</small>
            </td>
            <td class="text-right">\${item.qtyAvail.toFixed(6)}</td>
            <td class="text-center">\${item.uom}</td>
            <td class="text-right bg-light font-weight-bold">\${item.reqQty.toFixed(6)}</td>
            <td class="text-center align-middle">
                <div>
                    <input type="number" class="form-control form-control-sm text-right mx-auto received-qty" 
                        style="width:100px" value="\${item.recvQty.toFixed(6)}" \${inputState}
                        onchange="updateMainQty(\${index}, this.value)">
                </div>
                <div class="mt-1">
                    <a href="javascript:void(0)" class="\${linkState} small font-weight-bold" onclick="openBatchModal(\${index})" style="text-decoration:none;">
                        <i class="fas fa-edit"></i> Batch Details
                    </a>
                </div>
            </td>
        </tr>`;
        tbody.append(row);
    });
}

function updateMainQty(index, val) {
    mockItemDetails[index].recvQty = parseFloat(val) || 0;
}

function openBatchModal(index) {
    if (currentStatus === 'RELEASED') {
        AppUtils.showToast("Cannot edit batch info for RELEASED document.", "warning");
        return;
    }
    
    activeItemRowIndex = index;
    var item = mockItemDetails[index];
    currentReceivedBatchInfo = JSON.parse(JSON.stringify(item.batches || [])); // clone
    
    $('#batchModalTitle').text('Batch Details - ' + item.itemCode);
    renderBatchRows();
    $('#batchModal').modal('show');
}

function renderBatchRows() {
    var tbody = $('#batchTable tbody');
    tbody.empty();
    
    var total = 0;
    currentReceivedBatchInfo.forEach((b, i) => {
        total += parseFloat(b.qty) || 0;
        var row = `<tr>
            <td><input type="text" class="form-control form-control-sm border-0" value="\${b.batchNo}" onchange="updateBatchField(\${i}, 'batchNo', this.value)"></td>
            <td><input type="date" class="form-control form-control-sm border-0" value="\${b.expiry}" onchange="updateBatchField(\${i}, 'expiry', this.value)"></td>
            <td><input type="number" class="form-control form-control-sm border-0 text-right" value="\${b.qty}" onchange="updateBatchField(\${i}, 'qty', this.value); renderBatchRows();"></td>
            <td class="text-center"><i class="fas fa-trash-alt text-danger" style="cursor:pointer" onclick="removeBatchRow(\${i})"></i></td>
        </tr>`;
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
    var item = mockItemDetails[activeItemRowIndex];
    item.batches = currentReceivedBatchInfo;
    var total = currentReceivedBatchInfo.reduce((sum, b) => sum + (parseFloat(b.qty)||0), 0);
    if(total > 0) {
        item.recvQty = total;
        renderItems(); // update main input
    }
    $('#batchModal').modal('hide');
}

function loadDocument(id) {
    // Mock getting document details
    var isReleased = id == 1; // Assuming id 1 is released from list mock
    currentStatus = isReleased ? 'RELEASED' : 'HELD';
    
    $('#breadcrumbDocNumber').text('Doc #' + (id === 1 ? '000100006295' : '000100006294'));
    $('#dispReceiptNumber').text(id === 1 ? '000100006295' : '000100006294');
    
    $('#headerStatusBadge').text(currentStatus)
        .removeClass('badge-warning').addClass(currentStatus === 'RELEASED' ? 'badge-success' : 'badge-warning');
    $('#topActions').show();
    
    if(isReleased) {
        // Read-only mode
        $('#headerForm :input').prop('disabled', true);
        $('#actionFooter').hide(); // Hide save button
    }
    
    // Jump to step 2 visually
    $('#step1-header').hide();
    $('#step2-items').show();
    
    // Assuming mockItemDetails is populated from API
    renderItems();
}

function saveDocument() {
    if (currentStatus === 'RELEASED') return;
    AppUtils.showToast("Document saved with status HELD.", "success");
    currentStatus = 'HELD';
    $('#topActions').show();
    $('#headerStatusBadge').text('HELD').removeClass('badge-success').addClass('badge-warning');
    setTimeout(() => { window.location.href = '/consignment/receiving'; }, 1500);
}

function printSlip() {
    var id = docId || 1;
    window.open('/consignment/receiving/print?id=' + id, '_blank');
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
