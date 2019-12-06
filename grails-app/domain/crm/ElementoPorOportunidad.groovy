package crm

class ElementoPorOportunidad {

    String idMarca
    String idTipoProducto
    Long cantidad
    Double  valor
    String idEstadoElementoPorOportunidad
    Byte eliminado

    static belongsTo = [oportunidad:Oportunidad,
        linea:Linea,
        sublinea:Sublinea]
    
    static constraints = {
       
        idMarca nullable: true,maxSize: 10
        idTipoProducto nullable: true,maxSize: 10
        cantidad nullable: true
        valor nullable: true
        idEstadoElementoPorOportunidad  nullable: true, maxSize: 10
        eliminado defaultValue:0
    }

    static mapping = {
        table 'elementos_por_oportunidad'
        version false
    }
}
