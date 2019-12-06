package crm

class Sublinea {

    String descSublinea
    String observSublinea
    String idEstadoSublinea
    Byte eliminado

    static hasMany=[elementoporoportunidad:ElementoPorOportunidad,
                   producto:Producto]
               
    static belongsTo=[linea:Linea]
    
    
    static mapping ={
        table 'sublineas'
        version false
    }
    static constraints = {
        producto nullable:true
        descSublinea  nullable: false, maxSize: 200,blank: false
        observSublinea  nullable: true, maxSize: 200
        idEstadoSublinea  nullable: false, maxSize: 10
    }

    String toString(){
        return descSublinea
    }
}