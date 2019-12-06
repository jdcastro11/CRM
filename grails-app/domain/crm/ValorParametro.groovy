package crm
class ValorParametro {
 
   String idValorParametro
   String idParametro
   String valor
   String orden
   String estadoValorParametro
   String descValParametro
   Byte eliminado  
   static belongsTo=[parametro:Parametro]
   
    static constraints = {
        idValorParametro(unique:true)
        valor()
        orden(nullable:true)
        descValParametro nullable:true, maxSize: 150
        estadoValorParametro inList:['A','I'] 
        eliminado defaultValue:0
    }
   

   static mapping = {
     table 'valor_parametros'  
     version false     
      }  
      
  String toString(){
     return valor
   }
}
  
