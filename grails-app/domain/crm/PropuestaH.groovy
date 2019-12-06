package crm

class PropuestaH {

      String numPropuesta
      Date fecha   
      String valor
      String idEstadoPropuesta
      Byte   eliminado

    static belongsTo = [oportunidadh:OportunidadH,
                        persona:Persona,
                        empleado:Empleado]

    static mapping ={
        table 'propuestas_h'
        id generator:'assigned'
        version false
    }
    static constraints = {
        numPropuesta       nullable: true, maxSize: 50
        fecha              nullable: true    
        valor              nullable: true, maxSize: 20
        idEstadoPropuesta  nullable: true, maxSize: 10
        eliminado          defaultValue:0
    }
    String toString(){
        return numPropuesta
    }
}
