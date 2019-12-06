package crm
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.converters.*

@Transactional(readOnly = true)
class ContactoController extends BaseController{

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
       
        render view: 'index',  model:[ contactoInstanceList: filterPaneService.filter( params, Contacto ),
            contactoInstanceCount: filterPaneService.count( params, Contacto ),
            filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
            params:params, xtitulo:generalService?.getValorParametro('contactt00')]
    }
    
    def index(Integer max) {
        def query="from Contacto c inner join fetch c.persona as p inner join fetch c.empresa as e where  c.eliminado=0 order by p.primerNombre,p.primerApellido,c.fechaRegistro desc"
        def queryc="select count(c) from Contacto c where  c.eliminado=0"
        //contactt0

        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview 
        String  xoffset=params.offset?:0

 /*       if(!params.filter) params.filter = [op:[:]]
        params.filter.op.eliminado = "Equal"     
        params.filter.eliminado = '0' */

        //def contactoInstanceList = filterPaneService.filter( params, Contacto )
        def contactoInstanceList = Contacto.findAll(query,[max:params.max,offset:xoffset.toLong()])
        def num=Contacto.executeQuery(queryc)
       
        respond contactoInstanceList, model:[contactoInstanceCount:num[0],
                                             params:params, xtitulo:message(code:'contacto.title.label',default:'Contactos'), sw:1]
    }
    
   def indexp(Integer max) {
           
        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview 
        String  xoffset=params.offset?:0

        def query="from Contacto c  where c.persona.id=${params.id} and c.eliminado=0 order by  c.fechaRegistro desc"
        def contactoInstanceList = Contacto.executeQuery(query,[max:params.max,offset:xoffset.toLong()])
        println contactoInstanceList
       
        render view:"indexp", model:[contactoInstanceList:contactoInstanceList,contactoInstanceCount: contactoInstanceList.size()]
                                            
    }
    
    def listarContactos(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max=itemxview
        String  xoffset=params.offset?:0

        def query="from Contacto  where empresa.id='${params.id}' and eliminado=0"
        def contactoInstanceList=Contacto.findAll(query,[max:params.max,offset:xoffset.toLong()])

        def queryc="select count(c) from Contacto c where empresa.id='${params.id}' and eliminado=0"
        def  contactoInstanceCount= Contacto.executeQuery(queryc)

        render view:"index", model:[contactoInstanceList:contactoInstanceList,
            contactoInstanceCount:contactoInstanceCount,
            xtitulo:message(code:'contacto.title.label',default:'Contactos'),
            xlayout:params.layout]
    }
	
    def listarBorrados(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview 
        String  xoffset=params.offset?:0

        if(!params.filter) params.filter = [op:[:]]
        params.filter.op.eliminado = "Equal"     
        params.filter.eliminado = '1' 

        def contactoInstanceList = filterPaneService.filter( params, Contacto )
        render view:"index",  model:[contactoInstanceList:contactoInstanceList,
            contactoInstanceCount: filterPaneService.count( params, Contacto ),
            filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
            params:params, xtitulo:generalService?.getValorParametro('contactt01'), sw:1]
    }
	
    def show(Contacto contactoInstance) {
        respond contactoInstance
    }

    def create() {       
        respond new Contacto(params)
    }

    @Transactional //save
    def save(Contacto contactoInstance) {
      
        if (contactoInstance == null) {
            notFound()
            return
        }

        if (params.idempresa !=null &&  params.idContacto !=null){
	  
            contactoInstance.empresa=Empresa.get(params.idempresa)
            contactoInstance.persona=Persona.get(params.idContacto)
        }   
        contactoInstance.validate()
		 
        if (contactoInstance.hasErrors()) {
            respond contactoInstance.errors, view:'create'
            return
        }
 
        contactoInstance.save flush:true
		
        request.withFormat {
            form {
                // flash.message = message(code: 'default.updated.message', args: [message(code: 'Contacto.label', default: 'Contacto'), contactoInstance.id])
               redirect url:"/contacto/listarContactos/"+contactoInstance.empresa?.id+"?layout=${params.layout}"
            }
	'*'{ respond posibilidadInstance, [status: OK] }
        }
	  
 }

    def edit(Contacto contactoInstance) {
        respond contactoInstance
    }
	
    @Transactional //borrar
    def borrar(Contacto contactoInstance) {

        if (params.id == null) {
            notFound()
            return
        }

        contactoInstance= Contacto.get(params.id)

        contactoInstance.eliminado=1

        contactoInstance.save flush:true

        request.withFormat {
            form {
                // flash.message = message(code: 'default.updated.message', args: [message(code: 'Contacto.label', default: 'Contacto'), contactoInstance.id])
                redirect uri: request.getHeader('referer')
            }
			'*'{ respond posibilidadInstance, [status: OK] }
        }
    }
	
    @Transactional  //update
    def update(Contacto contactoInstance) {
        if (contactoInstance == null) {
            notFound()
            return
        }

        if (contactoInstance.hasErrors()) {
            respond contactoInstance.errors, view:'edit'
            return
        }

        contactoInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Contacto.label', default: 'Contacto'), contactoInstance.id])
                redirect url:"/contacto/listarContactos/"+contactoInstance.empresa?.id+"?layout=${params.layout}"
                             
            }
			'*'{ respond contactoInstance, [status: OK] }
        }
    }

    @Transactional //delete
    def delete(Contacto contactoInstance) {

        if (contactoInstance == null) {
            notFound()
            return
        }

        contactoInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Contacto.label', default: 'Contacto'), contactoInstance.id])
                redirect action:"index", method:"GET"
            }
			'*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'contactoInstance.label', default: 'Contacto'), params.id])
                redirect action: "index", method: "GET"
            }
			'*'{ render status: NOT_FOUND }
        }
    }

    def mostrarCboContacto(){
        render template:'/contacto/comboContacto',  model:[xidEmpresa:params.id,xidValue:params.idValue]
    }

    def autoCompletar(){ 
 
        render  generalService.autoCompletarContacto(params.term,params.idempresa) as JSON  
    }

}
