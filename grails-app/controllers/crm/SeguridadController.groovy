package crm

import grails.converters.JSON
import org.codehaus.groovy.grails.web.json.*

class SeguridadController extends BaseController  {
    
/*
    VIEWS:
*/
    def index () {
        render view :'index'
    }

    def application () {
        render view :'application'
    }
    
/*
    UTIL:
*/

    def parametros () {
        def query = "select v from ValorParametro v where v.idParametro = '${params.id}'"
        def list = ValorParametro.executeQuery(query)
        render(contentType: "text/json") {
            ['data':  list]
        }
    }

    def personas () {
        def query = "select p from Empleado p where p.eliminado = 0  order by primerNombre, segundoNombre, primerApellido, segundoApellido"
        def pers = Persona.executeQuery(query)
        def list = []
         pers.each(){
            def primerNombre = ""
            if(it.primerNombre!= null) primerNombre = it.primerNombre
            def segundoNombre = ""
            if(it.segundoNombre!= null) segundoNombre = it.segundoNombre
            def primerApellido = ""
            if(it.primerApellido!= null) primerApellido = it.primerApellido
            def segundoApellido = ""
            if(it.segundoApellido!= null) segundoApellido = it.segundoApellido
            def nombre = primerNombre+" "+segundoNombre+" "+primerApellido+" "+segundoApellido
            list.add([
                "id":it.id,
                "nombre":nombre
            ])
        }
        render(contentType: "text/json") {
            ['data':  list]
        }
    }

/*
    ROLES:
 */

    def roles () {
        def query = "select r from Rol r where  r.eliminado = 0 order by nombreRol"
        render(contentType: "text/json") {
            ['data':  Rol.executeQuery(query)]
        }
    }

    def nuevoRol () {
        def data = JSON.parse(params.data) 
        
        def rol = new Rol()
        rol.nombreRol = data.nombreRol
        rol.descRol = data.descRol
        rol.estadoRol = 'A'
        rol.eliminado = 0
        
        try{
            rol.save(flush:true, failOnError:true)
        }catch(Exception exp){
            render(contentType: "text/json") {
                ['ok':  false]
            } 
            return
        }
        render(contentType: "text/json") {
            ['ok':  true]
        } 
    }

    def editarRol () {
        def data = JSON.parse(params.data) 
        def rol = Rol.get(data.id)
        rol.nombreRol = data.nombreRol
        rol.descRol = data.descRol
        rol.estadoRol = data.estadoRol
        
        try{
            rol.save(flush:true, failOnError:true)
        }catch(Exception exp){
            render(contentType: "text/json") {
                ['ok':  false]
            } 
            return
        }
        render(contentType: "text/json") {
            ['ok':  true]
        } 
    }

    def borrarRoles () {
        List roles = JSON.parse(params.roles) 
        Rol.withTransaction{ status ->
            try{
                for(element in roles) {
                    def results = Rol.executeQuery("from Rol r where r.id = ${element}")
                    if(results.size()>0){
                        results[0].eliminado = 1
                        results[0].save(flush:true, failOnError:true)
                    }else{
                        render(contentType: "text/json") {
                            ['ok':  false]
                        }
                        return
                    }
                }
            }catch(Exception exp){
                render(contentType: "text/json") {
                    ['ok':  false]
                } 
                return
            }
        }
        
        render(contentType: "text/json") {
            ['ok':  true]
        } 
    }

/*
    OPCIONES:
*/

    def opcionesPorRol () {
        def query = "select o from RolOpcionOperacion roo join roo.opcion o where roo.rol.id = '${params.idRol}' and o.estadoOpcion = 'A' and roo.operacion.estadoOperacion = 'A' and roo.rol.eliminado = 0 and roo.opcion.eliminado = 0 and roo.operacion.eliminado = 0 and roo.eliminado = 0"
        render(contentType: "text/json") {
            ['data':  RolOpcionOperacion.executeQuery(query)]
        }
    }

