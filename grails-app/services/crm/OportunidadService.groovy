package crm
import grails.transaction.Transactional
@Transactional
class OportunidadService {
    def pedidoService
    def generalService

    def crearAnexosOp(lista,id) {

        lista.each{
            def num=Anexo.executeQuery("""select count(a)from Anexo a where 
                                      idEntidad=${id} and 
                                      nombreEntidad='oportunidad' and
                                      idTipoAnexo='${it}' and
                                      eliminado=0""")

            if (num[0]==0){
                def anexoInstance=new Anexo()
                anexoInstance.idEntidad=id
                anexoInstance.nombreEntidad="oportunidad"
                anexoInstance.idTipoAnexo="${it}"
                anexoInstance.idEstadoAnexo="genactivo"
                anexoInstance.eliminado=0
                anexoInstance.save()
            }
        }
        return true
    }

    def oportunidadCerrada(String id){  
        if (id != "") {
        def oportunidadInstance=Oportunidad.get(id.toLong())
        if(oportunidadInstance.idEstadoOportunidad in ['xganada','xperdida']) 
        return 'S' else return 'N'
        }
    }
    
    def tieneRegistroFabricante(String idFab, String xidOpor ){
        
        def query ="""select count(r) from RegistroOportunidad r 
                      where r.oportunidad.id=${xidOpor} and 
                      idRegistroEn='${idFab}' and r.eliminado=0 """
        
        def xnreg=RegistroOportunidad.executeQuery(query)
        if (xnreg[0] > 0 ) return true else return false        
        
    }
    
    def validarOportunidad(String xidoportunidad){ 
        def sw=0
        // Validar Si existe propuesta ganadora     
        def oportunidadInstance=Oportunidad.get(xidoportunidad)
        if (!oportunidadInstance?.idPropuesta) return 1 
        
        // Validad si hay porlo menos un item en la oportunidad
        def xnum = ElementoPorOportunidad.executeQuery("select count(e) from ElementoPorOportunidad e where oportunidad.id=${xidoportunidad} and eliminado=0")
        if (xnum[0]==0) return 2
        return 0  //oportunidad cumple para generar pedido
    }
    
    def getNumRegistros(idopor){

        def query ="""select numRegistroOportunidad,idEstadoRegistroOportunidad  
                       from RegistroOportunidad  
                       where oportunidad.id=${idopor} and                  
                       numRegistroOportunidad !='' and 
                       eliminado=0"""
        
        def salida=[]
        def lista=RegistroOportunidad.executeQuery(query)  
        lista.each(){
            switch (it[1]){               
            case "regregistr":
                salida.add("<span style='font-weight:bold;color:green'>"+it[0]+"</span>")
                break
            case "regrechaza":
                salida.add("<span style='font-weight:bold;color:red'>"+it[0]+"</span>")                                
                break
            case "regnoaplic":
                salida.add(it[0])
                break
                deafult:                  
                salida.add(it[0])                
            }            
        }  
        
        return salida.join(' | ')
    }
    
