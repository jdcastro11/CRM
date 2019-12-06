package crm

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
@Transactional(readOnly = true)
class ParametroController extends BaseController{

    static allowedMethods = [save: "POST", update: "PUT",delete: "DELETE"]    
     
    def generalService   
    def filterPaneService
    
    def filter(){

        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview
        String  xoffset=params.offset?:0
        
        if(!params.filter) params.filter = [op:[:]]
        params.filter.op.eliminado = "Equal"
        params.filter.eliminado = '0' 
        println params
        render view: 'index',  model:[ parametroInstanceList: filterPaneService.filter( params, Parametro ),
                        parametroInstanceCount: filterPaneService.count( params, Parametro ),
                        filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
                        params:params, xtitulo:generalService?.getValorParametro('parametr00')]
    }

    def index(Integer max) {
        
        int itemxview=generalService.getItemsxView(0) 
        params.max = Math.min(max?: itemxview, 100)

        String  xoffset=params.offset?:0
       if(!params.filter) params.filter = [op:[:]]
        params.filter.op.eliminado = "Equal"
        params.filter.eliminado = '0' 
        println params
        def parametroInstanceList=filterPaneService.filter(params,Parametro)
        def parametroInstanceCount=filterPaneService.count(params,Parametro)
               
        respond parametroInstanceList, model:[parametroInstanceCount:parametroInstanceCount,itemxview:itemxview,sw:1,
                                             xtitulo:generalService?.getValorParametro('parametr01')]
        
    }
    
    def listarBorrados(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max = Math.min(max ?: itemxview, 100)
        render view: "index" , model:[parametroInstanceList:Parametro.findAllByEliminado(1),
            parametroInstanceCount: Parametro.findAllByEliminado(1).size(),
            itemxview:itemxview,
            xtitulo:generalService?.getValorParametro('vt02'),
            sw:0]
    }
    def eliminar(Integer max) {
      
        def xparamIds=params.list("parametros")
        
        respond Parametro.getAll(xparamIds)
    }

    def show(Parametro parametroInstance) {
        respond parametroInstance
        // render view:'read', model:[parametroInstance:parametroInstance]
    }

    def create() {
        respond new Parametro(params)
    }

    @Transactional
    def save(Parametro parametroInstance) {
        if (parametroInstance == null) {
            notFound()
            return
        }

        if (parametroInstance.hasErrors()) {
            respond parametroInstance.errors, view:'create'
            return
        }

        parametroInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'parametroInstance.label', default: 'Parametro'), parametroInstance.id])
                redirect action:"index"
            }
            '*' { respond parametroInstance, [status: CREATED] }
        }
    }

    def edit(Parametro parametroInstance) {
        respond parametroInstance
    }

    @Transactional
    def borrar(Parametro parametroInstance) {
     
        if (params.id == null) {
            notFound()
            return
        }
       
        parametroInstance= Parametro.get(params.id)

        parametroInstance.eliminado=1

        parametroInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Parametro.label', default: 'Parametro'), parametroInstance.id])
                redirect action:"index"
            }
            '*'{ respond parametroInstance, [status: OK] }
        }
    }

    @Transactional
    def update(Parametro parametroInstance) {
        if (parametroInstance == null) {
            notFound()
            return
        }

        if (parametroInstance.hasErrors()) {
            respond parametroInstance.errors, view:'edit'
            return
        }

        parametroInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Parametro.label', default: 'Parametro'), parametroInstance.id])
                redirect action:"index"
            }
            '*'{ respond parametroInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Parametro parametroInstance) {

        if (parametroInstance == null) {
            notFound()
            return
        }

        parametroInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Parametro.label', default: 'Parametro'), parametroInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'parametroInstance.label', default: 'Parametro'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