     def opciones () {
        def query = "select o from Opcion o where o.eliminado = 0 order by o.orden"
        def list = []
        def opciones = Usuario.executeQuery(query)
        opciones.each(){
            def esta = RolOpcionOperacion.executeQuery("select count(roo) from RolOpcionOperacion roo where roo.opcion.id='${it.id}' and roo.rol.id = '${params.idRol}' and roo.rol.eliminado = 0 and roo.opcion.eliminado = 0 and roo.operacion.eliminado = 0 and roo.eliminado = 0")
            list.add([
                'id':it.id,
                'nombreOpcion':it.nombreOpcion, 
                'descOpcion':it.descOpcion, 
                'idTipoOpcion':it.idTipoOpcion,    
                'estadoOpcion':it.estadoOpcion,
                'eliminado':it.eliminado,
                'controlador':it.controlador,
                'url':it.url,
                'idPadre':it.idPadre,
                'tieneHijos':it.tieneHijos,
                'asignado': esta[0] == 0? "NO" : "SI",
                'orden': it.orden,
                'cls': it.cls
            ])
        }
        render(contentType: "text/json") {
            ['data':  list]
        }
    }

    def asignarOpciones () {
        List opc = JSON.parse(params.opciones) 
        RolUsuario.withTransaction{ status ->
            try{
                for(element in opc) {
                    def roo = new RolOpcionOperacion()
                    roo.opcion = Opcion.get(element)
                    roo.operacion = Operacion.get(1)
                    roo.rol = Rol.get(params.idRol)
                    roo.estadoRolOpcionOperacion = "A"
                    roo.eliminado = 0
                    roo.save(flush:true, failOnError:true)
                }
            }catch(Exception exp){
                
                render(contentType: "text/json") {
                    ['ok':  false]
                }
                return
            }
        }
        render(contentType: "text/json") {
            ['ok':  true]
        }
    }

    def quitarOpciones () {
        List opc = JSON.parse(params.opciones) 
        
        RolOpcionOperacion.withTransaction{ status ->
            try{
                for(element in opc) {
                    
                    def results = RolOpcionOperacion.executeQuery("""from RolOpcionOperacion roo where 
                                                                     roo.rol.id = ${params.idRol}  and 
                                                                     roo.opcion.id = ${element} and 
                                                                     roo.rol.eliminado = 0 and 
                                                                     roo.opcion.eliminado = 0 and 
                                                                     roo.operacion.eliminado = 0""")
                    if(results.size()>0){
                        for(element2 in results) {
                            element2.eliminado = 1
                            element2.save(flush:true, failOnError:true)
                        }
                    }else{
                        render(contentType: "text/json") {
                            ['ok':  false]
                        }
                        return
                    }
                }
            }catch(Exception exp){
                render(contentType: "text/json") {
                    ['ok':  false]
                } 
                return
            }
        }
        
        render(contentType: "text/json") {
            ['ok':  true]
        }
    }

    def nuevaOpcion () {
        def data = JSON.parse(params.data)         
        def opcion = new Opcion()
        opcion.nombreOpcion = data.nombreOpcion
        opcion.descOpcion = data.descOpcion
        opcion.url = data.url
        opcion.controlador = data.controlador
        opcion.cls = data.cls
        opcion.orden = data.orden
        opcion.idTipoOpcion = data.idTipoOpcion
        opcion.estadoOpcion = 'A'
         if (data.idPadre=='') opcion.idPadre=null
         else opcion.idPadre= data.idPadre.toLong()
        opcion.tieneHijos=data.tieneHijos.toLong()
        opcion.eliminado = 0
        
        try{
            opcion.save(flush:true, failOnError:true)
        }catch(Exception exp){
          
            render(contentType: "text/json") {
                ['ok':  false]
            } 
            return
        }
        render(contentType: "text/json") {
            ['ok':  true]
        } 
    }

