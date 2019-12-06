package crm
import grails.transaction.Transactional
import org.springframework.web.context.request.RequestContextHolder

class AuditoriaService {      
    def generalService
    def logIn(String nomEntidad,Long identidad) {
        def session = RequestContextHolder.currentRequestAttributes().getSession()
        def usuarioInstance=Usuario.get(session["idUsuario"])
        def current = new Date()   
        EncLog enc = new EncLog([
                idEntidad:identidad,
                nomEntidad:nomEntidad,
                idTipoLog:'enclogcrea',
                fecha:current,
                idEstadoEncLog:"A",
                eliminado:0,
                usuario:usuarioInstance
            ]) 
        enc.save()
        
    }
    
    def logUp(nomEntidad,oldMap,newMap,identidad) {    
        def session = RequestContextHolder.currentRequestAttributes().getSession()
        println "Entre idusuario=${session["idUsuario"]}"
        def usuarioInstance=Usuario.get(session["idUsuario"])
        def defLogList = DefLog.executeQuery("from DefLog where nomEntidad = '${nomEntidad}' and idEstadoDefLog='genactivo' and eliminado=0")
        println "Campos para actualizar=${defLogList}"
        EncLog  encLogInstance = null
        def current = new Date()       
        if(defLogList.size()>0){
          
            defLogList.each(){         
                
                if(newMap[it.campo]){
                     println "newMap=${newMap}"
                    // println "oldMap=${oldMap}"
                    if(!encLogInstance){  
                        
                        EncLog enc = new EncLog()                        
                        enc.idEntidad=identidad
                     
                        enc.nomEntidad=nomEntidad
                        enc.idTipoLog='enlogmodi'
                        enc.fecha=current
                        enc.idEstadoEncLog="A"
                        enc.eliminado=0
                        enc.usuario=usuarioInstance
                        enc.save()
                        encLogInstance = enc
                       
                        }
               
                    DetLog det = new DetLog()
                    
                    det.campo=it.campo                                        
                    det.idTipoContenido=it.idTipoContenido
                    
                    det.valorAnterior=oldMap[it.campo].toString()
                    det.valorActual=newMap[it.campo].toString()   
                    det.idEstadoDetLog="A"                    
                    det.eliminado=0
                    det.enclog=encLogInstance                     
                    det.save() 
               }
            }
        } // fin si   */       
    }
    
    def  valorCampo(campo,valor,tipo){
         String resp
        if (tipo=='deflogfk'){      
            switch (campo) {
              case "persona":
                resp=Persona.get(valor)
              case "empresa":
                resp=Empresa.get(valor)
              case "empleado":
                resp=Empleado.get(valor)
              case "idSucursal":
                resp=Empresa.get(valor)
            }
        }
       if (tipo=='deflogpar'){
           resp=generalService.getValorParametro(valor)         
       }
        if (tipo=='deflogval' || tipo==null){
           resp=valor 
       }
         return resp
    }  
    
    def nombreCampo( xcampo,xentidad){
       def query="select nombreCampo from DefLog where nomEntidad='${xentidad}' and campo='${xcampo}'" 
       def nom=DefLog.executeQuery(query)
      
       if (!nom) return xcampo else return nom[0]
    }

}