package crm



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class DefLogController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def generalService 
    
    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max = itemxview
        String  xoffset=params.offset?:0 
       
        def query="from DefLog where nomEntidad='${params.id}' and eliminado=0"
        def defLogInstanceList=DefLog.findAll(query,[max:params.max,offset:xoffset.toLong()])
        
        respond defLogInstanceList, model:[defLogInstanceCount: DefLog.countByNomEntidadAndEliminado(params.id,0),
                                           xentidad:params.id]
    }
    
     def listarBorrados(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max = itemxview
        String  xoffset=params.offset?:0 
        
        def query="from DefLog where nomEntidad='${params.id}' and eliminado=1"
        def defLogInstanceList=DefLog.findAll(query,[max:params.max,offset:xoffset.toLong()])
       
        render view:"index",  model:[defLogInstanceList:defLogInstanceList,
                                     defLogInstanceCount: DefLog.countByNomEntidadAndEliminado(params.id,1),
                                     xentidad:params.id]
    }
    
    def listarAuditables(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max = itemxview
        String  xoffset=params.offset?:0 
        
        def query="from ValorParametro  where idParametro='entidaudit' and eliminado=0 and estadoValorParametro='A' order by descValParametro"
        
      //  def queryc="select count(v)  from ValorParametro v where idParametro='entidaudit' and eliminado=0 and estadoValorParametro='A'"
        
        def auditableInstanceList=ValorParametro.findAll(query,[max:params.max,offset:xoffset.toLong()])
        
       // def xcount=ValorParametro.executeQuery(queryc)
        
        render view :'listarEntidades', model:[auditableInstanceList:auditableInstanceList,
                                        auditableInstanceCount:ValorParametro.countByIdParametroAndEstadoValorParametroAndEliminado('entidaudit','A',0)]
    }
    
    def borrar() {

        if (params.id == null) {
            notFound()
            return
        }

        defLogInstance= DefLog.get(params.id)

        defLogInstance.eliminado=1

        defLogInstance.save flush:true
        flash.warning="Registro  ha sido Borrado"
        redirect url:"/defLog/index/${defLogInstance?.nomEntidad}"
            
    }

    def mostrar() {
        render view:"mostrar",model:[xentidad:params.id,xnom:params.nom]
    }
    
    def show(DefLog defLogInstance) {
        respond defLogInstance
    }

    def create() {
        respond new DefLog(params)
    }

    @Transactional // save
    def save(DefLog defLogInstance) {
        if (defLogInstance == null) {
            notFound()
            return
        }
        defLogInstance.validate()

        if (defLogInstance.hasErrors()) {
            respond defLogInstance.errors, view:'create'
            return
        }

        defLogInstance.save flush:true

        request.withFormat {
            form {
                flash.warning ="Registro creado exitosamente"
                redirect url:"/defLog/index/${defLogInstance?.nomEntidad}"
            }
            '*' { respond defLogInstance, [status: CREATED] }
        }
    }

    def edit(DefLog defLogInstance) {
        respond defLogInstance
    }

    @Transactional // update
    def update(DefLog defLogInstance) {
        if (defLogInstance == null) {
            notFound()
            return
        }

        defLogInstance.validate()
        if (defLogInstance.hasErrors()) {
            respond defLogInstance.errors, view:'edit'
            return
        }

        defLogInstance.save flush:true

        request.withFormat {
            form {
                flash.warning="Registro creado exitosamente"
                redirect url:"/defLog/index/${params.nomEntidad}"
            }
            '*'{ respond defLogInstance, [status: OK] }
        }
    }

    @Transactional  //delete 
    def delete(DefLog defLogInstance) {

        if (defLogInstance == null) {
            notFound()
            return
        }

        defLogInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DefLog.label', default: 'DefLog'), defLogInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'defLogInstance.label', default: 'DefLog'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
