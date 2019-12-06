package crm

class Persona {


    String identificacion
    String idTipoPersona
    String primerNombre
    String segundoNombre
    String primerApellido
    String segundoApellido
    String email
    String celularPrincipal
    String celularAdicional
    String telefonoFijo
    String cargo
    String idNivelDecision
    Character repLegal
    String observaciones
    String idEstadoPersona
    Byte eliminado

    static hasMany = [contacto:Contacto,                    
        prospecto:Prospecto,
        oportunidad:Oportunidad,
        pedido:Pedido,
        propuesta:Propuesta,
        encvencimiento:EncVencimiento]
                
    static mapping = {
        table 'personas'
        version false
        eliminado defaultValue:"0"               
    }
       
    static constraints = {
                
        identificacion nullable: true, maxSize: 15
        idTipoPersona nullable: true, maxSize: 10
        primerNombre nullable: false,blank:false, maxSize: 30
        segundoNombre nullable: true, maxSize: 50
        primerApellido nullable: false,blank:false, maxSize: 30
        segundoApellido nullable: true, maxSize: 30
        email nullable: true, maxSize: 100,email:true
        celularPrincipal nullable: true, maxSize: 15
        celularAdicional nullable: true, maxSize: 15
        telefonoFijo nullable: true, maxSize:50
        cargo nullable: true, maxSize: 50
        idNivelDecision nullable: true, maxSize: 10
        repLegal nullable: true, maxSize: 1
        observaciones nullable: true, maxSize: 200
        idEstadoPersona nullable: true, maxSize: 10
             
    }
           
    String nombreCompleto(){
        return (this.segundoApellido==null)? this.primerNombre+" "+this.primerApellido:this.primerNombre+" "+this.primerApellido+" "+this.segundoApellido
        
    }
        
    String toString(){
        //return primerNombre+" "+{primerApellido+" "+${segundoApellido
        return [primerNombre, primerApellido,segundoApellido].findAll {it != null}.join(' ')
    }
}
