package crm

class DetLog {

    String campo
    String valorAnterior
    String valorActual
    String idTipoContenido
    String idEstadoDetLog
    Byte   eliminado

    static belongsTo=[enclog:EncLog]

    static mapping = {
        table 'det_log'
        version false
    }

    static constraints = {
        campo           nullable: true
        valorAnterior   nullable:false,  maxSize: 500
        valorActual     nullable:false,  maxSize: 500
        idTipoContenido nullable:false, maxSize: 10
        idEstadoDetLog  nullable:false,  maxSize: 10
        eliminado       defaultValue:0
    }

    String toString(){
        return campo 
    }
}