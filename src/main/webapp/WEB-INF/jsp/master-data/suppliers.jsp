<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"><jsp:param name="title" value="Suppliers"/></jsp:include>
<jsp:include page="../common/sidebar.jsp"><jsp:param name="pageTitle" value="Supplier Management"/></jsp:include>

<main class="main-content fade-in">
    <div class="content-header">
        <div>
            <h5><i class="fas fa-truck mr-2 text-primary"></i>Suppliers</h5>
            <small class="text-muted">Master Data / Suppliers</small>
        </div>
    </div>

    <div class="card">
        <div class="card-header bg-white">
            <div class="row align-items-center">
                <div class="col-md-4">
                    <label class="mb-0 small">Company</label>
                    <select class="form-control form-control-sm" id="filterCompany" onchange="onCompanyChange()">
                        <option value="">Select Company</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="mb-0 small">Store</label>
                    <select class="form-control form-control-sm" id="filterStore" onchange="loadData()" disabled>
                        <option value="">Select Store</option>
                    </select>
                </div>
                <div class="col-md-4 d-flex align-items-end">
                    <button class="btn btn-sm btn-outline-secondary" onclick="resetFilters()">
                        <i class="fas fa-redo mr-1"></i>Reset
                    </button>
                </div>
            </div>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0" id="suppliersTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Supplier Code</th>
                        <th>Company</th>
                        <th>Store</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td colspan="5" class="text-center py-4 text-muted">Select filters to load suppliers</td></tr>
                </table>
        </div>
        <div class="card-footer bg-white"></div>
    </div>
</main>

<jsp:include page="../common/footer.jsp"/>
<script>
document.addEventListener('configLoaded', function() {
    if (!Auth.requireAuth()) return;
    initFilters();
});

async function initFilters() {
    try {
        // Load companies for filter dropdown
        var response = await ApiClient.get('CONSIGNMENT', '/master-data/companies');
        var companies = response.data || response || [];
        
        var options = '<option value="">Select Company</option>';
        companies.forEach(function(company) {
            options += '<option value="' + company + '">' + company + '</option>';
        });
        $('#filterCompany').html(options);
        
        // Check URL params for pre-selected values
        var urlParams = new URLSearchParams(window.location.search);
        var companyParam = urlParams.get('company');
        var storeParam = urlParams.get('store');
        if (companyParam) {
            $('#filterCompany').val(companyParam);
        }
        
        loadData();
    } catch (e) {
        console.error('Failed to load companies:', e);
        loadData();
    }
}

async function onCompanyChange() {
    var company = $('#filterCompany').val();
    $('#filterStore').html('<option value="">Select Store</option>').prop('disabled', !company);
    $('#suppliersTable tbody').html('<tr><td colspan="5" class="text-center py-4 text-muted">Select Store</td></tr>');
    if (company) {
        try {
            var response = await ApiClient.get('CONSIGNMENT', '/master-data/stores?company=' + encodeURIComponent(company));
            var stores = response.data || response || [];
            
            var options = '<option value="">Select Store</option>';
            stores.forEach(function(store) {
                options += '<option value="' + store + '">' + store + '</option>';
            });
            $('#filterStore').html(options);
        } catch (e) {
            console.error('Failed to load stores:', e);
        }
    }
}

async function loadData() {
    var company = $('#filterCompany').val();
    var store = $('#filterStore').val();
    
    if (!company || !store) {
        $('#suppliersTable tbody').html('<tr><td colspan="5" class="text-center py-4 text-muted">Please select Company and Store</td></tr>');
        return;
    }
    
    try {
        var url = '/master-data/suppliers?company=' + encodeURIComponent(company) + '&store=' + encodeURIComponent(store);
        var response = await ApiClient.get('CONSIGNMENT', url);
        var data = response.data || response || [];
        renderTable(data, company, store);
    } catch (e) {
        $('#suppliersTable tbody').html('<tr><td colspan="5" class="text-center text-muted py-4">Failed to load data</td></tr>');
        console.error('Failed to load suppliers:', e);
    }
}

}

 function renderTable(items, company, store) {
    if (!items || items.length === 0) {
        $('#suppliersTable tbody').html('<tr><td colspan="5" class="text-center text-muted py-4">No data available</td></tr>');
        return;
    }
    
    var html = '';
            items.forEach(function(item, index) {
                html += '<tr>' +
                    '<td>' + (index + 1) + '</td>' +
                    '<td><span class="font-weight-semibold">' + item + '</span></td>' +
                    '<td>' + company+ '</td>' +
                    '<td>' + store+ '</td>' +
                    '<td class="text-center">' +
                        '<button class="btn btn-sm btn-outline-info btn-action" title="View Contracts" onclick="viewContracts(\'' + company + '\', \'' + store + '\')">' +
                            window.location.href = '/master-data/contracts?company=' + encodeURIComponent(company) + '&store=' + encodeURIComponent(store);
                                + '&supplierCode=' + encodeURIComponent(supplierCode);
                            });
                        });
                    }
                </script>
            });
        }
    }
</main>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>
