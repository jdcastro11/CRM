package crm

class Vencimiento {

    String idTipoVencimiento
    String serial //NUMERO DE SERIE------
    String descripcion    
    String idTipoCobertura
	String plataforma
    Date fechaInicio
    Date fechaVencimiento
    String observaciones
    String idEstadoVencimiento
    Byte   eliminado
	Byte notificar	
	String idTipoContrato //Solo para arrendamiento de terceros
	String idTipoConvenio //Solo para arrendamiento de soportes Redsis
	String refTipModNumContract  //El mismo campo para referencia/tipomodelo y num contrato
	String serialManual	
	String archivoSeriales
	String motivoNoRenovacion
    

    static belongsTo=[pedido:Pedido,
					  empleado:Empleado,                      
                      encvencimiento:EncVencimiento,
					  detpedidop:DetPedido]
	
	static hasMany=[seriales:Seriales]
	

    static mapping ={
        table 'vencimientos'
        version false
    }
    static constraints = {
        idTipoVencimiento    nullable: false, maxSize: 10
        serial               nullable: true, maxSize: 300//se modifica a 300        
        descripcion          nullable: true, maxSize: 200
		plataforma           nullable: true, maxSize: 50
        idTipoCobertura      nullable: true, maxSize: 10
        fechaInicio          nullable: false
        fechaVencimiento     nullable: false
        observaciones        nullable: true, maxSize: 100
        idEstadoVencimiento  nullable: false, maxSize: 10
		idTipoContrato       nullable: true
        eliminado            nullable: true,defaultValue:0
        notificar            nullable: true,defaultValue:1
		idTipoConvenio	     nullable: true, maxSize: 10
		refTipModNumContract nullable: false, maxSize: 20
		serialManual		 nullable:false
		archivoSeriales		 nullable: true, maxSize: 60
		motivoNoRenovacion	 nullable:true, maxSize:200
    }
}
