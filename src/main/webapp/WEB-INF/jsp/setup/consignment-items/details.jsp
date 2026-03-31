<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Item Supplier Setup</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
<div class="main-content">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="pageTitle" value="Item Supplier Setup"/>
    </jsp:include>

    <div class="container-fluid mt-3">
        <!-- Breadcrumb & Top Actions -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                    <li class="breadcrumb-item"><a href="/setup/consignment-items">Setup</a></li>
                    <li class="breadcrumb-item active" aria-current="page" id="breadcrumbItemName">Loading...</li>
                </ol>
            </nav>
            <button class="btn btn-sm btn-secondary" onclick="window.history.back()">Back to List</button>
        </div>

        <div class="row">
            <!-- Sidebar Navigation Form -->
            <div class="col-md-3">
                <div class="card">
                    <div class="card-body p-0">
                        <div class="list-group list-group-flush">
                            <a href="#" class="list-group-item list-group-item-action font-weight-bold border-0"><i class="fas fa-circle text-success mr-2"></i> General (Completed)</a>
                            <a href="#" class="list-group-item list-group-item-action font-weight-bold active"><i class="fas fa-circle text-primary mr-2"></i> Consignment Supplier</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Content -->
            <div class="col-md-9">
                <h4 id="itemHeaderTitle" class="mb-4">Loading Item...</h4>

                <!-- External Suppliers -->
                <div class="card mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold text-dark">External Consignment Suppliers</h6>
                        <button class="btn btn-sm btn-primary" onclick="openSupplierModal('External')">Add Supplier</button>
                    </div>
                    <div class="card-body p-0">
                        <table class="table table-hover mb-0" id="extSupplierTable">
                            <thead class="bg-light">
                                <tr>
                                    <th>Supplier</th>
                                    <th>Store</th>
                                    <th width="120" class="text-right">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- JS Render -->
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Internal Suppliers -->
                <div class="card mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold text-dark">Internal Consignment Suppliers</h6>
                        <button class="btn btn-sm btn-primary" onclick="openSupplierModal('Internal')">Add Supplier</button>
                    </div>
                    <div class="card-body p-0">
                        <table class="table table-hover mb-0" id="intSupplierTable">
                            <thead class="bg-light">
                                <tr>
                                    <th>Supplier</th>
                                    <th>Store</th>
                                    <th width="120" class="text-right">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- JS Render -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add/Edit Supplier Modal -->
<div class="modal fade" id="supplierModal" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="supplierModalTitle">New External Consignment Supplier</h5>
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
            </div>
            <div class="modal-body">
                <form id="supplierForm">
                    <input type="hidden" id="supplierType">
                    <input type="hidden" id="supplierSetupId">
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label>Supplier <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="formSupplier" required placeholder="Search supplier...">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Supplier Contract <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="formContract" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Branch <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="formBranch" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label>Purchase Method</label>
                            <input type="text" class="form-control bg-light" value="Consignment" readonly>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Supplier Item Code</label>
                            <input type="text" class="form-control" id="formSupplierItemCode">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label>Qty Per Case</label>
                            <input type="text" class="form-control bg-light" id="formQtyPerCase" value="1" readonly>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label>Factor</label>
                            <input type="text" class="form-control bg-light" id="formFactor" value="1.000000" readonly>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label>Order Unit</label>
                            <select class="form-control" id="formOrderUnit">
                                <option value="1" selected>1</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label>Order Unit Description</label>
                            <input type="text" class="form-control bg-light" id="formOrderDesc" value="UNIT" readonly>
                        </div>
                    </div>

                    <hr class="mt-4 mb-4">
                    
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="font-weight-bold m-0">Consignee</h6>
                        <button type="button" class="btn btn-sm btn-dark" onclick="addConsigneeRow()">Add Row</button>
                    </div>

                    <table class="table table-bordered table-sm" id="consigneeTable">
                        <thead class="bg-light">
                            <tr>
                                <th>Consignee Company <span class="text-danger">*</span></th>
                                <th>Consignee Store <span class="text-danger">*</span></th>
                                <th width="60" class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Dynamic Rows -->
                        </tbody>
                    </table>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="saveSupplier()">Save</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />

<script>
var currentItemId = new URLSearchParams(window.location.search).get('id');

document.addEventListener('configLoaded', function() {
    loadItemDetails();
    loadSupplierSetups();
});

async function loadItemDetails() {
    try {
        var data = await ApiClient.get('MASTER_SETUP', '/products/' + currentItemId);
        if (data && data.data) {
            var item = data.data;
            var name = item.productName || item.name || 'CANDY CONCESS ITEM';
            var sku = item.productCode || item.sku || currentItemId;
            $('#breadcrumbItemName').text(name);
            $('#itemHeaderTitle').text(sku + ' - ' + name.toUpperCase());
            // Map values to form read-only fields
            $('#formQtyPerCase').val(1);
            $('#formFactor').val('1.000000');
        }
    } catch (e) {
        AppUtils.showToast('Failed to load item info', 'danger');
    }
}

