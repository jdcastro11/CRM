package crm

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ValorParametroController extends BaseController{

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
    
     def generalService   
     def filterPaneService
       
        
    def index(Integer max) {
        
       int itemxview=generalService.getItemsxView(0) 
        params.max = itemxview    
      
                 
        def xidparametro
        if (params.id)
           xidparametro=params.id
        else
           xidparametro=session.idparametro  
        
     
        
        if(!params.filter) params.filter = [op:[:]]
        params.filter.op.eliminado = "Equal"             
        params.filter.eliminado = '0' 
        params.filter.op.idParametro='Equal'
        params.filter.idParametro=xidparametro
        params.sort='orden'
        params.idp=params.idp
        def xidp=params.idp
        
        println params 
        def xtitulo=generalService.getValorParametro('valparat00')
        
       def valorParametroInstanceList = filterPaneService.filter(params,ValorParametro)        
       def valpCount=filterPaneService.count( params, ValorParametro)
        println   valorParametroInstanceList
        render view:"index", model:[ valorParametroInstanceList:valorParametroInstanceList,
                                     valorParametroInstanceCount:valpCount,
                                     filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
                                     itemxview:itemxview, xidp:xidp,xidparametro:xidparametro,xtitulo:xtitulo,
                                     xidparametro:xidparametro,params:params]
    }
    
   def listarBorrados(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview
        
         def query="from ValorParametro as vp where vp.idParametro='${params.id}' and vp.eliminado=1"
        render view: "index" , model:[valorParametroInstanceList:ValorParametro.findAll(query),
                                               valorParametroInstanceCount: ValorParametro.countByEliminado(1),
                                               itemxview:itemxview,xtitulo:generalService.getValorParametro('valparat05')]
    }
    
    def show(ValorParametro valorParametroInstance) {
        respond valorParametroInstance
    }

    def create() {
        respond new ValorParametro(params)
    }

    @Transactional //save
    def save(ValorParametro valorParametroInstance) {
        if (valorParametroInstance == null) {
            notFound()
            return
        }
               
       if (params.parametroID){
        valorParametroInstance.parametro=Parametro.get(params.parametroID)
       }else{
             def parametroInstance=Parametro.findByIdParametro(params.idParametro)
            valorParametroInstance.parametro=parametroInstance
        }
        
       valorParametroInstance.validate()
         
        if (valorParametroInstance.hasErrors()) {
            respond valorParametroInstance.errors, view:'create'
            return
        }

        valorParametroInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'valorParametroInstance.label', default: 'ValorParametro'), valorParametroInstance.id])
                redirect url:"/valorParametro/index/"+valorParametroInstance.idParametro+"?idp="+valorParametroInstance.parametro.id
            }
            '*' { respond valorParametroInstance, [status: CREATED] }
        }
    }

    def edit(ValorParametro valorParametroInstance) {
        respond valorParametroInstance
    }

    @Transactional //update 
    def update(ValorParametro valorParametroInstance) {
       
        valorParametroInstance=ValorParametro.get(params.id)
        
        if (valorParametroInstance == null) {
            notFound()
            return
        }
        
        valorParametroInstance.parametro=Parametro.get(params.parametroID)        
        valorParametroInstance.validate()
       
        if (valorParametroInstance.hasErrors()) {
            respond valorParametroInstance.errors, view:'edit'
            return
        }
         println params
         println valorParametroInstance.properties
         valorParametroInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ValorParametro.label', default: 'ValorParametro'), valorParametroInstance.id])
                redirect url:"/valorParametro/index/"+valorParametroInstance.idParametro+"?idp="+valorParametroInstance.parametro.id
            }
            '*'{ respond valorParametroInstance, [status: OK] }
        }
    }
    
    @Transactional //borrar
    def borrar(ValorParametro valorParametroInstance) {
     
        if (params.id == null) {
            notFound()
            return
        }
       
        valorParametroInstance= ValorParametro.get(params.id)

        valorParametroInstance.eliminado=1

        valorParametroInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ValorParametro.label', default: 'ValorParametro'), valorParametroInstance.id])
                 redirect url:"/valorParametro/index/"+valorParametroInstance.idParametro
            }
            '*'{ respond parametroInstance, [status: OK] }
        }
    }
    
    @Transactional // delete 
    def delete(ValorParametro valorParametroInstance) {

        if (valorParametroInstance == null) {
            notFound()
            return
        }

        valorParametroInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ValorParametro.label', default: 'ValorParametro'), valorParametroInstance.id])
                redirect url:"/valorParametro/index/"+valorParametroInstance.idParametro
                //redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'valorParametroInstance.label', default: 'ValorParametro'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
