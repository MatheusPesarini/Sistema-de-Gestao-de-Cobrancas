<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Acesso Negado</title>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card border-danger">
                <div class="card-header bg-danger text-white text-center">
                    <h4><i class="bi bi-shield-exclamation"></i> Acesso Negado</h4>
                </div>
                <div class="card-body text-center">
                    <p class="mb-4">Você não tem permissão para acessar esta página.</p>
                    <a href="${request.contextPath}/" class="btn btn-primary">
                        <i class="bi bi-house"></i> Voltar ao Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>

