package crm
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsWebRequest
class LoginController {

       def generalService
      
       
    def index() { 
        
        if(!params.estado) params.estado = 1       

        if (session["id_session"]) {
            redirect(controller:"Dashboard",action:"index")
            return false 
        }else{           
            render view: 'index',  model:[estado:params.estado,uriAnterior:params.uriAnterior]
        }
    }
    
    def acceso() { render view: 'acceso' }    
    
    def autenticacion() {
        Date hora= new Date()
        //println hora
        println "Iniciando sesión Usuario:  " +session["nombre"] +": "+params.username +" Ahora:"+ hora
		
		def clave = params.password + ""
        clave = clave.encodeAsMD5()
        /*def query1 = "from Usuario u where u.usuario ='${params.username}'"
        def usuariosInstance = Usuario.executeQuery(query1)*/
        
        def query = Usuario.where {
            usuario == params.username.toString()
            contrasena == clave
            eliminado == 0
            idEstadoUsuario == "useractivo"
        }
        Usuario user = query.find()
        
        if (user){
           
            session["usuario"]  = user.usuario
            session["nombre"]= generalService.getNombreEmpleado(user.id.toLong())
            session["idUsuario"]  = user.id
            session["id_session"]  = 123
            String duracion =generalService.getValorParametro('durasesion')
            session.maxInactiveInterval = duracion?.toInteger()?:1800
            if(params.estado==1){                 
                redirect  url: "/dashboard/index"
            }else{   
                String xuriAnterior=params.uriAnterior
                if (xuriAnterior ) {
                      println xuriAnterior
                      if (xuriAnterior.indexOf('swmodal=1')!=-1)
                          redirect  url: "/dashboard/index"
                      else {                        
                           def xurl=xuriAnterior.replaceAll('/crm','')                           
                           redirect url:xurl
                      }
                }else  
                   redirect  url: "/dashboard/index"
                           
            }
        }else{
          
            flash.message = message(code: 'default.login.userError')
            redirect  url: "/login/index"
        }
        
    }
    
    def cerrarSesion() { 
        session.invalidate()
        Date hora= new Date()
        //println hora
        println "Sesion de Usuario cerrada:  "+params.username + hora
        GrailsWebRequest.lookup(request).session = null        
        redirect(controller:"Login",action:"index")
    }
}
