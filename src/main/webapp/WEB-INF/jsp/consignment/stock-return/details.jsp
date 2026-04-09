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
                        <div class="col-md-6 mb-3">
                            <label class="small text-muted mb-1">Supplier <span class="text-danger">*</span></label>
                            <select class="form-control" name="supplierCode" id="supplierCode" required>
                                <option value="">Select Supplier</option>
                            </select>
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
<script src="/static/js/services/consignment-service.js"></script>
<script src="/static/js/consignment-master-data.js"></script>

<script>
var isReleased = false; // Mock status flag

document.addEventListener('configLoaded', function() {
    ConsignmentMasterData.init();
    
    var urlParams = new URLSearchParams(window.location.search);
    var id = urlParams.get('id');

    if (id) {
        document.getElementById('breadcrumbAction').textContent = 'Return No: ' + (1130 + parseInt(id));
        document.getElementById('headerTitle').textContent = 'Document Details';
        document.getElementById('btnNext').classList.add('d-none');
        document.getElementById('btnSave').classList.remove('d-none');
        
        // Mock logic: if ID is 3, simulate "Released" status 
        if (id === '3') {
            isReleased = true;
            document.getElementById('thActualQuantity').classList.remove('d-none');
            document.getElementById('btnAddRow').classList.add('d-none');
            document.getElementById('thAction').classList.add('d-none');
        }
        
        showItemDetails();
        
        // Load mock initial data
        loadMockItem();
    } else {
        document.getElementById('breadcrumbAction').textContent = 'Add New';
        document.getElementById('headerTitle').textContent = 'Add New - Header';
        addEmptyRow();
    }
});

function showItemDetails() {
    document.getElementById('itemsCard').classList.remove('d-none');
    document.getElementById('btnNext').classList.add('d-none');
    document.getElementById('btnSave').classList.remove('d-none');
}

function loadMockItem() {
    var tbody = document.getElementById('itemsTableBody');
    tbody.innerHTML = '';
    
    var tr = document.createElement('tr');
    tr.innerHTML = `
        <td class="text-center align-middle">1</td>
        <td>
            <select class="form-control form-control-sm" name="itemCode" \${isReleased ? 'disabled' : ''}>
                <option value="100201185">100201185 - HL SMOOTH HAIR CONDITIONER</option>
            </select>
        </td>
        <td class="align-middle">1 UNIT</td>
        <td>
            <input type="number" class="form-control form-control-sm text-right" name="quantity" value="1.000000" \${isReleased ? 'disabled' : ''} />
        </td>
    `;
    if (isReleased) {
        tr.innerHTML += `<td><input type="number" class="form-control form-control-sm text-right" name="actualQuantity" value="0.000000" /></td>`;
    }
    tr.innerHTML += `
        <td>
            <input type="text" class="form-control form-control-sm" name="batchId" placeholder="Batch ID" value="0" \${isReleased ? 'disabled' : ''} />
        </td>
        <td>
            <input type="date" class="form-control form-control-sm" name="expiryDate" value="9999-12-31" \${isReleased ? 'disabled' : ''} />
        </td>
    `;
    if (!isReleased) {
        tr.innerHTML += `<td class="text-center align-middle"><button type="button" class="btn btn-sm text-danger" onclick="this.closest('tr').remove()"><i class="fas fa-trash"></i></button></td>`;
    }
    tbody.appendChild(tr);
}

function addEmptyRow() {
    var tbody = document.getElementById('itemsTableBody');
    var rowCount = tbody.rows.length + 1;
    
    var tr = document.createElement('tr');
    tr.innerHTML = `
        <td class="text-center align-middle">\${rowCount}</td>
        <td>
            <select class="form-control form-control-sm" name="itemCode">
                <option value="">Select Item</option>
            </select>
        </td>
        <td class="align-middle">-</td>
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
    var values = ConsignmentMasterData.getValues();
    if (values.company && values.store && values.supplier && values.contract) {
        ConsignmentMasterData.loadItems(values.company, values.store, values.supplier, values.contract);
    }
}

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

    var formData = new FormData(form);
    
    var items = [];
    var rows = document.querySelectorAll('#itemsTableBody tr');
    
    rows.forEach(function(tr) {
        var itemCode = tr.querySelector('select[name="itemCode"]').value;
        var quantity = tr.querySelector('input[name="quantity"]') ? parseFloat(tr.querySelector('input[name="quantity"]').value) : 0;
        var batchId = tr.querySelector('input[name="batchId"]') ? tr.querySelector('input[name="batchId"]').value : '';
        var expiryDate = tr.querySelector('input[name="expiryDate"]') ? tr.querySelector('input[name="expiryDate"]').value : null;
        
        if (itemCode && quantity > 0) {
            items.push({
                itemCode: itemCode,
                uom: "UNIT",
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
        createdBy: "SYSTEM",
        items: items
    };

    try {
        var urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('id')) {
            // Already created, but API doesn't support generic PUT for CSR header right now.
            // Mock success for edit view if API isn't available
            AppUtils.showToast("Actual quantity update isn't fully wired for generic update", 'warning');
            btn.disabled = false;
            btn.innerHTML = originalBtnText;
        } else {
            await ConsignmentService.createCSR(payload);
            AppUtils.showToast('Document created successfully!', 'success');
            setTimeout(function() {
                window.location.href = '/consignment/stock-return';
            }, 1500);
        }
    } catch (e) {
        console.error('Error saving CSR:', e);
        AppUtils.showToast('Failed to save document. Please check the network log.', 'error');
        btn.disabled = false;
        btn.innerHTML = originalBtnText;
    }
}
</script>

</body>
</html>
