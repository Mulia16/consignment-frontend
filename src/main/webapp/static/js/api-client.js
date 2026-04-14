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
        options.cache = 'no-store'; // Prevent browser from caching GET requests

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
                // Default response structure matching actual API
                let mockData = { message: 'success', status: 200, data: [], meta: { page: 1, perPage: 20, totalData: 0, totalPage: 1 } };
                
                if (path.includes('/master-data/')) {
                    if (path.includes('/companies')) mockData.data = ["COMP01", "COMP02", "COMP03"];
                    else if (path.includes('/stores')) mockData.data = ["STORE01", "STORE02", "STORE03"];
                    else if (path.includes('/suppliers')) mockData.data = ["SUPP001", "SUPP002", "SUPP003"];
                    else if (path.includes('/contracts')) mockData.data = ["CONTRACT-2024-001", "CONTRACT-2024-002"];
                    else if (path.includes('/items')) mockData.data = ["ITEM001", "ITEM002", "ITEM003", "ITEM004"];
                    
                    mockData.meta.totalData = mockData.data.length;
                    mockData.meta.totalPage = 1;
                } else if (method === 'POST' && path.includes('/customer-billing/compute')) {
                    mockData = {
                        message: 'Customer billing request computed',
                        status: 201,
                        data: {
                            id: 'cbr-uuid-' + Date.now(),
                            docNo: 'CBR-' + String(Math.floor(Math.random() * 10000)).padStart(5, '0'),
                            periodType: 'MONTHLY',
                            fromDate: '2026-04-01',
                            toDate: '2026-04-30',
                            store: 'STORE01',
                            customerCode: null,
                            status: 'HELD',
                            processStatus: 'COMPLETED',
                            createdBy: 'admin',
                            releasedAt: null,
                            details: [
                                { id: 'detail-uuid-001', customerCode: null, itemCode: 'ITEM001', uom: 'PCS', salesQty: 24.5, returnQty: 0.0, billingQty: 24.5, unitPrice: 15000000.0, lineAmount: 367500000.0, actualReturnQty: null },
                                { id: 'detail-uuid-002', customerCode: null, itemCode: 'ITEM002', uom: 'PCS', salesQty: 25.0, returnQty: 0.0, billingQty: 25.0, unitPrice: 10000000.0, lineAmount: 250000000.0, actualReturnQty: null }
                            ]
                        }
                    };
                } else if (method === 'GET' && path.includes('/customer-billing/failed')) {
                    // Failed CBR list
                    mockData.data = [];
                    var companies = ['Alpro Pharmacy SDN BHD', 'HealthMart SDN BHD', 'MediCare Malaysia'];
                    var stores = ['1001', '1002', '1003', '1004', '1005'];
                    var customers = ['0000000659 - BLUE SKY SJ', '0000000660 - RED SEA KL', '0000000661 - GREEN VALLEY', '0000000662 - GOLDEN GATE', '0000000663 - SILVER LINING'];
                    var errors = ['Insufficient inventory tracking data', 'Cost mapping misaligned', 'Missing supplier contract reference', 'Duplicate billing period detected', 'Price discrepancy in item mapping'];
                    for (var fi = 1; fi <= 10; fi++) {
                        mockData.data.push({
                            id: 'failed-cbr-uuid-' + fi,
                            docNo: 'CBR-' + String(9000 + fi).padStart(5, '0'),
                            company: companies[fi % companies.length],
                            store: stores[fi % stores.length],
                            customerCode: customers[fi % customers.length],
                            fromDate: '2026-04-01',
                            toDate: '2026-04-30',
                            periodType: 'MONTHLY',
                            errorReason: errors[fi % errors.length],
                            processStatus: 'FAILED',
                            status: 'HELD',
                            createdBy: 'admin',
                            createdAt: '2026-04-' + String(10 + fi).padStart(2, '0') + 'T10:' + String(10 + fi).padStart(2, '0') + ':00Z'
                        });
                    }
                    mockData.meta.totalData = 10;
                    mockData.meta.totalPage = 1;
                } else if (method === 'GET' && path.includes('/customer-billing/') && !path.includes('/customer-billing?')) {
                    // Get by ID - return single item with details
                    var mockId = path.split('/customer-billing/')[1];
                    mockData = {
                        message: 'success',
                        status: 200,
                        data: {
                            id: mockId,
                            docNo: 'CBR-00001',
                            periodType: 'MONTHLY',
                            fromDate: '2026-04-01',
                            toDate: '2026-04-30',
                            store: 'STORE01',
                            customerCode: null,
                            status: 'HELD',
                            processStatus: 'COMPLETED',
                            createdBy: 'admin',
                            releasedAt: null,
                            details: [
                                { id: 'detail-uuid-001', customerCode: null, itemCode: 'ITEM001', uom: 'PCS', salesQty: 24.5, returnQty: 0.0, billingQty: 24.5, unitPrice: 15000000.0, lineAmount: 367500000.0, actualReturnQty: null },
                                { id: 'detail-uuid-002', customerCode: null, itemCode: 'ITEM002', uom: 'PCS', salesQty: 25.0, returnQty: 0.0, billingQty: 25.0, unitPrice: 10000000.0, lineAmount: 250000000.0, actualReturnQty: null }
                            ]
                        }
                    };
                } else if (method === 'GET' && path.includes('?')) {
                    mockData.data = this.generateMockItems(serviceName, path, 15);
                    mockData.meta.totalData = 45;
                    mockData.meta.totalPage = 3;
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
            
            // CONSIGNMENT Service - All consignment-related endpoints
            if (serviceName === 'CONSIGNMENT') {
                // Consignment Setup Items
                if (path.includes('consignment-setup') || path.includes('consignment-items')) {
                    item.itemCode = 'ITEM-' + (1000 + i);
                    item.itemName = 'Consignment Item ' + i;
                    item.variant = ['16GB/256GB', '32GB/512GB', '64GB/1TB'][i % 3];
                    item.hierarchy = ['CONSIGNMENT', 'OUTRIGHT'][i % 2];
                    item.itemModel = 'MODEL-' + (100 + i);
                    item.unitRetail = 1000000 + (i * 100000);
                    item.mvc = 800000 + (i * 80000);
                    item.category = ['Electronics', 'Fashion', 'Home'][i % 3];
                    item.externalSuppliers = [
                        {
                            id: 'ext-sup-' + i + '-1',
                            supplierCode: 'SUP-' + (100 + i),
                            supplierType: 'EXTERNAL',
                            contractNumber: 'CONTRACT-2024-' + (1000 + i),
                            consigneeCompany: 'COMP01',
                            consigneeStore: 'STORE01',
                            currentInventoryQty: 0
                        }
                    ];
                    item.internalSuppliers = [];
                }
                // CSA - Consignment Stock Adjustment
                else if (path.includes('/csa')) {
                    item.id = 'csa-' + (1000 + i) + '-mock-id';
                    item.docNo = 'CSA-' + String(1000 + i).padStart(5, '0');
                    item.company = 'COMP01';
                    item.store = 'STORE01';
                    item.supplierCode = 'SUPP001';
                    item.supplierContract = 'CONTRACT-2024-' + (1000 + i);
                    item.transactionType = ['ADJ_IN', 'ADJ_OUT'][i % 2];
                    item.referenceNo = i % 2 === 0 ? 'REF-' + (1000 + i) : null;
                    item.reasonCode = ['RECOUNT', 'DAMAGE', 'LOSS', 'CORRECTION'][i % 4];
                    item.remark = null;
                    item.createFrom = null;
                    item.status = ['HELD', 'RELEASED'][i % 2];
                    item.createdBy = 'admin';
                    item.releasedAt = i % 2 === 1 ? '2024-03-31T12:00:00Z' : null;
                    item.releasedBy = i % 2 === 1 ? 'admin' : null;
                    item.createdAt = '2024-03-31T10:00:00Z';
                    item.updatedAt = '2024-03-31T10:00:00Z';
                    item.items = [
                        {
                            id: 'csa-item-' + i + '-mock-id',
                            itemCode: 'ITEM001',
                            itemName: 'Laptop Pro 15',
                            qty: (i * 2) + 0.0000,
                            uom: 'PCS',
                            settlementDecision: item.transactionType === 'ADJ_IN' ? 'DIRECT_BV_INCREASE' : 'DIRECT_BV_DECREASE'
                        }
                    ];
                }
                // CSO - Consignment Stock Out
                else if (path.includes('/cso')) {
                    item.id = 'CSO-' + (1000 + i);
                    item.docNo = 'CSO-2024-' + (1000 + i);
                    item.company = 'COMP-01';
                    item.store = 'STORE-' + i;
                    item.customerCode = 'CUST-' + (100 + i);
                    item.supplierCode = 'SUP-' + (100 + i);
                    item.status = ['DRAFT', 'RELEASED', 'COMPLETED'][i % 3];
                    item.createdAt = '2024-03-31T10:00:00Z';
                }
                // CSR - Consignment Stock Return
                else if (path.includes('/csr')) {
                    item.id = 'CSR-' + (1000 + i);
                    item.docNo = 'CSR-2024-' + (1000 + i);
                    item.company = 'COMP-01';
                    item.store = 'STORE-' + i;
                    item.supplierCode = 'SUP-' + (100 + i);
                    item.status = ['DRAFT', 'RELEASED', 'COMPLETED'][i % 3];
                    item.createdAt = '2024-03-31T10:00:00Z';
                }
                // CSRQ - Consignment Stock Requisition
                else if (path.includes('/csrq')) {
                    item.id = 'CSRQ-' + (1000 + i);
                    item.docNo = 'CSRQ-2024-' + (1000 + i);
                    item.company = 'COMP-01';
                    item.store = 'STORE-' + i;
                    item.supplierCode = 'SUP-' + (100 + i);
                    item.status = ['DRAFT', 'RELEASED', 'COMPLETED'][i % 3];
                    item.createdAt = '2024-03-31T10:00:00Z';
                }
                // CSRV - Consignment Stock Receive
                else if (path.includes('/csrv')) {
                    item.id = 'csrv-' + (1000 + i) + '-mock-id';
                    item.docNo = 'CSRV-' + String(1000 + i).padStart(8, '0');
                    item.company = 'COMP01';
                    item.receivingStore = 'STORE01';
                    item.supplierCode = 'SUPP001';
                    item.supplierContract = 'CONTRACT-2024-' + (1000 + i);
                    item.branch = null;
                    item.supplierDoNo = 'DO-2024-' + (100 + i);
                    item.deliveryDate = '2024-01-15';
                    item.remark = null;
                    item.status = ['HELD', 'RELEASED'][i % 2];
                    item.createdBy = 'user01';
                    item.createdMethod = ['MANUAL', 'AUTO'][i % 2];
                    item.referenceNo = i % 2 === 0 ? 'REF-' + (1000 + i) : null;
                    item.releasedAt = i % 2 === 1 ? '2024-01-15T09:00:00Z' : null;
                    item.createdAt = '2024-01-15T08:00:00Z';
                    item.updatedAt = '2024-01-15T08:00:00Z';
                    item.items = [
                        {
                            id: 'item-detail-' + i + '-mock-id',
                            itemCode: 'ITEM001',
                            availableQty: 0.0000,
                            requestQty: 100.0000,
                            receivingQty: 100.0000
                        }
                    ];
                }
                // CSDO - Consignment Stock Delivery Order
                else if (path.includes('/csdo')) {
                    item.id = 'CSDO-' + (1000 + i);
                    item.docNo = 'CSDO-2024-' + (1000 + i);
                    item.company = 'COMP-01';
                    item.store = 'STORE-' + i;
                    item.customerCode = 'CUST-' + (100 + i);
                    item.status = ['DRAFT', 'RELEASED', 'COMPLETED'][i % 3];
                    item.createdAt = '2024-03-31T10:00:00Z';
                }
                // Customer Billing
                else if (path.includes('/customer-billing')) {
                    item.id = 'cbr-uuid-' + (1000 + i);
                    item.docNo = 'CBR-' + String(1000 + i).padStart(5, '0');
                    item.periodType = ['MONTHLY', 'WEEKLY'][i % 2];
                    item.fromDate = '2026-04-01';
                    item.toDate = '2026-04-30';
                    item.store = 'STORE0' + ((i % 3) + 1);
                    item.customerCode = i % 3 === 0 ? null : 'CUST-' + (100 + i);
                    item.status = ['HELD', 'RELEASED'][i % 2];
                    item.processStatus = 'COMPLETED';
                    item.createdBy = 'admin';
                    item.releasedAt = i % 2 === 1 ? '2026-04-13T06:00:00Z' : null;
                    item.details = [
                        {
                            id: 'detail-uuid-' + (1000 + i) + '-1',
                            customerCode: null,
                            itemCode: 'ITEM001',
                            uom: 'PCS',
                            salesQty: 24.5,
                            returnQty: 0.0,
                            billingQty: 24.5,
                            unitPrice: 15000000.0,
                            lineAmount: 367500000.0,
                            actualReturnQty: null
                        },
                        {
                            id: 'detail-uuid-' + (1000 + i) + '-2',
                            customerCode: null,
                            itemCode: 'ITEM002',
                            uom: 'PCS',
                            salesQty: 25.0,
                            returnQty: 0.0,
                            billingQty: 25.0,
                            unitPrice: 10000000.0,
                            lineAmount: 250000000.0,
                            actualReturnQty: null
                        }
                    ];
                }
                // Settlement
                else if (path.includes('/settlement')) {
                    item.id = 'STL-' + (1000 + i);
                    item.docNo = 'STL-2024-' + (1000 + i);
                    item.company = 'COMP-01';
                    item.store = 'STORE-' + i;
                    item.settlementType = ['SUPPLIER', 'CUSTOMER'][i % 2];
                    item.supplierCode = 'SUP-' + (100 + i);
                    item.totalAmount = 5000.00 + (i * 100);
                    item.currency = 'IDR';
                    item.status = ['DRAFT', 'PREPARED', 'BILLED', 'SETTLED'][i % 4];
                    item.createdAt = '2024-03-31T10:00:00Z';
                }
                // Reports
                else if (path.includes('/reports')) {
                    item.docNo = 'RPT-2024-' + (1000 + i);
                    item.documentType = ['CSRQ', 'CSRV', 'CSO', 'CSDO', 'CSR', 'CSA'][i % 6];
                    item.company = 'COMP-01';
                    item.store = 'STORE-' + i;
                    item.supplierCode = 'SUP-' + (100 + i);
                    item.itemCode = 'ITEM-' + (1000 + i);
                    item.qty = 10 + i;
                    item.uom = 'PCS';
                    item.status = 'COMPLETED';
                    item.businessDate = '2024-03-31';
                }
                // Consignments (default)
                else if (path.includes('/consignments')) {
                    item.requestId = 'REQ-' + (1000 + i);
                    item.sku = 'SKU-' + (1000 + i);
                    item.quantity = 10 + i;
                    item.requestStore = 'STORE-' + i;
                    item.supplier = 'SUP-' + (100 + i);
                    item.status = ['PENDING', 'APPROVED', 'REJECTED'][i % 3];
                    item.createdAt = '2024-03-31T10:00:00Z';
                }
                // Master Sync
                else if (path.includes('/master-sync')) {
                    item.syncedCount = 10 + i;
                    item.message = 'Sync completed successfully';
                }
            }
            // INVENTORY Service
            else if (serviceName === 'INVENTORY') {
                item.sku = 'SKU-' + (1000 + i);
                item.available = 100 + (i * 10);
                item.requestedQty = 10;
                item.reserved = i % 2 === 0;
                item.remainingAvailable = 90 + (i * 10);
            }
            // BATCH Service
            else if (serviceName === 'BATCH') {
                item.status = 'COMPLETED';
                item.jobId = 10000 + i;
                item.jobName = 'Batch Job ' + i;
                item.startTime = '2024-03-31T10:00:00Z';
                item.endTime = '2024-03-31T10:05:00Z';
            }
            // AUTH Service
            else if (serviceName === 'AUTH') {
                item.token = 'mock-jwt-token-' + i;
                item.tokenType = 'Bearer';
                item.expiresIn = 86400;
                item.username = 'user' + i;
                item.roles = ['ROLE_USER', 'ROLE_ADMIN'][i % 2];
            }
            
            items.push(item);
        }
        return items;
    }
};
window.ApiClient = ApiClient;
