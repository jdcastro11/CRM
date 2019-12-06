package crm
import grails.converters.*
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class EmpleadoController extends BaseController{

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
   
    def generalService
   def filterPaneService
    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max =  itemxview
        String  xoffset=params.offset?:0
        if(!params.filter) params.filter = [op:[:]]
     
        params.filter.op.eliminado = "Equal"     
        params.filter.eliminado = '0'
        
        
        //  def query="from Empleado p where p.idTipoEmpleado in ('pervendedo', 'peremplead') and  eliminado=0 order by primerNombre,primerApellido"
        //  def queryc=" select count(p) from Empleado p where p.idTipoEmpleado in ('pervendedo', 'peremplead') and  eliminado=0"

        //  def empleadoInstanceList=Empleado.findAll(query,[max:params.max,offset:xoffset.toLong()])
        //def cuantos=Empleado.executeQuery(queryc)
	
        render view: "index", model: [empleadoInstanceList:filterPaneService.filter(params, Empleado),
            empleadoInstanceCount:filterPaneService.count(params,Empleado), 
            filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
            xtitulo: generalService?.getValorParametro('empleadt01')]
		        
    }
     
    def listarBorrados(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max = Math.min(max?: itemxview, 100)
        String  xoffset=params.offset?:0

        def query="from Empleado p where  p.eliminado=1 "
        def queryc=" select count(p) from Empleado p where p.eliminado=1"

        def empleadoInstanceList=Empleado.findAll(query,[max:params.max,offset:xoffset.toLong()])
        def empleadoInstanceCount=Empleado.executeQuery(queryc)
		
        render view: "index", model: [empleadoInstanceList: empleadoInstanceList,
            empleadoInstanceCount: empleadoInstanceCount,
            itemxview: itemxview,
            xtitulo: generalService?.getValorParametro('empleadt02')]
		        
    }

    def show(Empleado empleadoInstance) {
        // def x =generalService.getValorParametro('vinactiva') 
        
        render view:"show", model:[empleadoInstance:empleadoInstance,generalService:generalService]
    }

    def create() {
        respond new Empleado(params)
    }

    @Transactional //save
    def save(Empleado empleadoInstance) {
         
        if (empleadoInstance == null) {
            notFound()
            return
        }

        if (empleadoInstance.hasErrors()) {
            respond empleadoInstance.errors, view:'create'
            return
        }

        empleadoInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'empleadoInstance.label', default: 'Empleado'), empleadoInstance.id])
                redirect action: "index"
            }
            '*' { respond empleadoInstance, [status: CREATED] }
        }
    }
	
    @Transactional
    def borrar(Empleado empleadoInstance) {

        if (params.id == null) {
            notFound()
            return
        }
		
        println empleadoInstance.properties
        empleadoInstance= Empleado.get(params.id)
		
        empleadoInstance.eliminado=1

        empleadoInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Empleado.label', default: 'Empleado'), empleadoInstance.id])
                redirect action: "index"
            }
            '*'{ respond lineaInstance, [status: OK] }
        }
    }
	
    def edit(Empleado empleadoInstance) {
        respond empleadoInstance
    }

    @Transactional //update
    def update(Empleado empleadoInstance) {

        empleadoInstance=Empleado.get(params.id)

        if (empleadoInstance == null) {
            notFound()
            return
        }

        if (empleadoInstance.hasErrors()) {
            respond empleadoInstance.errors, view:'edit'
            return
        }

        empleadoInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Empleado.label', default: 'Empleado'), empleadoInstance.id])
                redirect action: "index"
            }
            '*'{ respond empleadoInstance, [status: OK] }
        }
    }
	
    @Transactional //delete
    def delete(Empleado empleadoInstance) {

        if (empleadoInstance == null) {
            notFound()
            return
        }

        empleadoInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Empleado.label', default: 'Empleado'), empleadoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.warning = message(code: 'default.not.found.message', args: [message(code: 'empleadoInstance.label', default: 'Empleado'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
