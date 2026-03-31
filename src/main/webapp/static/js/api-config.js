var API_CONFIG = {
    APP_MODE: '',
    GATEWAY_BASE_URL: '',
    SERVICES: {
        AUTH: '',
        TRACE_LOG: '',
        MASTER_SETUP: '',
        TRANSACTION: '',
        SETTLEMENT: '',
        REPORT: ''
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
