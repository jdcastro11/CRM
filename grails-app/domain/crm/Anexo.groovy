package crm

class Anexo {

    Long   idEntidad
    String nombreEntidad
    String idTipoAnexo
    String nombreArchivo
    String comentarios
    Date fechaCreacion
    String idEstadoAnexo
    byte   eliminado

    static mapping ={
    table 'anexos'
    version false
    }
    static constraints = {
        idEntidad      nullable: false
        nombreEntidad  nullable: false, maxSize: 40
        idTipoAnexo    nullable: false, maxSize: 10
        fechaCreacion  nullable: true
        nombreArchivo  nullable: true, maxSize: 200       
        comentarios    nullable: true, maxSize: 200
        idEstadoAnexo  nullable: true, maxSize: 10
        eliminado      defaultValue:0
    }
}
