package backend

import grails.plugin.springsecurity.SpringSecurityService

class LoginController {

    SpringSecurityService springSecurityService

    /**
     * Exibe o formulário de login.
     */
    def auth() {
        if (springSecurityService.isLoggedIn()) {
            redirect uri: '/'
            return
        }
        [postUrl: "${request.contextPath}/login/authenticate"]
    }

    /**
     * Página de acesso negado.
     */
    def denied() {
        if (!springSecurityService.isLoggedIn()) {
            redirect action: 'auth'
            return
        }
    }

    /**
     * Callback de falha no login.
     */
    def authfail() {
        String msg = 'Usuário ou senha inválidos.'
        if (session['SPRING_SECURITY_LAST_EXCEPTION']) {
            msg = session['SPRING_SECURITY_LAST_EXCEPTION'].message ?: msg
        }
        flash.message = msg
        redirect action: 'auth'
    }
}

