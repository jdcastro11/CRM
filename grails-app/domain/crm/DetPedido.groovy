package crm

class DetPedido {

    String refProducto
    String descProducto
    Long cantidad
    Long cantidadRecibida
    String ordenCompra
    BigDecimal valor
    String idProcesarPara
    Date fechaPosibleLlegada
    Date fechaLlegada
    String observaciones
    String idEstadoDetPedido
	String tieneContrato	
    Byte   eliminado
    
    static auditable = [handlersOnly:true]
	
	static hasOne=[contrato:Contrato]
    
    static belongsTo=[pedido:Pedido,producto:Producto,empresa:Empresa]
    
    def auditoriaService    
    
    static transients=['auditoriaService']
    
    static mapping ={
        table 'det_pedidos'
        version false
    }
    static constraints = {
        producto            nullable:true   
        empresa             nullable:true
		contrato			nullable:true 
        refProducto         nullable: false, maxSize: 50
        descProducto        nullable: false, maxSize: 1000
        ordenCompra         nullable: true, maxSize: 15 
        cantidad            nullable: false
        cantidadRecibida    nullable: true
        valor               nullable: false
        fechaPosibleLlegada nullable: true
        fechaLlegada        nullable: true
        idProcesarPara      nullable: false, maxSize: 10
        observaciones       nullable: true, maxSize: 200
        idEstadoDetPedido   nullable: true, maxSize: 10
		tieneContrato       nullable: true, maxSize: 1
        eliminado           defaultValue:0

    }
    static manualFlush(closure) { 
        
      withSession {session -> 
            def save 
            try { 
                save = session.flushMode
                session.setFlushMode(org.hibernate.FlushMode.MANUAL)               
                closure() 
            } finally { 
                if (save) { 
                    session.flushMode = save 
                } 
         } 
        } 
    } 
    def onChange = { oldMap,newMap ->
        manualFlush{              
        auditoriaService.logUp('DetPedido',oldMap,newMap,this.id)
        }
    }
}
