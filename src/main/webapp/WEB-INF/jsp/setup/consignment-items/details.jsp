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

                <!-- Item Information Card -->
                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <h6 class="m-0 font-weight-bold text-dark"><i class="fas fa-box mr-2"></i>Item Information</h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4 mb-2">
                                <small class="text-muted d-block">Item Code</small>
                                <span class="font-weight-bold" id="infoItemCode">-</span>
                            </div>
                            <div class="col-md-4 mb-2">
                                <small class="text-muted d-block">Item Name</small>
                                <span id="infoItemName">-</span>
                            </div>
                            <div class="col-md-4 mb-2">
                                <small class="text-muted d-block">Hierarchy</small>
                                <span id="infoHierarchy">-</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-2">
                                <small class="text-muted d-block">Variant</small>
                                <span id="infoVariant">-</span>
                            </div>
                            <div class="col-md-4 mb-2">
                                <small class="text-muted d-block">Item Model</small>
                                <span id="infoItemModel">-</span>
                            </div>
                            <div class="col-md-4 mb-2">
                                <small class="text-muted d-block">Category</small>
                                <span id="infoCategory">-</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-2">
                                <small class="text-muted d-block">Unit Retail</small>
                                <span id="infoUnitRetail">-</span>
                            </div>
                            <div class="col-md-4 mb-2">
                                <small class="text-muted d-block">MVC</small>
                                <span id="infoMvc">-</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- External Suppliers -->
                <div class="card mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold text-dark"><i class="fas fa-truck mr-2"></i>External Consignment Suppliers</h6>
                        <button class="btn btn-sm btn-primary" onclick="openSupplierModal('External')"><i class="fas fa-plus mr-1"></i>Add Supplier</button>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0" id="extSupplierTable">
                                <thead class="bg-light">
                                    <tr>
                                        <th>Supplier Code</th>
                                        <th>Contract Number</th>
                                        <th>Consignee Company</th>
                                        <th>Consignee Store</th>
                                        <th class="text-center">Inventory Qty</th>
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

                <!-- Internal Suppliers -->
                <div class="card mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold text-dark"><i class="fas fa-building mr-2"></i>Internal Consignment Suppliers</h6>
                        <button class="btn btn-sm btn-primary" onclick="openSupplierModal('Internal')"><i class="fas fa-plus mr-1"></i>Add Supplier</button>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0" id="intSupplierTable">
                                <thead class="bg-light">
                                    <tr>
                                        <th>Supplier Code</th>
                                        <th>Supplier Store</th>
                                        <th>Consignee Company</th>
                                        <th>Consignee Store</th>
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
                            <label>Supplier Code <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="formSupplier" required placeholder="Enter supplier code...">
                        </div>
                        <div class="col-md-4 mb-3" id="contractFieldGroup">
                            <label>Contract Number <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="formContract" placeholder="Enter contract number...">
                        </div>
                        <div class="col-md-4 mb-3" id="branchFieldGroup">
                            <label>Supplier Store <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="formBranch" placeholder="Enter supplier store...">
                        </div>
                    </div>
                    <div class="row" id="purchaseMethodRow">
                        <div class="col-md-4 mb-3">
                            <label>Purchase Method</label>
                            <input type="text" class="form-control bg-light" value="Consignment" readonly>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Supplier Item Code</label>
                            <input type="text" class="form-control" id="formSupplierItemCode">
                        </div>
                    </div>
                    <div class="row" id="unitDetailRow">
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
                        <button type="button" class="btn btn-sm btn-dark" onclick="addConsigneeRow()"><i class="fas fa-plus mr-1"></i>Add Row</button>
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
                <button type="button" class="btn btn-primary" onclick="saveSupplier()"><i class="fas fa-save mr-1"></i>Save</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />

<!-- Consignment Service -->
<script src="/static/js/services/consignment-service.js"></script>

<script>
var currentItemCode = new URLSearchParams(window.location.search).get('code');

document.addEventListener('configLoaded', function() {
    loadItemDetails();
});

function displayVal(val) {
    return (val !== null && val !== undefined && val !== '') ? val : '-';
}

