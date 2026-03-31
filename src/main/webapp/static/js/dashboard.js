/**
 * Dashboard.js — Load dashboard summary data
 */
document.addEventListener('configLoaded', function() {
    if (!Auth.requireAuth()) return;
    loadDashboardData();
});

async function loadDashboardData() {
    // Update user info
    $('#currentUser').text(Auth.getUser());

    try {
        // Try loading product count from master data
        const productData = await ApiClient.get('MASTER_SETUP', '/products?page=0&size=1');
        if (productData && productData.data) {
            $('#totalProducts').text(productData.data.totalElements || 0);
        }
    } catch (e) {
        $('#totalProducts').text('-');
    }

    try {
        // Try loading inventory summary
        const inventoryData = await ApiClient.get('TRANSACTION', '/stock-balances?page=0&size=1');
        if (inventoryData && inventoryData.data) {
            $('#totalStock').text(inventoryData.data.totalElements || 0);
        }
    } catch (e) {
        $('#totalStock').text('-');
    }

    try {
        // Try loading inbound summary
        const inboundData = await ApiClient.get('TRANSACTION', '/purchase-orders?page=0&size=1');
        if (inboundData && inboundData.data) {
            $('#totalPO').text(inboundData.data.totalElements || 0);
        }
    } catch (e) {
        $('#totalPO').text('-');
    }

    try {
        // Try loading settlement summary
        const settlementData = await ApiClient.get('SETTLEMENT', '/settlements?page=0&size=1');
        if (settlementData && settlementData.data) {
            $('#totalSettlement').text(settlementData.data.totalElements || 0);
        }
    } catch (e) {
        $('#totalSettlement').text('-');
    }
}
