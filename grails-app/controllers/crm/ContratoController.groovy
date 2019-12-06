package crm



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ContratoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def generalService
    def filterPaneService

    @Transactional
    def index(Integer max) {
        //params.max = Math.min(max ?: 10, 100)

        int itemxview=generalService.getItemsxView(0)
        params.max = Math.min(max ?: itemxview, 100)

        //generalService.actualizarEstadoContratos()

        def contratoInstanceList

        if(!params.filter) params.filter = [op:[:],seriales:[:]]


        if(params.filter.idTipoVencimiento)
            params.filter.idTipoVencimiento=generalService.getIdValorParametro('tipovencim',params.filter.idTipoVencimiento)

        if(params.filter.idTipoCobertura)
            params.filter.idTipoCobertura=generalService.getIdValorParametro('tipocobert',params.filter.idTipoCobertura)






        if(params.filter.serial)
        {
            contratoInstanceList=filterPaneService.filter(params,Contrato)


            def query="Select s.contrato from Seriales as s Where s.numSerial like '%${params.filter.serial}%'"
            //println "My query es... "+query
            def resultado=Seriales.executeQuery(query)
            //println "El id del vencimiento con este serial en archivo es... "+resultado
            contratoInstanceList.addAll(resultado)


        }else
            contratoInstanceList=filterPaneService.filter(params,Contrato)






        render view: "index", model:[contratoInstanceList:contratoInstanceList,
                                     contratoInstanceCount: filterPaneService.count( params, Contrato ),params:params,
                                                     filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
                                                     itemxview:itemxview,
                                                     xtitulo:generalService.getValorParametro('contrat01'),sw:0]


        //respond Contrato.list(sort: "idEstadoVencimiento", order: "asc"), model:[contratoInstanceCount: Contrato.count()]


    }


    def clienteNoRenovo(){
        println "LOS PARAMETROS DE CLIENTE NO RENOVÓ SON......... "+params
        //render params
    }




    def show(Contrato contratoInstance) {
        respond contratoInstance
    }

    def create() {
        respond new Contrato(params)
    }

    @Transactional
    def save(Contrato contratoInstance) {
        if (contratoInstance == null) {
            notFound()
            return
        }

        if (contratoInstance.hasErrors()) {
            respond contratoInstance.errors, view:'create'
            return
        }

        contratoInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'contratoInstance.label', default: 'Contrato'), contratoInstance.id])
                redirect contratoInstance
            }
            '*' { respond contratoInstance, [status: CREATED] }
        }
    }

    def edit(Contrato contratoInstance) {
        respond contratoInstance
    }

    @Transactional
    def update(Contrato contratoInstance) {
        if (contratoInstance == null) {
            notFound()
            return
        }

        if (contratoInstance.hasErrors()) {
            respond contratoInstance.errors, view:'edit'
            return
        }

        contratoInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Contrato.label', default: 'Contrato'), contratoInstance.id])
                redirect contratoInstance
            }
            '*'{ respond contratoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Contrato contratoInstance) {

        if (contratoInstance == null) {
            notFound()
            return
        }

        contratoInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Contrato.label', default: 'Contrato'), contratoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'contratoInstance.label', default: 'Contrato'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