async function loadItemDetails() {
    try {
        var response = await ConsignmentService.getSetupItem(currentItemCode);
        if (response && response.data) {
            var item = response.data;
            
            // Store item data for later use
            window.currentItem = item;

            // Update breadcrumb and header
            var itemName = displayVal(item.itemName);
            var itemCode = item.itemCode || currentItemCode;
            $('#breadcrumbItemName').text(itemCode);
            $('#itemHeaderTitle').text(itemCode + (item.itemName ? ' - ' + item.itemName : ''));

            // Populate item info card
            $('#infoItemCode').text(displayVal(item.itemCode));
            $('#infoItemName').text(displayVal(item.itemName));
            $('#infoHierarchy').html(item.hierarchy 
                ? '<span class="badge badge-' + (item.hierarchy === 'CONSIGNMENT' ? 'primary' : 'secondary') + '">' + item.hierarchy + '</span>' 
                : '-');
            $('#infoVariant').text(displayVal(item.variant));
            $('#infoItemModel').text(displayVal(item.itemModel));
            $('#infoCategory').text(displayVal(item.category));
            $('#infoUnitRetail').text(item.unitRetail !== null ? Number(item.unitRetail).toFixed(2) : '-');
            $('#infoMvc').text(item.mvc !== null ? Number(item.mvc).toFixed(2) : '-');

            // Now render supplier tables
            renderSupplierTables(item);
        }
    } catch (e) {
        console.error('Failed to load item details:', e);
        AppUtils.showToast('Failed to load item details', 'danger');
    }
}

function renderSupplierTables(item) {
    var extSuppliers = item.externalSuppliers || [];
    var intSuppliers = item.internalSuppliers || [];
    
    var extBody = $('#extSupplierTable tbody');
    var intBody = $('#intSupplierTable tbody');
    extBody.empty();
    intBody.empty();

    // Render external suppliers
    if (extSuppliers.length > 0) {
        extSuppliers.forEach(function(s) {
            var row = '<tr>' +
                '<td><span class="font-weight-bold">' + displayVal(s.supplierCode) + '</span></td>' +
                '<td>' + displayVal(s.contractNumber) + '</td>' +
                '<td>' + displayVal(s.consigneeCompany) + '</td>' +
                '<td>' + displayVal(s.consigneeStore) + '</td>' +
                '<td class="text-center"><span class="badge badge-light">' + (s.currentInventoryQty !== null ? s.currentInventoryQty : 0) + '</span></td>' +
                '<td class="text-right">' +
                    '<button class="btn btn-sm btn-outline-primary mr-1" onclick="editSupplierSetup(\'' + s.id + '\', \'External\')" title="Edit"><i class="fas fa-edit"></i></button>' +
                    '<button class="btn btn-sm btn-outline-danger" onclick="deleteSupplierSetup(\'' + s.id + '\', \'External\')" title="Delete"><i class="fas fa-trash-alt"></i></button>' +
                '</td>' +
            '</tr>';
            extBody.append(row);
        });
    } else {
        extBody.html('<tr><td colspan="6" class="text-center text-muted py-3"><i class="fas fa-inbox mr-2"></i>No external supplier mapped</td></tr>');
    }

    // Render internal suppliers
    if (intSuppliers.length > 0) {
        intSuppliers.forEach(function(s) {
            var row = '<tr>' +
                '<td><span class="font-weight-bold">' + displayVal(s.supplierCode) + '</span></td>' +
                '<td>' + displayVal(s.supplierStore) + '</td>' +
                '<td>' + displayVal(s.consigneeCompany) + '</td>' +
                '<td>' + displayVal(s.consigneeStore) + '</td>' +
                '<td class="text-right">' +
                    '<button class="btn btn-sm btn-outline-primary mr-1" onclick="editSupplierSetup(\'' + s.id + '\', \'Internal\')" title="Edit"><i class="fas fa-edit"></i></button>' +
                    '<button class="btn btn-sm btn-outline-danger" onclick="deleteSupplierSetup(\'' + s.id + '\', \'Internal\')" title="Delete"><i class="fas fa-trash-alt"></i></button>' +
                '</td>' +
            '</tr>';
            intBody.append(row);
        });
    } else {
        intBody.html('<tr><td colspan="5" class="text-center text-muted py-3"><i class="fas fa-inbox mr-2"></i>No internal supplier mapped</td></tr>');
    }
}

function openSupplierModal(type) {
    var isExternal = (type === 'External');
    
    $('#supplierModalTitle').text('New ' + type + ' Consignment Supplier');
    $('#supplierType').val(type);
    $('#supplierSetupId').val('');
    $('#supplierForm')[0].reset();
    $('#consigneeTable tbody').empty();
    
    // Toggle fields based on supplier type
    if (isExternal) {
        $('#contractFieldGroup').show();
        $('#branchFieldGroup').hide();
        $('#purchaseMethodRow').show();
        $('#unitDetailRow').show();
        $('#formContract').prop('required', true);
        $('#formBranch').prop('required', false);
    } else {
        $('#contractFieldGroup').hide();
        $('#branchFieldGroup').show();
        $('#purchaseMethodRow').hide();
        $('#unitDetailRow').hide();
        $('#formContract').prop('required', false);
        $('#formBranch').prop('required', true);
    }
    
    addConsigneeRow();
    $('#supplierModal').modal('show');
}