    def editarOpcion () {   
      
       def data = JSON.parse(params.data)      
        println "data=${data.idPadre}"
        //  println "data.id=${data['id']}"
        def opcion = Opcion.get(data.id)
        opcion.nombreOpcion = data.nombreOpcion
        opcion.descOpcion = data.descOpcion
        opcion.idTipoOpcion=data.idTipoOpcion
        opcion.url = data.url
        opcion.controlador = data.controlador
        opcion.orden = data.orden
        opcion.cls = data.cls
        opcion.estadoOpcion = data.estadoOpcion     
        if (data.idPadre=='') opcion.idPadre=null
        else opcion.idPadre= data.idPadre.toLong()
        opcion.tieneHijos=data.tieneHijos.toLong()
        try{
            opcion.save(flush:true, failOnError:true)
        }catch(Exception exp){
            render(contentType: "text/json") {
                ['ok':  false]
            } 
            return
        }
        render(contentType: "text/json") {
            ['ok':  true]
        } 
    }

    def borrarOpciones () {
        List opciones = JSON.parse(params.opciones) 
        Opcion.withTransaction{ status ->
            try{
                for(element in opciones) {
                    def results = Opcion.executeQuery("from Opcion o where o.id = ${element}")
                    if(results.size()>0){
                        results[0].eliminado = 1
                        results[0].save(flush:true, failOnError:true)
                    }else{
                        render(contentType: "text/json") {
                            ['ok':  false]
                        }
                        return
                    }
                }
            }catch(Exception exp){
                render(contentType: "text/json") {
                    ['ok':  false]
                } 
                return
            }
        }
        
        render(contentType: "text/json") {
            ['ok':  true]
        } 
    }

/*
    USUARIOS:
*/
    def usuariosPorRol () {

        def query = "select u from RolUsuario ru join ru.usuario u where ru.rol.id = '${params.idRol}' and u.idEstadoUsuario='useractivo' and ru.rol.eliminado = 0 and ru.usuario.eliminado = 0 and ru.eliminado = 0"
        def list = []
        def usuarios = RolUsuario.executeQuery(query)
        usuarios.each(){
            list.add([
                "id":it.id,
                "usuario":it.usuario,
                "idEstadoUsuario":it.idEstadoUsuario,
                "estado":ValorParametro.findByIdValorParametro(it.idEstadoUsuario).toString()
            ])
        }
        render(contentType: "text/json") {
            ['data':  list]
        }
    }

    
    def usuarios () {
        def query = "select u from Usuario u where u.eliminado = 0"
        def list = []
        def usuarios = Usuario.executeQuery(query)
        usuarios.each(){
            def esta = RolUsuario.executeQuery("select count(ru) from RolUsuario ru where ru.usuario.id='${it.id}' and ru.rol.id = '${params.idRol}' and ru.rol.eliminado=0 and ru.usuario.eliminado = 0 and ru.eliminado=0")
            list.add([
                'id':it.id,
                'usuario':it.usuario, 
                'idEstadoUsuario':it.idEstadoUsuario, 
                'estado':ValorParametro.findByIdValorParametro(it.idEstadoUsuario).toString(),
                'eliminado':it.eliminado,
                'asignado': esta[0] == 0? "NO" : "SI",
                'persona_id': it.empleado.id,
                'tipoUsuario':it.tipoUsuario
            ])
        }
        render(contentType: "text/json") {
            ['data':  list]
        }
    }

    def asignarUsuarios () {
        List usu = JSON.parse(params.usuarios) 
        RolUsuario.withTransaction{ status ->
            try{
                for(element in usu) {
                    def ru = new RolUsuario()
                    ru.usuario = Usuario.get(element)
                    ru.rol = Rol.get(params.idRol)
                    ru.estadoRolUsuario = "A"
                    ru.eliminado = 0
                    ru.save(flush:true, failOnError:true)
                }
            }catch(Exception exp){
                render(contentType: "text/json") {
                    ['ok':  false]
                }
                return
            }
        }
        render(contentType: "text/json") {
            ['ok':  true]
        }
    }