	def getNumRegistros2(idopor){ //sin elementos html en la salida
		
				def query ="""select numRegistroOportunidad,idEstadoRegistroOportunidad
                       from RegistroOportunidad  
                       where oportunidad.id=${idopor} and                  
                       numRegistroOportunidad !='' and 
                       eliminado=0"""
				
				def salida=[]
				def lista=RegistroOportunidad.executeQuery(query)
				lista.each(){					
						salida.add(it[0])
					
				}
				
				return salida.join(' | ')
			}
	
	
    def archivarOportunidad(xid) {
        def oportunidadInstance=Oportunidad.get(xid)       
        def oportunidadInstanceH=new OportunidadH(oportunidadInstance.properties) 
        oportunidadInstanceH.id=oportunidadInstance.id      
        oportunidadInstanceH.save()
       
        // copiar items de la oportunidad a tabla de archivadas 
        def elexOpH
        def listaItems=ElementoPorOportunidad.findAll("from ElementoPorOportunidad where oportunidad.id=${xid}")
        if (listaItems.size()>0){
            listaItems.each(){
                elexOpH=new ElementoPorOportunidadH(it.properties)
                elexOpH.id=it.id
                elexOpH.oportunidadh=oportunidadInstanceH
                elexOpH.linea=it.linea
                elexOpH.sublinea=it.sublinea
                elexOpH.save(failOnError:true)
            }
        }
       
        ElementoPorOportunidad.executeUpdate("delete from ElementoPorOportunidad where oportunidad.id=${xid}")
        
        // copiar actividades a tabla de Archivadas 
        def actividadH
        def listaActiv=Actividad.findAll("from Actividad where idEntidad=${xid}")        
        if (listaActiv.size()>0){
            listaActiv.each(){
                actividadH=new ActividadH(it.properties) 
                actividadH.id=it.id
                actividadH.save(failOnError:true)
            }
        }
        
        Actividad.executeUpdate("delete from Actividad where idEntidad=${xid}")
       
        // copiar propuestas  a tabla de de propuestas archivadas 
        def propuestaH; def listaAnexos;def anexoH
       
        def listaProp=Propuesta.findAll("from Propuesta where oportunidad.id=${xid}")
        if (listaProp.size()>0){
            listaProp.each(){
                propuestaH=new PropuestaH(it.properties)
                propuestaH.id=it.id
                propuestaH.oportunidadh=oportunidadInstanceH
                propuestaH.empleado=it.empleado
                propuestaH.persona=it.persona
                propuestaH.save(failOnError:true)
                
                listaAnexos=Anexo.findAll("from Anexo where idEntidad=${it.id} and nombreEntidad='propuesta'")
                if (listaAnexos.size()>0){
                    listaAnexos.each(){
                        anexoH=new AnexoH(it.properties) 
                        anexoH.id=it.id                   
                        anexoH.save(failOnError:true)
                    }
                    Anexo.executeUpdate("delete from Anexo where idEntidad=${it.id} and nombreEntidad='propuesta'")
                } 
            }
            
            Propuesta.executeUpdate("delete from Propuesta where oportunidad.id=${xid}")
            // copiar Registro de Portunidades a Tabla de Archivadas 
            def regH
            def listaReg=RegistroOportunidad.findAll("from RegistroOportunidad where oportunidad.id=${xid}")
            if (listaReg.size()>0){
                listaReg.each(){
                    regH=new RegistroOportunidadH(it.properties)
                    regH.id=it.id
                    regH.oportunidadh=oportunidadInstanceH
                    regH.save(failOnError:true)
                }
                RegistroOportunidad.executeUpdate("delete from RegistroOportunidad where oportunidad.id=${xid}")
            }  
            
            Oportunidad.executeUpdate("delete from Oportunidad where oportunidad.id=${xid}")
            
            return true

        }
    }
    
    def  valorProspectosPorPeriodo(xidven,xperiodo,xtipo) {        
        def periodo   
        def hoy = new Date()
        def xanio=hoy[Calendar.YEAR]       
        
        if (xtipo=='M') periodo="month(fechaApertura)"  else periodo="trimestre"            
          
        def query =""" select sum(p.valorProspecto),count(p),${periodo} from Prospecto p                        
                       where p.empleado.id=${xidven} and  
                       year(fechaApertura)=${xanio} and  
                       ${periodo}='${xperiodo}' and p.eliminado=0 
                       group by  3
                      """
       
        def resp=Prospecto.executeQuery(query)
        resp=resp?resp[0]:[0,0]
              
        query="from Indicador  where idEntidad=${xidven} and idTipoIndicador='vprospxven' and  anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='prospecto' and estado='A' and eliminado=0"
        
        def lista =Indicador.findAll(query)
        
        if(lista.size()==0){
            def indicadorInstance=new Indicador()
            indicadorInstance.anio="${xanio}"
            indicadorInstance.eliminado=0
            indicadorInstance.estado='A'
            indicadorInstance.nomEntidad='prospecto'
            indicadorInstance.idEntidad=xidven
            indicadorInstance.idTipoIndicador='vprospxven' 
            indicadorInstance.periodo=xperiodo
            indicadorInstance.valor=(resp[0]?:0)/1000
            indicadorInstance.cant=resp[1]?:0
            indicadorInstance.save()
        }else {
            lista[0].valor=(resp[0]?:0)/1000
            lista[0].cant=resp[1]?:0
            lista[0].save()
        }    
    }
    
