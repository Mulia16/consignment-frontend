var ApiClient = {
    request: async function(serviceName, path, options = {}) {
        if (API_CONFIG.isDevMode()) {
            console.log(`[DEV MODE BYPASS] Fetch intercepted: ${serviceName}${path}`, options);
            return this.getMockResponse(serviceName, path, options.method || 'GET');
        }

        var url = API_CONFIG.getUrl(serviceName, path);
        var token = Auth.getToken();
        
        var headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' };
        if (token) headers['Authorization'] = 'Bearer ' + token;
        if (options.headers) Object.assign(headers, options.headers);
        options.headers = headers;

        try {
            var response = await fetch(url, options);

            if (response.status === 401) {
                var refreshed = await this.refreshToken();
                if (refreshed) {
                    options.headers['Authorization'] = 'Bearer ' + Auth.getToken();
                    response = await fetch(url, options);
                } else {
                    Auth.logout();
                    throw new Error("Session expired");
                }
            }

            if (!response.ok) {
                var errorData = await response.json().catch(() => ({}));
                var msg = errorData.message || 'API request failed';
                AppUtils.showToast(msg, 'danger');
                throw new Error(msg);
            }

            return await response.json();
        } catch (error) {
            console.error('API Error:', error);
            throw error;
        }
    },

    get: function(serviceName, path) { return this.request(serviceName, path, { method: 'GET' }); },
    post: function(serviceName, path, body) { return this.request(serviceName, path, { method: 'POST', body: JSON.stringify(body) }); },
    put: function(serviceName, path, body) { return this.request(serviceName, path, { method: 'PUT', body: JSON.stringify(body) }); },
    delete: function(serviceName, path) { return this.request(serviceName, path, { method: 'DELETE' }); },

    refreshToken: async function() {
        var refresh = Auth.getRefreshToken();
        if (!refresh) return false;

        try {
            var url = API_CONFIG.getUrl('AUTH', '/refresh');
            var response = await fetch(url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ refreshToken: refresh })
            });

            if (response.ok) {
                var data = await response.json();
                if (data.success && data.data) {
                    Auth.setSession(data.data.accessToken, data.data.refreshToken, Auth.getUser());
                    return true;
                }
            }
            return false;
        } catch (error) {
            return false;
        }
    },

    // Mock data for Dev Mode (Slicing)
    getMockResponse: function(serviceName, path, method) {
        return new Promise((resolve) => {
            setTimeout(() => {
                let mockData = { success: true, data: { content: [], totalElements: 0, totalPages: 1 } };
                
                if (method === 'GET' && path.includes('?')) {
                    mockData.data.content = this.generateMockItems(serviceName, path, 15);
                    mockData.data.totalElements = 45;
                    mockData.data.totalPages = 3;
                } else if (method === 'GET' && serviceName === 'MASTER_SETUP' && path === '/dashboard/summary') {
                    mockData = { success: true, data: {
                        totalProducts: 1250, totalSuppliers: 45, lowStockItems: 12, pendingOrders: 8,
                        recentActivities: [
                            { description: 'PO-2024-001 created', timeStr: '10 mins ago' },
                            { description: 'Stock updated for Paracetamol', timeStr: '1 hour ago' },
                            { description: 'New supplier added: MediCare Ltd', timeStr: '2 hours ago' }
                        ]
                    }};
                }
                
                resolve(mockData);
            }, 300); // simulate latency
        });
    },

    generateMockItems: function(serviceName, path, count) {
        let items = [];
        for (let i = 1; i <= count; i++) {
            let item = { id: i, status: 'ACTIVE' };
            if (serviceName === 'MASTER_SETUP') {
                if (path.includes('consignment-items')) {
                    item.sku = '1001082' + (40+i); item.name = 'CANDY CONCESS ITEM ' + String.fromCharCode(64+i); item.variant = 'Merchandize > Candy'; item.price = 20.00 + i;
                } else if (path.includes('product')) {
                    item.sku = 'SKU-100' + i; item.name = 'Sample Item ' + i; item.category = 'Category A'; item.price = 99.99; item.stock = 50;
                } else if (path.includes('supplier')) {
                    item.supplierCode = 'SUP-0' + i; item.supplierName = 'Supplier ' + i; item.contactPerson = 'John Doe'; item.phone = '555-010' + i;
                } else if (path.includes('warehouse')) {
                    item.warehouseCode = 'WH-0' + i; item.warehouseName = 'Warehouse ' + i; item.location = 'Zone ' + (i%5+1); item.capacity = 1000;
                } else {
                    item.configKey = 'KEY_' + i; item.configValue = 'Value ' + i; item.description = 'Config Description ' + i; item.category = 'SYSTEM';
                    item.dataType = 'TYPE_' + i; item.dataCode = 'CODE_' + i; item.dataValue = 'Value ' + i;
                }
            } else if (serviceName === 'TRANSACTION') {
                if (path.includes('stock-balance') || path.includes('stock-movement')) {
                    item.productName = 'Product ' + i; item.warehouseName = 'Main WH'; item.quantityOnHand = 100; item.quantityReserved = 10; item.quantityAvailable = 90; item.unit = 'PCS';
                    item.movementDate = '2024-03-31'; item.movementType = i%2==0 ? 'IN' : 'OUT'; item.quantity = 50; item.fromWarehouse = 'Supplier'; item.toWarehouse = 'Main WH';
                } else if (path.includes('purchase-order') || path.includes('goods-receipt')) {
                    item.poNumber = 'PO-2024-' + (1000+i); item.supplierName = 'Supplier ' + i; item.poDate = '2024-03-31'; item.totalItems = 5; item.totalAmount = 1500.00; item.status = ['DRAFT','APPROVED','RECEIVED'][i%3];
                    item.grNumber = 'GR-2024-' + (1000+i); item.poReference = 'PO-' + (i); item.receiptDate = '2024-03-31';
                } else if (path.includes('sales-order') || path.includes('delivery')) {
                    item.soNumber = 'SO-2024-' + (1000+i); item.customerName = 'Customer ' + i; item.orderDate = '2024-03-31'; item.totalItems = 3; item.totalAmount = 750.00; item.status = ['DRAFT','CONFIRMED','SHIPPED'][i%3];
                    item.doNumber = 'DO-2024-' + (1000+i); item.soReference = 'SO-' + (i); item.deliveryDate = '2024-04-01'; item.driverName = 'Driver ' + i;
                } else if (path.includes('return') || path.includes('adjustment')) {
                    item.returnNumber = 'RET-2024-' + (1000+i); item.returnType = 'RETURN_TO_SUPPLIER'; item.referenceNo = 'INV-' + i; item.reason = 'Defective'; item.returnDate = '2024-03-31'; item.totalItems = 2; item.status = 'COMPLETED';
                    item.adjustmentNumber = 'ADJ-2024-' + (1000+i); item.productName = 'Product ' + i; item.warehouseName = 'WH ' + i; item.adjustmentType = 'DECREASE'; item.quantity = 5; item.adjustmentDate = '2024-03-31';
                } else if (path.includes('transaction')) {
                    item.receiptNumber = 'RCP-2024-' + (1000+i); item.transactionDate = '2024-03-31 14:30'; item.cashierName = 'Cashier ' + (i%3+1); item.totalItems = 4; item.totalAmount = 250.00; item.paymentMethod = 'CASH'; item.status = 'COMPLETED';
                }
            } else if (serviceName === 'SETTLEMENT') {
                item.settlementNumber = 'STL-2024-' + (1000+i); item.period = '2024-03'; item.partnerName = 'Partner ' + i; item.totalSales = 5000.00; item.commissionAmount = 500.00; item.netAmount = 4500.00; item.status = ['DRAFT','SUBMITTED','APPROVED','SETTLED'][i%4];
                item.paymentNumber = 'PAY-2024-' + (1000+i); item.settlementReference = 'STL-' + i; item.amount = 4500.00; item.paymentDate = '2024-04-05'; item.paymentMethod = 'BANK_TRANSFER';
            } else if (serviceName === 'TRACE_LOG') {
                item.timestamp = '2024-03-31 10:00:00'; item.username = 'admin'; item.action = ['CREATE','UPDATE','DELETE','LOGIN'][i%4]; item.entityType = 'Product'; item.entityId = '10' + i; item.ipAddress = '192.168.1.' + i; item.details = 'Action performed successfully';
            }
            items.push(item);
        }
        return items;
    }
};
window.ApiClient = ApiClient;
