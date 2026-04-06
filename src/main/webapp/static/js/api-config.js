var API_CONFIG = {
    APP_MODE: '',
    GATEWAY_BASE_URL: '',
    // Service configuration aligned with backend API architecture
    // See plans/api-endpoint.md for full API documentation
    SERVICES: {
        AUTH: '',         // Auth Service: /auth (login, register, validate)
        CONSIGNMENT: '',  // Consignment Service: /api (56 endpoints)
        INVENTORY: '',    // Inventory Service: /api/v1/inventory (2 endpoints)
        BATCH: ''         // Batch Job Service: /batch (2 endpoints)
    },
    
    isDevMode: function() {
        return this.APP_MODE === 'dev';
    },

    loadConfig: async function() {
        try {
            var response = await fetch('/api/config');
            if (response.ok) {
                var config = await response.json();
                this.APP_MODE = config.APP_MODE || 'dev';
                this.GATEWAY_BASE_URL = config.GATEWAY_BASE_URL;
                this.SERVICES = Object.assign(this.SERVICES, config.SERVICES);
            }
        } catch (e) {
            console.error("Failed to load environment config", e);
        }
        return this;
    },

    getUrl: function(serviceName, path) {
        var servicePrefix = this.SERVICES[serviceName] || '';
        var fullPath = servicePrefix + (path.startsWith('/') ? path : '/' + path);
        return this.GATEWAY_BASE_URL + fullPath;
    }
};

window.API_CONFIG = API_CONFIG;
