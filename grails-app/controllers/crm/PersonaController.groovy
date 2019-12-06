package crm
import grails.converters.*
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PersonaController extends BaseController{

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
   
    def generalService
    def filterPaneService 
    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max = Math.min(max?:itemxview,100)  
        String  xoffset=params.offset?:0
        
        if(!params.filter) params.filter = [op:[:]]        
   
        params.filter.op.eliminado = "Equal"       
        params.filter.eliminado = '0' 
        
        def personaInstanceList=filterPaneService.filter(params, Persona )
        def  personaInstanceCount=filterPaneService.count(params, Persona)
        
         render view:"index", model:[personaInstanceList:personaInstanceList,personaInstanceCount: personaInstanceCount,params:params,
         filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),params:params,xtitulo:'Lista de Personas']
    }

 	
    @Transactional //borrar
    def borrar(Persona personaInstance) {

        if (params.id == null) {
            notFound()
            return
        }
        
         if (generalService.hayInstancias('crm.Pedido', params.id,'e.persona.id') ){
           flash.message="Existe al menos un Pedido  asociada a esta persona. Elimine primero los pedidos, luego la persona"
           redirect url:"/persona/index"
           return
       } 
        
       if (generalService.hayInstancias('crm.Oportunidad', params.id,'e.persona.id') ){
           flash.message="Existe al menos una Oportunidad  asociada a esta persona. Elimine primero las oportunidades, luego la persona"
           redirect url:"/persona/index"
           return
       }
        
        if (generalService.hayInstancias('crm.Propuesta', params.id,'e.persona.id') ){
           flash.message="Existe al menos una Propuesta  asociada a esta persona. Elimine primero las propuestas, luego la persona"
           redirect url:"/persona/index"
           return
       }
        if (generalService.hayInstancias('crm.Prospecto', params.id,'e.persona.id') ){
           flash.message="Existe al menos un Prospecto  asociado a esta persona. Elimine primero los prospectos, luego la persona"
           redirect url:"/persona/index"
           return
       } 
       if (generalService.hayInstancias('crm.Contacto', params.id,'e.persona.id') ){
           flash.message="Existe al menos un Contacto asociado a esta persona. Elimine primero los contactos, luego la persona"
           redirect url:"/persona/index"
           return
       }
      
     
       personaInstance= Persona.get(params.id)

        personaInstance.eliminado=1

        personaInstance.save flush:true

        request.withFormat {
            form {
                // flash.message = message(code: 'default.updated.message', args: [message(code: 'Contacto.label', default: 'Contacto'), contactoInstance.id])
                redirect url: "/"
            }
			'*'{ respond posibilidadInstance, [status: OK] }
        }
    }
    
   def show(Persona personaInstance) {
        if (params.pw)    
          render view:"show1", model:[personaInstance:personaInstance,generalService:generalService]
        else   
         render view:"show", model:[personaInstance:personaInstance,generalService:generalService]
    }
    
    def create() {
        def xpersona=new Persona(params)
       if (params.pw) 
         respond  xpersona, view:"create1" 
       else
         respond xpersona
    }

    def listarBorrados(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview 
        String  xoffset=params.offset?:0

        if(!params.filter) params.filter = [op:[:]]
        params.filter.op.eliminado = "Equal"     
        params.filter.eliminado = '1' 

        def personaInstanceList = filterPaneService.filter( params, Persona )
        render view:"index",  model:[personaInstanceList:personaInstanceList,
            personaInstanceCount: filterPaneService.count( params, Persona ),
            filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
            params:params, sw:1,xtitulo:'Lista de Personas Borradas',xaccion:'listarBorrados']
    }
	
    @Transactional     //save
    def save(Persona personaInstance) {
         
        if (personaInstance == null) {
            notFound()
            return
        }

        if (personaInstance.hasErrors()) {
            respond personaInstance.errors, view:'create'
            return
        }

        personaInstance.save flush:true

        request.withFormat {
            form {
                //flash.message = message(code: 'default.created.message', args: [message(code: 'personaInstance.label', default: 'Persona'), personaInstance.id])
                redirect url:"/regresar1.html"
            }
            '*' { respond personaInstance, [status: CREATED] }
        }
    }
    @Transactional  //Save Asincornico
    def saveAsync() {
        
        Persona personaInstance = new Persona(params) 
               
     personaInstance.validate()      
     
        if (personaInstance.hasErrors()) {
          
            def errors = personaInstance.errors.allErrors.collect{
                ['message': message(error:it),
                 'field': it.getField(), 
                 'badValue': it.getRejectedValue()
                ]
            }
            render(contentType: "text/json") {
                ['success':  false, 'errors':errors]
            }
            return
        }
      
        personaInstance.save flush:true

        def xnombre=(personaInstance.primerNombre==null? "":personaInstance.primerNombre)+" "+(personaInstance.primerApellido==null? "":personaInstance.primerApellido)+" "+(personaInstance.segundoApellido==null? "":personaInstance.segundoApellido)

        render(contentType: "text/json") {
            ['success':  true, key:personaInstance.id, value:xnombre]
        }
        
    }

    def edit(Persona personaInstance) {
        if (params.pw)
           respond personaInstance, view:"edit1"
        else 
           respond personaInstance
    }

    @Transactional  //update
    
    def update(Persona personaInstance) {

        personaInstance=Persona.get(params.id)

        if (personaInstance == null) {
            notFound()
            return
        }

        if (personaInstance.hasErrors()) {
            respond personaInstance.errors, view:'edit'
            return
        }

        personaInstance.save flush:true

        request.withFormat {
            form {
                //flash.message = message(code: 'default.updated.message', args: [message(code: 'Persona.label', default: 'Persona'), personaInstance.id])
                redirect url:"/regresar1.html"
            }
            '*'{ respond personaInstance, [status: OK] }
        }
    }
    
    @Transactional   // Update Asincronico
    def updateAsync() {
    
        Persona personaInstance = Persona.get(params.id)
        
        personaInstance.properties = params
       
            
        personaInstance.validate()
        if (personaInstance.hasErrors()) {
            def errors = personaInstance.errors.allErrors.collect{
                ['message': message(error:it),
                 'field': it.getField(), 
                 'badValue': it.getRejectedValue()
                ]
            }
            render(contentType: "text/json") {
                ['success':  false, 'errors':errors]
            }
            return
        }

        personaInstance.save flush:true

        def xnombre=(personaInstance.primerNombre==null? "":personaInstance.primerNombre)+" "+(personaInstance.primerApellido==null? "":personaInstance.primerApellido)+" "+(personaInstance.segundoApellido==null? "":personaInstance.segundoApellido)

        
        render(contentType: "text/json") {
            ['success':  true, key:personaInstance.id, value:xnombre]
        }
        
    }
    
    @Transactional //Delete
    def delete(Persona personaInstance) {

        if (personaInstance == null) {
            notFound()
            return
        }

        personaInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Persona.label', default: 'Persona'), personaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'personaInstance.label', default: 'Persona'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    def autoCompletar(){ 
        render  generalService.autoCompletarNombre(params.term) as JSON  
    }
    
    def datosContacto(){  
        def personaInstance=Persona.get(params.id)    
        render template :'infoContacto', model:[personaInstance:personaInstance,xidpersona:params.id]

    }        
   
}
