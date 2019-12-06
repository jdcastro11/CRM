package crm



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PiezaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	def generalService

    def index(Integer max) {
		
		
		int itemxview=generalService.getItemsxView(0)
		params.max = itemxview
		String  xoffset=params.offset?:0
		
		//def query="from Tactica where eliminado=0 order by tactica"
		def query="From Pieza where tactica.id='${params.id}' and eliminado=0"
		def queryc="Select count(p) from Pieza p where p.tactica.id='${params.id}' and  p.eliminado=0"
		
		def piezaInstanceList=Pieza.findAll(query,[max:params.max,offset:xoffset.toLong()])
		def xnum = Pieza.executeQuery(queryc)[0]
		respond piezaInstanceList, model:[piezaInstanceCount: xnum]
		

    }
	
	
	def listarBorrados(Integer max)
	{
		int itemxview=generalService.getItemsxView(0)
		params.max =itemxview
		String  xoffset=params.offset?:0		
		
		
		def tactica_id=session.getAttribute("tactica_id")
		
		println "IDESTRA "+tactica_id
		
		def query="from Pieza as p where p.eliminado=1 and p.tactica=${tactica_id}"
		def PiezaInstanceList=Pieza.findAll(query,[max:params.max,offset:xoffset.toLong()])

		render view: "index" , model:[piezaInstanceList:PiezaInstanceList,
									  piezaInstanceCount: Pieza.countByEliminado(1),itemxview:itemxview]
	}

    def show(Pieza piezaInstance) {
        respond piezaInstance
    }

    def create() {
		
		println "mis parametros create sonnnnnnn "+params
        respond new Pieza(params)
    }

    @Transactional
    def save(Pieza piezaInstance) {
		
		println "mis parametros de hiddenfield create sonnnnnnn "+params.idTactica
		
		
        if (piezaInstance == null) {
            notFound()
            return
        }
		piezaInstance.tactica=Tactica.get(params.idTactica)		
		piezaInstance.validate()

        if (piezaInstance.hasErrors()) {
            respond piezaInstance.errors, view:'create'
            return
        }

        piezaInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'piezaInstance.label', default: 'Pieza'), piezaInstance.id])
                //redirect piezaInstance
				redirect url :"/pieza/index/"+piezaInstance?.tactica?.id
            }
            '*' { respond piezaInstance, [status: CREATED] }
        }
    }

    def edit(Pieza piezaInstance) {
        respond piezaInstance
    }

    @Transactional
    def update(Pieza piezaInstance) {
        if (piezaInstance == null) {
            notFound()
            return
        }

        if (piezaInstance.hasErrors()) {
            respond piezaInstance.errors, view:'edit'
            return
        }

        piezaInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Pieza.label', default: 'Pieza'), piezaInstance.id])
                redirect piezaInstance
            }
            '*'{ respond piezaInstance, [status: OK] }
        }
    }
	
	
	@Transactional   // Borrar
	def borrar(Pieza piezaInstance) {

		if (params.id == null) {
			notFound()
			return
		}

		piezaInstance= Pieza.get(params.id)

		piezaInstance.eliminado=1

		piezaInstance.save flush:true

		request.withFormat {
			form {
				flash.message = message(code: 'default.updated.message', args: [message(code: 'pieza.label', default: 'Pieza'), piezaInstance.id])
				  redirect url :"/pieza/index/"+piezaInstance?.tactica?.id
			}
			'*'{ respond piezaInstance, [status: OK] }
		}
	}

    @Transactional
    def delete(Pieza piezaInstance) {

        if (piezaInstance == null) {
            notFound()
            return
        }

        piezaInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Pieza.label', default: 'Pieza'), piezaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'piezaInstance.label', default: 'Pieza'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
