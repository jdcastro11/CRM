package crm

class Nota {

   
    Long   idEntidad
    String nombreEntidad
    String idTipoNota
    Date   fecha
    Long   idAutor
    String nota   
    String idEstadoNota
    Byte   eliminado
    String funcionariosNotificados
    

    static mapping ={
        table 'notas'        
        version false
    }
    static constraints = {
        idEntidad       nullable: false
        nombreEntidad   nullable: false, maxSize: 40
        idTipoNota      nullable: false, maxSize: 10
        nota            nullable: false, maxSize: 700
        fecha           nullable: true    
        idAutor         nullable: true    
        funcionariosNotificados    nullable: true  
        idEstadoNota    nullable: true, maxSize: 10
        eliminado       defaultValue:0
    }
     String toString(){
        return  nota
    }
}
