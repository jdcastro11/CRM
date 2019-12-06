package crm

class Tactica {

    String idEstrategia
    String tactica   
    String idFrecuencia
    Date   ultimaFecha
    String idEstadoTactica
    Byte   eliminado    

    static belongsTo=[estrategia:Estrategia]
	static hasMany=[pieza:Pieza]
    
    static mapping = {
        table 'tacticas'
        version false
    }

    static constraints = {        
        tactica         nullable:false, maxSize: 200
        idEstrategia    nullable:true, maxSize: 10
        idFrecuencia    nullable:false, maxSize: 10
        ultimaFecha     nullable:true
        idEstadoTactica nullable:true, maxSize: 10
        eliminado       defaultValue:0
    }

    String toString(){
        return tactica 
    }
}