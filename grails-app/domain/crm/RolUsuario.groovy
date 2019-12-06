package crm

class RolUsuario {
    
    String estadoRolUsuario 
    Byte eliminado
    
     static belongsTo=[rol:Rol,usuario:Usuario]    
     static mapping ={
        table 'roles_usuarios'
        version false
        eliminado defaultValue:"0"
    }
    static constraints = {
        estadoRolUsuario inList:['A','I']
    }
    
}
