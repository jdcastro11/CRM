package crm

class ActualizarEstadoVencimientoJob {
        def generalService
    static triggers = {
       // Se-Mi-Ho-Dm-Me-Ds-A
        cron name: 'avisarTrigger', cronExpression: "0 55 05 * * ?"
		//simple name: 'mySimpleTrigger', startDelay: 60000, repeatInterval: 80000
    }

    def execute() {
        generalService.actualizarEstadoVencimientos()
        log.info("Hola corri job Actualizar estado:. Todos los estados de vencimientos han sido actualizados exitosamente")  

    }
}
