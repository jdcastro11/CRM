package crm

class Faq {
    String pregunta 
    String idTipo
    String respuesta
    String estadoFaq
    String orden
    Byte eliminado 
    
    static mapping = {
        table 'faqs'
        version false      
        respuesta type:'text'        
       }
    static constraints = {
        pregunta nullable: true, maxSize: 300
        orden nullable: true, maxSize: 3
        idTipo nullable: true, maxSize: 10
        respuesta nullable:true 
        estadoFaq inList:['A','I'] 
        eliminado defaultValue:0
    }

    String toString(){           
        return   pregunta
    } 
}