function addConsigneeRow() {
    var raw = '<tr>' +
        '<td><input type="text" class="form-control form-control-sm" placeholder="Enter consignee company..."></td>' +
        '<td><input type="text" class="form-control form-control-sm" placeholder="Enter consignee store..."></td>' +
        '<td class="text-center align-middle">' +
            '<i class="fas fa-trash-alt text-danger" style="cursor:pointer" onclick="$(this).closest(\'tr\').remove()"></i>' +
        '</td>' +
    '</tr>';
    $('#consigneeTable tbody').append(raw);
}

function editSupplierSetup(id, type) {
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

    // Find the supplier data from currentItem
    var item = window.currentItem || {};
    var supplier = null;
    
    if (type === 'External') {
        var extList = item.externalSuppliers || [];
        supplier = extList.find(function(s) { return s.id === id; });
    } else {
        var intList = item.internalSuppliers || [];
        supplier = intList.find(function(s) { return s.id === id; });
    }

    if (!supplier) {
        AppUtils.showToast('Supplier data not found', 'danger');
        return;
    }

    // Open the modal
    openSupplierModal(type);
    $('#supplierModalTitle').text('Edit ' + type + ' Consignment Supplier');
    $('#supplierSetupId').val(id);

    // Pre-fill form
    $('#formSupplier').val(supplier.supplierCode || '');
    
    if (type === 'External') {
        $('#formContract').val(supplier.contractNumber || '');
    } else {
        $('#formBranch').val(supplier.supplierStore || '');
    }

    // Pre-fill consignee table
    $('#consigneeTable tbody').empty();
    if (supplier.consigneeCompany || supplier.consigneeStore) {
        var row = '<tr>' +
            '<td><input type="text" class="form-control form-control-sm" value="' + (supplier.consigneeCompany || '') + '"></td>' +
            '<td><input type="text" class="form-control form-control-sm" value="' + (supplier.consigneeStore || '') + '"></td>' +
            '<td class="text-center align-middle">' +
                '<i class="fas fa-trash-alt text-danger" style="cursor:pointer" onclick="$(this).closest(\'tr\').remove()"></i>' +
            '</td>' +
        '</tr>';
        $('#consigneeTable tbody').append(row);
    } else {
        addConsigneeRow();
    }

    AppUtils.showToast("Edit mode unlocked.", "success");
}

async function deleteSupplierSetup(id, type) {
    if (!confirm('Are you sure you want to delete this supplier setup?')) {
        return;
    }

    try {
        if (type === 'External') {
            await ConsignmentService.deleteExternalSupplierSetup(currentItemCode, id);
        } else {
            await ConsignmentService.deleteInternalSupplierSetup(currentItemCode, id);
        }
        AppUtils.showToast('Supplier setup deleted successfully', 'success');
        // Reload item details to refresh tables
        loadItemDetails();
    } catch (e) {
        console.error('Failed to delete supplier setup:', e);
        AppUtils.showToast('Failed to delete supplier setup', 'danger');
    }
}

async function saveSupplier() {
    // Validate empty consignees
    if ($('#consigneeTable tbody tr').length === 0) {
        alert("At least one consignee company & store must be defined.");
        return;
    }

    var supplierType = $('#supplierType').val();
    var supplierSetupId = $('#supplierSetupId').val();

    // Get consignee data from first row
    var firstRow = $('#consigneeTable tbody tr:first');
    var consigneeCompany = firstRow.find('td:eq(0) input').val();
    var consigneeStore = firstRow.find('td:eq(1) input').val();

    if (!consigneeCompany || !consigneeStore) {
        alert("Consignee Company and Consignee Store are required.");
        return;
    }

    try {
        if (supplierType === 'External') {
            var body = {
                supplierCode: $('#formSupplier').val(),
                supplierType: 'EXTERNAL',
                contractNumber: $('#formContract').val(),
                consigneeCompany: consigneeCompany,
                consigneeStore: consigneeStore,
                currentInventoryQty: 0
            };

            if (supplierSetupId) {
                await ConsignmentService.updateExternalSupplierSetup(currentItemCode, supplierSetupId, body);
            } else {
                await ConsignmentService.createExternalSupplierSetup(currentItemCode, body);
            }
        } else {
            // Internal supplier
            var body = {
                supplierCode: $('#formSupplier').val(),
                supplierStore: $('#formBranch').val(),
                consigneeCompany: consigneeCompany,
                consigneeStore: consigneeStore
            };

            if (supplierSetupId) {
                await ConsignmentService.updateInternalSupplierSetup(currentItemCode, supplierSetupId, body);
            } else {
                await ConsignmentService.createInternalSupplierSetup(currentItemCode, body);
            }
        }

        AppUtils.showToast('Supplier setup saved successfully', 'success');
        $('#supplierModal').modal('hide');
        // Reload item details to refresh tables
        loadItemDetails();
    } catch (e) {
        console.error('Failed to save supplier setup:', e);
        AppUtils.showToast('Failed to save supplier setup', 'danger');
    }
}
</script>
</body>
</html>
