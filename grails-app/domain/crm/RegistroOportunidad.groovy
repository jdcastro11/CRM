package crm

import java.math.BigDecimal;
import java.util.Date;

class RegistroOportunidad {

     String fecha
     Long   idAutor
     String idRegistroEn
     String numRegistroOportunidad
     String idEstadoRegistroOportunidad
     Long   idAsignadoA
     Byte   eliminado
	 Date fechaCierreEstimada
	 String comentarioRegistroOportunidad
	 String valorRegOp

    static belongsTo = [oportunidad:Oportunidad]
    static mapping = {
        table 'registro_oportunidades'
        version false
    }

    static constraints = {
        fecha                       nullable:true, maxSize:20
        idAutor                     nullable:false
        idRegistroEn                nullable:true, maxSize:10
        numRegistroOportunidad      nullable:true, maxSize:50
		fechaCierreEstimada      	nullable: true
        idEstadoRegistroOportunidad nullable:true, maxSize:10
        idAsignadoA                 nullable:true
        eliminado                   defaultValue:0
		comentarioRegistroOportunidad nullable:true,maxSize:600
		valorRegOp					nullable:true
    }
    String toString(){
        return    numRegistroOportunidad
    }
}
