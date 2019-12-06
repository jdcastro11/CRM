package crm

abstract class BaseController {
    def beforeInterceptor = [action: this.&auth]
    def seguridadService
    def grailsApplication
    private auth() {
		
		def peticion=request.JSON
		
		if(peticion)
		{
			
			//redirect (uri:actionUri,params:[aja:'tnces'])
			return
		}
				
        if (!session["id_session"]) {
         	
			
            if (actionUri == "/dashboard/index"){
                println "Ok entre a estado 1"
                redirect(controller:"Login",action:"index",params:[estado:1])
                return false
            }else{  
            

                def uriAnterior
                if (request.getQueryString())                
					uriAnterior=request.forwardURI+"?"+request.getQueryString()                
                else				
					uriAnterior=request.forwardURI				              
              
                redirect(controller:"Login",action:"index",params:[estado:2,uriAnterior:uriAnterior])
                return false
                
            }
        }

        def tipo = seguridadService.tipoOpcion(actionUri)
       
        def acceso = seguridadService.validarOpcion(session["idUsuario"],actionUri)

        if (!acceso){
            if(tipo == "M"){
                redirect(controller:"Login",action:"acceso")
                return false 
            }else{
                render text: message(code: 'seguridad.accesoDenegado', default: "Acceso denegado!")
                return false 
            }
                
        }

        def operaciones = seguridadService.operacionesPorOpcion(session["idUsuario"],actionUri)
        
        
        if(operaciones != null){
            session["operaciones"] = operaciones
        }else{
            session["operaciones"] = []        
        }
       
    }  
    
     
}

