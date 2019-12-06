package crm

class Territorio {


        String idTipoTerritorio
        String nombreTerritorio
        String codigoTerritorio 
        String estadoTerritorio
        Byte eliminado
    
    static hasMany=[hijos:Territorio]
    static belongsTo=[padre:Territorio]
     
    static mapping ={
        table 'territorios'
        version false 
            
    }
    static constraints = {
        idTipoTerritorio nullable:false
        nombreTerritorio nullable:true
        codigoTerritorio nullable:true 
        estadoTerritorio inList:['A','I']       
    }  
    
         
  String toString(){
  return nombreTerritorio
}
}