    def  valorOportunidadPorPeriodo(xidven,xperiodo,xtipo) {        
        def periodo   
        def hoy = new Date()
        def xanio=hoy[Calendar.YEAR]       
        
        if (xtipo=='M') periodo="month(fechaCierreEstimada)"  else periodo="trimestre"            
          
        def query ="""select sum(p.valorOportunidad),count(p),${periodo},idEtapa from Oportunidad p                        
                      where p.empleado.id=${xidven} and  
                      year(fechaCierreEstimada)=${xanio} and  
                      ${periodo}='${xperiodo}' and p.eliminado=0 and 
                      idEtapa in ('posventa10','posventx25','posventx50','posventa75','posvent100')
                      group by  3,4
                      """
       
        def resp=Oportunidad.executeQuery(query)
       // resp=resp[0]
         
        def lista 
        resp.each(){
           
            def xtipoind
            if (it[3]=='posventa10') xtipoind='opor10xven'
            else if (it[3]=='posventx25') xtipoind='opor25xven'
            else if (it[3]=='posventx50') xtipoind='opor50xven'
            else if (it[3]=='posvent100' || it[3]=='posventa75' ) xtipoind='vopganxven'
            query="from Indicador  where idEntidad=${xidven} and  idTipoIndicador='${xtipoind}' and  anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='oportunidad' and estado='A' and eliminado=0"
            lista=Indicador.findAll(query)
          
            if(lista.size()==0) {
            def indicadorInstance=new Indicador()
            indicadorInstance.anio="${xanio}"
            indicadorInstance.eliminado=0
            indicadorInstance.estado='A'
            indicadorInstance.nomEntidad='oportunidad'
            indicadorInstance.idEntidad=xidven
            indicadorInstance.idTipoIndicador=xtipoind
            indicadorInstance.periodo=xperiodo
            indicadorInstance.valor=(it[0]?:0)/1000
            indicadorInstance.cant=it[1]?:0
            indicadorInstance.save()
            }else{
                lista[0].valor=(it[0]?:0)/1000
                lista[0].cant=it[1]?:0
            }
         }
        
    }     
    
    
    // cambios realizados por MQ el dia 6 de mzo 2015
    def  totalOpttyGeneradas(vendedor) {        
        def hoy = new Date()
        def xanio=hoy[Calendar.YEAR]   
        //1 es para traer el Q actual --- 2 para el rango defechas del Q
        def xperiodo = generalService.getQoRangoFechasQ('1', hoy)
        //def vendedor = '9'
        def xidven = vendedor.toLong()
         //println "el q a sumar es:" + xperiodo
        def query ="""select sum(p.valorOportunidad),count(p) from Oportunidad p                        
                      where p.empleado.id=${xidven} and  
                      year(fechaCierreEstimada)=${xanio} and  
                      trimestre='${xperiodo}' and p.eliminado=0 and
                      idEstrategia ='posacgenv'
                      """
       
        def resp=Oportunidad.executeQuery(query)
        resp=resp[0]
        println "La respuesta es: " +resp
        
        if(resp){
            
            // buscamos en la tabla indicador si esta ya el parametro
            query="from Indicador  where idEntidad=${xidven} and idTipoIndicador='opgenxven' and  anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='oportunidad' and estado='A' and eliminado=0"
            def lista =Indicador.findAll(query)
            if(lista.size()==0){
                def indicadorInstance=new Indicador()
                indicadorInstance.anio="${xanio}"
                indicadorInstance.eliminado=0
                indicadorInstance.estado='A'
                indicadorInstance.nomEntidad='oportunidad'
                indicadorInstance.idEntidad=xidven
                indicadorInstance.idTipoIndicador='opgenxven'
                indicadorInstance.periodo=xperiodo
                indicadorInstance.valor= resp[0]?:0/1000
                 indicadorInstance.cant=resp[1]?:0
                indicadorInstance.save(flush: true)
                
                if (!indicadorInstance.save()) {
                    indicadorInstance.errors.each {
                        println it
                    }
                }
            }else{
                 lista[0].valor= resp[0]?:0/1000
                 lista[0].cant = resp[1]
                 lista[0].save(flush: true)
                
            }    
                
            }else{
                
            }
   
    }  
    
