package crm



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UsuarioController extends BaseController{

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(){   
        
        def usuarioInstance=Usuario.get(session['idUsuario'])
        render view :'cambiarPwd', model:[usuarioInstance: usuarioInstance]
    }

    @Transactional
    def update(Usuario usuarioInstance) {
               
        def clave = params.contrasena0
        clave = clave.encodeAsMD5()
       
        def query="""select count(u) from Usuario u where usuario='${params.usuario}' 
                          and contrasena='${clave}' and eliminado=0 
                          and idEstadoUsuario='useractivo'"""
       
        def res=Usuario.executeQuery(query)
        
        if (res[0]==0){
            flash.message="Contraseña actual Invalida"
            redirect url:"/usuario/index"          
        }else{
           
            if (params.contrasena1 != params.contrasena2 ){

                flash.message="Nuevas contraseñas no coinciden. Verifique"
                redirect url:"/usuario/index"               
            }else {
                def nuevopwd=params.contrasena1.toString()
                usuarioInstance.contrasena=nuevopwd.encodeAsMD5()
                usuarioInstance.save()
                flash.warning="Password Cambiado Exitosamente"
                redirect url:"/usuario/index"
            }
        }
    }

   
    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'usuarioInstance.label', default: 'Usuario'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
