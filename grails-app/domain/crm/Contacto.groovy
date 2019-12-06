package crm

class Contacto {

    String idEstadoContacto
    Date fechaRegistro
    Byte eliminado

    //static hasMany=[pedido:Pedido]
    static belongsTo=[empresa:Empresa,persona:Persona]

    static mapping = {
        table 'contactos'
        version false
    }
    static constraints = {
         persona unique: 'empresa'
        idEstadoContacto nullable: true, maxSize: 10
        fechaRegistro nullable:true
        eliminado defaultValue:0
    }

}
