package crm

class Oportunidad {
    
    String numOportunidad	
    String nombreOportunidad
    String descOportunidad
    String nombreCliente
    String nombreContacto
    String nombreVendedor
    Date  fechaApertura
    Date fechaCierreEstimada
    Date fechaCierreReal
    Long idUltimaNota
    BigDecimal valorOportunidad
    BigDecimal valorFacturado 
    Long idSucursal 
    String numOportunidadFabricante   
    String idEstrategia
    Long  estrategiaId
    Long idTactica
    String idCondicion
    String idEtapa      
    String idEstadoOportunidad
    String idMotivoPerdida
    String observCierre
    String observCambioVendedor
    Long idPropuesta
    String idFabricante
    Byte eliminado 
    String trimestre
    
    static auditable = [handlersOnly:true]
    
    def auditoriaService
    static transients=['auditoriaService']
    
    static hasMany=[propuesta:Propuesta,
        regOportunidad:RegistroOportunidad,                   
        pedido:Pedido,
        elementoporoportunidad:ElementoPorOportunidad]
    
    
    static belongsTo = [empresa:Empresa,
        persona:Persona,
        empleado:Empleado,
        prospecto:Prospecto]

    static mapping = {
        table 'oportunidades'   
        version false        
    }

    static constraints = {
        prospecto                nullable:true  
        empleado                 nullable:true    
        idSucursal               nullable: false
        numOportunidad           nullable: true,unique:true, maxSize: 50	 
        nombreOportunidad        nullable: true, maxSize: 50
        nombreCliente            nullable: true, maxSize:100
        nombreContacto           nullable: true, maxSize:100
        nombreVendedor           nullable: true, maxSize:100
        descOportunidad          nullable: true, maxSize: 400
        fechaApertura            nullable: false
        fechaCierreEstimada      nullable: true
        fechaCierreReal          nullable: true
        valorOportunidad         nullable: true
        valorFacturado           nullable: true
        numOportunidadFabricante nullable: true, maxSize:100        
        idUltimaNota             nullable: true
        idEstrategia             nullable: true, maxSize: 10
        idTactica                nullable: true
        idCondicion              nullable: true, maxSize: 10
        idEtapa                  nullable: true, maxSize: 10
        idMotivoPerdida          nullable: true, maxSize: 10            
        observCierre             nullable: true, maxSize: 300
        observCambioVendedor     nullable: true, maxSize: 200
        idEstadoOportunidad      nullable: true, maxSize: 10
        idFabricante             nullable: true, maxSize: 10
        trimestre                nullable: true, maxSize: 2
        idPropuesta              nullable:true
        eliminado                defaultValue:0
    }
    String toString(){
         
        String xnum=numOportunidad?:""     
        return    nombreOportunidad+"("+xnum+")"
    }  
    
     static manualFlush(closure) { 
        
      withSession {session -> 
            def save 
            try { 
                save = session.flushMode
                session.setFlushMode(org.hibernate.FlushMode.MANUAL)               
                closure() 
            } finally { 
                if (save) { 
                    session.flushMode = save 
                } 
         } 
        } 
    } 
    def onChange = {oldMap,newMap ->  
        manualFlush{ 
       auditoriaService.logUp('Oportunidad',oldMap,newMap,this.id)
        }
        }
}
