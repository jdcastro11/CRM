package crm

class AvisarVencimientoJob {
    def generalService
    
    static triggers = {   
        // Se-Mi-Ho-Dm-Me-Ds-A
        //cron name: 'avisarTrigger', cronExpression: "0 30 06 * * ?"
		cron name: 'avisoVencimientoTrigger', cronExpression: "0 52 05 * * ?"
    }

    def execute() {
        generalService.notificarVencimientos2()
		log.info("Job de notificar vencimientos ejecutado..")
    }
 
    
}
