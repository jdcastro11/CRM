package crm



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional
class LineaController extends BaseController{

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]     
     
    def generalService   

    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max = Math.min(max?: itemxview, 100)
        String  xoffset=params.offset?:0

        def query="from Linea  where eliminado=0 order by descLinea"
        def lineaInstanceList=Linea.findAll(query,[max:params.max,offset:xoffset.toLong()])

        respond lineaInstanceList, model:[lineaInstanceCount: Linea.countByEliminado(0),
            xtitulo:generalService?.getValorParametro('lineat01')]
    }
   
    def listarBorrados(Integer max) {

        int itemxview=generalService.getItemsxView(0) 
        params.max = Math.min(max ?: itemxview, 100)
        String  xoffset=params.offset?:0

        def query="from Linea  where eliminado=1 order by descLinea"
        def lineaInstanceList=Linea.findAll(query,[max:params.max,offset:xoffset.toLong()])

        render view: "index" , model:[lineaInstanceList:lineaInstanceList,
            lineaInstanceCount: Linea.countByEliminado(1),
            itemxview:itemxview,xtitulo:generalService?.getValorParametro('lineat02')]
    }

    def show(Linea lineaInstance) {
        respond lineaInstance,model:[sw:0]
    }

    def create() {
        respond new Linea(params),model:[sw:1]
    }
    
    @Transactional
    def borrar(Linea lineaInstance) {
		
		

        /*if (params.id == null) {
            notFound()
            return
        }

        lineaInstance= Linea.get(params.id)

        lineaInstance.eliminado=1

        lineaInstance.save flush:true*/
		
		
		def listaLineas=new ArrayList()
		if(params?.lineas!=null)//SI SE DECIDIO BORRAR DESDE AFUERA
		{
			listaLineas.addAll(params?.lineas)
			listaLineas.each {
				Linea linea=Linea.get(it)
				println linea
				linea.eliminado=1				
				linea.save(flush:true)
				
				generalService.eliminarSublineasFromLinea("${it}")
				
				//def query="Update Sublinea set eliminado=1 Where linea.id=${it}"
				//Sublinea.executeUpdate(query)				
			}
		}
		else //SI NO SE MARCÓ NINGUNA PARA BORRAR DESDE AFUERA		
		{			
			
			if(params.id)//SI SE DECIDIO ELIMINAR LINEA DESDE ADENTRO
			{
				lineaInstance= Linea.get(params.long('id'))
				lineaInstance.eliminado=1
				lineaInstance.save flush:true
				generalService.eliminarSublineasFromLinea(params.id)
			}
			else
			{
				flash.warning = message(code: 'default.select.one')
				redirect url:"/linea/index/"
				return
			}
			
			
		}

        request.withFormat {
            form {
                //flash.message = message(code: 'default.updated.message', args: [message(code: 'Empresa.label', default: 'Empresa'), lineaInstance.id])
				flash.message="Linea(s) eliminadas exitosamente"
                redirect url:"/linea/index/"
            }
            '*'{ respond lineaInstance, [status: OK] }
        }
    }
    
    @Transactional
    def save(Linea lineaInstance) {
        if (lineaInstance == null) {
            notFound()
            return
        }

        if (lineaInstance.hasErrors()) {
            respond lineaInstance.errors, view:'create'
            return
        }

        lineaInstance.save flush:true

        request.withFormat {
            form {
                // flash.message = message(code: 'default.created.message', args: [message(code: 'lineaInstance.label', default: 'Linea'), lineaInstance.id])
                redirect url:"/linea/edit/"+lineaInstance.id
            }
            '*' { respond lineaInstance, [status: CREATED] }
        }
    }

    def edit(Linea lineaInstance) {
        respond lineaInstance,model:[sw:1]
    }

    @Transactional
    def update(Linea lineaInstance) {
        if (lineaInstance == null) {
            notFound()
            return
        }

        if (lineaInstance.hasErrors()) {
            respond lineaInstance.errors, view:'edit'
            return
        }

        lineaInstance.save flush:true

        request.withFormat {
            form {
                //flash.message = message(code: 'default.updated.message', args: [message(code: 'Linea.label', default: 'Linea'), lineaInstance.id])
                redirect url:"/linea/index"
            }
            '*'{ respond lineaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Linea lineaInstance) {

        if (lineaInstance == null) {
            notFound()
            return
        }

        lineaInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Linea.label', default: 'Linea'), lineaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'lineaInstance.label', default: 'Linea'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
