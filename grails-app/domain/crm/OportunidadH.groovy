package crm

class OportunidadH {
    
    String numOportunidad	
    String nombreOportunidad
    String descOportunidad
    String nombreCliente
    String nombreContacto
    String nombreVendedor
    Date  fechaApertura
    Date fechaCierreEstimada
    Date fechaCierreReal
    Date fechaUltimaNota
    String ultimaNota
    BigDecimal valorOportunidad
    BigDecimal valorFacturado 
    Long idSucursal 
    String numOportunidadFabricante
    String idEstrategia
    Long idTactica
    String idCondicion
    String idEtapa      
    String idEstadoOportunidad
    String idMotivoPerdida
    String observCierre
    String observCambioVendedor
    Byte eliminado 
    String trimestre    
   
    
    static hasMany=[propuestah:PropuestaH,
        regOportunidadh:RegistroOportunidadH,                   
        elementoporoportunidadh:ElementoPorOportunidadH]
    
    
    static belongsTo = [empresa:Empresa,
        persona:Persona,
        empleado:Empleado,
        prospecto:Prospecto]

    static mapping = {
        table 'oportunidades_h' 
        id generator:'assigned'
        version false        
    }

    static constraints = {
        prospecto                nullable:true  
        empleado                 nullable:true    
        idSucursal               nullable: false
        numOportunidad           nullable: true, maxSize: 50	 
        nombreOportunidad        nullable: true, maxSize: 50
        nombreCliente            nullable: true, maxSize:100
        nombreContacto           nullable: true, maxSize:100
        nombreVendedor           nullable: true, maxSize:100
        descOportunidad          nullable: true, maxSize: 300
        fechaApertura            nullable: false
        fechaCierreEstimada      nullable: true
        fechaCierreReal          nullable: true
        fechaUltimaNota          nullable: true 
        ultimaNota               nullable: true,maxSize: 500
        valorOportunidad         nullable: true
        valorFacturado           nullable: true
        numOportunidadFabricante nullable: true, maxSize:100
        idEstrategia             nullable: true, maxSize: 10
        idTactica                nullable: true
        idCondicion              nullable: true, maxSize: 10
        idEtapa                  nullable: true, maxSize: 10
        idMotivoPerdida          nullable: true, maxSize: 10            
        observCierre             nullable: true, maxSize: 200
        observCambioVendedor     nullable: true, maxSize: 200
        idEstadoOportunidad      nullable: true, maxSize: 10
        trimestre                nullable: true, maxSize: 2
        eliminado                defaultValue:0
    }
    String toString(){
         
        String xnum=numOportunidad?:""     
        return    nombreOportunidad+"("+xnum+")"
    }
    

}
