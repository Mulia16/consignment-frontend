
var AuthService = {
    
    /**
     * Login - Authenticate user and get JWT token
     * POST /auth/login
     * 
     * @param {Object} credentials - { username, password }
     * @returns {Promise<Object>} - { token, token_type, expires_in, username, roles }
     */
    login: async function(credentials) {
        return ApiClient.post('AUTH', '/login', credentials);
    },

    /**
     * Register - Register a new user
     * POST /auth/register
     * 
     * @param {Object} userData - { username, email, password }
     * @returns {Promise<Object>} - { message }
     */
    register: async function(userData) {
        return ApiClient.post('AUTH', '/register', userData);
    },

    /**
     * Validate Token - Validate JWT token
     * POST /auth/validate
     * 
     * @returns {Promise<Object>} - { valid, username }
     */
    validateToken: async function() {
        return ApiClient.post('AUTH', '/validate', {});
    },

    /**
     * Refresh Token - Refresh expired JWT token
     * POST /auth/refresh
     * 
     * @param {string} refreshToken - The refresh token
     * @returns {Promise<Object>} - { success, data: { accessToken, refreshToken } }
     */
    refreshToken: async function(refreshToken) {
        return ApiClient.post('AUTH', '/refresh', { refreshToken: refreshToken });
    }
};

window.AuthService = AuthService;
