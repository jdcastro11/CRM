package crm

class Pedido {

     Long idSucursal
     Long idUsuarioAutor
     Long idFacturarA
     String numPedido
     String nombreCliente
     String nombreContacto
     String nombreVendedor
     Double descuentoPedido
     String ordenCompra
     String idFormaPago
     String clienteNuevo
     String idTipoPrecio
     String dirDespacho
     Long idPaisDirDes
     Long idDptoDirDes
     Long idCiudadDirDes
     Long idPaisDirFac
     Long idDptoDirFac
     Long idCiudadDirFac
     Date fechaApertura
     Date fechaEntrega
     String dirEntregaFactura
     String idMondedaFactura
     String requierePolizas
     String descPolizas
     String campaniaRedsis
     String descCampania
     String idBidNexsys
     String bidIbm
     String compraIbm
     String servicioIbm
     String numCliente
     Long  idVendedorAnterior
     String idProductoDisponible
     String handOff
     String facturacionParcial
     String arquitectoSol
     String listaArquitectos
     String idEstadoPedido   
     Long idAutorizado
     String trimestre
     BigDecimal valorPedido
     BigDecimal trm
     Byte   eliminado
     String observacionesPedido
	 String notificarCuentaCobro
	 Byte detenidoEnCompra
	 String razonesSinArquitecto
     String uniSinco
     String gerenteProye
     String listaGerenteProye
     String eyc
     String ce
     String mantenimiento
     BigDecimal costoMateriales
     BigDecimal costoManoObra
     BigDecimal precioVentaMaterales
     BigDecimal preicoVentaManoObra


     
    static auditable = [handlersOnly:true]

    def auditoriaService
    static transients=['auditoriaService']
    
    static hasMany=[detpedido:DetPedido,
                    factura:Factura,
                    vencimiento:Vencimiento]

    static belongsTo=[oportunidad:Oportunidad,
                      empresa:Empresa,
                      persona:Persona,
                      empleado:Empleado]

    static mapping ={
        table 'pedidos'
        version false
    }

    
    static constraints = {
        oportunidad          nullable: true
        idFacturarA          nullable: true
        idSucursal           nullable: false       
        idVendedorAnterior   nullable: true
        idUsuarioAutor       nullable: true
        nombreCliente        nullable: true, maxSize: 100
        nombreContacto       nullable: true, maxSize: 100
        nombreVendedor       nullable: true, maxSize: 100
        descuentoPedido      nullable: true, maxSize: 20 
        numPedido            nullable: true, maxSize: 50
        ordenCompra          nullable: true, maxSize: 50
        fechaEntrega         nullable: true
        fechaApertura        nullable: true
        idFormaPago          nullable: true, maxSize: 10
        clienteNuevo         nullable: true, maxSize: 1
        idTipoPrecio         nullable: true, maxSize: 10
        dirDespacho          nullable: true, maxSize: 200
        dirEntregaFactura    nullable: true, maxSize: 200
        idPaisDirDes         nullable: true
        idDptoDirDes         nullable: true
        idCiudadDirDes       nullable: true
        idPaisDirFac         nullable: true
        idDptoDirFac         nullable: true
        idCiudadDirFac       nullable: true
        idMondedaFactura     nullable: true, maxSize: 10
        requierePolizas      nullable: true, maxSize: 1
        descPolizas          nullable: true, maxSize: 300
        campaniaRedsis       nullable: true, maxSize: 1
        descCampania         nullable: true, maxSize: 200
        idBidNexsys          nullable: true, maxSize: 10
        bidIbm               nullable: true, maxSize: 1
        compraIbm            nullable: true, maxSize: 1
        numCliente           nullable: true, maxSize: 20
        idProductoDisponible nullable: true, maxSize: 10
        handOff              nullable: true, maxSize: 1        
        idEstadoPedido       nullable: true, maxSize: 10
        servicioIbm          nullable: true, maxSize: 1
        facturacionParcial   nullable: true, maxSize: 1
        arquitectoSol        nullable: true, maxSize: 1
        listaArquitectos     nullable: true, maxSize: 200
        idAutorizado         nullable: true
        trimestre            nullable: true, maxSize: 2
        valorPedido          nullable: true,defaultValue:0
        trm                  nullable: true, scale: 2 
        eliminado            nullable: true,defaultValue:0
        observacionesPedido  nullable: true, maxSize: 2000
		notificarCuentaCobro nullable: true
		detenidoEnCompra     nullable: true,defaultValue:0
		razonesSinArquitecto nullable: true, maxSize: 500
        uniSinco             nullable: true, maxSize: 1
        gerenteProye         nullable: true, maxSize: 1
        listaGerenteProye    nullable: true, maxSize: 200
        ce                   nullable: true, maxSize: 200, defaultValue:"N"
        eyc                  nullable: true, maxSize: 1, defaultValue:"N"
        mantenimiento        nullable: true, maxSize: 1, defaultValue:"N"
        costoMateriales      nullable: true,defaultValue:0
        costoManoObra        nullable: true,defaultValue:0
        precioVentaMaterales nullable: true,defaultValue:0
        preicoVentaManoObra  nullable: true,defaultValue:0
    }

    String toString(){
        return numPedido
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
        auditoriaService.logUp('Pedido',oldMap,newMap,this.id)
        }
    }
}