    def  totalOpttyAsignadas(vendedor) {        
        def hoy = new Date()
        def xanio=hoy[Calendar.YEAR]   
        //1 es para traer el Q actual --- 2 para el rango defechas del Q
        def xperiodo = generalService.getQoRangoFechasQ('1', hoy)
        //def vendedor = '9'
        def xidven = vendedor.toLong()
         //println "el q a sumar es:" + xperiodo
        def query ="""select sum(p.valorOportunidad),count(p) from Oportunidad p                        
                      where p.empleado.id=${xidven} and  
                      year(fechaCierreEstimada)=${xanio} and  
                      trimestre='${xperiodo}' and p.eliminado=0 and
                      prospecto is not NULL
                      """
       
        def resp=Oportunidad.executeQuery(query)
        resp=resp[0]
        println "La respuesta es: " +resp
        
        if(resp){
            
         
            // buscamos en la tabla indicador si esta ya el parametro
            query="from Indicador  where idEntidad=${xidven} and idTipoIndicador='opgasigxve' and  anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='oportunidad' and estado='A' and eliminado=0"
            def lista =Indicador.findAll(query)
            if(lista.size()==0){
                def indicadorInstance=new Indicador()
                indicadorInstance.anio="${xanio}"
                indicadorInstance.eliminado=0
                indicadorInstance.estado='A'
                indicadorInstance.nomEntidad='oportunidad'
                indicadorInstance.idEntidad=xidven
                indicadorInstance.idTipoIndicador='opgasigxve'
                indicadorInstance.periodo=xperiodo
                indicadorInstance.valor= resp[0]?:0/1000
                indicadorInstance.cant=resp[1]?:0
                indicadorInstance.save(flush: true)
                
                if (!indicadorInstance.save()) {
                    indicadorInstance.errors.each {
                        println it
                    }
                }
            }else{
                lista[0].valor= resp[0]?:0/1000
                lista[0].cant = resp[1]
                lista[0].save(flush: true)   
            }    
             
        }else{
            
            
        }
        
 
    } 
    
     def  totalOpttyPerdidas(vendedor) {        
        def hoy = new Date()
        def xanio=hoy[Calendar.YEAR]   
        
        //1 es para traer el Q actual --- 2 para el rango defechas del Q
        def xperiodo = generalService.getQoRangoFechasQ('1', hoy)
        def xrango = generalService.getQoRangoFechasQ('2', hoy)
        //def vendedor = '9'
        def xidven = vendedor.toLong()
         //println "el q a sumar es:" + xperiodo
        def query ="""select sum(p.valorOportunidad),count(p) from Oportunidad p                        
                      where p.empleado.id=${xidven} and
                      fechaCierreReal >='${xrango[0]}' and
                      fechaCierreReal <='${xrango[1]}' and p.eliminado=0 and
                      idMotivoPerdida = 'poscompete'
                      """
       
        def resp=Oportunidad.executeQuery(query)
        resp=resp[0]
        println "La respuesta es perdido es: " +resp
        if(resp){
            
            // buscamos en la tabla indicador si esta ya el parametro
            query="from Indicador  where idEntidad=${xidven} and idTipoIndicador='opperdixve' and  anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='oportunidad' and estado='A' and eliminado=0"
            def lista =Indicador.findAll(query)
            if(lista.size()==0){
                def indicadorInstance=new Indicador()
                indicadorInstance.anio="${xanio}"
                indicadorInstance.eliminado=0
                indicadorInstance.estado='A'
                indicadorInstance.nomEntidad='oportunidad'
                indicadorInstance.idEntidad=xidven
                indicadorInstance.idTipoIndicador='opperdixve'
                indicadorInstance.periodo=xperiodo
                indicadorInstance.valor= resp[0]?:0/1000
                indicadorInstance.cant=resp[1]?:0
                indicadorInstance.save(flush: true)
                
                if (!indicadorInstance.save()) {
                    indicadorInstance.errors.each {
                        println it
                    }
                }
            }else{
                lista[0].valor= resp[0]?:0/1000
                lista[0].cant = resp[1]
                lista[0].save(flush: true)   
            }    
             
        }else{
            
            
        }
        
 
    }
    
