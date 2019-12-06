package crm

class ActividadH {//Historia de Actividades

    Long   idPadre
    Long   idEntidad
    Long   idContacto
    String nombreEntidad
    Date   fechaInicio
    Date   fechaFinal
    String descActividad
    String idTipoActividad
    String idEstadoActividad
    String idAvance
    String idPrioridad
    Long   idResponsable
    Long   idAsignador
    Byte   eliminado


    static mapping = {
        table 'actividades_h'
        id generator:'assigned'
        version false
    }

    static constraints = {
        idPadre              nullable:true
        idEntidad            nullable:false
        idContacto           nullable:true
        nombreEntidad        nullable:false, maxSize:50
        fechaInicio          nullable:true
        fechaFinal           nullable:true
        descActividad        nullable:false,blank:false, maxSize:200
        idTipoActividad      nullable:true, maxSize:10
        idAvance             nullable:true, maxSize:10
        idPrioridad          nullable:true, maxSize:10
        idEstadoActividad    nullable:true, maxSize:10
        idResponsable        nullable:false
        idAsignador          nullable:false
        eliminado            defaultValue:0
    }
}
