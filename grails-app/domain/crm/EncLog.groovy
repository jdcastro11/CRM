package crm

class EncLog {

    long   idEntidad
    String nomEntidad
    String idTipoLog
    Date   fecha 
    String idEstadoEncLog
    Byte   eliminado

    static hasMany = [detlog:DetLog]
    
    static belongsTo=[usuario:Usuario]

    static mapping = {
        table 'enc_log'
        version false
    }

    static constraints = {
        idEntidad       nullable: true
        nomEntidad      nullable:false, blank:false, maxSize: 100
        idTipoLog       nullable:false, maxSize: 10;
        idEstadoEncLog  nullable:false, maxSize: 10;
        eliminado       defaultValue:0
    }

        
    String toString(){
        return nomEntidad + " - " + idEntidad
    }
}
