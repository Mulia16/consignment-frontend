<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — Alpro Consignment</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/static/css/login.css">
</head>
<body class="login-page">

<div class="login-container">
    <div class="login-card">
        <div class="login-logo">
            <div class="logo-icon">
                <i class="fas fa-pills"></i>
            </div>
            <h3>Alpro Consignment</h3>
            <p>Pharmacy Consignment Management System</p>
        </div>

        <div class="login-error" id="loginError" style="display:none;">
            <i class="fas fa-exclamation-circle mr-1"></i>
            <span id="loginErrorMsg">Login failed</span>
        </div>

        <form id="loginForm" onsubmit="return handleLogin(event)">
            <div class="form-group">
                <label for="username">Username</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                    </div>
                    <input type="text" class="form-control" id="username" name="username"
                           placeholder="Enter username" required autofocus>
                </div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    </div>
                    <input type="password" class="form-control" id="password" name="password"
                           placeholder="Enter password" required>
                </div>
            </div>

            <button type="submit" class="btn btn-login" id="btnLogin">
                <span id="loginText"><i class="fas fa-sign-in-alt mr-2"></i>SIGN IN</span>
                <span id="loginSpinner" style="display:none">
                    <span class="spinner-border spinner-border-sm mr-2"></span>Processing...
                </span>
            </button>
        </form>
    </div>

    <div class="login-footer">
        &copy; 2026 Alpro Pharmacy — Consignment System
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
<script src="/static/js/api-config.js"></script>

<script>
    if (typeof API_CONFIG !== 'undefined') {
        API_CONFIG.loadConfig().then(function() {
            var ver = new Date().getTime();
            var scripts = ['/static/js/api-client.js?v=' + ver, '/static/js/common.js?v=' + ver, '/static/js/auth.js?v=' + ver];
            var loadedCount = 0;
            scripts.forEach(function(src) {
                var script = document.createElement('script');
                script.src = src;
                script.onload = function() {
                    loadedCount++;
                    if(loadedCount === scripts.length) {
                        try {
                            if (Auth.isAuthenticated()) {
                                window.location.href = '/dashboard';
                            }
                        } catch(e) {}
                    }
                };
                document.body.appendChild(script);
            });
        });
    }

    async function handleLogin(e) {
        e.preventDefault();

        var username = $('#username').val().trim();
        var password = $('#password').val().trim();

        if (!username || !password) return false;

        $('#loginText').hide();
        $('#loginSpinner').show();
        $('#btnLogin').prop('disabled', true);
        $('#loginError').hide();

        var success = await Auth.login(username, password);

        if (success) {
            window.location.href = '/dashboard';
        } else {
            $('#loginErrorMsg').text("Invalid username or password");
            $('#loginError').fadeIn();
            $('#loginText').show();
            $('#loginSpinner').hide();
            $('#btnLogin').prop('disabled', false);
        }

        return false;
    }
</script>

</body>
</html>
