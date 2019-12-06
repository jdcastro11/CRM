package crm

class RolOpcionOperacion {

     String estadoRolOpcionOperacion
     Byte  eliminado

     static belongsTo=[rol:Rol,opcion:Opcion,operacion:Operacion] 
     
     static mapping ={
        table 'rol_opcion_operacion'
        version false
        eliminado defaultValue:"0"
        
    }
    static constraints = {
        estadoRolOpcionOperacion inList:['A','I']    
        
    }
}
