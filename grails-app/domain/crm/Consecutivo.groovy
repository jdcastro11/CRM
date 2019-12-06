package crm

class Consecutivo {

    Long   secuencia  
    String entidad
    String anio
    int  mes
    Byte   eliminado

    static belongsTo=[empresa:Empresa]

    static mapping ={
        table 'consecutivos'
        version false
    }
    static constraints = {
        secuencia    nullable:false
        anio         nullable: false, maxSize: 4,blank: false
        mes          nullable:true
        entidad      nullable:false,maxSize:50,blank:false
        
        eliminado    defaultValue:0
    }
    String toString(){
        return secuencia
    }

}
