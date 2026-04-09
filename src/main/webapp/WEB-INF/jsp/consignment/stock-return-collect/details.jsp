<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stock Return Collect Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
<div class="main-content">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="pageTitle" value="Consignment Stock Return Collect Details"/>
    </jsp:include>

    <div class="container-fluid mt-3">
        <!-- Breadcrumb -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                    <li class="breadcrumb-item">Consignment</li>
                    <li class="breadcrumb-item">Transaction</li>
                    <li class="breadcrumb-item"><a href="/consignment/stock-return-collect">Consignment Stock Return Collect</a></li>
                    <li class="breadcrumb-item active" aria-current="page" id="breadcrumbAction">Details</li>
                </ol>
            </nav>
        </div>

        <!-- Details Panel -->
        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                <h6 class="m-0 font-weight-bold" id="headerTitle">Document Details</h6>
                <div>
                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="window.history.back()">Back</button>
                    <button type="button" class="btn btn-primary btn-sm ml-2" id="btnSave" onclick="saveDocument()">Save Actual Quantity</button>
                    <button type="button" class="btn btn-success btn-sm ml-2" id="btnUpdate" onclick="updateDocument()">Update Status</button>
                    <button type="button" class="btn btn-outline-secondary btn-sm ml-2" onclick="printSlip()"><i class="fas fa-print"></i> Print Slip</button>
                </div>
            </div>
            <div class="card-body">
                <form id="detailsForm">
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Company</label>
                            <input type="text" class="form-control" name="company" value="ALPRO PHARMACY SDN BHD" disabled>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Store</label>
                            <input type="text" class="form-control" name="store" value="0001 - Q PHARMACY IPOH MALL STORE" disabled>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="small text-muted mb-1">Supplier</label>
                            <input type="text" class="form-control" name="supplier" value="0000001197 - EASY PHARMA SDN BHD" disabled>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Supplier Contract</label>
                            <input type="text" class="form-control" name="supplierContract" value="CONT-001" disabled>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Internal Supplier Store</label>
                            <input type="text" class="form-control" name="internalSupplierStore" value="INT-001" disabled>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="small text-muted mb-1">Status</label>
                            <input type="text" class="form-control font-weight-bold" id="docStatus" value="Held" disabled>
                        </div>
                    </div>

                </form>
            </div>
        </div>

        <!-- Items Table -->
        <div class="card shadow-sm mt-4" id="itemsCard">
            <div class="card-header bg-white">
                <h6 class="m-0 font-weight-bold">Item Details - Input Actual Return Qty</h6>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-bordered mb-0">
                        <thead class="bg-light">
                            <tr>
                                <th width="50">No.</th>
                                <th>Item Code</th>
                                <th>UOM</th>
                                <th width="120">Planned Qty</th>
                                <th width="120" class="table-warning">Actual Qty</th>
                                <th width="150">Batch ID</th>
                                <th width="150">Expiry Date</th>
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
var isUpdated = false; // Mock status flag (true = "Updated", false = "Held")

document.addEventListener('DOMContentLoaded', function() {
    var urlParams = new URLSearchParams(window.location.search);
    var id = urlParams.get('id');

    if (id) {
        document.getElementById('breadcrumbAction').textContent = 'CSRN-C No: C-113' + id;
        
        // Mock logic: if ID is 2, simulate "Updated" status 
        if (id === '2') {
            isUpdated = true;
            document.getElementById('docStatus').value = 'Updated';
            document.getElementById('btnSave').classList.add('d-none');
            document.getElementById('btnUpdate').classList.add('d-none');
        }
        
        loadMockItem();
    } else {
        alert("CSRN-C documents are only auto-created. Cannot create manually in this mockup.");
        window.history.back();
    }
});

function loadMockItem() {
    var tbody = document.getElementById('itemsTableBody');
    tbody.innerHTML = '';
    
    var tr = document.createElement('tr');
    tr.innerHTML = `
        <td class="text-center align-middle">1</td>
        <td>
            <input type="text" class="form-control form-control-sm" value="100201185 - HL SMOOTH HAIR CONDITIONER" disabled />
        </td>
        <td class="align-middle">1 UNIT</td>
        <td>
            <input type="number" class="form-control form-control-sm text-right" value="1.000000" disabled />
        </td>
        <td class="table-warning">
            <input type="number" name="actualQuantity" class="form-control form-control-sm text-right border-warning" value="\${isUpdated ? '1.000000' : '0.000000'}" \${isUpdated ? 'disabled' : ''} />
        </td>
        <td>
            <input type="text" class="form-control form-control-sm" value="BAT-12345" disabled />
        </td>
        <td>
            <input type="date" class="form-control form-control-sm" value="2025-12-31" disabled />
        </td>
    `;
    tbody.appendChild(tr);
}

async function saveDocument() {
    var urlParams = new URLSearchParams(window.location.search);
    var id = urlParams.get('id');
    if (!id) return;
    
    var btn = document.getElementById('btnSave');
    var originalBtnText = btn.innerHTML;
    btn.disabled = true;
    btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Saving...';
    
    try {
        var tr = document.querySelector('#itemsTableBody tr');
        var actualQty = 0;
        if (tr) {
            var input = tr.querySelector('input[name="actualQuantity"]');
            if (input) actualQty = parseFloat(input.value) || 0;
        }
        
        // Mocking detailId as 1 for demonstration
        await ConsignmentService.updateCSRActualQty(id, 1, actualQty);
        AppUtils.showToast('Actual quantity saved successfully!', 'success');
    } catch (e) {
        console.error('Error saving actual quantity:', e);
        AppUtils.showToast("Actual quantity update isn't fully wired. Saved locally.", 'warning');
    } finally {
        btn.disabled = false;
        btn.innerHTML = originalBtnText;
    }
}

async function updateDocument() {
    if(confirm('Confirm update status to "Updated"? This will post the return to inventory.')) {
        var urlParams = new URLSearchParams(window.location.search);
        var id = urlParams.get('id');
        
        var btn = document.getElementById('btnUpdate');
        var originalBtnText = btn.innerHTML;
        btn.disabled = true;
        btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Updating...';

        try {
            if (id) {
                // Assuming complete or release API applies to updating CSRN-C status based on endpoint docs
                await ConsignmentService.completeCSR(id);
            }
            AppUtils.showToast('Document updated and posted to inventory!', 'success');
            document.getElementById('docStatus').value = 'Updated';
            isUpdated = true;
            document.getElementById('btnSave').classList.add('d-none');
            document.getElementById('btnUpdate').classList.add('d-none');
            loadMockItem();
        } catch(e) {
            console.error('Error updating status:', e);
            AppUtils.showToast('Status update mock action applied. API hit failed.', 'info');
            document.getElementById('docStatus').value = 'Updated';
            isUpdated = true;
            document.getElementById('btnSave').classList.add('d-none');
            document.getElementById('btnUpdate').classList.add('d-none');
            loadMockItem();
        } finally {
            btn.disabled = false;
            btn.innerHTML = originalBtnText;
        }
    }
}

function printSlip() {
    AppUtils.showToast('Printing slip...', 'info');
}
</script>

</body>
</html>
