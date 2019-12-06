package crm

class Estrategia {

    String descripcion    
    String idEstadoEstrategia
    Byte   eliminado    

    static hasMany=[tactica:Tactica]
    
    
    static mapping = {
        table 'estrategias'
        version false
    }

    static constraints = {        
        descripcion        nullable:false, maxSize: 200
        idEstadoEstrategia nullable:true, maxSize: 10
        eliminado          defaultValue:0
    }

    String toString(){
        return descripcion 
    }
}