package crm

class DefLog {

    String nomEntidad
    String nombreCampo
    String campo
    String idTipoContenido
    String idEstadoDefLog
    Byte   eliminado

    static mapping = {
        table 'def_log'
        version false
    }

    static constraints = {
        nomEntidad      nullable:false, blank:false, maxSize: 100
        nombreCampo     nullable:false, blank:false, maxSize: 100
        campo           nullable:false, blank:false, maxSize: 100
        idEstadoDefLog  nullable:false, maxSize: 10;
        idTipoContenido nullable:false, maxSize: 10;
        eliminado       defaultValue:0
    }

    String toString(){
        return nomEntidad + " - " + campo
    }
}
