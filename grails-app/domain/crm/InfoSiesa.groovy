package crm

import java.math.BigDecimal;
import java.util.Date;

class InfoSiesa {
	
	
	String numPedido
	String nombreCliente
	String nit
	BigDecimal valorPedido	
	BigDecimal trm
	String idFormaPago
	String idTipoPrecio
	
	
	
	static belongsTo=[pedido:Pedido]
	static mapping ={
		table 'info_siesa'
		version false
	}

    static constraints = {
    }
}
