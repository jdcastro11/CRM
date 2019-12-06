package crm

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class DetLogController {

  static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
  def generalService
  def index(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max = itemxview
        String  xoffset=params.offset?:0 
        
        def query="from DetLog  where enclog.id=${params.id} and eliminado=0"
        
        def queryc="select count(e) from DetLog e  where enclog.id=${params.id} and eliminado=0"
        
        def detLogInstanceList=DetLog.findAll(query,[max:params.max,offset:xoffset.toLong()])
        
        def xcount=DetLog.executeQuery(queryc)
        
        render view:'index', model:[detLogInstanceList:detLogInstanceList,detLogInstanceCount:xcount[0],xidenclog:params.id]                                                                                                                                                                                                                                                                                                                                                                                                              
    }

     
  def show(DetLog detLogInstance) {
        respond detLogInstance
    }

  def create() {
        respond new DetLog(params)
    }

  @Transactional //save
    def save(DetLog detLogInstance) {
        if (detLogInstance == null) {
            notFound()
            return
        }

        if (detLogInstance.hasErrors()) {
            respond detLogInstance.errors, view:'create'
            return
        }

        detLogInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'detLogInstance.label', default: 'DetLog'), detLogInstance.id])
                redirect detLogInstance
            }
            '*' { respond detLogInstance, [status: CREATED] }
        }
    }

  def edit(DetLog detLogInstance) {
        respond detLogInstance
    }

  @Transactional //update
    def update(DetLog detLogInstance) {
        if (detLogInstance == null) {
            notFound()
            return
        }

        if (detLogInstance.hasErrors()) {
            respond detLogInstance.errors, view:'edit'
            return
        }

        detLogInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DetLog.label', default: 'DetLog'), detLogInstance.id])
                redirect detLogInstance
            }
            '*'{ respond detLogInstance, [status: OK] }
        }
    }

  @Transactional //delete
    def delete(DetLog detLogInstance) {

        if (detLogInstance == null) {
            notFound()
            return
        }

        detLogInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DetLog.label', default: 'DetLog'), detLogInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'detLogInstance.label', default: 'DetLog'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
