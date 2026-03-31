var Auth = {
    TOKEN_KEY: 'consignment_token',
    REFRESH_TOKEN_KEY: 'consignment_refresh_token',
    USER_KEY: 'consignment_user',

    login: async function(username, password) {
        if (API_CONFIG.isDevMode()) {
            this.setSession('dev-token-bypass', 'dev-refresh-bypass', { username: username, role: 'ADMIN' });
            return true;
        }

        try {
            var url = API_CONFIG.getUrl('AUTH', '/login');
            var response = await fetch(url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ username: username, password: password })
            });

            if (response.ok) {
                var data = await response.json();
                if (data.success && data.data) {
                    this.setSession(data.data.accessToken, data.data.refreshToken, data.data.user);
                    return true;
                }
            }
            return false;
        } catch (error) {
            console.error('Login error:', error);
            return false;
        }
    },

    logout: function() {
        localStorage.removeItem(this.TOKEN_KEY);
        localStorage.removeItem(this.REFRESH_TOKEN_KEY);
        localStorage.removeItem(this.USER_KEY);
        window.location.href = '/login';
    },

    setSession: function(token, refreshToken, user) {
        localStorage.setItem(this.TOKEN_KEY, token);
        localStorage.setItem(this.REFRESH_TOKEN_KEY, refreshToken);
        localStorage.setItem(this.USER_KEY, JSON.stringify(user));
    },

    getToken: function() {
        if (API_CONFIG.isDevMode() && !localStorage.getItem(this.TOKEN_KEY)) {
            return 'dev-token-bypass';
        }
        return localStorage.getItem(this.TOKEN_KEY);
    },

    getRefreshToken: function() { return localStorage.getItem(this.REFRESH_TOKEN_KEY); },
    getUser: function() { var u = localStorage.getItem(this.USER_KEY); return u ? JSON.parse(u) : null; },
    isAuthenticated: function() { 
        if (API_CONFIG.isDevMode()) return true;
        return !!this.getToken(); 
    },

    requireAuth: function() {
        if (!this.isAuthenticated()) {
            window.location.href = '/login';
            return false;
        }
        this.updateUI();
        return true;
    },

    updateUI: function() {
        var user = this.getUser();
        if (user) {
            $('.user-name').text(user.fullName || user.username);
            $('.user-role').text(user.role || 'User');
            if (API_CONFIG.isDevMode()) {
                $('.user-name').text('Dev Mode Admin');
            }
        }
    }
};
window.Auth = Auth;
