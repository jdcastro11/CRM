package crm

class Producto {
    String idTipoProducto
    String  IdMarca   
    String descProducto
    String refProducto
    String idEstadoProducto
    byte eliminado

    static hasMany=[detpedido:DetPedido]
    
    static belongsTo=[linea:Linea,sublinea:Sublinea]
    
    static constraints = {
           
           linea            nullable:true
           sublinea         nullable:true
           idTipoProducto   nullable: true, maxSize: 10
           idMarca          nullable: true, maxSize: 10       
           descProducto     nullable: false, maxSize: 200,blank: false
           refProducto      nullable: true, maxSize: 50
           idEstadoProducto nullable: true, maxSize: 10
           eliminado        defaultValue:0
    }
    
     static mapping = {
     table 'productos'  
     version false     
      }
    String toString(){        
        return descProducto
    }
}
