package crm

class ResetCambiarPedidoJob {
	def generalService
    static triggers = {
    cron name: 'resetCambiarPedidoTrigger', cronExpression: "0 0 02 * * ?"
    }

    def execute() {		
		generalService.resetCambiarPedido()
		println "NINGUN PEDIDO PUEDE SER MODIFICADOA"
    }
}
