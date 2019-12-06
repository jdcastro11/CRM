package crm



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class EncLogController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
     def generalService
    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max = itemxview
        String  xoffset=params.offset?:0 
        
    def query="from EncLog  where idEntidad=${params.id} and nomEntidad='${params.entidad}' and eliminado=0 order by fecha desc"
        
    def queryc="select count(e) from EncLog e  where idEntidad=${params.id} and nomEntidad='${params.entidad}' and eliminado=0"
        
    def encLogInstanceList=EncLog.findAll(query,[max:params.max,offset:xoffset.toLong()])
        
    def xcount=EncLog.executeQuery(queryc)
        
    render view :'index', model:[encLogInstanceList:encLogInstanceList,
                                 encLogInstanceCount: xcount[0],xidentidad:params.id,
                                 xentidad:params.entidad]
    }

    def show(EncLog encLogInstance) {
        respond encLogInstance
    }

    def create() {
        respond new EncLog(params)
    }

    @Transactional  // save
    def save(EncLog encLogInstance) {
        if (encLogInstance == null) {
            notFound()
            return
        }

        if (encLogInstance.hasErrors()) {
            respond encLogInstance.errors, view:'create'
            return
        }

        encLogInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'encLogInstance.label', default: 'EncLog'), encLogInstance.id])
                redirect encLogInstance
            }
            '*' { respond encLogInstance, [status: CREATED] }
        }
    }

    def edit(EncLog encLogInstance) {
        respond encLogInstance
    }

    @Transactional   // update
    def update(EncLog encLogInstance) {
        if (encLogInstance == null) {
            notFound()
            return
        }

        if (encLogInstance.hasErrors()) {
            respond encLogInstance.errors, view:'edit'
            return
        }

        encLogInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'EncLog.label', default: 'EncLog'), encLogInstance.id])
                redirect encLogInstance
            }
            '*'{ respond encLogInstance, [status: OK] }
        }
    }

    @Transactional  //delete 
    def delete(EncLog encLogInstance) {

        if (encLogInstance == null) {
            notFound()
            return
        }

        encLogInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'EncLog.label', default: 'EncLog'), encLogInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'encLogInstance.label', default: 'EncLog'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
