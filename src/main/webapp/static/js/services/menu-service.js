/**
 * Menu Service - ACL (Access Control List) for sidebar menu visibility
 * 
 * Fetches user menu permissions from /auth/me/menus API
 * and controls which sidebar items are visible based on the user's role.
 * 
 * Menu keys from API:
 *   CONSIGNEE: PRODUCTS, PURCHASE_ORDERS, DASHBOARD
 *   ADMIN: All CONSIGNMENT_*, SETTLEMENT_*, MASTER_DATA_*, SETUP_*, REPORT_*, SYSTEM_* keys
 */
var MenuService = {
    MENUS_KEY: 'consignment_menus',

    /**
     * Mapping of menu keys to sidebar data-menu attribute values.
     * Each key maps to the data-menu attribute on the sidebar <li> element.
     */
    MENU_MAP: {
        // Consignment
        'CONSIGNMENT_RECEIVING': 'CONSIGNMENT_RECEIVING',
        'CONSIGNMENT_STOCK_OUT': 'CONSIGNMENT_STOCK_OUT',
        'CONSIGNMENT_STOCK_REQUEST': 'CONSIGNMENT_STOCK_REQUEST',
        'CONSIGNMENT_DELIVERY_ORDER': 'CONSIGNMENT_DELIVERY_ORDER',
        'CONSIGNMENT_STOCK_RETURN': 'CONSIGNMENT_STOCK_RETURN',
        'CONSIGNMENT_STOCK_RETURN_COLLECT': 'CONSIGNMENT_STOCK_RETURN_COLLECT',
        'CONSIGNMENT_STOCK_ADJUSTMENT': 'CONSIGNMENT_STOCK_ADJUSTMENT',
        // Settlement
        'SETTLEMENT_CUSTOMER_COMPUTE': 'SETTLEMENT_CUSTOMER_COMPUTE',
        'SETTLEMENT_CUSTOMER_BILLING': 'SETTLEMENT_CUSTOMER_BILLING',
        'SETTLEMENT_FAILURE_CUSTOMER': 'SETTLEMENT_FAILURE_CUSTOMER',
        'SETTLEMENT_SUPPLIER_COMPUTE': 'SETTLEMENT_SUPPLIER_COMPUTE',
        'SETTLEMENT_SUPPLIER_BILLING': 'SETTLEMENT_SUPPLIER_BILLING',
        'SETTLEMENT_FAILURE_SUPPLIER': 'SETTLEMENT_FAILURE_SUPPLIER',
        // Master Data
        'MASTER_DATA_COMPANIES': 'MASTER_DATA_COMPANIES',
        'MASTER_DATA_STORES': 'MASTER_DATA_STORES',
        'MASTER_DATA_SUPPLIERS': 'MASTER_DATA_SUPPLIERS',
        'MASTER_DATA_CONTRACTS': 'MASTER_DATA_CONTRACTS',
        'MASTER_DATA_ITEMS': 'MASTER_DATA_ITEMS',
        // Setup
        'SETUP_CONSIGNMENT_ITEMS': 'SETUP_CONSIGNMENT_ITEMS',
        // Reports
        'REPORT_CENTER': 'REPORT_CENTER',
        'REPORT_CSRQ': 'REPORT_CSRQ',
        'REPORT_CSRV': 'REPORT_CSRV',
        'REPORT_CSO': 'REPORT_CSO',
        'REPORT_CSDO': 'REPORT_CSDO',
        'REPORT_CSR': 'REPORT_CSR',
        'REPORT_CSA': 'REPORT_CSA',
        'REPORT_SETTLEMENT_SUMMARY': 'REPORT_SETTLEMENT_SUMMARY',
        'REPORT_SETTLEMENT_DETAIL': 'REPORT_SETTLEMENT_DETAIL',
        'REPORT_SUPPLIER_BOOK_VALUE': 'REPORT_SUPPLIER_BOOK_VALUE',
        'REPORT_CUSTOMER_INVENTORY': 'REPORT_CUSTOMER_INVENTORY',
        'REPORT_RESERVATIONS': 'REPORT_RESERVATIONS',
        'REPORT_CONSIGNMENT_SETUP': 'REPORT_CONSIGNMENT_SETUP',
        // System
        'SYSTEM_AUDIT_LOG': 'SYSTEM_AUDIT_LOG',
        // Consignee-specific
        'PRODUCTS': 'PRODUCTS',
        'PURCHASE_ORDERS': 'PURCHASE_ORDERS',
        'DASHBOARD': 'DASHBOARD'
    },

    /**
     * Mapping of page paths to required menu keys for route protection.
     * Used by checkPageAccess() to determine if user can access a specific URL.
     * Values can be a single string or an array of strings (any match grants access).
     */
    PAGE_MENU_MAP: {
        '/dashboard': 'DASHBOARD',
        '/consignee/dashboard': 'DASHBOARD',
        '/consignment/receiving': 'CONSIGNMENT_RECEIVING',
        '/consignment/stock-out': 'CONSIGNMENT_STOCK_OUT',
        '/consignment/stock-request': 'CONSIGNMENT_STOCK_REQUEST',
        '/consignment/delivery-order': 'CONSIGNMENT_DELIVERY_ORDER',
        '/consignment/stock-return': 'CONSIGNMENT_STOCK_RETURN',
        '/consignment/stock-return-collect': 'CONSIGNMENT_STOCK_RETURN_COLLECT',
        '/consignment/stock-adjustment': 'CONSIGNMENT_STOCK_ADJUSTMENT',
        '/consignment/settlement/customer-compute': 'SETTLEMENT_CUSTOMER_COMPUTE',
        '/consignment/settlement/customer-billing': 'SETTLEMENT_CUSTOMER_BILLING',
        '/consignment/settlement/failure-customer': 'SETTLEMENT_FAILURE_CUSTOMER',
        '/consignment/settlement/supplier-compute': 'SETTLEMENT_SUPPLIER_COMPUTE',
        '/consignment/settlement/supplier-billing': 'SETTLEMENT_SUPPLIER_BILLING',
        '/consignment/settlement/failure-supplier': 'SETTLEMENT_FAILURE_SUPPLIER',
        '/master-data/companies': 'MASTER_DATA_COMPANIES',
        '/master-data/stores': 'MASTER_DATA_STORES',
        '/master-data/suppliers': 'MASTER_DATA_SUPPLIERS',
        '/master-data/contracts': 'MASTER_DATA_CONTRACTS',
        '/master-data/items': 'MASTER_DATA_ITEMS',
        '/products': 'PRODUCTS',
        '/setup/consignment-items': 'SETUP_CONSIGNMENT_ITEMS',
        '/reports': 'REPORT_CENTER',
        '/audit/logs': 'SYSTEM_AUDIT_LOG',
        '/purchase-orders': 'PURCHASE_ORDERS'
    },

    /**
     * Fetch menus from API and store in localStorage.
     * Called after successful login.
     * @returns {Promise<string[]>} Array of menu keys
     */
    fetchMenus: async function() {
        if (API_CONFIG.isDevMode()) {
            // In dev mode, grant all menus (admin access)
            var allMenus = Object.keys(this.MENU_MAP);
            this.setMenus(allMenus);
            return allMenus;
        }

        try {
            var response = await ApiClient.get('AUTH', '/me/menus');
            var menus = response.data || response || [];
            this.setMenus(menus);
            return menus;
        } catch (error) {
            console.error('Failed to fetch menus:', error);
            // On error, default to empty menus (no access)
            this.setMenus([]);
            return [];
        }
    },

    /**
     * Store menus in localStorage
     * @param {string[]} menus - Array of menu keys
     */
    setMenus: function(menus) {
        localStorage.setItem(this.MENUS_KEY, JSON.stringify(menus));
    },

    /**
     * Get menus from localStorage
     * @returns {string[]} Array of menu keys
     */
    getMenus: function() {
        if (API_CONFIG.isDevMode()) {
            return Object.keys(this.MENU_MAP);
        }
        var stored = localStorage.getItem(this.MENUS_KEY);
        return stored ? JSON.parse(stored) : [];
    },

    /**
     * Check if user has access to a specific menu
     * @param {string} menuKey - The menu key to check
     * @returns {boolean}
     */
    hasMenu: function(menuKey) {
        var menus = this.getMenus();
        return menus.indexOf(menuKey) !== -1;
    },

    /**
     * Check if user has access to the current page based on URL path
     * @param {string} [pathname] - Optional path to check, defaults to window.location.pathname
     * @returns {boolean|string} true if access allowed, string (required menu key) if denied
     */
    checkPageAccess: function(pathname) {
        var path = pathname || window.location.pathname;
        var menus = this.getMenus();

        // Pages that don't require menu permission
        var publicPaths = ['/', '/login', '/dashboard'];
        if (publicPaths.indexOf(path) !== -1) return true;

        // Helper: check if user has any of the required menu keys
        var hasAnyMenu = function(requiredMenus) {
            if (Array.isArray(requiredMenus)) {
                for (var i = 0; i < requiredMenus.length; i++) {
                    if (menus.indexOf(requiredMenus[i]) !== -1) return true;
                }
                return false;
            }
            return menus.indexOf(requiredMenus) !== -1;
        };

        // Helper: get display string for denied menu
        var getDeniedMenu = function(requiredMenus) {
            if (Array.isArray(requiredMenus)) {
                return requiredMenus.join(' OR ');
            }
            return requiredMenus;
        };

        // Check exact match first
        if (this.PAGE_MENU_MAP[path]) {
            var requiredMenu = this.PAGE_MENU_MAP[path];
            return hasAnyMenu(requiredMenu) ? true : getDeniedMenu(requiredMenu);
        }

        // Check prefix match for sub-pages (e.g., /consignment/receiving/details)
        var sortedPaths = Object.keys(this.PAGE_MENU_MAP).sort(function(a, b) {
            return b.length - a.length; // Sort by length descending for longest match first
        });

        for (var i = 0; i < sortedPaths.length; i++) {
            var mappedPath = sortedPaths[i];
            if (path.indexOf(mappedPath) === 0) {
                var reqMenu = this.PAGE_MENU_MAP[mappedPath];
                return hasAnyMenu(reqMenu) ? true : getDeniedMenu(reqMenu);
            }
        }

        // If no mapping found, allow access (page not in ACL system)
        return true;
    },

    /**
     * Apply ACL to sidebar - show/hide menu items based on user menus.
     * Should be called after config is loaded and menus are available.
     */
    applySidebarAcl: function() {
        var menus = this.getMenus();
        var menuSet = {};
        for (var i = 0; i < menus.length; i++) {
            menuSet[menus[i]] = true;
        }

        // Show/hide individual menu items based on data-menu attribute
        var menuItems = document.querySelectorAll('#sidebar li[data-menu]');
        for (var j = 0; j < menuItems.length; j++) {
            var item = menuItems[j];
            var menuKey = item.getAttribute('data-menu');
            if (menuKey && menuSet[menuKey]) {
                item.style.display = '';
            } else {
                item.style.display = 'none';
            }
        }

        // Show/hide section headers based on visible items within each section
        var headers = document.querySelectorAll('#sidebar li.menu-header');
        for (var h = 0; h < headers.length; h++) {
            var header = headers[h];
            var nextSibling = header.nextElementSibling;
            var hasVisibleItems = false;

            // Check all following siblings until next header or end of list
            while (nextSibling) {
                if (nextSibling.classList && nextSibling.classList.contains('menu-header')) {
                    break;
                }
                if (nextSibling.tagName === 'LI' && nextSibling.style.display !== 'none') {
                    hasVisibleItems = true;
                    break;
                }
                nextSibling = nextSibling.nextElementSibling;
            }

            header.style.display = hasVisibleItems ? '' : 'none';
        }
    },

    /**
     * Clear menus from localStorage (called on logout)
     */
    clearMenus: function() {
        localStorage.removeItem(this.MENUS_KEY);
    }
};

window.MenuService = MenuService;
