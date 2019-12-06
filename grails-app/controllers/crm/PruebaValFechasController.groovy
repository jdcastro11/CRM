package crm



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PruebaValFechasController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PruebaValFechas.list(params), model:[pruebaValFechasInstanceCount: PruebaValFechas.count()]
    }

    def show(PruebaValFechas pruebaValFechasInstance) {
        respond pruebaValFechasInstance
    }

    def create() {
        params.xronly = true
        respond new PruebaValFechas(params)
    }

    @Transactional
    def save(PruebaValFechas pruebaValFechasInstance) {
        if (pruebaValFechasInstance == null) {
            notFound()
            return
        }

        if (pruebaValFechasInstance.hasErrors()) {
            respond pruebaValFechasInstance.errors, view:'create'
            return
        }

        pruebaValFechasInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'pruebaValFechasInstance.label', default: 'PruebaValFechas'), pruebaValFechasInstance.id])
                redirect pruebaValFechasInstance
            }
            '*' { respond pruebaValFechasInstance, [status: CREATED] }
        }
    }

    def edit(PruebaValFechas pruebaValFechasInstance) {
        respond pruebaValFechasInstance
    }

    @Transactional
    def update(PruebaValFechas pruebaValFechasInstance) {
        if (pruebaValFechasInstance == null) {
            notFound()
            return
        }

        if (pruebaValFechasInstance.hasErrors()) {
            respond pruebaValFechasInstance.errors, view:'edit'
            return
        }

        pruebaValFechasInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PruebaValFechas.label', default: 'PruebaValFechas'), pruebaValFechasInstance.id])
                redirect pruebaValFechasInstance
            }
            '*'{ respond pruebaValFechasInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PruebaValFechas pruebaValFechasInstance) {

        if (pruebaValFechasInstance == null) {
            notFound()
            return
        }

        pruebaValFechasInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PruebaValFechas.label', default: 'PruebaValFechas'), pruebaValFechasInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pruebaValFechasInstance.label', default: 'PruebaValFechas'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
