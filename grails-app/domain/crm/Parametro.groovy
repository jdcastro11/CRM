package crm

class Parametro {
    
    String idParametro
    String atributo 
    String descripcion
    String tipoParametro
    String estadoParametro 
    Byte eliminado
    
    static hasMany=[valorParametro:ValorParametro]
    static constraints = {
        
        idParametro nullable:false, maxSize: 10, unique:true
        atributo()
        descripcion()
        tipoParametro inList: ['S','U']
        estadoParametro inList:['A','I'] 
        eliminado defaultValue:0
    }
    static mapping ={
       table 'parametros'
       version false              
     }  
  String toString(){
  return descripcion
}
}