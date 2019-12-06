package crm

class Factura {

    String numFactura
    Date fechaFactura
    BigDecimal valorFactura
    String idEstadoFactura
    String trimestre
    Byte    eliminado

    static belongsTo=[pedido:Pedido]

    static mapping = {
        table 'facturas'
        version false
    }
    static constraints = {

        numFactura      nullable:false,blank:false, maxSize: 20
        fechaFactura    nullable:false
        valorFactura    nullable:false
        idEstadoFactura nullable:false,maxSize: 10;
        trimestre       nullable: true, maxSize: 2
        eliminado       defaultValue:0
    }

    String toString(){
        return numFactura
    }
}
