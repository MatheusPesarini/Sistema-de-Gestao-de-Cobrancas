package backend

import grails.converters.JSON
import grails.gorm.transactions.Transactional

class WebhookController {

    /**
     * Exibe a página de informações sobre o webhook (GET /webhook/index)
     */
    def index() {
        def totalEventos = WebhookEvent.count()
        def ultimosEventos = WebhookEvent.list(max: 20, sort: 'dateCreated', order: 'desc')
        [totalEventos: totalEventos, ultimosEventos: ultimosEventos]
    }

    /**
     * Endpoint que recebe notificações POST do Asaas.
     * URL para configurar no painel Asaas: https://seu-dominio.com/webhook/receberNotificacao
     */
    @Transactional
    def receberNotificacao() {
        def json = request.JSON

        if (!json || !json.event) {
            render(status: 400, text: [erro: "Payload inválido"] as JSON)
            return
        }

        String evento = json.event
        def payment = json.payment

        println "📩 [WEBHOOK] Evento recebido: ${evento}"
        println "📩 [WEBHOOK] Payment ID: ${payment?.id}"

        // Salva o evento para log/auditoria
        def webhookEvent = new WebhookEvent(
            evento: evento,
            asaasPaymentId: payment?.id,
            payloadJson: json.toString()
        )
        webhookEvent.save(flush: true)

        // Mapeia eventos do Asaas para status local
        String novoStatus = mapearStatus(evento)

        if (novoStatus && payment?.id) {
            def cobranca = Cobranca.findByAsaasId(payment.id as String)
            if (cobranca) {
                cobranca.status = novoStatus
                cobranca.save(flush: true)
                println "✅ [WEBHOOK] Cobrança #${cobranca.id} atualizada para ${novoStatus}"
            } else {
                println "⚠️ [WEBHOOK] Nenhuma cobrança encontrada com asaasId: ${payment.id}"
            }
        }

        render(status: 200, text: [recebido: true] as JSON)
    }

    /**
     * Mapeia o evento do Asaas para um status local do sistema.
     */
    private String mapearStatus(String evento) {
        switch (evento) {
            case 'PAYMENT_CONFIRMED':
            case 'PAYMENT_RECEIVED':
                return 'PAGA'
            case 'PAYMENT_OVERDUE':
                return 'VENCIDA'
            case 'PAYMENT_DELETED':
            case 'PAYMENT_REFUNDED':
            case 'PAYMENT_CHARGEBACK_REQUESTED':
                return 'CANCELADA'
            case 'PAYMENT_CREATED':
            case 'PAYMENT_UPDATED':
            case 'PAYMENT_AWAITING_RISK_ANALYSIS':
                return 'PENDENTE'
            default:
                println "⚠️ [WEBHOOK] Evento não mapeado: ${evento}"
                return null
        }
    }
}
