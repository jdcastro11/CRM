package crm

class Operacion {

    String nombreOperacion 
    String estadoOperacion 
    String acciones // las acciones separadas por ","
    Byte eliminado
    
    static hasMany = [rolopcoper:RolOpcionOperacion]
    static belongsTo=[opcion:Opcion]
    
    static mapping = {
	    table 'operaciones'
        version false
        eliminado defaultValue:"0"
	}
    static constraints = {
        nombreOperacion  nullable: false, maxSize: 100,blank:false
        acciones  nullable: false, maxSize: 1000
        estadoOperacion  inList:['A','I']
        opcion nullable: true
    }
 
    String toString(){
        return nombreOperacion
    }
}