async function loadSupplierSetups() {
    // Calling mock endpoint to retrieve connected setups
    try {
        var data = await ApiClient.get('MASTER_SETUP', '/item-supplier-setup/' + currentItemId);
        var setups = (data && data.data) ? data.data : getMockSetups();
        
        var extBody = $('#extSupplierTable tbody');
        var intBody = $('#intSupplierTable tbody');
        extBody.empty();
        intBody.empty();

        setups.forEach(s => {
            var row = `<tr>
                <td>\${s.supplierName}<br><small class="text-muted">\${s.supplierCode}</small></td>
                <td>
                    <small>
                        \${s.consignees.map(c => '<b>' + c.company + '</b><br>' + c.store).join('<br><br>')}
                    </small>
                </td>
                <td class="text-right">
                    <button class="btn btn-sm btn-link" onclick="editSupplierSetup('\${s.id}')">Edit</button>
                </td>
            </tr>`;

            if (s.type === 'External') extBody.append(row);
            else intBody.append(row);
        });

        if (extBody.children().length === 0) extBody.html('<tr><td colspan="3" class="text-center text-muted">No external supplier mapped</td></tr>');
        if (intBody.children().length === 0) intBody.html('<tr><td colspan="3" class="text-center text-muted">No internal supplier mapped</td></tr>');

    } catch (e) {
        console.error(e);
    }
}

function openSupplierModal(type) {
    $('#supplierModalTitle').text('New ' + type + ' Consignment Supplier');
    $('#supplierType').val(type);
    $('#supplierSetupId').val('');
    $('#supplierForm')[0].reset();
    $('#consigneeTable tbody').empty();
    addConsigneeRow();
    $('#supplierModal').modal('show');
}

function addConsigneeRow() {
    var raw = `<tr>
        <td><input type="text" class="form-control form-control-sm" placeholder="Wildcard company..."></td>
        <td><input type="text" class="form-control form-control-sm" placeholder="Multi-select / Range / Empty"></td>
        <td class="text-center align-middle">
            <i class="fas fa-trash-alt text-danger" style="cursor:pointer" onclick="$(this).closest('tr').remove()"></i>
        </td>
    </tr>`;
    $('#consigneeTable tbody').append(raw);
}

async function editSupplierSetup(id) {
    // SLICING VALIDATION DEMO
    var hasPending = confirm('SIMULATION CHECK: Does this item have pending consignment transactions? \n(Click OK to simulate YES, Cancel for NO)');
    if (hasPending) {
        alert("Cannot edit: There are pending uncompleted consignment transactions.");
        return;
    }

    var isZeroized = confirm('SIMULATION CHECK: Are all inventories for this supplier zeroized? \n(Click OK for ZERO, Cancel for NOT zero)');
    if (!isZeroized) {
        alert("Cannot edit: Consignment inventory (Supplier book value, unpost sales, etc) is NOT zeroized.");
        return;
    }

    // Pass checks -> Open edit
    openSupplierModal('External');
    $('#supplierModalTitle').text('Edit Consignment Supplier');
    $('#supplierSetupId').val(id);
    AppUtils.showToast("Edit mode unlocked.", "success");
}

async function saveSupplier() {
    // Validate empty consignees
    if($('#consigneeTable tbody tr').length === 0) {
        alert("At least one consignee company & store must be defined.");
        return;
    }

    // Assuming form is valid, simulate saving
    var body = {
        itemId: currentItemId,
        type: $('#supplierType').val(),
        supplier: $('#formSupplier').val()
        // other fields mapping...
    };

    try {
        await ApiClient.post('MASTER_SETUP', '/item-supplier-setup', body);
        AppUtils.showToast('Supplier setup saved successfully', 'success');
        $('#supplierModal').modal('hide');
        loadSupplierSetups();
    } catch (e) {
        console.error(e);
    }
}

// Temporary Mock Data Generation for the layout
function getMockSetups() {
    return [
        {
            id: 'S1', type: 'External', supplierName: '0000040114 - D KSH (M) SDN BHD', supplierCode: 'MC-00001',
            consignees: [ { company: '001 - ALPRO PHARMACY SDN BHD', store: 'ALL' } ]
        },
        {
            id: 'S2', type: 'Internal', supplierName: '001 - ALPRO PHARMACY SDN BHD', supplierCode: '1001',
            consignees: [ { company: '001 - ALPRO PHARMACY SDN BHD', store: '0837 - Serai' } ]
        }
    ];
}
</script>
</body>
</html>
