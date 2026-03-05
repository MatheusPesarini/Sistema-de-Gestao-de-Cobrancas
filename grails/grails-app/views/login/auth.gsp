<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="login"/>
    <title>Login - Sistema de Cobranças</title>
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .login-card {
            max-width: 420px;
            margin: 80px auto;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0,0,0,.2);
        }
        .login-card .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            text-align: center;
            border-radius: 12px 12px 0 0;
            padding: 30px 20px 20px;
        }
        .login-card .card-header h3 {
            margin: 0;
            font-weight: 700;
        }
        .login-card .card-header p {
            margin: 5px 0 0;
            opacity: .85;
            font-size: .9rem;
        }
        .login-card .card-body {
            padding: 30px;
        }
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 10px;
            font-size: 1rem;
            font-weight: 600;
        }
        .btn-login:hover {
            opacity: .9;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card login-card">
        <div class="card-header">
            <h3><i class="bi bi-shield-lock"></i> Login</h3>
            <p>Sistema de Gestão de Cobranças</p>
        </div>
        <div class="card-body">

            <g:if test="${flash.message}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle"></i> ${flash.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </g:if>

            <form action="${postUrl ?: request.contextPath + '/login/authenticate'}" method="POST" autocomplete="off">

                <div class="mb-3">
                    <label for="username" class="form-label fw-semibold">
                        <i class="bi bi-person"></i> Usuário
                    </label>
                    <input type="text" class="form-control form-control-lg" id="username" name="username"
                           placeholder="Digite seu usuário" required autofocus/>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label fw-semibold">
                        <i class="bi bi-key"></i> Senha
                    </label>
                    <input type="password" class="form-control form-control-lg" id="password" name="password"
                           placeholder="Digite sua senha" required/>
                </div>

                <div class="form-check mb-3">
                    <input type="checkbox" class="form-check-input" id="remember_me" name="remember-me"/>
                    <label class="form-check-label" for="remember_me">Lembrar-me</label>
                </div>

                <button type="submit" class="btn btn-primary btn-login w-100 text-white">
                    <i class="bi bi-box-arrow-in-right"></i> Entrar
                </button>
            </form>

            <div class="text-center mt-3 text-muted small">
                <i class="bi bi-info-circle"></i> Usuário padrão: <strong>admin</strong> / Senha: <strong>admin123</strong>
            </div>
        </div>
    </div>
</div>

</body>
</html>


