package crm

class Usuario {

    String usuario 
    String idEstadoUsuario   
    String contrasena
    String tipoUsuario
    Byte   eliminado
    
    
    static belongsTo=[empleado:Empleado]    
    
    static mapping = {
        table 'usuarios'
        version false
        eliminado defaultValue:"0"
        tipoUsuario defaultValue:"INT"
    }
    static constraints = {
        
        usuario nullable: false, maxSize: 50, blank:false
        contrasena nullable: true, maxSize: 100    
        idEstadoUsuario  nullable: true,maxSize: 10
        tipoUsuario inList:['INT','EXT'], maxSize: 3
    }
    
    String toString(){
        return usuario
    }
}
