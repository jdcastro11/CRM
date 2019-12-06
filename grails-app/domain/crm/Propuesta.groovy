package crm

class Propuesta {

      String numPropuesta
      Date fecha   
      String valor
      String idEstadoPropuesta      
      Byte   eliminado
	  String comentarioPropuesta

    static belongsTo = [oportunidad:Oportunidad,
                        persona:Persona,
                        empleado:Empleado]

    static mapping ={
        table 'propuestas'
        version false
    }
    static constraints = {
        numPropuesta       nullable: true, maxSize: 50
        fecha              nullable: true    
        valor              nullable: true, maxSize: 20
        idEstadoPropuesta  nullable: true, maxSize: 10       
        eliminado          defaultValue:0
		comentarioPropuesta nullable:true 
    }
    String toString(){
        return numPropuesta
    }
}
