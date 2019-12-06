package crm



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class EstrategiaController extends BaseController{

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]     
     
    def generalService   
	def exportarService

    def index(Integer max) {
		
		println "MIS PARMETROS "+params
        int itemxview=generalService.getItemsxView(0) 
        params.max = Math.min(max?: itemxview, 100)
        String  xoffset=params.offset?:0

        def query="from Estrategia  where eliminado=0 order by descripcion"
        def estrategiaInstanceList=Estrategia.findAll(query,[max:params.max,offset:xoffset.toLong()])
        respond estrategiaInstanceList, model:[estrategiaInstanceCount: Estrategia.countByEliminado(0)]
    }
   
    def listarBorrados(Integer max) {

        int itemxview=generalService.getItemsxView(0) 
        params.max = Math.min(max ?: itemxview, 100)
        String  xoffset=params.offset?:0

        def query="from Estrategia  where eliminado=1 order by descripcion"
        def estrategiaInstanceList=Estrategia.findAll(query,[max:params.max,offset:xoffset.toLong()])

        render view: "index" , model:[estrategiaInstanceList:estrategiaInstanceList,
            estrategiaInstanceCount: Estrategia.countByEliminado(1),
            itemxview:itemxview]
    }


    def eliminarDatos=
    {
        def ids=params.list('estrategias')?:params.int('id')//ids de las estrategias		
		int num_tacticas_activas=0
		//println "SIZE "+ids.size()
		if(ids)
		{
			
			ids.each {
				println "Valor es =${it}"
				def query="from Tactica as t where t.estrategia=${it} and t.eliminado=0"
				def queryresults = Tactica.findAll(query)
				num_tacticas_activas+=queryresults.size()
				println "NUMAXAS"+num_tacticas_activas
			}
			
			if(num_tacticas_activas==0)//si no hay registros con tacticas activas se puede borrar
			ids.each {
				Estrategia.executeUpdate("update Estrategia e set e.eliminado=1 where e.id=${it}")
				flash.message="Registro(s) eliminados exitosamente"
			}
            else {
            flash.message="Existe al menos una Táctica  asociada a esta estrategia. Elimine primero las tácticas, luego la estrategia"
           //redirect url:"/estrategia/index/"
			}			
		}		
		redirect(action:'index')
	 }

    def show(Estrategia estrategiaInstance) {
		session["estrategia_id"]=params.id
        respond estrategiaInstance,model:[sw:0]
    }

    def create() {
        respond new Estrategia(params),model:[sw:1]
    }
    
    @Transactional  // borrar 
    def borrar(Estrategia estrategiaInstance) {

        if (params.id == null) {
            notFound()
            return
        }
        if (generalService.hayInstancias('crm.Tactica', params.id,'e.estrategia.id') ){
           flash.message="Existe al menos una Táctica  asociada a esta estrategia. Elimine primero las tácticas, luego la estrategia"
           redirect url:"/estrategia/index/"
           return
       }
        estrategiaInstance= Estrategia.get(params.id)

        estrategiaInstance.eliminado=1

        estrategiaInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Empresa.label', default: 'Empresa'), estrategiaInstance.id])
                redirect url:"/estrategia/index/"
            }
            '*'{ respond estrategiaInstance, [status: OK] }
        }
    }
    
    @Transactional               //save
    def save(Estrategia estrategiaInstance) {
        if (estrategiaInstance == null) {
            notFound()
            return
        }

        if (estrategiaInstance.hasErrors()) {
            respond estrategiaInstance.errors, view:'create'
            return
        }

        estrategiaInstance.save flush:true

        request.withFormat {
            form {
                // flash.message = message(code: 'default.created.message', args: [message(code: 'estrategiaInstance.label', default: 'Estrategia'), estrategiaInstance.id])
                redirect url:"/estrategia/edit/"+estrategiaInstance.id
            }
            '*' { respond estrategiaInstance, [status: CREATED] }
        }
    }

    def edit(Estrategia estrategiaInstance) {
        respond estrategiaInstance,model:[sw:1]
    }

    @Transactional                     // update
    def update(Estrategia estrategiaInstance) {
        if (estrategiaInstance == null) {
            notFound()
            return
        }

        if (estrategiaInstance.hasErrors()) {
            respond estrategiaInstance.errors, view:'edit'
            return
        }

        estrategiaInstance.save flush:true

        request.withFormat {
            form {
                //flash.message = message(code: 'default.updated.message', args: [message(code: 'Estrategia.label', default: 'Estrategia'), estrategiaInstance.id])
                redirect url:"/estrategia/index"
            }
            '*'{ respond estrategiaInstance, [status: OK] }
        }
    }

    @Transactional  // delete
    def delete(Estrategia estrategiaInstance) {

        if (estrategiaInstance == null) {
            notFound()
            return
        }

        estrategiaInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Estrategia.label', default: 'Estrategia'), estrategiaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'estrategiaInstance.label', default: 'Estrategia'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}