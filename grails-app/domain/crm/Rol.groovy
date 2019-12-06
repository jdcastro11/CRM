package crm

class Rol {
    
    String nombreRol 
    String descRol
    String estadoRol 
    Byte  eliminado
    
    
    static hasMany = [rolusuario:RolUsuario,rolopcoper:RolOpcionOperacion]
    
 static mapping ={
        table 'roles'
        version false
        eliminado defaultValue:"0"
    }
    static constraints = {
        nombreRol    nullable: false, maxSize: 100,blank:false
        descRol      nullable: true, maxSize: 200
        estadoRol    inList:['A','I']    
    }
    
    String toString(){
        return nombreRol
    }
}
