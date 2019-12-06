package crm

class ElementoPorOportunidadH {//Historia de elementos x Oportunidad
  
    String idMarca
    String idTipoProducto
    Long cantidad
    Double  valor
    String idEstadoElementoPorOportunidad
    Byte eliminado

    static belongsTo = [oportunidadh:OportunidadH,
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
        table 'elementos_por_oportunidad_h'
        id generator:'assigned'
        version false
    }
}
