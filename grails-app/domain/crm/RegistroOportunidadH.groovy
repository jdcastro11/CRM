package crm

class RegistroOportunidadH {

     String fecha
     Long   idAutor
     String idRegistroEn
     String numRegistroOportunidad
     String idEstadoRegistroOportunidad
     Long   idAsignadoA
     Byte   eliminado

    static belongsTo = [oportunidadh:OportunidadH]
    static mapping = {
        table 'registro_oportunidades_h'
        id generator:'assigned'
        version false
    }

    static constraints = {
        fecha                       nullable:true, maxSize:20
        idAutor                     nullable:false
        idRegistroEn                nullable:true, maxSize:10
        numRegistroOportunidad      nullable:true, maxSize:50
        idEstadoRegistroOportunidad nullable:true, maxSize:10
        idAsignadoA                 nullable:true
        eliminado                   defaultValue:0
    }
    String toString(){
        return    numRegistroOportunidad
    }
}
