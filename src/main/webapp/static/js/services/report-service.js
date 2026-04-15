/**
 * Report Service - Handles all report API calls
 * 
 * Endpoints based on API collection - 11 Reports:
 * - R01: GET /api/reports/csrq
 * - R02: GET /api/reports/csrv
 * - R03: GET /api/reports/cso
 * - R04: GET /api/reports/csdo
 * - R05: GET /api/reports/csr
 * - R06: GET /api/reports/csa
 * - R07: GET /api/reports/settlement-summary
 * - R08: GET /api/reports/settlement-detail/{settlementId}
 * - R09: GET /api/reports/supplier-book-value
 * - R10: GET /api/reports/customer-inventory
 * - R11: GET /api/reports/reservations
 * - R12: GET /api/reports/consignment-setup
 * 
 * Requires api-client.js
 */
var ReportService = {

    // ══════════════════════════════════════════════════════════
    // R01 - CSRQ REPORT (Consignment Stock Requisition)
    // GET /api/reports/csrq
    // Params: company, store, fromDate, toDate, supplierCode?, status?
    // ══════════════════════════════════════════════════════════
    getCSRQReport: async function(params) {
        var query = this._buildQuery(params);
        return ApiClient.get('CONSIGNMENT', '/reports/csrq' + query);
    },

    // ══════════════════════════════════════════════════════════
    // R02 - CSRV REPORT (Consignment Stock Receiving)
    // GET /api/reports/csrv
    // Params: company, store, fromDate, toDate
    // ══════════════════════════════════════════════════════════
    getCSRVReport: async function(params) {
        var query = this._buildQuery(params);
        return ApiClient.get('CONSIGNMENT', '/reports/csrv' + query);
    },

    // ══════════════════════════════════════════════════════════
    // R03 - CSO REPORT (Consignment Stock Out)
    // GET /api/reports/cso
    // Params: company, store, customerCode?, fromDate, toDate
    // ══════════════════════════════════════════════════════════
    getCSOReport: async function(params) {
        var query = this._buildQuery(params);
        return ApiClient.get('CONSIGNMENT', '/reports/cso' + query);
    },

    // ══════════════════════════════════════════════════════════
    // R04 - CSDO REPORT (Consignment Stock Delivery Order)
    // GET /api/reports/csdo
    // Params: company, store, fromDate, toDate
    // ══════════════════════════════════════════════════════════
    getCSDOReport: async function(params) {
        var query = this._buildQuery(params);
        return ApiClient.get('CONSIGNMENT', '/reports/csdo' + query);
    },

    // ══════════════════════════════════════════════════════════
    // R05 - CSR REPORT (Consignment Stock Return)
    // GET /api/reports/csr
    // Params: company, store, fromDate, toDate
    // ══════════════════════════════════════════════════════════
    getCSRReport: async function(params) {
        var query = this._buildQuery(params);
        return ApiClient.get('CONSIGNMENT', '/reports/csr' + query);
    },

    // ══════════════════════════════════════════════════════════
    // R06 - CSA REPORT (Consignment Stock Adjustment)
    // GET /api/reports/csa
    // Params: company, store, fromDate, toDate
    // ══════════════════════════════════════════════════════════
    getCSAReport: async function(params) {
        var query = this._buildQuery(params);
        return ApiClient.get('CONSIGNMENT', '/reports/csa' + query);
    },

    // ══════════════════════════════════════════════════════════
    // R07 - SETTLEMENT SUMMARY
    // GET /api/reports/settlement-summary
    // Params: company, store, settlementType?, fromDate, toDate
    // ══════════════════════════════════════════════════════════
    getSettlementSummaryReport: async function(params) {
        var query = this._buildQuery(params);
        return ApiClient.get('CONSIGNMENT', '/reports/settlement-summary' + query);
    },

    // ══════════════════════════════════════════════════════════
    // R08 - SETTLEMENT DETAIL
    // GET /api/reports/settlement-detail/{settlementId}
    // ══════════════════════════════════════════════════════════
    getSettlementDetailReport: async function(settlementId) {
        return ApiClient.get('CONSIGNMENT', '/reports/settlement-detail/' + settlementId);
    },

    // ══════════════════════════════════════════════════════════
    // R09 - SUPPLIER BOOK VALUE
    // GET /api/reports/supplier-book-value
    // Params: store, supplierCode, supplierContract?
    // ══════════════════════════════════════════════════════════
    getSupplierBookValueReport: async function(params) {
        var query = this._buildQuery(params);
        return ApiClient.get('CONSIGNMENT', '/reports/supplier-book-value' + query);
    },

    // ══════════════════════════════════════════════════════════
    // R10 - CUSTOMER INVENTORY
    // GET /api/reports/customer-inventory
    // Params: store, customerCode
    // ══════════════════════════════════════════════════════════
    getCustomerInventoryReport: async function(params) {
        var query = this._buildQuery(params);
        return ApiClient.get('CONSIGNMENT', '/reports/customer-inventory' + query);
    },

    // ══════════════════════════════════════════════════════════
    // R11 - RESERVATIONS
    // GET /api/reports/reservations
    // Params: store, itemCode
    // ══════════════════════════════════════════════════════════
    getReservationsReport: async function(params) {
        var query = this._buildQuery(params);
        return ApiClient.get('CONSIGNMENT', '/reports/reservations' + query);
    },

    // ══════════════════════════════════════════════════════════
    // R12 - CONSIGNMENT SETUP
    // GET /api/reports/consignment-setup
    // Params: company, store, supplierCode?
    // ══════════════════════════════════════════════════════════
    getConsignmentSetupReport: async function(params) {
        var query = this._buildQuery(params);
        return ApiClient.get('CONSIGNMENT', '/reports/consignment-setup' + query);
    },

    // ══════════════════════════════════════════════════════════
    // HELPER: Build query string from params object (removes null/empty)
    // ══════════════════════════════════════════════════════════
    _buildQuery: function(params) {
        if (!params) return '';
        var filtered = {};
        Object.keys(params).forEach(function(key) {
            if (params[key] !== null && params[key] !== undefined && params[key] !== '') {
                filtered[key] = params[key];
            }
        });
        var query = new URLSearchParams(filtered).toString();
        return query ? '?' + query : '';
    }
};

window.ReportService = ReportService;
