package crm

class Linea {

    String descLinea
    String observLinea
    String idEstadoLinea
    Byte eliminado

    static hasMany=[sublinea:Sublinea,
                    elementoporoportunidad:ElementoPorOportunidad,
                    producto:Producto]

    static mapping ={
        table 'lineas'
        version false
    }
    static constraints = {
        producto nullable:true
        descLinea  nullable: false, maxSize: 200,blank: false
        observLinea  nullable: true, maxSize: 200
        idEstadoLinea  nullable: false, maxSize: 10
        eliminado defaultValue:0
    }
    String toString(){
        return descLinea
    }

}
