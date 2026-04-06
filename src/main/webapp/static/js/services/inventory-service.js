/**
 * Inventory Service API Client
 * Handles all inventory-related API calls
 * 
 * Base Path: /api/v1/inventory
 * Endpoints: 2 (availability, reserve)
 * See plans/api-endpoint.md for full documentation
 */
var InventoryService = {

    /**
     * Get Inventory Availability
     * GET /api/v1/inventory/{sku}/availability
     * 
     * @param {string} sku - The SKU to check availability for
     * @returns {Promise<Object>} - { sku, available }
     */
    getAvailability: async function(sku) {
        return ApiClient.get('INVENTORY', '/' + sku + '/availability');
    },

    /**
     * Reserve Inventory
     * POST /api/v1/inventory/reserve
     * 
     * @param {Object} data - { sku, quantity }
     * @returns {Promise<Object>} - { sku, requestedQty, reserved, remainingAvailable }
     */
    reserve: async function(data) {
        return ApiClient.post('INVENTORY', '/reserve', data);
    }
};

// Make available globally
window.InventoryService = InventoryService;