     def  totalOpttyGanadas(vendedor) {        
        def hoy = new Date()
        def xanio=hoy[Calendar.YEAR]   
        
        //1 es para traer el Q actual --- 2 para el rango defechas del Q
        def xperiodo = generalService.getQoRangoFechasQ('1', hoy)
        def xrango = generalService.getQoRangoFechasQ('2', hoy)
        //def vendedor = '9'
        def xidven = vendedor.toLong()
         //println "el q a sumar es:" + xperiodo
        def query ="""SELECT sum(p.valorPedido), count(p) FROM Pedido p, Oportunidad o WHERE 
                      o.empleado.id=${xidven} and p.oportunidad.id = o.id and
                      o.idEstadoOportunidad = 'xganada' and
                      o.fechaCierreReal >='${xrango[0]}' and
                      o.fechaCierreReal <='${xrango[1]}' and
                      p.idEstadoPedido <> 'pedenelab1' and
                      p.idEstadoPedido <> 'pedanuladx' and
                      p.idEstadoPedido <> 'pedenrevi2' and o.eliminado=0
                    """
       
        def resp=Oportunidad.executeQuery(query)
        resp=resp[0]
        println "La respuesta para valor Ganadas es: " +resp
        if(resp){
           
            // buscamos en la tabla indicador si esta ya el parametro
            query="from Indicador  where idEntidad=${xidven} and idTipoIndicador='pedganxve' and  anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='pedido' and estado='A' and eliminado=0"
            def lista =Indicador.findAll(query)
            if(lista.size()==0){
                def indicadorInstance=new Indicador()
                indicadorInstance.anio="${xanio}"
                indicadorInstance.eliminado=0
                indicadorInstance.estado='A'
                indicadorInstance.nomEntidad='pedido'
                indicadorInstance.idEntidad=xidven
                indicadorInstance.idTipoIndicador='pedganxve'
                indicadorInstance.periodo=xperiodo
                indicadorInstance.valor= resp[0]?:0/1000
                indicadorInstance.cant=resp[1]?:0
                indicadorInstance.save(flush: true)
                
                if (!indicadorInstance.save()) {
                    indicadorInstance.errors.each {
                        println it
                    }
                }
            }else{
                lista[0].valor= resp[0]?:0/1000
                lista[0].cant = resp[1]
                lista[0].save(flush: true)   
            }    
             
        }else{
            
            
        }
        
 
    }
    
    
    
     def  totalOpttyForecast(vendedor) {   // oportunidades que esten en el Q con etapa mayor = al 25% y menor  = 755
        def hoy = new Date()
        def xanio=hoy[Calendar.YEAR]   
        
        //1 es para traer el Q actual --- 2 para el rango defechas del Q
        def xperiodo = generalService.getQoRangoFechasQ('1', hoy)
    
        def xidven = vendedor.toLong()
         //println "el q a sumar es:" + xperiodo
        def query ="""select sum(p.valorOportunidad),count(p) from Oportunidad p                        
                      where p.empleado.id=${xidven} anD 
                      year(fechaCierreEstimada)=${xanio} and  
                      trimestre='${xperiodo}'
                      and p.eliminado=0 and
                      idEtapa <>'posventx10' and idEtapa <>'posventx100' and
                      idEtapa <>'posventa75' and idEtapa <>'posventa00' 
                    """
       
        def resp=Oportunidad.executeQuery(query)
        resp=resp[0]
        println "La respuesta para valor forecast es: " +resp
   
        if(resp){
           
            // buscamos en la tabla indicador si esta ya el parametro
            query="from Indicador  where idEntidad=${xidven} and idTipoIndicador='opfcastxve' and  anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='oportunidad' and estado='A' and eliminado=0"
            def lista =Indicador.findAll(query)
            if(lista.size()==0){
                def indicadorInstance=new Indicador()
                indicadorInstance.anio="${xanio}"
                indicadorInstance.eliminado=0
                indicadorInstance.estado='A'
                indicadorInstance.nomEntidad='oportunidad'
                indicadorInstance.idEntidad=xidven
                indicadorInstance.idTipoIndicador='opfcastxve'
                indicadorInstance.periodo=xperiodo
                indicadorInstance.valor= resp[0]?:0/1000
                indicadorInstance.cant=resp[1]?:0
                indicadorInstance.save(flush: true)
                
                if (!indicadorInstance.save()) {
                    indicadorInstance.errors.each {
                        println it
                    }
                }
            }else{
                lista[0].valor= resp[0]?:0/1000
                lista[0].cant = resp[1]
                lista[0].save(flush: true)   
            }    
             
        }else{
            
            
        }
        
 
    }
    
    // ******************* cierre cambiosMQ
    
   
}
