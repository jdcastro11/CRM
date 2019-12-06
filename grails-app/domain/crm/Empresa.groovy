package crm

class Empresa {

    Long padreId
    String nit
    String idTipoEmpresa
    String razonSocial
    String idTipoSede
    String idSector
    Long   idRegion
    Long   idSucursal
    String direccion
    Long   idPais
    Long   idDpto
    Long   idCiudad
    String telefonos
    String fax
    String email
    String celular
    String observaciones
    String idEstadoEmpresa
    String iniciales
    String numAnteFabricante
    Long   idUltimaTactica
    Byte   eliminado


    static hasMany = [prospecto:Prospecto,
                      oportunidad:Oportunidad,
                      contacto:Contacto,
                      pedido:Pedido,
                      detpedido:DetPedido,
                      encvencimiento:EncVencimiento,
                      consecutivo:Consecutivo]
    
    static belongsTo=[empleado:Empleado]
   
    static mapping = {
        table 'empresas'
        version false                
    }

    static constraints = {  
        empleado            nullable: true
        padreId             nullable: true
        nit                 nullable: true, maxSize: 15
        idTipoEmpresa       nullable: true, maxSize: 20
        idSucursal          nullable:true
        razonSocial         nullable: false, maxSize: 100                    
        idTipoSede          nullable: true, maxSize: 10
        idSector            nullable: true, maxSize: 10
        idRegion            nullable: true, maxSize: 10
        direccion           nullable: true, maxSize: 100
        idPais              nullable: true
        idDpto              nullable: true
        idCiudad            nullable: true
        telefonos           nullable: true, maxSize: 20
        fax                 nullable: true, maxSize: 15
        email               nullable: true, email: true, maxSize: 100
        celular             nullable: true, maxSize: 20
        observaciones       nullable: true, maxSize: 300
        idEstadoEmpresa     nullable: true, maxSize: 10
        iniciales           nullable:true,  maxSize:3
        numAnteFabricante   nullable:true, maxSize:150
        idUltimaTactica     nullable:true
        eliminado           defaultValue:0
    }
    String toString(){
           
        return razonSocial
    }

    
 
}
