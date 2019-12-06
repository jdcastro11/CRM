package crm



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class EncVencimientoController extends BaseController{

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

   def generalService  
   def filterPaneService

    def filter(){
        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview 
        String  xoffset=params.offset?:0
		
        if(!params.filter) params.filter = [op:[:]]
        params.filter.op.eliminado = "Equal"     
        params.filter.eliminado = '0' 

        render view: 'index',  model:[ encVencimientoInstanceList: filterPaneService.filter( params, EncVencimiento ),
            encVencimientoInstanceCount: filterPaneService.count( params, EncVencimiento ),
            filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
            params:params, xtitulo:generalService.getValorParametro('encvenct01')]
    }

    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max = Math.min(max?: itemxview, 100)  
        String  xoffset=params.offset?:0
       
        def query="from EncVencimiento as ev where ev.eliminado=0 order by ev.empresa.razonSocial"
        def encVencimientoInstanceList=EncVencimiento.findAll(query,[max:params.max,offset:xoffset.toLong()])

        respond  encVencimientoInstanceList, model:[encVencimientoInstanceCount:EncVencimiento.countByEliminado(0),
                                               xtitulo:generalService.getValorParametro('encvenct01'),sw:1]
    }
 def listarBorrados(Integer max) {
       int itemxview=generalService.getItemsxView(0) 
        params.max = Math.min(max ?: itemxview, 100)
        String  xoffset=params.offset?:0
       
        def query="from EncVencimiento as e where e.eliminado=1"
        def encVencimientoInstanceList=EncVencimiento.findAll(query,[max:params.max,offset:xoffset.toLong()])  
        
        render view: "index", model:[encVencimientoInstanceList:encVencimientoInstanceList,
                                              encVencimientoInstanceCount:EncVencimiento.countByEliminado(1),
                                              itemxview:itemxview,
                                              xtitulo:generalService.getValorParametro('encvenct05'),sw:0]
    }
    
    @Transactional
    def borrar(EncVencimiento encVencimientoInstance) {
     
        if (params.id == null) {
            notFound()
            return
        }
       
        encVencimientoInstance= EncVencimiento.get(params.id)

        encVencimientoInstance.eliminado=1

       encVencimientoInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'EncVencimiento.label', default: 'Vencimiento'), encVencimientoInstance.id])
                redirect  action:"index"
            }
            '*'{ respond encVencimientoInstance, [status: OK] }
        }
    }


    def show(EncVencimiento encVencimientoInstance) {
        respond encVencimientoInstance,model:[sw:0]
	
		
		
    }

    def create() {
        respond new EncVencimiento(params)
    }

    @Transactional
    def save(EncVencimiento encVencimientoInstance) {
        
        if (encVencimientoInstance == null) {
            notFound()
            return
        }
        
         if (params.idempresa){   
            encVencimientoInstance.empresa=Empresa.get(params.idempresa)
        }
        
        if (params.idContacto) { 
            encVencimientoInstance.persona=Persona.get(params.idContacto)
        }
        if (params.idVendedor) { 
            encVencimientoInstance.empleado=Empleado.get(params.idVendedor)
        }
        
        
        encVencimientoInstance.validate()
        
        if (encVencimientoInstance.hasErrors()) {
            respond encVencimientoInstance.errors, view:'create'
            return
        }

        encVencimientoInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'encVencimientoInstance.label', default: 'EncVencimiento'), encVencimientoInstance.id])
                 redirect url: "/EncVencimiento/edit/"+encVencimientoInstance.id
            }
            '*' { respond encVencimientoInstance, [status: CREATED] }
        }
    }

    def edit(EncVencimiento encVencimientoInstance) {
        respond encVencimientoInstance,model:[sw:1]
    }

    @Transactional
    def update(EncVencimiento encVencimientoInstance) {
        if (encVencimientoInstance == null) {
            notFound()
            return
        }

         if (params.idempresa){   
            encVencimientoInstance.empresa=Empresa.get(params.idempresa)
        }
        
        if (params.idContacto) { 
            encVencimientoInstance.persona=Persona.get(params.idContacto)
        }
        
         if (params.idVendedor) { 
            encVencimientoInstance.empleado=Empleado.get(params.idVendedor)
        }
        encVencimientoInstance.validate()
        
        if (encVencimientoInstance.hasErrors()) {
            respond encVencimientoInstance.errors, view:'edit'
            return
        }

        encVencimientoInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'EncEncVencimiento.label', default: 'EncVencimiento'), encVencimientoInstance.id])
               redirect url:"/EncVencimiento/index/"
            }
            '*'{ respond encVencimientoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(EncVencimiento encVencimientoInstance) {

        if (encVencimientoInstance == null) {
            notFound()
            return
        }

        encVencimientoInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'EncEncVencimiento.label', default: 'EncVencimiento'), encVencimientoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'encVencimientoInstance.label', default: 'EncVencimiento'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    

}