    def quitarUsuarios () {
        List usu = JSON.parse(params.usuarios) 
        RolUsuario.withTransaction{ status ->
            try{
                for(element in usu) {
                    def results = RolUsuario.executeQuery("from RolUsuario ru where ru.rol.id = ${params.idRol}  and ru.usuario.id = ${element} and ru.rol.eliminado=0 and ru.usuario.eliminado = 0")
                    if(results.size()>0){
                        results[0].eliminado = 1
                        results[0].save(flush:true, failOnError:true)
                    }else{
                        render(contentType: "text/json") {
                            ['ok':  false]
                        }
                        return
                    }
                }
            }catch(Exception exp){
                render(contentType: "text/json") {
                    ['ok':  false]
                } 
                return
            }
        }
        
        render(contentType: "text/json") {
            ['ok':  true]
        }
    }

    def nuevaUsuario () {
        def data = JSON.parse(params.data) 
        
        def usuario = new Usuario()
        usuario.usuario = data.usuario
       if (data.contrasena != "") usuario.contrasena  =  (""+data.contrasena).encodeAsMD5()
        usuario.idEstadoUsuario = 'useractivo'
        usuario.empleado = Empleado.get(data.persona_id)
        usuario.eliminado = 0
        usuario.tipoUsuario = data.tipoUsuario

        try{
            usuario.save(flush:true, failOnError:true)
        }catch(Exception exp){
           
            render(contentType: "text/json") {
                ['ok':  false]
            } 
            return
        }
        render(contentType: "text/json") {
            ['ok':  true]
        } 
    }

    def editarUsuario () {
        
        def data = JSON.parse(params.data) 
        def usuario = Usuario.get(data.id)
        usuario.usuario = data.usuario
        if (data.contrasena != "") usuario.contrasena  =  (""+data.contrasena).encodeAsMD5()
        usuario.idEstadoUsuario = data.idEstadoUsuario
        usuario.empleado = Empleado.get(data.persona_id)
        usuario.tipoUsuario = data.tipoUsuario
        
        try{
            usuario.save(flush:true, failOnError:true)
        }catch(Exception exp){
            render(contentType: "text/json") {
                ['ok':  false]
            } 
            return
        }
        render(contentType: "text/json") {
            ['ok':  true]
        } 
    }

    def borrarUsuarios () {
        List usuarios = JSON.parse(params.usuarios) 
        Usuario.withTransaction{ status ->
            try{
                for(element in usuarios) {
                    def results = Usuario.executeQuery("from Usuario u where u.id = ${element}")
                    if(results.size()>0){
                        results[0].eliminado = 1
                        results[0].save(flush:true, failOnError:true)
                    }else{
                        render(contentType: "text/json") {
                            ['ok':  false]
                        }
                        return
                    }
                }
            }catch(Exception exp){
                render(contentType: "text/json") {
                    ['ok':  false]
                } 
                return
            }
        }
        
        render(contentType: "text/json") {
            ['ok':  true]
        } 
    }

/*
    OPERACIONES:
*/

    def operacionesPorOpcion () {
        def query = "select a from RolOpcionOperacion roo join roo.operacion a where roo.rol.id = '${params.idRol}' and roo.opcion.id = '${params.idOpcion}'  and a.estadoOperacion = 'A' and roo.rol.eliminado = 0 and roo.opcion.eliminado = 0 and roo.operacion.eliminado = 0 and roo.eliminado=0"
        render(contentType: "text/json") {
            ['data':  RolOpcionOperacion.executeQuery(query)]
        }
    }

    def operaciones () {
        def query = "select o from Operacion o where o.eliminado = 0 and (o.opcion.id = '${params.idOpcion}' or o.opcion.id = null) "
        def list = []
        def operaciones = Operacion.executeQuery(query)
        operaciones.each(){
            def esta = RolOpcionOperacion.executeQuery("select count(roo) from RolOpcionOperacion roo where roo.opcion.id='${params.idOpcion}' and roo.rol.id = '${params.idRol}' and roo.operacion.id = '${it.id}' and roo.rol.eliminado = 0 and roo.opcion.eliminado = 0 and roo.operacion.eliminado = 0 and roo.eliminado = 0")
            list.add([
                'id':it.id,
                'nombreOperacion':it.nombreOperacion, 
                'estadoOperacion':it.estadoOperacion, 
                'acciones':it.acciones,
                'eliminado':it.eliminado,
                'asignado': esta[0] == 0? "NO" : "SI"
            ])
        }
        render(contentType: "text/json") {
            ['data':  list]
        }
    }

