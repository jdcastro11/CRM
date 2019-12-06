package crm



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FaqController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "POST"]
    def pedidoService
    def generalService
    def filterPaneService
    
    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview 
        String  xoffset=params.offset?:0
        
        respond Faq.list(params), model:[faqInstanceCount: Faq.count()]
    }
    
     def indexn(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview 
        String  xoffset=params.offset?:0        
       
                   
      
        if(!params.filter) params.filter = [op:[:]]
    
        if(params.filter.idTipo){          
                params.filter.idTipo=generalService.getIdValorParametro('faqtipopre',params.filter.idTipo)
         }
        params.filter.op.eliminado = "Equal"
        params.filter.eliminado = '0'
        
        String xrol=generalService.getRolUsuario(session['idUsuario'].toLong())
    
        if (xrol !='ADMIN_FUNCIONAL'){
            
          if (!params.filter.idTipo  || params.filter.idTipo=='faqadmin'){
            params.filter.op.idTipo = "NotEqual"           
            params.filter.idTipo='faqadmin'
          }
           params.filter.op.estadoFaq="Equal"
           params.filter.estadoFaq='A'
         }      
        
        def faqInstanceList = filterPaneService.filter(params,Faq)
        faqInstanceList.sort{it.idTipo+it.orden}
        
        def faqInstanceCount=filterPaneService.count(params,Faq)
    
        render view: "indexn", model:[faqInstanceList:faqInstanceList,faqInstanceCount: faqInstanceCount,params:params]
    }


    def show(Faq faqInstance) {
        respond faqInstance
    }
    
    def help(Faq faqInstance) {
            
        respond faqInstance
    }
    
    def create() {
        respond new Faq(params)
    }

    @Transactional
    def save(Faq faqInstance) {
        if (faqInstance == null) {
            notFound()
            return
        }

        if (faqInstance.hasErrors()) {
            respond faqInstance.errors, view:'create'
            return
        }

        faqInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'faqInstance.label', default: 'Faq'), faqInstance.id])
                redirect url:"/faq/index"
            }
            '*' { respond faqInstance, [status: CREATED] }
        }
    }

    def edit(Faq faqInstance) {
        respond faqInstance
    }

    @Transactional // Update
    def update(Faq faqInstance) {
        if (faqInstance == null) {
            notFound()
            return
        }

        if (faqInstance.hasErrors()) {
            respond faqInstance.errors, view:'edit'
            return
        }

        faqInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Faq.label', default: 'Faq'), faqInstance.id])
              redirect url:"/faq/index"
            }
            '*'{ respond faqInstance, [status: OK] }
        }
    }

    @Transactional //borrar  eliminacion fisica
    def borrar() {
      
         def faqInstance = Faq.get(params.long('id'))
        if (faqInstance == null) {
            notFound()
            return
        }

        faqInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Faq.label', default: 'Faq'), faqInstance.id])
                  redirect url:"/faq/index"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'faqInstance.label', default: 'Faq'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
