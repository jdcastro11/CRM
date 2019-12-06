package crm



class AtenderProspectosJob {
	def generalService
	
   static triggers = {   
        // Se-Mi-Ho-Dm-Me-Ds-A
        //cron name: 'avisarTrigger', cronExpression: "0 30 06 * * ?"
		//cron name: 'atenderProspectosTrigger', cronExpression: "0 52 05 * * ?"
	   cron name: 'atenderProspectosTrigger', cronExpression: "0 57 05 * * ?"
    }

    def execute() {
        generalService.notificarProspectosSinAtender()
		log.info("Job de atender prospectos ejecutado..")
    }
}
