<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 — Access Denied</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }
        .error-container {
            text-align: center;
            color: #fff;
            max-width: 520px;
            padding: 40px;
        }
        .error-code {
            font-size: 120px;
            font-weight: 800;
            line-height: 1;
            text-shadow: 0 4px 20px rgba(0,0,0,0.2);
            margin-bottom: 10px;
        }
        .error-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 16px;
        }
        .error-message {
            font-size: 16px;
            opacity: 0.9;
            margin-bottom: 32px;
            line-height: 1.6;
        }
        .error-icon {
            font-size: 60px;
            margin-bottom: 20px;
            opacity: 0.8;
        }
        .btn-logout {
            background: rgba(255,255,255,0.2);
            border: 2px solid #fff;
            color: #fff;
            padding: 12px 40px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 50px;
            transition: all 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-logout:hover {
            background: #fff;
            color: #764ba2;
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .btn-back {
            background: transparent;
            border: none;
            color: rgba(255,255,255,0.7);
            padding: 10px 30px;
            font-size: 14px;
            cursor: pointer;
            display: inline-block;
            margin-top: 12px;
            transition: color 0.3s ease;
        }
        .btn-back:hover {
            color: #fff;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">
            <i class="fas fa-lock"></i>
        </div>
        <div class="error-code">403</div>
        <div class="error-title">Access Denied</div>
        <div class="error-message">
            You do not have permission to access this resource.<br>
            Please logout and sign in again to refresh your session.
        </div>
        <div>
            <a href="/login" class="btn-logout" onclick="clearStorageAndRedirect()">
                <i class="fas fa-sign-out-alt mr-2"></i>Logout & Sign In
            </a>
        </div>
        <div>
            <a href="javascript:history.back()" class="btn-back">
                <i class="fas fa-arrow-left mr-1"></i> Go Back
            </a>
        </div>
    </div>

    <script>
        function clearStorageAndRedirect() {
            localStorage.removeItem('consignment_token');
            localStorage.removeItem('consignment_refresh_token');
            localStorage.removeItem('consignment_user');
            localStorage.removeItem('consignment_menus');
            window.location.href = '/login';
        }
    </script>
</body>
</html>
