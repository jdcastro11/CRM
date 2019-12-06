package crm

class Prospecto {
     
    String numProspecto
    String nombreProspecto
    String nombreCliente
    String nombreContacto
    String nombreVendedor
    String descProspecto
    Date fechaApertura
    Date fechaCierreEstimada
    BigDecimal valorProspecto
    Long idSucursal
    String idRazonCancelacion
    String otraRazonCancelacion
    String idEstadoProspecto 
    String idEstrategia
    Long idTactica
    String evolucion
    Byte eliminado    
    String trimestre
    Long  estrategiaId
    String numOportunidadFabricante
    
    static auditable = [handlersOnly:true]
    
    def auditoriaService
    static transients=['auditoriaService']
    
    static hasMany =[oportunidad:Oportunidad]
     
    static belongsTo = [empresa:Empresa,empleado:Empleado,persona:Persona]

    static mapping = {
        table 'prospectos'
        version false        
    }

    static constraints = {
        empleado               nullable: true        
        empresa                nullable: true    
        persona                nullable: true    
        idSucursal             nullable: false  
        numProspecto           nullable: true, maxSize: 50
        nombreProspecto        nullable: true, maxSize: 50
        nombreCliente          nullable: true, maxSize:100
        nombreContacto         nullable: true, maxSize:100
        nombreVendedor         nullable: true, maxSize:100
        descProspecto          nullable: true, maxSize: 300
        fechaApertura          nullable: false
        fechaCierreEstimada    nullable: true	    
        valorProspecto         nullable: true       
        idRazonCancelacion     nullable: true, maxSize: 10
        otraRazonCancelacion   nullable: true, maxSize: 200            
        idEstadoProspecto      nullable: true, maxSize: 10
        idEstrategia           nullable: true, maxSize: 10
        estrategiaId           nullable: true   
        idTactica              nullable: true
        trimestre              nullable: true, maxSize: 2
        evolucion              nullable: true, maxSize: 2
        eliminado              defaultValue:0
        numOportunidadFabricante nullable: true, maxSize:100
       
            
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
    
    String toString(){                       
        return    nombreProspecto
    }
   
    def onChange = { oldMap,newMap ->        
        manualFlush{ 
        auditoriaService.logUp('Prospecto',oldMap,newMap,this.id)
        }
    }
    
    def onDelete = { oldMap ->
    
    }
}
