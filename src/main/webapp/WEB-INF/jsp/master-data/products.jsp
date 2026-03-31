<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Products"/>
</jsp:include>
<jsp:include page="../common/sidebar.jsp">
    <jsp:param name="pageTitle" value="Product Management"/>
</jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div>
            <h5><i class="fas fa-boxes mr-2 text-primary"></i>Products</h5>
            <small class="text-muted">Master Data / Products</small>
        </div>
        <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#productModal" onclick="resetForm()">
            <i class="fas fa-plus mr-1"></i> Add Product
        </button>
    </div>

    <!-- Search -->
    <div class="card mb-3">
        <div class="card-body py-2">
            <div class="row align-items-center">
                <div class="col-md-4">
                    <div class="input-group input-group-sm">
                        <input type="text" class="form-control" id="searchKeyword" placeholder="Search products...">
                        <div class="input-group-append">
                            <button class="btn btn-primary" onclick="searchProducts()"><i class="fas fa-search"></i></button>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 text-right">
                    <button class="btn btn-sm btn-outline-secondary" onclick="loadProducts()"><i class="fas fa-sync-alt mr-1"></i>Refresh</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Table -->
    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="productsTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Product Code</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Unit</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td colspan="8" class="text-center py-4 text-muted">Loading...</td></tr>
                </tbody>
            </table>
        </div>
        <div class="card-footer bg-white" id="productsPagination"></div>
    </div>
</main>

<!-- Product Modal -->
<div class="modal fade" id="productModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="productModalTitle">Add Product</h6>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <form id="productForm">
                <div class="modal-body">
                    <input type="hidden" id="productId">
                    <div class="form-group">
                        <label>Product Code <span class="text-danger">*</span></label>
                        <input type="text" class="form-control form-control-sm" id="productCode" required>
                    </div>
                    <div class="form-group">
                        <label>Product Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control form-control-sm" id="productName" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Category</label>
                                <input type="text" class="form-control form-control-sm" id="productCategory">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Unit</label>
                                <input type="text" class="form-control form-control-sm" id="productUnit" placeholder="e.g. PCS, BOX">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Price</label>
                        <input type="number" class="form-control form-control-sm" id="productPrice" step="0.01">
                    </div>
                    <div class="form-group">
                        <label>Description</label>
                        <textarea class="form-control form-control-sm" id="productDesc" rows="2"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-sm btn-primary"><i class="fas fa-save mr-1"></i>Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>

<script>
var currentPage = 0;

document.addEventListener('configLoaded', function() {
    if (!Auth.requireAuth()) return;
    loadProducts();

    $('#productForm').on('submit', function(e) {
        e.preventDefault();
        saveProduct();
    });
});

async function loadProducts(page) {
    currentPage = page || 0;
    try {
        var data = await ApiClient.get('MASTER_SETUP', '/products?page=' + currentPage + '&size=15');
        if (data && data.data) {
            renderProducts(data.data);
        }
    } catch (e) {
        console.error('Failed to load products:', e);
    }
}

function renderProducts(pagedData) {
    var items = pagedData.content || [];
    var columns = [
        { field: '_index', formatter: function(v, row) { return (currentPage * 15) + items.indexOf(row) + 1; } },
        { field: 'productCode' },
        { field: 'productName' },
        { field: 'category' },
        { field: 'unit' },
        { field: 'price', formatter: function(v) { return AppUtils.formatCurrency(v); } },
        { field: 'active', formatter: function(v) { return v !== false ? '<span class="badge badge-success badge-status">Active</span>' : '<span class="badge badge-secondary badge-status">Inactive</span>'; } }
    ];

    AppUtils.buildTable('productsTable', columns, items, function(row) {
        return '<button class="btn btn-sm btn-outline-info btn-action" onclick="editProduct(' + row.id + ')"><i class="fas fa-edit"></i></button>' +
               '<button class="btn btn-sm btn-outline-danger btn-action" onclick="deleteProduct(' + row.id + ')"><i class="fas fa-trash"></i></button>';
    });

    AppUtils.buildPagination('productsPagination', currentPage, pagedData.totalPages || 1, loadProducts);
}

async function searchProducts() {
    var keyword = $('#searchKeyword').val().trim();
    if (!keyword) { loadProducts(); return; }
    try {
        var data = await ApiClient.get('MASTER_SETUP', '/products/search?keyword=' + encodeURIComponent(keyword));
        if (data && data.data) {
            renderProducts({ content: data.data, totalPages: 1 });
        }
    } catch (e) { console.error(e); }
}

function resetForm() {
    $('#productModalTitle').text('Add Product');
    $('#productForm')[0].reset();
    $('#productId').val('');
}

async function editProduct(id) {
    try {
        var data = await ApiClient.get('MASTER_SETUP', '/products/' + id);
        if (data && data.data) {
            var p = data.data;
            $('#productModalTitle').text('Edit Product');
            $('#productId').val(p.id);
            $('#productCode').val(p.productCode);
            $('#productName').val(p.productName);
            $('#productCategory').val(p.category);
            $('#productUnit').val(p.unit);
            $('#productPrice').val(p.price);
            $('#productDesc').val(p.description);
            $('#productModal').modal('show');
        }
    } catch (e) { console.error(e); }
}

async function saveProduct() {
    var id = $('#productId').val();
    var body = {
        productCode: $('#productCode').val(),
        productName: $('#productName').val(),
        category: $('#productCategory').val(),
        unit: $('#productUnit').val(),
        price: parseFloat($('#productPrice').val()) || 0,
        description: $('#productDesc').val()
    };

    try {
        if (id) {
            await ApiClient.put('MASTER_SETUP', '/products/' + id, body);
            AppUtils.showToast('Product updated successfully', 'success');
        } else {
            await ApiClient.post('MASTER_SETUP', '/products', body);
            AppUtils.showToast('Product created successfully', 'success');
        }
        $('#productModal').modal('hide');
        loadProducts(currentPage);
    } catch (e) { console.error(e); }
}

function deleteProduct(id) {
    AppUtils.confirm('Are you sure you want to delete this product?', async function() {
        try {
            await ApiClient.delete('MASTER_SETUP', '/products/' + id);
            AppUtils.showToast('Product deleted', 'success');
            loadProducts(currentPage);
        } catch (e) { console.error(e); }
    });
}
</script>