    def asignarOperaciones () {
        List ope = JSON.parse(params.operaciones) 
        RolOpcionOperacion.withTransaction{ status ->
            try{
                for(element in ope) {
                    
                    def roo = new RolOpcionOperacion()
                    roo.opcion = Opcion.get(params.idOpcion)
                    roo.operacion = Operacion.get(element)
                    roo.rol = Rol.get(params.idRol)
                    roo.eliminado = 0
                    roo.estadoRolOpcionOperacion = "A"
                    roo.save(flush:true, failOnError:true)
                }
            }catch(Exception exp){
               
                render(contentType: "text/json") {
                    ['ok':  false]
                }
                return
            }
        }
        
        render(contentType: "text/json") {
            ['ok':  true]
        }
    }

    def quitarOperaciones () {
        List ope = JSON.parse(params.operaciones)      
        RolOpcionOperacion.withTransaction{ status ->
            try{
                for(element in ope) {
                        
                    def results = RolOpcionOperacion.executeQuery("""from RolOpcionOperacion roo 
                                                                     where roo.opcion.id = ${params.idOpcion} and 
                                                                     roo.rol.id = ${params.idRol} and 
                                                                     roo.operacion.id = ${element} and
                                                                     roo.rol.eliminado = 0 and 
                                                                     roo.opcion.eliminado = 0 and 
                                                                     roo.operacion.eliminado = 0""")
                    
             println "results=${results}" 
                    if(results.size()>0){
                       /* results[0].eliminado = 1
                        results[0].save(flush:true, failOnError:true)*/
                        results[0].delete()
                    }else{
                        render(contentType: "text/json") {
                            ['ok':  false]
                        }
                        return
                    }
                }
            }catch(Exception exp){
               
                render(contentType: "text/json") {
                            ['ok':  false]
                        }
                        return
            }
        }
        
        render(contentType: "text/json") {
            ['ok':  true]
        }
    }

    def nuevaOperacion () {
        def data = JSON.parse(params.data) 
        
        def operacion = new Operacion()
        operacion.nombreOperacion = data.nombreOperacion
        operacion.acciones = data.acciones
        operacion.estadoOperacion = 'A'
        operacion.eliminado = 0
        
        try{
            operacion.save(flush:true, failOnError:true)
        }catch(Exception exp){
            
            render(contentType: "text/json") {
                ['ok':  false]
            } 
            return
        }
        render(contentType: "text/json") {
            ['ok':  true]
        } 
    }

    def editarOperacion () {
        def data = JSON.parse(params.data) 
        def operacion = Operacion.get(data.id)
        operacion.nombreOperacion = data.nombreOperacion
        operacion.acciones = data.acciones
        operacion.estadoOperacion = data.estadoOperacion
        

        try{
            operacion.save(flush:true, failOnError:true)
        }catch(Exception exp){
            render(contentType: "text/json") {
                ['ok':  false]
            } 
            return
        }
        render(contentType: "text/json") {
            ['ok':  true]
        } 
    }

    def borrarOperaciones () {
        List operaciones = JSON.parse(params.operaciones) 
        Operacion.withTransaction{ status ->
            try{
                for(element in operaciones) {
                    def results = Operacion.executeQuery("from Operacion o where o.id = ${element}")
                    if(results.size()>0){
                        results[0].eliminado = 1
                        results[0].save(flush:true, failOnError:true)
                    }else{
                        render(contentType: "text/json") {
                            ['ok':  false]
                        }
                        return
                    }
                }
            }catch(Exception exp){
                render(contentType: "text/json") {
                    ['ok':  false]
                } 
                return
            }
        }
        
        render(contentType: "text/json") {
            ['ok':  true]
        } 
    }
}