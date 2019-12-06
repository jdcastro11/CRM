package crm

class Seriales {
	
	String numSerial
	Byte   eliminado
	
	static belongsTo=[contrato:Contrato]
	
	
	
	static mapping={
		table 'seriales'
		version false
	}

	static constraints={
		numSerial    nullable: true, maxSize: 20
		eliminado    nullable: true,defaultValue:0
	}
}
