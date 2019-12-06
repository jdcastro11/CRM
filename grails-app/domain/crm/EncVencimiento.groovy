package crm

class EncVencimiento {

  
    String idEstadoEncVencimiento
    Byte   eliminado 
    
    static hasMany=[vencimiento:Vencimiento]
    static belongsTo=[empresa:Empresa,
                      persona:Persona,
                      empleado:Empleado]

    static mapping ={
        table 'enc_vencimientos'
        version false
        eliminado defaultValue:"0"
    }
    static constraints = {

      idEstadoEncVencimiento nullable: true, maxSize: 10
    }
}
