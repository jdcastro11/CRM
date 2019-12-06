package crm

class Opcion {

    String idTipoOpcion
    Long idPadre
    String nombreOpcion
    String descOpcion
    String url 
    String cls
    String estadoOpcion
    String orden
    String controlador
    Byte   tieneHijos
    Byte eliminado
    
    static hasMany = [rolopcoper:RolOpcionOperacion, operaciones:Operacion]
    
     static mapping ={
        table 'opciones'
        version false
        eliminado defaultValue:"0"
    }
    static constraints = {
        
        idPadre nullable:true
        orden         nullable: true, maxSize: 3
        idTipoOpcion  nullable: true, maxSize: 10
        nombreOpcion  nullable: false, maxSize: 100
        descOpcion    nullable: true, maxSize: 200
        controlador   nullable: true, maxSize: 200
        url           nullable: true, maxSize: 300
        estadoOpcion  inList:['A','I']    
    }
     String toString(){
        return nombreOpcion
    }
}
