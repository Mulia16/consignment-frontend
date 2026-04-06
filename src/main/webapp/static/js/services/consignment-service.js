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
     * List Setup Items
     * GET /api/consignment-setup/items
     */
    listSetupItems: async function() {
        return ApiClient.get('CONSIGNMENT', '/consignment-setup/items');
    },

    /**
     * Get Item by Code
     * GET /api/consignment-setup/item/{itemCode}
     */
    getSetupItem: async function(itemCode) {
        return ApiClient.get('CONSIGNMENT', '/consignment-setup/item/' + itemCode);
    },

    /**
     * Create External Supplier Setup
     * POST /api/consignment-setup/item/{itemCode}/external-supplier
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
     */
    createInternalSupplierSetup: async function(itemCode, data) {
        return ApiClient.post('CONSIGNMENT', '/consignment-setup/item/' + itemCode + '/internal-supplier', data);
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
    // CSR CONTROLLER (Consignment Stock Return) - /api/csr
    // ══════════════════════════════════════════════════════════

    /**
     * Search CSR Documents
     * GET /api/csr
     */
    searchCSR: async function(params) {
        var query = new URLSearchParams(params).toString();
        return ApiClient.get('CONSIGNMENT', '/csr' + (query ? '?' + query : ''));
    },

    /**
     * Get CSR by ID
     * GET /api/csr/{id}
     */
    getCSR: async function(id) {
        return ApiClient.get('CONSIGNMENT', '/csr/' + id);
    },

    /**
     * Create CSR Document
     * POST /api/csr
     */
    createCSR: async function(data) {
        return ApiClient.post('CONSIGNMENT', '/csr', data);
    },

    /**
     * Release CSR Document
     * PUT /api/csr/{id}/release
     */
    releaseCSR: async function(id) {
        return ApiClient.put('CONSIGNMENT', '/csr/' + id + '/release', {});
    },

    /**
     * Update Actual Quantity
     * PUT /api/csr/{id}/detail/{detailId}/actual-qty
     */
    updateCSRActualQty: async function(id, detailId, actualQty) {
        return ApiClient.put('CONSIGNMENT', '/csr/' + id + '/detail/' + detailId + '/actual-qty', { actualQty: actualQty });
    },

    /**
     * Complete CSR Document
     * PUT /api/csr/{id}/complete
     */
    completeCSR: async function(id) {
        return ApiClient.put('CONSIGNMENT', '/csr/' + id + '/complete', {});
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
