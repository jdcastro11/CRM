package crm

class Indicador {

       Long idEntidad
       String nomEntidad
       String idTipoIndicador
       String periodo
       String anio
       BigDecimal valor
       Integer cant
       String estado
       Byte eliminado
       
      
     static mapping = {
        table 'indicadores'
        version false
    }
    static constraints = {
         idEntidad           nullable: false
         nomEntidad          nullable: false, maxSize: 50	 
         idTipoIndicador     nullable: true, maxSize: 10
         periodo             nullable: true, maxSize: 10
         anio                nullable: true
         cant                nullable: true
         valor               nullable: true 
         estado              nullable: true, maxSize:1
         eliminado           defaultValue:0
    }
}
