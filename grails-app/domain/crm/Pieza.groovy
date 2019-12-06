package crm

class Pieza {
	
	String url
	String textoParaMostrar
	byte eliminado
	
	static belongsTo=[tactica:Tactica]  

    static constraints = {
		url  maxSize: 100
		textoParaMostrar maxSize:200
		eliminado      defaultValue:0
    }
	
	static mapping ={
		table 'piezas'
		version false
	  }
}
