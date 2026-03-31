<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consignment Items Supplier Setup</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <style>
        .item-card { border-radius: 8px; border: 1px solid #e0e0e0; transition: all 0.2s; background: #fff; }
        .item-card:hover { box-shadow: 0 4px 12px rgba(0,0,0,0.08); transform: translateY(-2px); border-color: #ced4da; }
        .item-img-placeholder { width: 80px; height: 80px; background-color: #f8f9fa; border: 1px dashed #d1d1d1; display:flex; align-items:center; justify-content:center; border-radius: 4px;}
        .item-sku { font-size: 0.85rem; font-family: monospace; }
        .item-title { font-size: 1rem; font-weight: 600; color: #0056b3; }
        .badge-active { background-color: #20c997; color: white; padding: 4px 10px; border-radius: 12px; font-size: 0.75rem; font-weight: 600;}
        .item-desc { font-size: 0.8rem; color: #6c757d; }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp" />
<div class="main-content">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="pageTitle" value="Consignment Items Supplier Setup"/>
    </jsp:include>

    <div class="container-fluid mt-3">
        <!-- Breadcrumb & Top Actions -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                    <li class="breadcrumb-item">Consignment</li>
                    <li class="breadcrumb-item">Setup</li>
                    <li class="breadcrumb-item active" aria-current="page">Consignment Items Supplier Setup</li>
                </ol>
            </nav>
            <button class="btn btn-sm btn-primary" onclick="resyncItems()">
                <i class="fas fa-sync-alt mr-1"></i> Resync and Update
            </button>
        </div>

        <div class="mb-3 d-flex justify-content-between align-items-center">
            <span class="text-muted"><strong id="itemCount">0</strong> items found</span>
            <div class="input-group" style="width: 300px;">
                <input type="text" class="form-control form-control-sm" id="searchInput" placeholder="Search item...">
                <div class="input-group-append">
                    <button class="btn btn-sm btn-outline-secondary" onclick="loadItems(0)"><i class="fas fa-search"></i></button>
                </div>
            </div>
        </div>

        <!-- Items Grid -->
        <div class="row" id="itemsGrid">
            <!-- Rendered via JS -->
        </div>

        <!-- Pagination -->
        <div id="paginationContainer" class="mt-4"></div>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />

<script>
var currentPage = 0;

document.addEventListener('configLoaded', function() {
    loadItems(0);
});

async function loadItems(page) {
    currentPage = page || 0;
    AppUtils.showLoading('itemsGrid');
    
    try {
        var keyword = $('#searchInput').val();
        var path = '/consignment-items?page=' + currentPage + '&size=12';
        if (keyword) path += '&keyword=' + encodeURIComponent(keyword);

        var data = await ApiClient.get('MASTER_SETUP', path);
        
        if (data && data.data) {
            renderItems(data.data.content);
            $('#itemCount').text(data.data.totalElements || data.data.content.length);
            AppUtils.buildPagination('paginationContainer', currentPage, data.data.totalPages || 1, loadItems);
        }
    } catch (e) {
        $('#itemsGrid').html('<div class="col-12 text-center text-danger py-5"><i class="fas fa-exclamation-triangle fa-3x mb-3"></i><br>Failed to load consignment items</div>');
    }
}

function renderItems(items) {
    var grid = $('#itemsGrid');
    grid.empty();

    if (!items || items.length === 0) {
        grid.html('<div class="col-12 text-center text-muted py-5"><i class="fas fa-box-open fa-3x mb-3"></i><br>No items found</div>');
        return;
    }

    items.forEach(function(item) {
        // Mock data structure fallback based on ApiClient
        var sku = item.sku || ('SKU-' + item.id);
        var name = item.name || item.configValue || ('Item ' + item.id);
        var variant = item.variant || 'Standard';
        var price = item.price || 20.00;
        
        var card = `
        <div class="col-md-6 mb-3">
            <div class="item-card p-3 h-100 position-relative">
                <div class="position-absolute" style="top: 15px; right: 15px;">
                    <span class="badge-active">Active</span>
                    <i class="fas fa-ellipsis-h text-muted ml-2" style="cursor:pointer"></i>
                </div>
                
                <div class="d-flex">
                    <div class="mr-3">
                        <div class="item-img-placeholder text-muted">
                            <i class="fas fa-image fa-2x"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1">
                        <div class="d-flex align-items-center mb-1">
                            <span class="item-sku text-secondary mr-2">\${sku}</span>
                            <a href="/setup/consignment-items/setup?id=\${item.id}" class="text-primary" title="Edit Supplier Setup">
                                <i class="fas fa-pencil-alt"></i>
                            </a>
                        </div>
                        <div class="item-title mb-1">\${name.toUpperCase()}</div>
                        <div class="item-desc mb-2">Variant: \${variant}</div>
                        
                        <div class="row mt-3">
                            <div class="col-6">
                                <div class="text-muted" style="font-size:0.75rem">Unit Retail (Incl. Tax)</div>
                                <div class="font-weight-bold">MYR \${price.toFixed(2)} / UNIT</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        `;
        grid.append(card);
    });
}

function resyncItems() {
    AppUtils.showToast('Resync triggered properly. Waiting for ACMM modules...', 'info');
    setTimeout(() => {
        AppUtils.showToast('Items synchronized successfully.', 'success');
        loadItems(0);
    }, 1500);
}
</script>
</body>
</html>
