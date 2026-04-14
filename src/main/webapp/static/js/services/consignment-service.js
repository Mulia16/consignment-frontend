/**
 * Consignment Service API Client
 * Handles all consignment-related API calls
 * 
 * Base Path: /api
 * Endpoints: 56 (across 11 sub-modules)
 * See plans/api-endpoint.md for full documentation
 * 
 * Sub-modules:
 * - Consignment Controller: /api/v1/consignments
 * - Consignment Setup: /api/consignment-setup
 * - CSA (Stock Adjustment): /api/csa
 * - CSO (Stock Out): /api/cso
 * - CSR (Stock Return): /api/csr
 * - CSRQ (Stock Requisition): /api/csrq
 * - CSRV (Stock Receive): /api/csrv
 * - CSDO (Delivery Order): /api/csdo
 * - Settlement: /api/settlement
 * - Reports: /api/reports
 * - Master Sync: /api/acmm/master-sync
 */
var ConsignmentService = {

    // ══════════════════════════════════════════════════════════
    // CONSIGNMENT CONTROLLER - /api/v1/consignments
    // ══════════════════════════════════════════════════════════

    /**
     * Request Consignment - Create new consignment request
     * POST /api/v1/consignments/request
     */
    requestConsignment: async function(data) {
        return ApiClient.post('CONSIGNMENT', '/v1/consignments/request', data);
    },

    /**
     * List All Consignments
     * GET /api/v1/consignments
     */
    listConsignments: async function() {
        return ApiClient.get('CONSIGNMENT', '/v1/consignments');
    },

    /**
     * Get Consignment by ID
     * GET /api/v1/consignments/{requestId}
     */
    getConsignment: async function(requestId) {
        return ApiClient.get('CONSIGNMENT', '/v1/consignments/' + requestId);
    },

    /**
     * Update Consignment Status
     * PATCH /api/v1/consignments/{requestId}/status
     */
    updateConsignmentStatus: async function(requestId, data) {
        return ApiClient.request('CONSIGNMENT', '/v1/consignments/' + requestId + '/status', {
            method: 'PATCH',
            body: JSON.stringify(data)
        });
    },

    // ══════════════════════════════════════════════════════════
    // CONSIGNMENT SETUP CONTROLLER - /api/consignment-setup
    // ══════════════════════════════════════════════════════════

    /**
     * List Setup Items with pagination and filters
     * GET /api/consignment-setup/items
     * @param {Object} params - Query parameters (optional)
     * @param {number} params.page - Page number (default: 1)
     * @param {number} params.perPage - Items per page (default: 20)
     * @param {string} params.itemCode - Filter by item code
     * @param {string} params.itemName - Filter by item name
     * @param {string} params.variant - Filter by variant
     * @param {string} params.hierarchy - CONSIGNMENT / OUTRIGHT
     * @param {string} params.categoryL1 - Filter by category L1
     * @param {string} params.categoryL2 - Filter by category L2
     */
    listSetupItems: async function(params = {}) {
        var query = new URLSearchParams();
        if (params.page) query.append('page', params.page);
        if (params.perPage) query.append('perPage', params.perPage);
        if (params.itemCode) query.append('itemCode', params.itemCode);
        if (params.itemName) query.append('itemName', params.itemName);
        if (params.variant) query.append('variant', params.variant);
        if (params.hierarchy) query.append('hierarchy', params.hierarchy);
        if (params.categoryL1) query.append('categoryL1', params.categoryL1);
        if (params.categoryL2) query.append('categoryL2', params.categoryL2);
        
        var queryString = query.toString();
        return ApiClient.get('CONSIGNMENT', '/consignment-setup/items' + (queryString ? '?' + queryString : ''));
    },

    /**
     * Get Item by Code
     * GET /api/consignment-setup/item/{itemCode}
     */
    getSetupItem: async function(itemCode) {
        return ApiClient.get('CONSIGNMENT', '/consignment-setup/item/' + itemCode);
    },

    /**
     * Create Item Setup
     * POST /api/consignment-setup/items
     * @param {Object} data - Item setup data
     * @param {string} data.itemCode - Item code (required)
     * @param {string} data.itemName - Item name (required)
     * @param {string} data.variant - Item variant
     * @param {string} data.hierarchy - CONSIGNMENT / OUTRIGHT
     * @param {string} data.itemModel - Item model
     * @param {number} data.unitRetail - Unit retail price
     * @param {number} data.mvc - MVC value
     * @param {string} data.categoryL1 - Category level 1
     * @param {string} data.categoryL2 - Category level 2
     * @param {string} data.categoryL3 - Category level 3
     */
    createItemSetup: async function(data) {
        return ApiClient.post('CONSIGNMENT', '/consignment-setup/items', data);
    },

    /**
     * Update Item Setup
     * PUT /api/consignment-setup/item/{itemCode}
     * @param {string} itemCode - Item code to update
     * @param {Object} data - Updated item data (same fields as create)
     */
    updateItemSetup: async function(itemCode, data) {
        return ApiClient.put('CONSIGNMENT', '/consignment-setup/item/' + itemCode, data);
    },

    /**
     * Create External Supplier Setup
     * POST /api/consignment-setup/item/{itemCode}/external-supplier
     * @param {string} itemCode - Item code
     * @param {Object} data - Supplier data
     * @param {string} data.supplierCode - Supplier code (required)
     * @param {string} data.supplierType - Supplier type (EXTERNAL)
     * @param {string} data.contractNumber - Contract number
     * @param {string} data.consigneeCompany - Consignee company
     * @param {string} data.consigneeStore - Consignee store
     * @param {number} data.currentInventoryQty - Current inventory qty
     */
    createExternalSupplierSetup: async function(itemCode, data) {
        return ApiClient.post('CONSIGNMENT', '/consignment-setup/item/' + itemCode + '/external-supplier', data);
    },

    /**
     * Update External Supplier Setup
     * PUT /api/consignment-setup/item/{itemCode}/external-supplier/{id}
     */
    updateExternalSupplierSetup: async function(itemCode, id, data) {
        return ApiClient.put('CONSIGNMENT', '/consignment-setup/item/' + itemCode + '/external-supplier/' + id, data);
    },

    /**
     * Delete External Supplier Setup
     * DELETE /api/consignment-setup/item/{itemCode}/external-supplier/{id}
     */
    deleteExternalSupplierSetup: async function(itemCode, id) {
        return ApiClient.delete('CONSIGNMENT', '/consignment-setup/item/' + itemCode + '/external-supplier/' + id);
    },

    /**
     * Create Internal Supplier Setup
     * POST /api/consignment-setup/item/{itemCode}/internal-supplier
     * @param {string} itemCode - Item code
     * @param {Object} data - Supplier data
     * @param {string} data.supplierCode - Supplier code (required)
     * @param {string} data.supplierStore - Supplier store
     * @param {string} data.consigneeCompany - Consignee company
     * @param {string} data.consigneeStore - Consignee store
     */
    createInternalSupplierSetup: async function(itemCode, data) {
        return ApiClient.post('CONSIGNMENT', '/consignment-setup/item/' + itemCode + '/internal-supplier', data);
    },

    /**
     * Update Internal Supplier Setup
     * PUT /api/consignment-setup/item/{itemCode}/internal-supplier/{id}
     */
    updateInternalSupplierSetup: async function(itemCode, id, data) {
        return ApiClient.put('CONSIGNMENT', '/consignment-setup/item/' + itemCode + '/internal-supplier/' + id, data);
    },

    /**
     * Delete Internal Supplier Setup
     * DELETE /api/consignment-setup/item/{itemCode}/internal-supplier/{id}
     */
    deleteInternalSupplierSetup: async function(itemCode, id) {
        return ApiClient.delete('CONSIGNMENT', '/consignment-setup/item/' + itemCode + '/internal-supplier/' + id);
    },

    // ══════════════════════════════════════════════════════════
    // CSA CONTROLLER (Consignment Stock Adjustment) - /api/csa
    // ══════════════════════════════════════════════════════════

    /**
     * Search CSA Documents
     * GET /api/csa
     */
    searchCSA: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/csa' + (query ? '?' + query : ''));
    },

    /**
     * Get CSA by ID
     * GET /api/csa/{id}
     */
    getCSA: async function(id) {
        return ApiClient.get('CONSIGNMENT', '/csa/' + id);
    },

    /**
     * Create CSA Document
     * POST /api/csa
     */
    createCSA: async function(data) {
        return ApiClient.post('CONSIGNMENT', '/csa', data);
    },

    /**
     * Release CSA Document
     * PUT /api/csa/{id}/release
     */
    releaseCSA: async function(id, user) {
        var headers = user ? { 'X-User': user } : {};
        return ApiClient.request('CONSIGNMENT', '/csa/' + id + '/release', {
            method: 'PUT',
            headers: headers
        });
    },

    // ══════════════════════════════════════════════════════════
    // CSO CONTROLLER (Consignment Stock Out) - /api/cso
    // ══════════════════════════════════════════════════════════

    /**
     * Search CSO Documents
     * GET /api/cso
     */
    searchCSO: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/cso' + (query ? '?' + query : ''));
    },

    /**
     * Get CSO by ID
     * GET /api/cso/{id}
     */
    getCSO: async function(id) {
        return ApiClient.get('CONSIGNMENT', '/cso/' + id);
    },

    createCSO: async function(data) {
        return ApiClient.post('CONSIGNMENT', '/cso', data);
    },

    releaseCSO: async function(id, user) {
        var headers = user ? { 'X-User': user } : {};
        return ApiClient.request('CONSIGNMENT', '/cso/' + id + '/release', {
            method: 'PUT',
            headers: headers
        });
    },

    deleteCSO: async function(id) {
        return ApiClient.delete('CONSIGNMENT', '/cso/' + id);
    },

    autoCreateCSO: async function(data) {
        return ApiClient.post('CONSIGNMENT', '/acmm/cso/auto-create', data);
    },

    // ══════════════════════════════════════════════════════════
    // CSRN CONTROLLER (Consignment Stock Return) - /api/csrn
    // ══════════════════════════════════════════════════════════

    /**
     * Search CSRN Documents
     * GET /api/csrn
     */
    searchCSRN: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/csrn' + (query ? '?' + query : ''));
    },

    /**
     * Get CSRN by ID
     * GET /api/csrn/{id}
     */
    getCSRN: async function(id) {
        return ApiClient.get('CONSIGNMENT', '/csrn/' + id);
    },

    /**
     * Create CSRN Document
     * POST /api/csrn
     */
    createCSRN: async function(data) {
        return ApiClient.post('CONSIGNMENT', '/csrn', data);
    },

    /**
     * Update CSRN Document
     * PUT /api/csrn/{id}
     */
    updateCSRN: async function(id, data) {
        return ApiClient.put('CONSIGNMENT', '/csrn/' + id, data);
    },

    /**
     * Release CSRN Document
     * PUT /api/csrn/{id}/release
     */
    releaseCSRN: async function(id) {
        return ApiClient.put('CONSIGNMENT', '/csrn/' + id + '/release', {});
    },

    /**
     * Update Actual Quantity
     * PUT /api/csrn/{id}/detail/{detailId}/actual-qty
     */
    updateCSRNActualQty: async function(id, detailId, actualQty) {
        return ApiClient.put('CONSIGNMENT', '/csrn/' + id + '/detail/' + detailId + '/actual-qty', { actualQty: actualQty });
    },

    /**
     * Complete CSRN Document
     * PUT /api/csrn/{id}/complete
     */
    completeCSRN: async function(id) {
        return ApiClient.put('CONSIGNMENT', '/csrn/' + id + '/complete', {});
    },

    // ══════════════════════════════════════════════════════════
    // CSRN-C CONTROLLER (Consignment Stock Return Collect) - /api/csrn-c
    // ══════════════════════════════════════════════════════════

    /**
     * Search CSRN-C Documents
     * GET /api/csrn-c
     */
    searchCSRNC: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/csrn-c' + (query ? '?' + query : ''));
    },

    /**
     * Get CSRN-C by ID
     * GET /api/csrn-c/{id}
     */
    getCSRNC: async function(id) {
        return ApiClient.get('CONSIGNMENT', '/csrn-c/' + id);
    },

    /**
     * Update Actual Quantity for CSRN-C
     * PUT /api/csrn-c/{id}/detail/{detailId}/actual-qty
     */
    updateCSRNCActualQty: async function(id, detailId, actualQty) {
        return ApiClient.put('CONSIGNMENT', '/csrn-c/' + id + '/detail/' + detailId + '/actual-qty', { actualQty: actualQty });
    },

    /**
     * Complete CSRN-C Document
     * PUT /api/csrn-c/{id}/complete
     */
    completeCSRNC: async function(id) {
        return ApiClient.put('CONSIGNMENT', '/csrn-c/' + id + '/complete', {});
    },

    searchCSRQ: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/csrq' + (query ? '?' + query : ''));
    },

    /**
     * Get CSRQ by ID
     * GET /api/csrq/{id}
     */
    getCSRQ: async function(id) {
        return ApiClient.get('CONSIGNMENT', '/csrq/' + id);
    },

    /**
     * Create CSRQ Document
     * POST /api/csrq
     */
    createCSRQ: async function(data) {
        return ApiClient.post('CONSIGNMENT', '/csrq', data);
    },

    /**
     * Release CSRQ Document
     * PUT /api/csrq/{id}/release
     */
    releaseCSRQ: async function(id) {
        return ApiClient.put('CONSIGNMENT', '/csrq/' + id + '/release', {});
    },

    /**
     * Delete CSRQ Document
     * DELETE /api/csrq/{id}
     */
    deleteCSRQ: async function(id) {
        return ApiClient.delete('CONSIGNMENT', '/csrq/' + id);
    },

    // ══════════════════════════════════════════════════════════
    // CSRV CONTROLLER (Consignment Stock Receive) - /api/csrv
    // ══════════════════════════════════════════════════════════

    /**
     * Search CSRV Documents
     * GET /api/csrv
     */
    searchCSRV: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/csrv' + (query ? '?' + query : ''));
    },

    /**
     * Get CSRV by ID
     * GET /api/csrv/{id}
     */
    getCSRV: async function(id) {
        return ApiClient.get('CONSIGNMENT', '/csrv/' + id);
    },

    /**
     * Create CSRV Document
     * POST /api/csrv
     */
    createCSRV: async function(data) {
        return ApiClient.post('CONSIGNMENT', '/csrv', data);
    },

    /**
     * Release CSRV Document
     * PUT /api/csrv/{id}/release
     */
    releaseCSRV: async function(id) {
        return ApiClient.put('CONSIGNMENT', '/csrv/' + id + '/release', {});
    },

    /**
     * Auto Create CSRV
     * POST /api/acmm/csrv/auto-create
     */
    autoCreateCSRV: async function(data) {
        return ApiClient.post('CONSIGNMENT', '/acmm/csrv/auto-create', data);
    },

    // ══════════════════════════════════════════════════════════
    // CSDO CONTROLLER (Consignment Stock Delivery Order) - /api/csdo
    // ══════════════════════════════════════════════════════════

    /**
     * Search CSDO Documents
     * GET /api/csdo
     */
    searchCSDO: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/csdo' + (query ? '?' + query : ''));
    },

    /**
     * Get CSDO by ID
     * GET /api/csdo/{id}
     */
    getCSDO: async function(id) {
        return ApiClient.get('CONSIGNMENT', '/csdo/' + id);
    },

    /**
     * Transfer from CSO to CSDO
     * POST /api/csdo/transfer/{csoId}
     */
    transferFromCSO: async function(csoId, data) {
        return ApiClient.post('CONSIGNMENT', '/csdo/transfer/' + csoId, data);
    },

    /**
     * Release CSDO Document
     * PUT /api/csdo/{id}/release
     */
    releaseCSDO: async function(id) {
        return ApiClient.put('CONSIGNMENT', '/csdo/' + id + '/release', {});
    },

    /**
     * Reverse Correction CSDO
     * PUT /api/csdo/{id}/reverse
     */
    reverseCSDO: async function(id) {
        return ApiClient.put('CONSIGNMENT', '/csdo/' + id + '/reverse', {});
    },

    // ══════════════════════════════════════════════════════════
    // SETTLEMENT CONTROLLER - /api/settlement
    // ══════════════════════════════════════════════════════════

    /**
     * Search Settlement Documents
     * GET /api/settlement
     */
    searchSettlement: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/settlement' + (query ? '?' + query : ''));
    },

    /**
     * Get Settlement by ID
     * GET /api/settlement/{id}
     */
    getSettlement: async function(id) {
        return ApiClient.get('CONSIGNMENT', '/settlement/' + id);
    },

    /**
     * Create Settlement Document
     * POST /api/settlement
     */
    createSettlement: async function(data) {
        return ApiClient.post('CONSIGNMENT', '/settlement', data);
    },

    /**
     * Generate Batch Settlement
     * POST /api/settlement/generate
     */
    generateBatchSettlement: async function(data) {
        return ApiClient.post('CONSIGNMENT', '/settlement/generate', data);
    },

    /**
     * Post Details from Documents
     * POST /api/settlement/{id}/details/from-documents
     */
    postSettlementDetailsFromDocuments: async function(id, documentSources) {
        return ApiClient.post('CONSIGNMENT', '/settlement/' + id + '/details/from-documents', { documentSources: documentSources });
    },

    /**
     * Prepare for Billing
     * PUT /api/settlement/{id}/prepare-for-billing
     */
    prepareSettlementForBilling: async function(id) {
        return ApiClient.put('CONSIGNMENT', '/settlement/' + id + '/prepare-for-billing', {});
    },

    /**
     * Mark as Billed
     * PUT /api/settlement/{id}/mark-as-billed
     */
    markSettlementAsBilled: async function(id) {
        return ApiClient.put('CONSIGNMENT', '/settlement/' + id + '/mark-as-billed', {});
    },

    /**
     * Mark as Settled
     * PUT /api/settlement/{id}/mark-as-settled
     */
    markSettlementAsSettled: async function(id) {
        return ApiClient.put('CONSIGNMENT', '/settlement/' + id + '/mark-as-settled', {});
    },

    // ══════════════════════════════════════════════════════════
    // REPORTS CONTROLLER - /api/reports
    // ══════════════════════════════════════════════════════════

    /**
     * CSRQ Report
     * GET /api/reports/csrq
     */
    getCSRQReport: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/reports/csrq' + (query ? '?' + query : ''));
    },

    /**
     * CSRV Report
     * GET /api/reports/csrv
     */
    getCSRVReport: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/reports/csrv' + (query ? '?' + query : ''));
    },

    /**
     * CSO Report
     * GET /api/reports/cso
     */
    getCSOReport: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/reports/cso' + (query ? '?' + query : ''));
    },

    /**
     * CSDO Report
     * GET /api/reports/csdo
     */
    getCSDOReport: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/reports/csdo' + (query ? '?' + query : ''));
    },

    /**
     * CSR Report
     * GET /api/reports/csr
     */
    getCSRReport: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/reports/csr' + (query ? '?' + query : ''));
    },

    /**
     * CSA Report
     * GET /api/reports/csa
     */
    getCSAReport: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/reports/csa' + (query ? '?' + query : ''));
    },

    /**
     * Settlement Summary Report
     * GET /api/reports/settlement-summary
     */
    getSettlementSummaryReport: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/reports/settlement-summary' + (query ? '?' + query : ''));
    },

    /**
     * Settlement Detail Report
     * GET /api/reports/settlement-detail/{settlementId}
     */
    getSettlementDetailReport: async function(settlementId) {
        return ApiClient.get('CONSIGNMENT', '/reports/settlement-detail/' + settlementId);
    },

    /**
     * Supplier Book Value Report
     * GET /api/reports/supplier-book-value
     */
    getSupplierBookValueReport: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/reports/supplier-book-value' + (query ? '?' + query : ''));
    },

    /**
     * Customer Inventory Report
     * GET /api/reports/customer-inventory
     */
    getCustomerInventoryReport: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/reports/customer-inventory' + (query ? '?' + query : ''));
    },

    /**
     * Reservations Report
     * GET /api/reports/reservations
     */
    getReservationsReport: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/reports/reservations' + (query ? '?' + query : ''));
    },

    /**
     * Consignment Setup Report
     * GET /api/reports/consignment-setup
     */
    getConsignmentSetupReport: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/reports/consignment-setup' + (query ? '?' + query : ''));
    },

    // ══════════════════════════════════════════════════════════
    // CUSTOMER BILLING CONTROLLER - /api/customer-billing
    // ══════════════════════════════════════════════════════════

    /**
     * Compute Customer Billing Request
     * POST /api/customer-billing/compute
     * @param {Object} data
     * @param {string} data.store - Store code (required)
     * @param {string} data.fromDate - YYYY-MM-DD (required)
     * @param {string} data.toDate - YYYY-MM-DD (required)
     * @param {string} data.periodType - MONTHLY / WEEKLY
     * @param {string|null} data.customerCode - null = all customers
     * @param {string} data.createdBy - Creator username
     */
    computeCustomerBilling: async function(data) {
        return ApiClient.post('CONSIGNMENT', '/customer-billing/compute', data);
    },

    /**
     * List Customer Billing Requests
     * GET /api/customer-billing
     * @param {Object} params - Query parameters
     * @param {number} params.page - Page number (default: 1)
     * @param {number} params.perPage - Items per page (default: 20)
     * @param {string} params.docNo - Filter by document number
     * @param {string} params.store - Filter by store
     * @param {string} params.customerCode - Filter by customer code
     * @param {string} params.customerBranch - Filter by customer branch
     * @param {string} params.periodType - MONTHLY / WEEKLY
     * @param {string} params.status - HELD / RELEASED
     * @param {string} params.processStatus - COMPLETED / FAILED
     * @param {string} params.fromDate - YYYY-MM-DD
     * @param {string} params.toDate - YYYY-MM-DD
     */
    listCustomerBilling: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/customer-billing' + (query ? '?' + query : ''));
    },

    /**
     * Get Customer Billing by ID
     * GET /api/customer-billing/{id}
     */
    getCustomerBilling: async function(id) {
        return ApiClient.get('CONSIGNMENT', '/customer-billing/' + id);
    },

    /**
     * Release Customer Billing (HELD → RELEASED)
     * PUT /api/customer-billing/{id}/release
     */
    releaseCustomerBilling: async function(id) {
        return ApiClient.put('CONSIGNMENT', '/customer-billing/' + id + '/release', {});
    },

    /**
     * Update Actual Return Qty on a detail line (RELEASED only)
     * PUT /api/customer-billing/{id}/detail/{detailId}/actual-return-qty
     * @param {string} billingId - Billing document ID
     * @param {string} detailId - Detail line ID from details[].id
     * @param {number} actualReturnQty - Actual return quantity
     */
    updateCustomerBillingActualReturnQty: async function(billingId, detailId, actualReturnQty) {
        return ApiClient.put('CONSIGNMENT', '/customer-billing/' + billingId + '/detail/' + detailId + '/actual-return-qty', { actualReturnQty: actualReturnQty });
    },

    /**
     * Delete Customer Billing (HELD only — for reprocess)
     * DELETE /api/customer-billing/{id}
     */
    deleteCustomerBilling: async function(id) {
        return ApiClient.delete('CONSIGNMENT', '/customer-billing/' + id);
    },

    /**
     * Search Failed Customer Billing Records
     * GET /api/customer-billing/failed
     * @param {Object} params - Query parameters
     * @param {string} params.company - Filter by company name (optional)
     * @param {string} params.store - Filter by store code (optional)
     * @param {string} params.customerCode - Filter by customer code (optional)
     * @param {string} params.fromDate - Filter from date YYYY-MM-DD (optional)
     * @param {string} params.toDate - Filter to date YYYY-MM-DD (optional)
     * @param {number} params.page - Page number (default: 1)
     * @param {number} params.perPage - Items per page (default: 20)
     */
    searchFailedCBR: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/customer-billing/failed' + (query ? '?' + query : ''));
    },

    /**
     * Confirm Failed Customer Billing Record
     * PUT /api/customer-billing/{cbrId}/confirm-failed
     * @param {string} cbrId - Customer Billing Record ID to confirm
     */
    confirmFailedCBR: async function(cbrId) {
        return ApiClient.put('CONSIGNMENT', '/customer-billing/' + cbrId + '/confirm-failed', {});
    },

    /**
     * Delete Failed Customer Billing Record
     * DELETE /api/customer-billing/{cbrId}/failed
     * @param {string} cbrId - Customer Billing Record ID to delete
     */
    deleteFailedCBR: async function(cbrId) {
        return ApiClient.delete('CONSIGNMENT', '/customer-billing/' + cbrId + '/failed');
    },

    // ══════════════════════════════════════════════════════════
    // MASTER DATA CONTROLLER - /api/master-data
    // ══════════════════════════════════════════════════════════

    /**
     * Get Companies
     * GET /api/master-data/companies
     */
    getCompanies: async function() {
        return ApiClient.get('CONSIGNMENT', '/master-data/companies');
    },

    /**
     * Get Stores by Company
     * GET /api/master-data/stores?company={company}
     * @param {string} company - Company code (optional)
     */
    getStores: async function(company) {
        var query = company ? '?company=' + encodeURIComponent(company) : '';
        return ApiClient.get('CONSIGNMENT', '/master-data/stores' + query);
    },

    /**
     * Get Suppliers by Company+Store
     * GET /api/master-data/suppliers?company={company}&store={store}
     * @param {string} company - Company code (optional)
     * @param {string} store - Store code (optional)
     */
    getSuppliers: async function(company, store) {
        var params = new URLSearchParams();
        if (company) params.append('company', company);
        if (store) params.append('store', store);
        var query = params.toString();
        return ApiClient.get('CONSIGNMENT', '/master-data/suppliers' + (query ? '?' + query : ''));
    },

    /**
     * Get Contracts by Supplier
     * GET /api/master-data/contracts?company={company}&store={store}&supplierCode={supplierCode}
     * @param {string} company - Company code (optional)
     * @param {string} store - Store code (optional)
     * @param {string} supplierCode - Supplier code (optional)
     */
    getContracts: async function(company, store, supplierCode) {
        var params = new URLSearchParams();
        if (company) params.append('company', company);
        if (store) params.append('store', store);
        if (supplierCode) params.append('supplierCode', supplierCode);
        var query = params.toString();
        return ApiClient.get('CONSIGNMENT', '/master-data/contracts' + (query ? '?' + query : ''));
    },

    /**
     * Get Items by Supplier+Contract
     * GET /api/master-data/items?company={company}&store={store}&supplierCode={supplierCode}&supplierContract={supplierContract}
     * @param {string} company - Company code (optional)
     * @param {string} store - Store code (optional)
     * @param {string} supplierCode - Supplier code (optional)
     * @param {string} supplierContract - Contract number (optional)
     */
    getMasterItems: async function(company, store, supplierCode, supplierContract) {
        var params = new URLSearchParams();
        if (company) params.append('company', company);
        if (store) params.append('store', store);
        if (supplierCode) params.append('supplierCode', supplierCode);
        if (supplierContract) params.append('supplierContract', supplierContract);
        var query = params.toString();
        return ApiClient.get('CONSIGNMENT', '/master-data/items' + (query ? '?' + query : ''));
    },

    // ══════════════════════════════════════════════════════════
    // MASTER SYNC CONTROLLER - /api/acmm/master-sync
    // ══════════════════════════════════════════════════════════

    /**
     * Sync Master Data
     * POST /api/acmm/master-sync/{entity}
     */
    syncMasterData: async function(entity, records) {
        return ApiClient.post('CONSIGNMENT', '/acmm/master-sync/' + entity, { records: records });
    }
};

// Make available globally
window.ConsignmentService = ConsignmentService;
