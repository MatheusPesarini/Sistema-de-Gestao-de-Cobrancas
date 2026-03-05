<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Webhook - Log de Eventos</title>
</head>
<body>
<div id="content" role="main">
    <div class="container">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="bi bi-broadcast"></i> Webhook - Log de Eventos</h1>
            <span class="badge bg-primary fs-6">${totalEventos} evento(s)</span>
        </div>

        <div class="card mb-4">
            <div class="card-header bg-dark text-white">
                <i class="bi bi-gear"></i> Configuração do Webhook no Asaas
            </div>
            <div class="card-body">
                <p>Para receber notificações automáticas do Asaas, configure o seguinte URL no painel do Asaas:</p>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-link-45deg"></i></span>
                    <input type="text" class="form-control font-monospace" readonly
                           value="https://seu-dominio.com/webhook/asaas" id="webhookUrl"/>
                    <button class="btn btn-outline-secondary" type="button"
                            onclick="navigator.clipboard.writeText(document.getElementById('webhookUrl').value)">
                        <i class="bi bi-clipboard"></i> Copiar
                    </button>
                </div>
                <small class="text-muted mt-2 d-block">
                    <i class="bi bi-info-circle"></i> Método: <strong>POST</strong> |
                    Eventos suportados: PAYMENT_CONFIRMED, PAYMENT_RECEIVED, PAYMENT_OVERDUE,
                    PAYMENT_DELETED, PAYMENT_REFUNDED, PAYMENT_CREATED
                </small>
            </div>
        </div>

        <g:if test="${ultimosEventos}">
            <div class="card">
                <div class="card-header">
                    <i class="bi bi-clock-history"></i> Últimos Eventos Recebidos
                </div>
                <div class="card-body p-0">
                    <table class="table table-striped table-hover mb-0">
                        <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Evento</th>
                            <th>Payment ID (Asaas)</th>
                            <th>Data</th>
                            <th>Detalhes</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${ultimosEventos}" var="e" status="i">
                            <tr>
                                <td>${e.id}</td>
                                <td>
                                    <g:if test="${e.evento?.contains('CONFIRMED') || e.evento?.contains('RECEIVED')}">
                                        <span class="badge bg-success">${e.evento}</span>
                                    </g:if>
                                    <g:elseif test="${e.evento?.contains('OVERDUE')}">
                                        <span class="badge bg-danger">${e.evento}</span>
                                    </g:elseif>
                                    <g:elseif test="${e.evento?.contains('DELETED') || e.evento?.contains('REFUNDED')}">
                                        <span class="badge bg-secondary">${e.evento}</span>
                                    </g:elseif>
                                    <g:else>
                                        <span class="badge bg-warning text-dark">${e.evento}</span>
                                    </g:else>
                                </td>
                                <td><code>${e.asaasPaymentId ?: '-'}</code></td>
                                <td><g:formatDate date="${e.dateCreated}" format="dd/MM/yyyy HH:mm:ss"/></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-secondary"
                                            type="button"
                                            data-bs-toggle="collapse"
                                            data-bs-target="#payload-${e.id}">
                                        <i class="bi bi-code-slash"></i> JSON
                                    </button>
                                </td>
                            </tr>
                            <tr class="collapse" id="payload-${e.id}">
                                <td colspan="5">
                                    <pre class="bg-dark text-success p-3 rounded small mb-0">${e.payloadJson}</pre>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </g:if>
        <g:else>
            <div class="alert alert-info">
                <i class="bi bi-inbox"></i> Nenhum evento recebido ainda. Configure o webhook no painel do Asaas.
            </div>
        </g:else>

    </div>
</div>
</body>
</html>
