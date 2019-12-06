package crm

class Empleado {

    String identificacion  
    String idTipoEmpleado
    String primerNombre
    Long   idSucursal
    String segundoNombre
    String primerApellido
    String segundoApellido
    Integer cuota
    String email
    String celularPrincipal
    String celularAdicional
    String telefonoFijo
    String cargo
    String observaciones
    String idEstadoEmpleado
    Byte eliminado

    static hasMany = [usuario:Usuario,
                      prospecto:Prospecto,
                      oportunidad:Oportunidad,
                      pedido:Pedido,
                      propuesta:Propuesta,
                      vencimiento:Vencimiento,
                      encvencimiento:EncVencimiento,
                      empresa:Empresa]
                
    static mapping = {
        table 'empleados'
        version false
        eliminado defaultValue:"0"               
    }
       
    static constraints = {
                
        identificacion nullable: true, maxSize: 15
        idTipoEmpleado nullable: true, maxSize: 10
        primerNombre nullable: false,blank:false, maxSize: 30
        segundoNombre nullable: true, maxSize: 50
        primerApellido nullable: false,blank:false, maxSize: 30
        segundoApellido nullable: true, maxSize: 30
        email nullable: true, maxSize: 100,email:true
        celularPrincipal nullable: true, maxSize: 15
        celularAdicional nullable: true, maxSize: 15
        cuota nullable:true
        telefonoFijo nullable: true, maxSize:50
        cargo nullable: true, maxSize: 50               
        observaciones nullable: true, maxSize: 200
        idEstadoEmpleado nullable: true, maxSize: 10
             
    }
           
    String nombreCompleto(){
        return (this.segundoApellido==null)? this.primerNombre+" "+this.primerApellido:this.primerNombre+" "+this.primerApellido+" "+this.segundoApellido
        
    }
       
    String toString(){
        //return primerNombre+" "+{primerApellido+" "+${segundoApellido
        return [primerNombre, primerApellido,segundoApellido].findAll {it != null}.join(' ')
    }
}
