package crm

import grails.transaction.Transactional
import net.sf.json.JSONArray
import grails.converters.JSON
import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONObject
import wslite.soap.*
import wslite.http.auth.*
import groovyx.net.http.HTTPBuilder
import java.text.DateFormat
import java.text.DecimalFormat
import java.text.SimpleDateFormat
import javax.validation.constraints.Size

import grails.converters.*

import org.apache.poi.ss.usermodel.Cell
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.xssf.usermodel.XSSFSheet
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.grails.datastore.gorm.finders.MethodExpression.Between;
import org.springframework.web.context.request.RequestContextHolder
import static groovyx.net.http.ContentType.*
import static groovyx.net.http.Method.*
import groovyx.net.http.ContentType

@Transactional

class GeneralService {

    def grailsApplication
    def pedidoService  
    def seguridadService
    def filterPaneService
    def mover="this.style.backgroundColor='#0088CC';this.style.color='#fff';this.style.textDecoration='none';"
    def mout="this.style.backgroundColor='#fff';this.style.color='#333333';"
    def estilo="border:none;background-color:#fff;color:#333333;width:174px;text-align:left;padding-left:10px;font-size:13px;"
    def xmap=[10,5,10,20,30,50]
        
    def getValorParametro(String id) {
        return ValorParametro.findByIdValorParametro(id)
       
    }

    def getValorParametroByIDValorParametro(String idp, String val){
        String resp
        if (val !=null){
            def lista = crm.ValorParametro.executeQuery("select valor from ValorParametro where idParametro='${idp}' and  idValorParametro='${val}' and eliminado = 0")
            if (lista.size()>0){
                resp=lista[0]
            }else{
                resp=''
            }
        }else {
            resp=''
        }
        return resp
    }

    def getIdValorParametro(String idp, String val){
        String resp
        if (val !=null){
            def lista = crm.ValorParametro.executeQuery("select idValorParametro from ValorParametro where idParametro='${idp}' and  valor='${val}'")           
            if (lista.size()>0){
                resp=lista[0]
            }else{
                resp=''
            }
        }else {
            resp=''
        }
        return resp
    }
    
    def getIdSucursal(String razonsocial){
      
        String resp
        if (razonsocial){
            def lista = crm.Empresa.executeQuery("select id from Empresa where razonSocial='${razonsocial}' and  idTipoEmpresa='empbase'")           
            if (lista.size()>0){
                resp=lista[0]
            }else{
                resp=''
            }
        }else {
            resp=''
        }
        return resp
    }
 
    def getValoresParametro(String id) {
        def xorden
        def xc=ValorParametro.executeQuery("select count(v) from ValorParametro v where orden != '' and idParametro='${id}' and estadoValorParametro='A' and eliminado=0")
        if (xc[0]>0)
            xorden=" orden "
        else
           xorden=" valor "
             
        String query="from ValorParametro where idParametro='${id}' and estadoValorParametro='A' and eliminado=0 order by ${xorden}"
       //println  ValorParametro.findAll(query)
        return  ValorParametro.findAll(query)
        
    }
    
    
    def getValoresParametroxV(String id) {        
        String query="from ValorParametro where idParametro='${id}' and estadoValorParametro='A' and eliminado=0 order by valor"
        return  ValorParametro.findAll(query)
    }
    
    def getItemsxView(Integer i){
        return xmap[i]        
    }
    
    def getMenuV(Integer i){
        if (i==1)return mover
        else if(i==2) return mout
        else return estilo
    }
    
    def getSublinea(Long id){

        def query="from Sublinea s where s.linea.id='${id}' and s.eliminado=0"
        def sublineaList=Sublinea.findAll(query)
        return  sublineaList
    }
    
  def getTacticas(id){

        def query="from Tactica t where t.estrategia.id='${id}' and t.eliminado=0"
        def lista=Tactica.findAll(query)
        return  lista
    }
  
  
  def getMarcas(idValorParametro)
  {
	  def marcaList=getValoresParametro(idValorParametro)
	  return marcaList
  }
    
    def checked(String ref,String valor){
        if (ref==valor) return "checked" else return ""
    }

    def getHoy(Integer tipo){
        def date = new Date()
        if (tipo==1){ // datetime
            def sdf1 = new SimpleDateFormat("dd-MM-yyyy HH:mm")            
            return sdf1.format(date).toString()
        }else{
            def sdf = new SimpleDateFormat("dd-MM-yyyy")
            return sdf.format(date).toString()
        }
        
    }

    def listaContactos(String xidEmpresa){
       
        def xcontactoList=Contacto.findAll("from Contacto where empresa.id=${xidEmpresa}  and eliminado=0")
        def contactoList=[]
        xcontactoList.each(){ contactoList << Persona.get(it.persona.id)}

        return contactoList
    } 
 
    def getNombreTerritorio(Long id){
        if (id==null) return ""
        def territorioInstance=crm.Territorio.get(id)       
        return territorioInstance.nombreTerritorio    
    }
    
    def getMunicipios(Long idDpto){
        
        def xlista= Territorio.executeQuery("from Territorio  where padre.id='${idDpto}' and (idTipoTerritorio='termunicip' or idTipoTerritorio='terciudad') and eliminado=0  order by nombreTerritorio")
        return xlista
    }
     def getDptos(Long idpais){
        
        def xlista= Territorio.executeQuery("from Territorio  where padre.id='${idpais}' and idTipoTerritorio='terdpto' and eliminado=0  order by nombreTerritorio")
        return xlista
    }
    def traerTerritorios(String tipo,Long xpadre){
    
        def xterritorios=Territorio.executeQuery("""select id,nombreTerritorio from Territorio
                                                 where idTipoTerritorio='${tipo}'
                                                 and padre.id=${xpadre}
                                                 and eliminado=0 and estadoTerritorio='A'
                                                 order by nombreTerritorio""")
        return xterritorios
        
    }
 
    def enviarCorreo(int sw,List dest,String asunto, String cuerpo){
        def xto=[]       
        if (sw==0) // La lista es de ids  del dominio Empleado
        dest.each({
                def empleadoInstance=Empleado.get(it)               
                xto+=empleadoInstance?.email           
				println "PRUEBA CORREO "+xto    
            })
        else {
            xto=dest    // es una lista de correos
			
			println "LISTA DE CORREOS CON SW=1 "+xto
        }
        if (xto != null) {
            try {
				sendMail {
				async true
				to  xto.toArray()
                //from "${getValorParametro('fromgenera')}"
                subject "${asunto}"
				cc "auditorcorreocrm@redsis.com"
                html "${cuerpo}"    //body rendedriza texto, html renderiza html
            }    
            }catch(Exception  e){                
                return
            }
        }
    }

    def  autoCompletar(String term,String swAuto){
        def query=''
        if (swAuto=='1'){//AUTOCOMPLETAR PROSPECTOS 
            query=""" select id,razonSocial 
                 from Empresa where razonSocial like '%${term}%' and 
                 idTipoEmpresa in ('empcliente','empprospec')  and  
                 padreId=null and eliminado=0 order by razonSocial"""  
        }else{//AUTOCOMPLETAR OPORTUNIDADES
            query=""" select id,razonSocial 
                 from Empresa where razonSocial like '%${term}%' and 
                 idTipoEmpresa='empcliente'  and  
                 padreId=null and eliminado=0 order by razonSocial"""  
        }
      
        def  elist = Empresa.executeQuery(query)   
		println "TOTAL EMPRESAS QUE CUMPLEN ESTE CRITERIO ... : "+elist.size()
        def entidadList = [] 
        elist.each {
            def entidadMap = [:] 
            entidadMap.put("id", it[0])
            entidadMap.put("label", it[1])    
            entidadMap.put("value", it[1])
            entidadMap.put("value", it[1])
            entidadList.add(entidadMap) 
        }  
        
        return entidadList          
    }
    
    def  autoCompletarProducto(String term){
                        
        def   query="select descProducto,refProducto from Producto where (refProducto like '%${term}%' or descProducto like '%${term}%') and eliminado=0"  
        
        def  elist = Producto.executeQuery(query)   
        def entidadList = [] 
        elist.each {
            def entidadMap = [:] 
            entidadMap.put("id", it[0])
            entidadMap.put("label", it[1]+' | '+it[0])    
            entidadMap.put("value", it[1])
            entidadMap.put("value", it[1])
            entidadList.add(entidadMap) 
        }  
        
        return entidadList          
    }
    
    def  autoCompletarNombre(String term){
       
        def query=""" select id,primerNombre,primerApellido,segundoApellido \n\
                 from Persona where primerNombre like '%${term}%' and  \n\
                 idTipoPersona ='percontact' and  eliminado=0 """  
    
        def  elist = Persona.executeQuery(query)   
        def entidadList = [] 
        elist.each {
            def entidadMap = [:] 
            def xnombre=(it[3]==null)? it[1]+" "+it[2]:it[1]+" "+it[2]+" "+it[3]
            entidadMap.put("id", it[0])
            entidadMap.put("label", xnombre)    
            entidadMap.put("value", xnombre)
            entidadMap.put("contacto", true)
            entidadList.add(entidadMap) 
        }  
        
        return entidadList          
    }
    
    def  autoCompletarContacto(String term, String idEmpresa){
       
        def query=""" select p.id,p.primerNombre,p.primerApellido,p.segundoApellido,\n\
        (select count(c) from Contacto c where c.persona.id=p.id and c.empresa.id LIKE '%${idEmpresa}%') as grupo 
        from Persona p where (p.primerNombre LIKE '%${term}%' or p.segundoNombre LIKE '%${term}%' or p.primerApellido LIKE '%${term}%' or p.segundoApellido LIKE '%${term}%')
        and idTipoPersona ='percontact' and  eliminado=0 order by grupo desc,primerNombre,primerApellido,segundoApellido  """  
         
       /* def query=""" select p.id,p.primerNombre,p.primerApellido,p.segundoApellido
                       from Persona  p, Contacto c where c.persona.id=p.id and c.empresa.id = '${idEmpresa}' and 
                       (p.primerNombre like '${term}%' or p.segundoNombre like '${term}%' or p.primerApellido like '${term}%' or 
                       p.segundoApellido like '${term}%') and p.idTipoPersona ='percontact' and  
                       p.eliminado=0 order by p.primerNombre,p.primerApellido,p.segundoApellido  """  */
        
        def  elist = Persona.executeQuery(query)   
        def entidadList = [] 
        elist.each {
            //def esta = Contacto.executeQuery("select count(c) from Contacto c where c.persona.id='${it[0]}' and c.empresa.id = '${idEmpresa}' ")
            def entidadMap = [:] 

            def xnombre=(it[1]==null? "":it[1])+" "+(it[2]==null? "":it[2])+" "+(it[3]==null? "":it[3])
            entidadMap.put("id", it[0])
            entidadMap.put("label", xnombre)    
            entidadMap.put("value", xnombre)
             entidadMap.put("contacto",  it[4] == 0? "NO" : "SI")
            entidadList.add(entidadMap) 
        }
           

        return entidadList          
    }
    
    @Transactional // crearContacto
    def crearContacto(Long idempresa,Long idpersona){
        if (idempresa==null || idpersona==null) return
          
        def nexist=Contacto.executeQuery("select count(c) from Contacto c " +
	              		  " where c.eliminado=0 and c.persona.id=${idpersona} and " +
				  "c.empresa.id=${idempresa}")		
	 
        if(nexist[0]>0) return
       
        def contactoInstance=new Contacto()
        contactoInstance.empresa=Empresa.get(idempresa)
        contactoInstance.persona=Persona.get(idpersona)
        contactoInstance.idEstadoContacto='genactivo'
        contactoInstance.eliminado=0
        
        contactoInstance.save flush:true
               
    }
    
    def getNombreAnexo(String nombre,String id){
        
        if (nombre == null) return null
        String ext
 
        int index = nombre.lastIndexOf(".");
        if (index == -1)return nombre+"-"+id
        
        ext=nombre.substring(index + 1);
        nombre=nombre.substring(0,index)+"-"+id+"."+ext
        return nombre      
        
    }
	
	def getIdEstrategia(String valorParametroEstrategia)
	{
		def query="Select e.id from Estrategia e Where e.descripcion='${valorParametroEstrategia}'"
		def result=Empresa.executeQuery(query)[0]
		return result
		
	}
  
    def getRolUsuario(Long xid){
        def query=RolUsuario.executeQuery("select r.nombreRol from RolUsuario ru,Rol r  where r.id=ru.rol.id and ru.usuario.id=${xid} and ru.eliminado=0")
        return query[0]
    } 
  
    def getIdEmpleado(Long xidUsuario){
        def xid = Usuario.executeQuery("select empleado.id from Usuario where id=${xidUsuario}")    
        return xid[0] 
    }
    def getIdVendedorAnte(Long xidUsuario){
        def xid = Pedido.executeQuery("select pedido.idVendedorAnterior from pedido where idVendedorAnterior=${xidUsuario}")
        return xid[0]
    }
  
    def traerEmpleado(Long xidUsuario){
        Long xid=getIdEmpleado(xidUsuario)
        def nomb=Empleado.executeQuery("select primerNombre,primerApellido from Empleado where id=${xid}")
        return nomb 
    } 
    
      def traerCorreoEmpleado(Long xidEmpleado){
        //Long xid=getIdEmpleado(xidUsuario)
        def correo=Empleado.executeQuery("select email from Empleado where id=${xidEmpleado}")
        return correo[0] 
    } 
    def getNombreEmpleado(Long xidUsuario){
        def xnombre = Empleado.get(getIdEmpleado(xidUsuario))
        return xnombre 
    }
  
    def getIdSucursal(Long xidUsuario){
        def zid=getIdEmpleado(xidUsuario) 
        def xidSucursal=Empleado.executeQuery("select idSucursal from Empleado where id=${zid}")		
        return xidSucursal[0]
    }
    
    def getUsuariosFromParametro(String xidParametro,Integer sw){
     
        def lista=getValoresParametro(xidParametro)
        def usuariosList=[]
        def idUsuariosList=[]
        lista.each(){
            usuariosList+=Empleado.findByIdentificacionAndEliminado(it,0)
            def xid=Empleado.executeQuery("Select id from Empleado where identificacion='${it}' and eliminado=0")
            idUsuariosList+=xid[0]
        } 
        if (sw==1)       
        return idUsuariosList
        else   
        return usuariosList
    }
    
    def getTrim(Date fecha){        
        Calendar cal = Calendar.getInstance(Locale.US);
        cal.setTime(fecha)
        int month = cal.get(Calendar.MONTH);        
        return (month >= Calendar.JANUARY && month <= Calendar.MARCH)? "Q1" :
        (month >= Calendar.APRIL && month <= Calendar.JUNE)? "Q2" :
        (month >= Calendar.JULY && month <= Calendar.SEPTEMBER)? "Q3" : "Q4";  
    }
    
    @Transactional // Registrar Nota
    def registrarNota(String xentidad,String xpadre, String xtipo,String xnota){
        
        def notaInstance=new Nota()
        notaInstance.idEntidad=xpadre.toLong()
        notaInstance.nombreEntidad=xentidad
        notaInstance.nota=xnota
        notaInstance.fecha=new Date()
        notaInstance.idTipoNota=xtipo 
        notaInstance.idEstadoNota='genactivo'
        notaInstance.eliminado=0       
        notaInstance.save(flush:true,failOnError:true)
    }
	
	@Transactional // Registrar Nota
	def registrarNotaEnPedido(def autor,String xentidad,String xpadre, String tipoNota,String xnota,String parametroCorreo,String asunto,String body){
		
		def notaInstance=new Nota()
		
		String notificarA
		if(!getValorParametro(parametroCorreo))//si los correos vienen en texto plano y no en parametros(DetenidoEnComprasDef)
			notificarA=parametroCorreo
		else		
			notificarA=getValorParametro(parametroCorreo)?:(getValorParametro('detencom')?:getValorParametro('useraudito'))
		

		
		
		def listaDestino=convertirEnLista(notificarA)
		
		
		notaInstance.idEntidad=xpadre.toLong()
		notaInstance.nombreEntidad=xentidad
		notaInstance.idAutor=autor
		notaInstance.nota=xnota
		notaInstance.fecha=new Date()
		notaInstance.idTipoNota=tipoNota
		notaInstance.idEstadoNota='genactivo'
		notaInstance.funcionariosNotificados=notificarA//Se trae el valor de parametros de correosvarios
		notaInstance.eliminado=0
		notaInstance.save(flush:true,failOnError:true)
		
		
		
		enviarCorreo(1, listaDestino, asunto,body)
	}
    
    def getVendedores(){
        String query=""" select e from Empleado e, Usuario u 
                         where e.idTipoEmpleado='pervendedo'                          
                               and u.empleado.id=e.id                               
                               and u.idEstadoUsuario='useractivo'
                               and e.eliminado=0 
                               and u.eliminado=0
                               order by e.primerNombre,e.primerApellido"""
        def res=Empleado.executeQuery(query)
        
        return res
    }
    
    def getAdministrativos(){
        String query=""" select e from Empleado e, Usuario u 
                         where e.idTipoEmpleado in ('pervendedo','peremplead')                          
                               and u.empleado.id=e.id                               
                               and u.idEstadoUsuario='useractivo'
                               and e.eliminado=0 
                               and u.eliminado=0
                               order by e.primerNombre,e.primerApellido"""
        def res=Empleado.executeQuery(query)
        return res
    }
    def getGProyectos(){
        String query="""select v from ValorParametro v
                        where idParametro = 'gproyecto'"""
        def res=ValorParametro.executeQuery(query)
        return res
    }
    
    def getEstadoVencimiento(Date fechaInicio,Date fechaFinal){        
        def  resp
        String  xdias=getValorParametro('diaspavenc')?:0
        def fechaHoy =new Date()
        fechaHoy.clearTime()
        if (fechaHoy < fechaInicio) resp=['vennoinici','background:#DDDDDD !important']            
        else if (fechaHoy >=fechaInicio && fechaHoy <=fechaFinal && (fechaFinal-fechaHoy) <=xdias.toInteger())  resp=['venporvenc','background:#FFF056 !important']     
        else if (fechaHoy >= fechaInicio && fechaHoy <=fechaFinal) resp=['venvigente','background:#93DF93 !important']            
        else if (fechaHoy > fechaFinal) resp=['venvencido','background:#F15850 !important'] 
        return resp
    }    
       
    
    def actualizarEstadoVencimientos(){
		
      def lista=Vencimiento.executeQuery("Select v from Vencimiento v where v.idEstadoVencimiento NOT IN ('vennorenov','vennoinici')  and v.eliminado=0")
		lista.each{			
			
			println "VENCIMIENTO "+it.id
			
			def estado=getEstadoVencimiento(it.fechaInicio,it.fechaVencimiento)[0]		
			def query="Update Vencimiento set idEstadoVencimiento='${estado}' where id=${it.id}"
			
			Vencimiento.executeUpdate(query)
		}
		println "Actualic�"
    }

    def actualizarEstadoContratos(){

        def lista=Contrato.executeQuery("Select c from Contrato c where c.idEstadoVencimiento NOT IN ('vennorenov','vennoinici')  and c.eliminado=0")


        println lista.size()
        lista.each{

            println "VENCIMIENTO "+it.id

            def estado=getEstadoVencimiento(it.fechaInicio,it.fechaVencimiento)[0]

            def query="Update Contrato set idEstadoVencimiento='${estado}' where id=${it.id}"
            println "La query para actualización es.. "+query
            Contrato.executeUpdate(query)
        }
        println "Actualicé"
    }

    
    def getCampos(clase){ 
        
       def xcampos = grailsApplication.getDomainClass(clase).persistentProperties.collect{it.name} 
       return xcampos 
    }    
    
    def preExportar(entidad,query,campos,swfiltro){
        def entidadInstanceList 
       
        if (swfiltro){
           def session = RequestContextHolder.currentRequestAttributes().getSession()
          
            session.filterParams['max']=10000
           entidadInstanceList=filtrar(session.filterParams,entidad)
        }else
          entidadInstanceList=grailsApplication.getDomainClass(entidad).clazz.executeQuery(query)
         
         List datos=[]
         Map reg        
        for (def entidadInstance in entidadInstanceList){           
            reg=[:]
            for (x in campos){ 
                if(x.key.toLowerCase().contains('estado') || x.key.toLowerCase().contains('tipo'))
                   reg[x.key]=getValorParametro(entidadInstance["${x.value}"])
                else    
                   reg[x.key]=entidadInstance["${x.value}"]
            }
            datos.add(reg)
            
        }        
        return datos
    }
    
    def getValorIndicador(idEntidad,periodo,anio,entidad,tipo){
        def res=Indicador.executeQuery("""select valor from Indicador where 
                                        idEntidad=${idEntidad} and  
                                        idTipoIndicador='${tipo}' and
                                        periodo='${periodo}' and  anio='${anio}' and
                                        nomEntidad='${entidad}' and Eliminado=0 and
                                        estado='A'""")
        if(res.size()>0) return res[0]
        else return 0
    }
    
    def mostrarIcono(xevolucion,sw){     
        Map iconos=['10':'chulo.png','RQ':'llave.png','PR':'doc.png','CO':'manos.png','GA':'peso.png']
        Map titulos=['10':'10%','RQ':'Hay Requerimiento','PR':'Cotizada','CO':'Comprometida','GA':'Ganada']
        def valor1=titulos[xevolucion]?:''
        def valor =iconos[xevolucion]?:'nada.png'
        if (sw==0)return valor else return valor1 
    }
  
   def valorEnPesoTrm(valor,trm){
        def xtrm=new BigDecimal(trm?:0)
        return valor*xtrm        
   }
   
   def valorEnDolar(valor){
        String ztrm=getValorParametro('trm')
        def xtrm=new BigDecimal(ztrm)        
        if (xtrm !=0)  valor=valor/xtrm else  valor=0
        return valor     
   }
   
     def valorEnDolarTrm(valor,trm){
         def xtrm=new BigDecimal(trm)        
        if (xtrm !=0)  valor=valor/xtrm else  valor=0
        return valor     
   }
   
   def filtrar(xparam,xdominio){
        def resultado
        switch (xdominio){
           case 'crm.Prospecto':
            resultado=filterPaneService.filter(xparam,Prospecto)
            break
        case 'crm.Oportunidad':
            resultado=filterPaneService.filter(xparam,Oportunidad)
            break
        case 'crm.Pedido':
            resultado=filterPaneService.filter(xparam,Pedido)
            break
        case 'crm.Empresa':
            resultado=filterPaneService.filter(xparam,Empresa)
            break
            
        }
       
        return resultado
   }   
  
   def cambiarRazonSocial(idempresa){
       
       // try{
           def  empresaInstance=Empresa.get(idempresa.toLong())
            def query1="update Prospecto set nombreCliente='${empresaInstance.razonSocial}' where empresa.id=${idempresa}"
            Prospecto.executeUpdate(query1)
            def query2="update Oportunidad set nombreCliente='${empresaInstance.razonSocial}' where empresa.id=${idempresa}"
            Oportunidad.executeUpdate(query2)
            def query3="update Pedido set nombreCliente='${empresaInstance.razonSocial}' where empresa.id=${idempresa}"
            Pedido.executeUpdate(query3)
            return true
      //  }catch(Exception  e){            
          //  return false
        //}
    }
    
   def getMenu(iduser){ //crear solo padres menu principal
        def opciones=seguridadService.menuPorUsuario(iduser)        
        def nodos=[padres:[],hijos:[]]
        opciones.each(){
            if (it.idPadre==null)
              nodos['padres']+=it
            else if (it.idPadre !=0 && it.idTipoOpcion !='D')
              nodos['hijos']+=it
        }
        return nodos;
    }
    
    def subMenu(datos,idpadre){ //crear nodos recursivamente       
        def html=''
        def xcolor=''
        def xcls=''
        def xicon=''
        if(datos !=null){
            html+="<ul style='margin-left:50px'>"
            datos.each(){                
                if(it.tieneHijos==1){ 
                  xcls='link'
                  xcolor="#EAC83A"
                  xicon='icon-minus-sign icon-white '
              }else{
                  xicon=''
                  xcls='birdcss birdover'
                  xcolor=''
              }   
                if(it.idPadre==idpadre){
                  html+="<li style='margin-left:5px'> "  
                  html+="""<a href=${it.url} class='${xcls}' 
                           data-status='${it.tieneHijos}' 
                           style='color:${xcolor} !important' >
                            <i class='${xicon}' style='opacity:.4;'></i>
                            ${it.nombreOpcion}</a> """
                  html+=subMenu(datos,it.id) 
                  html+="</li>"
                }                
            }
            html+="</ul>"
        }
        return html
    }
    
     // MODIFICACIONES REALIZADAS POR MARIO QUINTERO 06-03-2015
    
    def informacionEstadoQempleado(xidUsuario){
       //espacio para buscar la info de cada empleado
        def roleUsuario
        ////println "El Role del que accede" +getRolUsuario(xidUsuario.toLong())
        if ('VENDEDOR'  in getRolUsuario(xidUsuario.toLong())){
            roleUsuario = '1' //para traer solo sus datos o para traer el conjunto de todos los vendedores 
        }else if ('ADMIN_FUNCIONAL'  in getRolUsuario(xidUsuario.toLong()) || 'GERENTE'  in getRolUsuario(xidUsuario.toLong()) || 
            'ADMIN_SISTEMAS'  in getRolUsuario(xidUsuario.toLong())){
             roleUsuario = '2' //para traer solo sus datos o para traer el conjunto de todos los vendedores
        }else{
          roleUsuario = '3'  
        }
        //sacamos el id del usuario para enviarlo
        def idUsuario = getIdEmpleado(xidUsuario)
        Map infoEmpleadoQ = new HashMap()
        def valGeneradas = traerInfoQGeneradas(idUsuario, roleUsuario)
        def valAsignadas = traerInfoQAsignadas(idUsuario, roleUsuario)
        def valPerdidas = traerInfoQPerdida(idUsuario, roleUsuario)
        def valPedidoFacturado = traerInfoQpedidosFacturados(idUsuario, roleUsuario)
        def valOpttyGanadas = traerInfoQGanadas(idUsuario, roleUsuario)
        def valOpttyForecast = traerInfoForecast(idUsuario, roleUsuario)
        
        infoEmpleadoQ.put("forecast", valOpttyForecast);
        infoEmpleadoQ.put("ganadas", valOpttyGanadas);
        infoEmpleadoQ.put("perdida", valPerdidas);
        infoEmpleadoQ.put("asignado", valAsignadas);
        infoEmpleadoQ.put("generado", valGeneradas);
        infoEmpleadoQ.put("facturado", valPedidoFacturado);
       return infoEmpleadoQ
        
    }
    
     //verificamos si hay o no registros para la info optty generadas
    def traerInfoQGeneradas(vendedor, roleUsuario){
        def query
        def hoy = new Date()
        def xanio=hoy[Calendar.YEAR]   
        def xperiodo = getQoRangoFechasQ('1', hoy)
        //def vendedor = '9'
        def xidven = vendedor.toLong()
        if (roleUsuario == '1'){
            query="from Indicador  where idEntidad=${xidven} and idTipoIndicador='opgenxven' and  anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='oportunidad' and estado='A' and eliminado=0"
            def lista =Indicador.findAll(query)
            if(lista.size()==0){
                int valor = 0
                return valor
            }else{
                // si hay, traigo el valor del registro
                return lista[0].valor
            }
        }else if(roleUsuario == '2'){
            query="""select sum(p.valor)from Indicador p  where idTipoIndicador='opgenxven' and
                    anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='oportunidad' and
                    estado='A' and eliminado=0"""
             def resp=Indicador.executeQuery(query)
             if(resp){
                return resp[0]
             }else{
                int valor = 0
                return valor 
             }
        }else{
             int valor = 0
             return valor 
        }   
          
        
    }
    
    def traerInfoQAsignadas(vendedor, roleUsuario){
        def hoy = new Date()
        def xanio=hoy[Calendar.YEAR]   
        def xperiodo = getQoRangoFechasQ('1', hoy)
        //def vendedor = '9'
        def xidven = vendedor.toLong()
         if (roleUsuario == '1'){
          def query= "from Indicador  where idEntidad=${xidven} and idTipoIndicador='opgasigxve' and  anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='oportunidad' and estado='A' and eliminado=0"
            def lista =Indicador.findAll(query)
            if(lista.size()==0){
                int valor = 0
                return valor
            }else{
                // si hay, traigo el valor del registro
                return lista[0].valor
            }
          }else if(roleUsuario == '2'){
              // hacemos el select de todos los vendedores
            def query="""select sum(p.valor)from Indicador p  where idTipoIndicador='opgasigxve' and
               anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='oportunidad' and estado='A' and eliminado=0"""
 
             def resp=Indicador.executeQuery(query)
             if(resp){
                return resp[0]
             }else{
                int valor = 0
                return valor 
             }
            
          }  
        
    }
    
     def traerInfoQPerdida(vendedor, roleUsuario){
        def hoy = new Date()
        def xanio=hoy[Calendar.YEAR]   
        def xperiodo = getQoRangoFechasQ('1', hoy)
        //def vendedor = '9'
        def xidven = vendedor.toLong()
        if (roleUsuario == '1'){
          def  query="from Indicador  where idEntidad=${xidven} and idTipoIndicador='opperdixve' and  anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='oportunidad' and estado='A' and eliminado=0"
         
            def lista =Indicador.findAll(query)
            if(lista.size()==0){
                int valor = 0
                return valor
            }else{
                // si hay, traigo el valor del registro
                return lista[0].valor
            }
         }else if(roleUsuario == '2'){
               // hacemos el select de todos los vendedores
            def query= """select sum(p.valor)from Indicador p  where idTipoIndicador='opperdixve' and
                        anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='oportunidad' and estado='A' and eliminado=0"""
 
             def resp=Indicador.executeQuery(query)
             if(resp){
                return resp[0]
             }else{
                int valor = 0
                return valor 
             }
         }
        
    }
    // Taer informacion de pedidos facturados
    def traerInfoQpedidosFacturados(vendedor, roleUsuario){
        def hoy = new Date()
        def xanio=hoy[Calendar.YEAR]   
        def xperiodo = getQoRangoFechasQ('1', hoy)
        
        def xidven = vendedor.toLong()
        if (roleUsuario == '1'){
        def query = "from Indicador  where idEntidad=${xidven} and idTipoIndicador='pedfacxveq' and anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='pedido' and estado='A' and eliminado=0"
        
        def lista =Indicador.findAll(query)
            if(lista.size()==0){
                int valor = 0
                return valor
            }else{
                // si hay, traigo el valor del registro
                return lista[0].valor
            }
        }else if(roleUsuario == '2'){
            // hacemos el select de todos los vendedores
            def query= """select sum(p.valor)from Indicador p where idTipoIndicador='pedfacxveq' and
               anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='pedido' and estado='A' and eliminado=0"""
        
             def resp=Indicador.executeQuery(query)
             if(resp){
                return resp[0]
             }else{
                int valor = 0
                return valor 
             }   
            
        }
    }
    
     def traerInfoQGanadas(vendedor, roleUsuario){
        def hoy = new Date()
        def xanio=hoy[Calendar.YEAR]   
        def xperiodo = getQoRangoFechasQ('1', hoy)
        //def vendedor = '9'
        def xidven = vendedor.toLong()
        if (roleUsuario == '1'){
         def query="from Indicador  where idEntidad=${xidven} and idTipoIndicador='pedganxve' and  anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='pedido' and estado='A' and eliminado=0"
            def lista =Indicador.findAll(query)
            if(lista.size()==0){
                int valor = 0
                return valor
            }else{
                // si hay, traigo el valor del registro
                return lista[0].valor
            }
        }else if(roleUsuario == '2'){
             // hacemos el select de todos los vendedores
            def query= """select sum(p.valor)from Indicador p   where idTipoIndicador='pedganxve' and  anio='${xanio}' and periodo='${xperiodo}' and
                        nomEntidad='pedido' and estado='A' and eliminado=0"""
        
             def resp=Indicador.executeQuery(query)
             if(resp){
                return resp[0]
             }else{
                int valor = 0
                return valor 
             }   
        }
        
    }
    
    def traerInfoForecast(vendedor, roleUsuario){
        def hoy = new Date()
        def xanio=hoy[Calendar.YEAR]   
        def xperiodo = getQoRangoFechasQ('1', hoy)
        //def vendedor = '9'
        def xidven = vendedor.toLong()
        if (roleUsuario == '1'){
         def query="from Indicador  where idEntidad=${xidven} and idTipoIndicador='opfcastxve' and  anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='oportunidad' and estado='A' and eliminado=0"
           def lista =Indicador.findAll(query)
            if(lista.size()==0){
                int valor = 0
                return valor
            }else{
                // si hay, traigo el valor del registro
                return lista[0].valor
            }
        }else if(roleUsuario == '2'){
            // hacemos el select de todos los vendedores
            def query= """select sum(p.valor)from Indicador p  where idTipoIndicador='opfcastxve' and
                  anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='oportunidad' and estado='A' and eliminado=0"""
        
             def resp=Indicador.executeQuery(query)
             if(resp){
                return resp[0]
             }else{
                int valor = 0
                return valor 
             }   
            
        }
    }
    
    
     //funcion que nos permite conocer por medio de una fecha el Q o rango de fechas perteneciente al Q actual
    
    def getQoRangoFechasQ(parametro, fechaValidar){
        // parametro = 1 sacamos el Q de una fecha y parametro =2 sacamos es el rango de fechas que contiene el Q
        if(parametro == '1'){
            
            def xperiodo = getTrim(fechaValidar)
            return xperiodo
        }else{
            if(parametro == '2'){
                def hoy = new Date()
                def xanio=hoy[Calendar.YEAR]  
                def fechaQ1 = ["${xanio}-01-01", "${xanio}-03-31"]
                def fechaQ2 = ["${xanio}-04-01", "${xanio}-06-30"]
                def fechaQ3 = ["${xanio}-07-01", "${xanio}-09-30"]
                def fechaQ4 = ["${xanio}-10-01", "${xanio}-12-31"]
                def rangoFechaCreacion 
                
                def xperiodo = getTrim(fechaValidar)
                if(xperiodo == 'Q1'){
                    rangoFechaCreacion =  fechaQ1
                }else{
                    if(xperiodo == 'Q2'){
                        rangoFechaCreacion =  fechaQ2
                    }else{
                        if(xperiodo == 'Q3'){
                            rangoFechaCreacion =  fechaQ3
                        }else{
                            if(xperiodo == 'Q4'){
                                rangoFechaCreacion =  fechaQ4
                            }else{
                                
                            } 
                        } 
                    }   
                }
                
            }
        }
    }
    
    // funcion para sacar una lista de las empresas teniendo en cuenta el usuario que accede y si tiene oportunidades 
    
     def sacarListaCategoria(listado, categoria, idRetorno){
       //recorremos la lista y verificamos si esta o no y la adicionamos
       def datoAnterior =""
        def  listaRegistro = []
        def nombreCampo = categoria
        def idRetornoReg = idRetorno
        def idOnombre =''
        def dato 
         listado.each{
            if( it[nombreCampo] == datoAnterior){
               // //println "EMPRESA REPETIDA"
            }else{
                
                if (idRetorno == "idSucursal"){
                    dato = getSucursal(it[nombreCampo])  
                    idOnombre ="nombre"
                }else{
                  if (idRetorno == "idEstadoPedido"){
                    dato = getValorParametro(it[nombreCampo])  
                    idOnombre ="nombre"
                }  
                }
                
                
                
                if(idOnombre ==''){
                     listaRegistro.add([label:it[nombreCampo].toString(), id:it[idRetornoReg].toString()])
                 
                }else{                 
                    listaRegistro.add([label:dato, id:it[idRetornoReg].toString()])
                }
            }
            datoAnterior = it[nombreCampo]
         }
        return listaRegistro
    }
    
     def getSucursal(idSucursal){
          String resp
        if (idSucursal){
            def nombre = Empresa.findById(idSucursal.toLong())
          if (nombre){
              resp = nombre
          }else{
            resp=''
          }
        
        }else {
            resp=''
        }
        return resp
        
     }
     
    def notificarVencimientos(){
        
        def lista=EncVencimiento.executeQuery("""select v.encvencimiento.empresa.razonSocial,v.empleado.id,v.descripcion,v.fechaVencimiento,
                                                 DATEDIFF(v.fechaVencimiento,current_date) 
                                                 from Vencimiento v where                                                   
                                                  v.eliminado=0 and (DATEDIFF(v.fechaVencimiento,current_date)=60 or  DATEDIFF(v.fechaVencimiento,current_date)=-30)
                                              """)
       def  asunto="Notificacion sobre vencimientos"
       def cuerpo=""
       def empleado=0
      return lista.each{
         
         if (it[4]>0 ){
             cuerpo ="CLIENTE: "+it[0]+"\n EL PROXIMO: "+it[3].toString()+"\n VENCE: "+it[2]
         }else{
           cuerpo ="CLIENTE:"+it[0]+"\n HACE 30 DIAS EN :"+it[3].toString()+"\n VENCIO: "+it[2]                
         }
           empleado=[it[1]]
           enviarCorreo(0,empleado,asunto,cuerpo) 
      }
            
    }
   def validarNombreArchivo(String nombre){       
        def Resp=nombre.matches(/^[a-zA-Z0-9_-[.]\s]+$/)
       return Resp   
        
   }
   
    def convertirEnLista(tira){
        
        def lista = tira.split(',').collect{it}
        return lista
    }
    
   def HayExepcion(String uri){
       
        def xcount=ValorParametro.executeQuery("select count(vp) from ValorParametro vp where valor='${uri}' and estadoValorParametro='A' and eliminado=0")
        //println "xcount"
        //println  xcount
        if (xcount[0]>=1)
           return true
        else 
            return false
   } 
   
    def setUltimaUrl(id,valor){
        
        
    }
    
   def hayInstancias(String entidad, String id,String llave){       
       def query="select count(e) from ${entidad} e where ${llave}=${id}"
       //println query
       def xcount=grailsApplication.getDomainClass(entidad).clazz.executeQuery(query)
       if (xcount[0]!=0)
          return true 
        else
         return false 
    }
   
   
   def quitarCaracteresEspeciales(String cadena){
	  def cadenaOk
	  cadenaOk = cadena.replace('&','AND').replaceAll("[/{}\']",' ')
	  return cadenaOk
   }
   
   List traerPedidosxArquitecto()
   {
	   	def query="Select vp.idValorParametro From ValorParametro as vp where vp.eliminado=0 and vp.parametro=27"			
		def arquitectos=ValorParametro.executeQuery(query)
		List general=[]		
		
		arquitectos.each{arq->
			def pedidoxArquitecto="Select p From Pedido as p where p.listaArquitectos LIKE '%${arq}%' and p.eliminado=0 and p.idEstadoPedido!='pedanuladx'"			
			List Listapedxar=Pedido.executeQuery(pedidoxArquitecto)			//			
			////println arq+" LISTA_PED "+Listapedxar
			Listapedxar.each {numpe->
				def item=Pedido.findByNumPedido(numpe).properties				
				def tempMap=[arqui:getValorParametro(arq)]
				
				def gral= tempMap<<item				
				////println "GRAL "+gral
				general.addAll(gral)
			}
						
		}
		////println "SIZE  "+general2.size()
		////println "GRAL2 "+general2
		return general
   }
   
   
   def estadoItemDetPedido(String idEstadoPedido)
   {
   		def estadoPedido=Pedido.findById(idEstadoPedido).idEstadoPedido
		switch(estadoPedido)
		{
			case 'pedenelab1': //En elaboraci�n
			return 'peddetpd00'
			case 'pedenrevi2': //En revisi�n
			return 'peddetpd00'
			case 'pedpencom3': //Pendiente x compra
			return 'peddetpd01'			
			
			case 'pedpenfac2': //Pendiente por facturar
			return 'peddetpd01'			
			case 'pedpenfp23': //Pendiente por facturar parcial
			return 'peddetpd01'		
			
			case 'pedfacpar2': //Facturado parcialmente
			return 'peddetpd01'
			case 'pedfacturx': //Facturado
			return 'peddetpd01'
			
		}	   
   }
   
   
   def resetCambiarPedido()
   {
	   def query="update Pedido p set p.idAutorizado=NULL"
	   Pedido.executeUpdate(query)
	   println "NINGUN PEDIDO PUEDE SER MODIFICADO"
   }
   
   
   def notificarPreventa(String idpedido, def autorid)
   {
	   def query="from DetPedido as dp where dp.pedido.id=${idpedido} and dp.idProcesarPara='pedprosp02' and dp.eliminado=0"
	   def itemsPorPedido=DetPedido.findAll(query).size()
	   println "sizeD-> "+itemsPorPedido
	   def autor=Empleado.findById(autorid)
	   
	   def Pedidod=Pedido.get(idpedido)
	   def razonSocial=Empresa.get(Pedidod.empresa.id)

	   
	   if(itemsPorPedido>0)//si existen items en el pedido con procesar para cableado
	   {

		  String urlbase=getValorParametro('urlaplic')
		  String notificarA=getValorParametro('preventaOC')?:getValorParametro('useraudito')
		  def listaDestino=convertirEnLista(notificarA)			 
		  String asunto="PEDIDO No. ${Pedidod}-${razonSocial} ADICION ORDEN DE COMPRA CABLEADO"
		  String xpadre=Pedidod.id
		  String cuerpo="Nombre de quien elabora: ${autor}<br><br>Se ha adicionado la orden de compra al siguiente pedido :${Pedidod}\n y usted ha sido notificado para realizar las acciones pertinentes. <br><br>Haga clic <a href=${urlbase}/pedido/show/${xpadre}>aqui</a> para detalles."
		  
		  String xentidad='pedido'
		  String xtipo='notainform'
		  String xnota="Notificacion preventa cableado"
		  registrarNotaEnPedido(autorid,xentidad,xpadre,xtipo,xnota,notificarA,asunto,cuerpo)
		  //enviarCorreo(1, listaDestino, asunto, cuerpo)
		  
		  //notainform
	   }
	   
   	   //def registrarNota(String xentidad,String xpadre, String xtipo,String xnota){
	   //CREAR NOTA DE SEGUIMIENTO
	   //def enviarCorreo(int sw,List dest,String asunto, String cuerpo)
 
   }
   
   
   def esPedidoDetenido(Pedido pedidoInstance)
   {
	   //def notaexiste=Nota.findWhere(idEntidad:pedidoInstance.id,idTipoNota:"notadetcom")
	   if(pedidoInstance.detenidoEnCompra==1)
	   return true
	   else
	   return false
   }
   
   
   def tieneItems(Oportunidad oportunidadInstance)
   {
	   def query="from ElementoPorOportunidad as ep where ep.oportunidad.id=${oportunidadInstance.id} "
	   def result=ElementoPorOportunidad.findAll(query) 
	   if(result)
	   	return true
	   else
	   	return false
   } 
   

   //------------------------------------------------INDICADORESXQ JDMAURY------------------------------------------------------------//
   
   
   
   //def infoQEmpleado(String userId,String Q,String anio)
   def infoQEmpleado(Long[] userId,String[] Q,String anio, Long[]ciudades)
   {
	   def fechaQ
	   def userIds=userId.join(",")
	   def ciudadesIds=ciudades.join(",")
	   	   

	   
	   def fechaApertura= getQQuery(Q, "o.fechaApertura")
	   
	   
	   //println "FECHA APERTURA "+fechaApertura
	   
	   DecimalFormat dff=new DecimalFormat("#,###")

	   //def queryOpGeneradas="Select sum(o.valorOportunidad) from Oportunidad o Where o.idEstrategia='posacgenv' and o.trimestre='${Q}' and o.eliminado=0 and o.fechaApertura between '${fechaQ[0]}' and '${fechaQ[1]}' and o.id IN ('${opPorEmpleado}'))"
	   //def queryOpGeneradas="Select sum(o.valorOportunidad) from Oportunidad o Where  o.eliminado=0 and o.fechaApertura between '${fechaQ[0]}' and '${fechaQ[1]}' and o.empleado.id IN (${userIds}) and idSucursal IN (${ciudadesIds}) and o.estrategiaId='5' and o.idTactica='6'"
	   //def queryOpGeneradas="Select sum(o.valorOportunidad) from Oportunidad o Where  o.eliminado=0 and o.fechaApertura ${consultaFecha} and o.empleado.id IN (${userIds}) and idSucursal IN (${ciudadesIds}) and o.estrategiaId='5' and o.idTactica='6'"
	   def queryOpGeneradas="Select sum(o.valorOportunidad) from Oportunidad o Where  o.eliminado=0 and (${fechaApertura}) and o.empleado.id IN (${userIds}) and idSucursal IN (${ciudadesIds}) and o.estrategiaId='5' and o.idTactica='6'"
	   println queryOpGeneradas
	   //La tactica=6 Y estrategia=5 ambas son ' Generadas x vendedor ' 
	   def generado=Oportunidad.executeQuery(queryOpGeneradas)[0]
	   //println "Antes "+generado
	   if(generado)
	   	generado=dff.format(generado)
	   else	  
	   generado=0

		
	   //println "La suma de las oportunidades generadas es "+generado
	   //println "Las oportunidades son -> "+opPorEmpleado
	   
	   
	   

	   
	   //def queryOpAsignadas="Select sum(o.valorOportunidad) from Oportunidad o Where  o.eliminado=0 and o.fechaApertura between '${fechaQ[0]}' and '${fechaQ[1]}' and o.empleado.id IN (${userIds}) and idSucursal IN (${ciudadesIds})  and o.prospecto is not NULL"
	   
	   def queryOpAsignadas="Select sum(o.valorOportunidad) from Oportunidad o Where  o.eliminado=0 and (${fechaApertura}) and o.empleado.id IN (${userIds}) and idSucursal IN (${ciudadesIds})  and o.prospecto is not NULL"
	   def asignado=Oportunidad.executeQuery(queryOpAsignadas)[0]
	   if(asignado)
	   {
		   //dff.format(Oportunidad.executeQuery(queryOpAsignadas)[0])
		   //println "ASIGNADO ANTES "+asignado
		   asignado=dff.format(asignado)
		   //println "ASIGNADO DESPUES "+asignado
			   
	   }
	   else	   
	   		asignado=0
	   
		   
		println queryOpAsignadas
		 
	   //println "La suma de las oportunidades asignadas es "+asignado
	   
	   
	   //def queryOpForecast="Select sum(o.valorOportunidad) from Oportunidad o Where o.eliminado=0 and o.fechaCierreEstimada between '${fechaQ[0]}' and '${fechaQ[1]}' and o.empleado.id IN (${userIds}) and idSucursal IN (${ciudadesIds})  and o.idEtapa IN('posventx50','posventx25') and o.idEstadoOportunidad IN ('oporactiva','opocotizad')"
	   def fechaCierreEstimada=getQQuery(Q, "o.fechaCierreEstimada")
	   def queryOpForecast="Select sum(o.valorOportunidad) from Oportunidad o Where o.eliminado=0 and (${fechaCierreEstimada}) and o.empleado.id IN (${userIds}) and idSucursal IN (${ciudadesIds})  and o.idEtapa IN('posventx50','posventx25') and o.idEstadoOportunidad IN ('oporactiva','opocotizad')"
	   def forecast=Oportunidad.executeQuery(queryOpForecast)[0]
	   
	   
	   if(forecast)
	   		forecast=dff.format(forecast)
	   else
	    	forecast="No aplica"
	   
	   
	   println queryOpForecast
	   

	   
	   def fechaCierreReal=getQQuery(Q, "o.fechaCierreReal")
	   //def queryOpGanado="Select sum(o.valorOportunidad) from Oportunidad o Where o.eliminado=0 and o.fechaCierreReal between '${fechaQ[0]}' and '${fechaQ[1]}' and o.empleado.id IN (${userIds}) and idSucursal IN (${ciudadesIds})  and o.idEstadoOportunidad='xganada' "//fecha cierre real est� en el Q
	   def queryOpGanado="Select sum(o.valorOportunidad) from Oportunidad o Where o.eliminado=0 and  (${fechaCierreReal}) and o.empleado.id IN (${userIds}) and idSucursal IN (${ciudadesIds})  and o.idEstadoOportunidad='xganada' "//fecha cierre real est� en el Q
	   def ganado=Oportunidad.executeQuery(queryOpGanado)[0]
	   if(ganado)
	   	ganado=dff.format(ganado)
	   else
	   ganado=0
	   
	   println queryOpGanado
	   //println "La suma de las oportunidades ganadas "+ganado
	   
	   

	   
	   
	   def fechaFactura=getQQuery(Q, "f.fechaFactura")
	   //def queryFacturadoPesos="Select sum(f.valorFactura) FROM Factura f,Pedido p,Empleado e Where f.pedido=p.id and p.empleado=e.id and e.id IN (${userIds}) and p.idSucursal IN (${ciudadesIds}) and p.idTipoPrecio='pedtprec01' and f.eliminado=0 and (${fechaFactura})"
	   def queryFacturadoPesos="Select sum(f.valorFactura) FROM Factura f,Pedido p,Empleado e Where f.pedido=p.id and p.empleado=e.id and e.id IN (${userIds}) and p.idSucursal IN (${ciudadesIds}) and p.idMondedaFactura='pedtmone01' and f.eliminado=0 and (${fechaFactura})  and p.idEstadoPedido!='pedanuladx'"
	   def pesosFacturados=Factura.executeQuery(queryFacturadoPesos)[0]
	   
	   println "TOTAL FACTURADO PESOS -------->"+queryFacturadoPesos
	   
	   
	   if(pesosFacturados)
	   	pesosFacturados=pesosFacturados//2800
	   else
		pesosFacturados=0
	   
	   
	   def queryFacturadoDolares="Select sum(f.valorFactura) FROM Factura f,Pedido p,Empleado e  Where f.pedido=p.id and p.empleado=e.id and e.id IN (${userIds}) and p.idSucursal IN (${ciudadesIds}) and p.idMondedaFactura='pedtmone02' and f.eliminado=0 and (${fechaFactura})  and p.idEstadoPedido!='pedanuladx'"
	   def dolaresFacturados=Factura.executeQuery(queryFacturadoDolares)[0]
	   
	   println "DOLARES FACTURADOS GBATISTA"+dolaresFacturados
	   
	   if(!dolaresFacturados)	   	
	   	dolaresFacturados=0
	   
	   
	   def facturado=dff.format(pesosFacturados+dolaresFacturados)
	   
	   
	   
	   
	   //def queryOpPerdido="Select sum(o.valorOportunidad) from Oportunidad o Where o.eliminado=0 and o.fechaCierreReal between '${fechaQ[0]}' and '${fechaQ[1]}' and o.empleado.id IN (${userIds}) and o.idEstadoOportunidad='xperdida' "//fecha cierre real est� en el Q
	   def queryOpPerdido="Select sum(o.valorOportunidad) from Oportunidad o Where o.eliminado=0 and (${fechaCierreReal}) and o.empleado.id IN (${userIds}) and o.idEstadoOportunidad='xperdida' and o.idMotivoPerdida='poscompete' "//fecha cierre real est� en el Q
	   def perdido=Oportunidad.executeQuery(queryOpPerdido)[0]
	   if(perdido)
	      perdido=dff.format(perdido)
	   else
	   	  perdido=0
	   
	   println queryOpPerdido
	   
	   Map infoQ = new HashMap()
	   
	   
	   
	   
	   //----------------ESTA LINEA CORRESPONDE AL FACTURADO QUE SE MUESTRA EN EL PORCENTAJE
	   def facturadoParaPorcentaje=dff.format(pesosFacturados/2800+dolaresFacturados)
	   //----------------ESTA LINEA CORRESPONDE AL FACTURADO QUE SE MUESTRA EN EL PORCENTAJE
	   
	   
	   
	   
	   
	   pesosFacturados=dff.format(pesosFacturados)
	   dolaresFacturados=dff.format(dolaresFacturados)
	   
	   infoQ.put("forecast", forecast);
	   infoQ.put("ganadas", ganado);
	   infoQ.put("perdida", perdido);
	   infoQ.put("asignado", asignado);
	   infoQ.put("generado", generado);
	   infoQ.put("facturado", facturado);
	   infoQ.put("facturadoPesos", pesosFacturados);
	   infoQ.put("facturadoDolares", dolaresFacturados);
	   
	   

	   
	   
	   
	   
	   
	   
	   
	   def cuotaPorVendedor=getCuotaVendedor(userId,Q)
	   
	   //println "La cuota de estos vendedores es "+cuotaPorVendedor.generadasExpected
	   Long generadoExpet=cuotaPorVendedor.generadasExpected
	   
	   //Long generadoTemp=Long.parseLong("13.622")
	   Long generadoTemp=Long.parseLong(generado.toString().replace(".",""))//empanada para quitar el punto, porque el ParseLong no reconoce string con .
	   
	   def porcentajeGenerado
	   def porcentajeAsignado
	   
	   if(generadoExpet!=0)
	   	porcentajeGenerado=generadoTemp/generadoExpet*100
	   else
		porcentajeGenerado=0
		
		   println "Generado temp "+generadoTemp
		   println "Generado expet "+generadoExpet
		   println "Porcentaje Generado "+porcentajeGenerado
	   
		 
		   porcentajeGenerado=dff.format(porcentajeGenerado).replace('.','')
		   
		   println "Porcentaje Generado DESPUES "+porcentajeGenerado
		   
	    infoQ.put("porcentajeGenerado", porcentajeGenerado);
		
		
		
		Long asignadoExpet=cuotaPorVendedor.asignadasExpected
		Long asignadoTemp=Long.parseLong(asignado.toString().replace(".",""))

		

		
				
		println "ATEMP"+asignadoTemp
		println "AEXPET"+asignadoExpet
		if(asignadoExpet!=0)
			porcentajeAsignado=asignadoTemp/asignadoExpet*100
		else
		porcentajeAsignado=0
		
		
		porcentajeAsignado=dff.format(porcentajeAsignado)
		infoQ.put("porcentajeAsignado", porcentajeAsignado)
		
		
		
		
		Long forecastExpet=cuotaPorVendedor.forecastExpected
		Long forecastTemp
		def porcentajeForecast
		if(forecast!="No aplica")
			forecastTemp=Long.parseLong(forecast.toString().replace(".",""))
		else
		forecastTemp=0
		
		println "FTEMP"+forecastTemp
		println "FEXPET"+forecastExpet
		
		
		if(forecastExpet!=0)
		{   porcentajeForecast=(forecastTemp/forecastExpet*100)
			porcentajeForecast=dff.format(porcentajeForecast)
		}
		else
		porcentajeForecast="No aplica"
		
		
		
		infoQ.put("porcentajeForecast", porcentajeForecast)
		
		
		def queryGanadoExpet="Select sum(o.valorOportunidad) from Oportunidad o Where o.eliminado=0 and  (${fechaCierreReal}) and o.empleado.id IN (${userIds}) and idSucursal IN (${ciudadesIds})"//fecha cierre real est� en el Q
		def ganadoExpet=Oportunidad.executeQuery(queryGanadoExpet)[0]
		
		if(ganadoExpet)
			ganadoExpet=dff.format(ganadoExpet)
		else
		ganadoExpet=1//no estoy seguro si debe ser 1
		
		Long ganadaExpet=Long.parseLong(ganadoExpet.toString().replace(".", ""))
		Long ganadaTemp=Long.parseLong(ganado.toString().replace(".",""))
		
		
		
		Long ganadoooExpet=cuotaPorVendedor.ganadasExpected
		
		
		
		
		def porcentajeGanada
		//if(ganadaExpet!=null)//posiblemente de aqui a abajoo no
			//porcentajeGanada=ganadaTemp/ganadaExpet*100//se reemplazaron por las 2 lineas de abajo
			if(ganadoooExpet!=0)
			{
				porcentajeGanada=ganadaTemp/ganadoooExpet*100
				porcentajeGanada=dff.format(porcentajeGanada).replace('.','')
			}
			else
			porcentajeGanada=0
	   
			println "Ganada TEMP"+ganadaTemp
			println "Ganada EXPET"+ganadaExpet
			
			infoQ.put("porcentajeGanada", porcentajeGanada)
			//--------------PEDIDOS 
	   def fechaAperturaPedido=getQQuery(Q, "p.fechaApertura")
	   def queryPedidosPorEmpleadoPesos="Select sum(p.valorPedido) from Pedido p Where p.eliminado=0 and  (${fechaAperturaPedido}) and p.empleado.id IN (${userIds}) and idSucursal IN (${ciudadesIds}) and p.idTipoPrecio='pedtprec01'"
	   def queryPedidosPorEmpleadoDolares="Select sum(p.valorPedido) from Pedido p Where p.eliminado=0 and  (${fechaAperturaPedido}) and p.empleado.id IN (${userIds}) and idSucursal IN (${ciudadesIds}) and p.idTipoPrecio='pedtprec02'"
	   
	   def totalPedidosPorEmpleadoPesos
	   		totalPedidosPorEmpleadoPesos=Pedido.executeQuery(queryPedidosPorEmpleadoPesos)[0]
			   
			   println "TOTAL PEDIDO EMPLEADO PESOS "+totalPedidosPorEmpleadoPesos
			
	   if(totalPedidosPorEmpleadoPesos)
		totalPedidosPorEmpleadoPesos=totalPedidosPorEmpleadoPesos/2800//entre la tasa de trm
	   else
		totalPedidosPorEmpleadoPesos=0
			
			
	   def totalPedidosPorEmpleadoDolares=Pedido.executeQuery(queryPedidosPorEmpleadoDolares)[0]
	   
	   if(!totalPedidosPorEmpleadoDolares)	   	
		totalPedidosPorEmpleadoDolares=0
		
		println "TOTAL PEDIDO EMPLEADO DOLARES "+totalPedidosPorEmpleadoDolares
	   
	   def pedidosFacturadoExpet=dff.format(totalPedidosPorEmpleadoDolares+totalPedidosPorEmpleadoPesos)
	   	   println "ESTE SI DEBE SER "+pedidosFacturadoExpet	
		   println "FACTURADOOOOOOOOOOOOOOOOO CUADRITO "+facturado
	   
	   Long facturadoTemp=Long.parseLong(facturadoParaPorcentaje.toString().replace(".",""))
	   
	   println "TOTAL PEDIDOS PESOS ---> "+totalPedidosPorEmpleadoPesos
	   println "TOTAL PEDIDOS DOLARES---> "+totalPedidosPorEmpleadoDolares
	   println "TOTAL PEDIDOS 100% -> "+pedidosFacturadoExpet
	   
	   Long facturadoExpet=Long.parseLong(pedidosFacturadoExpet.toString().replace(".",""))//ESTO YA NO..CREO
	   
	   
	   Long facturadoExpected=cuotaPorVendedor.facturadoExpected
	   
	   def porcentajeFacturado
	   if(facturadoExpected==0)//
	   porcentajeFacturado=0
	   else
	   //porcentajeFacturado=facturadoTemp/facturadoExpet*100
	   porcentajeFacturado=facturadoTemp/facturadoExpected*100
	   
	   println "Facturado temp JODAAAAAAA "+facturadoTemp
	   println "Facturado Expected JODAAAAAAA "+facturadoExpected
	   println "PORCENTAJE F"+porcentajeFacturado
		
	   porcentajeFacturado=dff.format(porcentajeFacturado)
	   infoQ.put("porcentajeFacturado", porcentajeFacturado)
	   
	   
	   
	   
	   
	   
	   
	   

	   
	   
	   def queryPerdido="Select sum(o.valorOportunidad) from Oportunidad o Where o.eliminado=0 and o.empleado.id IN (${userIds}) and idMotivoPerdida='poscompete'"//fecha cierre real est� en el Q"
	   def perdidoExpet=Oportunidad.executeQuery(queryPerdido)[0]
	   
	   
	   def queryOpptyPeriodo="Select sum(o.valorOportunidad) from Oportunidad o Where o.eliminado=0 and (${fechaApertura}) and o.empleado.id IN (${userIds})"//fecha cierre real est� en el Q"
	   def resultOpptyPeriodo=Oportunidad.executeQuery(queryOpptyPeriodo)[0]
	   
	   println queryOpptyPeriodo
	   println "La suma de las oportunidades del periodo es "+resultOpptyPeriodo
	   
	   
	   if(perdidoExpet)
	   perdidoExpet=perdido//dff.format(perdidoExpet)
		   else
	   perdidoExpet=0
	   
	   if(resultOpptyPeriodo)//oportunidades del periodo
	   resultOpptyPeriodo=dff.format(resultOpptyPeriodo)
	   else
	   resultOpptyPeriodo=1
	   
	   Long perdidoTemp=Long.parseLong(perdidoExpet.toString().replace(".",""))//perdidas por competencia
	   //Long perdidooExpet=cuotaPorVendedor.perdidoExpected
	   Long perdidooExpet=Long.parseLong(resultOpptyPeriodo.toString().replace(".",""))
	   //println "AAAAAAAAAAAAAAAAAA +"+perdidooExpet
	   
	   println "PERDIDOS POR COMPETENCIA "+perdidoTemp
	   println "Valor OPORTUNIDADES PERIODO "+resultOpptyPeriodo
	   
	   def porcentajePerdido
	   if(perdidooExpet!=0)
	   	porcentajePerdido=perdidoTemp/perdidooExpet*100
	   else
	   	porcentajePerdido=0
		   
		   porcentajePerdido=dff.format(porcentajePerdido)
	   
	   infoQ.put("porcentajePerdido", porcentajePerdido)
	   
	   
	   println "TODA LA INFORMACION QUE DEVUELVE ESTE INFOQ ES ------------>          "+infoQ
	   return infoQ
	   
   		
	   
	   
	   
   }
   
   
   

   
   
   
   def traerVendedoresPorGerente(String gerenteUsername)
   {
	   def ids=[]
	   List vendedores=getValorParametro(gerenteUsername).toString().split(",")
	   vendedores.each {vendedor->
		   ids.add(Empleado.where{usuario.usuario==vendedor}.id.toList()[0]) //hallamos los IDS de los vendedores asociados
		   //println Empleado.findById(Empleado.where{usuario.usuario==vendedor}.id.toList()[0])
	   }
	   return ids
   }
   
   
   
   
   
   
 
   def stringToLongArray(def array) //PASAR UN ARRAY DE STRING A LONG
   {
	String[] prueba = array.split (",")
	Long[] longV=new long[prueba.size()]
	prueba.eachWithIndex {element,index->
		longV[index]=Long.parseLong(element)
		
	}
	return longV
	
   }
   
   
   def getQQuery(String[]Q, String tipofecha)
   {  
	   def query=""
	   Q.eachWithIndex {Qu, i->
		if((i+1)==Q.size())//es el ultimo elemento de la lista
		{
			query+=returnQQuery("2018",Qu,"${tipofecha}")
		}
		else
		{
			query+=returnQQuery("2018",Qu,"${tipofecha}")+" or "
		}
	   } 
	   
	   return query
   }
   
   
   def returnQQuery(String anio,String Q, String tipofecha)
   {
	   def query=""
	   switch(Q)
	   {
		  case "Q1":query="(${tipofecha} between '${anio}-01-01' and '${anio}-03-31')";break
		  case "Q2":query="(${tipofecha} between '${anio}-04-01' and '${anio}-06-30')";break
		  case "Q3":query="(${tipofecha} between '${anio}-07-01' and '${anio}-09-30')";break
		  case "Q4":query="(${tipofecha} between '${anio}-10-01' and '${anio}-12-31')";break
		  	   
	   }
	   
	   return query
	   
   }
   
   def getCuotaVendedor(Long[]empleadosId,String[] Q)
   {
	   Long cuotaPorVendedor=0
	   Long cuotaTotal=0
	   empleadosId.each {valor->
		   
		   def query="Select usuario FROM Usuario u Where u.empleado.id=${valor}"
		   def userName=Usuario.executeQuery(query)[0]+"C"	
		   println "USERNAME ES .."+userName	   
		   String p=getValorParametro("${userName}")?:"0"
		   println "Cuota Vendedor es .."+p
		   cuotaPorVendedor=Long.parseLong(p)/2800
		   println "La cuota para este VENDEDOR ES DE --------->"+cuotaPorVendedor
		   Q.each{paramQ->
		   	String porcentajeQ=getValorParametro("${paramQ}")
			   println "PORCENTAJE DE LAS Q POR VENDEDOR ----> "+porcentajeQ
			   
			   Long cuota=(long)Double.parseDouble(porcentajeQ)*cuotaPorVendedor			   
			//cuotaTotal+=(long)Double.parseDouble(porcentajeQ)*cuotaPorVendedor	
			  cuotaTotal+=cuota
			
		   }   
		    println "Cuota Total para este(os) vendedores es "+cuotaTotal
	   }
	   
	   Map porcentajesCumplimiento = new HashMap()
	   
	   porcentajesCumplimiento.put("generadasExpected", cuotaTotal*3);//GENERADO % CUMPLIMIENTO
	   porcentajesCumplimiento.put("asignadasExpected", cuotaTotal);//GENERADO % CUMPLIMIENTO
	   porcentajesCumplimiento.put("ganadasExpected", cuotaTotal);//GENERADO % CUMPLIMIENTO
	   porcentajesCumplimiento.put("facturadoExpected", cuotaTotal);//GENERADO % CUMPLIMIENTO
	   porcentajesCumplimiento.put("forecastExpected", cuotaTotal*3);//GENERADO % CUMPLIMIENTO
	   porcentajesCumplimiento.put("perdidoExpected", cuotaTotal);//GENERADO % CUMPLIMIENTO
	   
	   return porcentajesCumplimiento
	    
	   
   }
   
   //------------------------------------------------FORECASTXQ JDMAURY------------------------------------------------------------//
   
   
   def oportunidadesPorProbabilidad(def userId)
   {
	   
	   
	   Map opptyProb=new HashMap()
	   
	   def queryOppty10="Select sum(o.valorOportunidad) from Oportunidad o Where o.eliminado=0 and o.idEtapa='posventx10' and o.empleado.id=${userId} and o.idEtapa='posventx10' and o.fechaApertura between '2017-07-01' and '2017-09-30'"
	   def queryOppty25="Select sum(o.valorOportunidad) from Oportunidad o Where o.eliminado=0 and o.idEtapa='posventx25' and o.empleado.id=${userId} and o.idEtapa='posventx25' and o.fechaApertura between '2017-07-01' and '2017-09-30'"
	   def queryOppty50="Select sum(o.valorOportunidad) from Oportunidad o Where o.eliminado=0 and o.idEtapa='posventx50' and o.empleado.id=${userId} and o.idEtapa='posventx50' and o.fechaApertura between '2017-07-01' and '2017-09-30'"
	   def queryOppty75="Select sum(o.valorOportunidad) from Oportunidad o Where o.eliminado=0 and o.idEtapa='posventa75' and o.empleado.id=${userId} and o.idEtapa='posventa75' and o.fechaApertura between '2017-07-01' and '2017-09-30'"
	   def queryOppty100="Select sum(o.valorOportunidad) from Oportunidad o Where o.eliminado=0 and o.idEtapa='posvent100' and o.empleado.id=${userId} and o.idEtapa='posvent100' and o.fechaApertura between '2017-07-01' and '2017-09-30'"
	   
	   
	   def result10=Oportunidad.executeQuery(queryOppty10)[0]?:0
	   def result25=Oportunidad.executeQuery(queryOppty25)[0]?:0
	   def result50=Oportunidad.executeQuery(queryOppty50)[0]?:0
	   def result75=Oportunidad.executeQuery(queryOppty75)[0]?:0
	   def result100=Oportunidad.executeQuery(queryOppty100)[0]?:0
	   
	   
	   
	   opptyProb.put("op10", result10)
	   opptyProb.put("op25", result25)
	   opptyProb.put("op50", result50)
	   opptyProb.put("op75", result75)
	   opptyProb.put("op100", result100)
	   
	   return opptyProb
   }

   def stringToDate(String dateString)
   {
	   if(dateString.contains('/'))
	   	dateString=dateString.replace('/', '-')
	   
	   
	   DateFormat df=new SimpleDateFormat("dd-MM-yyyy")
	   Date fechaParseada=df.parse(dateString)
	   return fechaParseada
   }

   def stringDateWithTimeToDate(String dateString)
   {
	   DateFormat inputFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS")
	   Date dateFormat = inputFormatter.parse(dateString)
	   DateFormat outputFormatter = new SimpleDateFormat("dd-MM-yyyy")
	   dateString=outputFormatter.format(dateFormat)
	   return dateString
   }


   def  notificarVencimiento(String idTipoVencimiento,Long idvendedor,String asunto,String cuerpo)
   {
	   
	   
	   def lista=[]

	   String emailVendedor=Empleado.get(idvendedor).email
	   String emailJefe=''
	   def sucursalVendedor=Empleado.get(idvendedor).idSucursal
	   
	   if(sucursalVendedor==1 || sucursalVendedor==3)//Barranquilla o Bucaramanga
		   emailJefe='vendedorBAQBUC@redsis.com'
	   else
	   {
		   if(sucursalVendedor==2)//Bogota
		   emailJefe='vendedorBogota@redsis.com'
	   }
		   
	   String notificados=emailVendedor+","+emailJefe
	   
	   println "notificados"+notificados
	   
	   println "recibi el idTipoVencimiento "+idTipoVencimiento
	   
	   switch(idTipoVencimiento)//dependiendo del tipo de vencimiento se notifica a una persona
	   {	  
		  
		  case "venhardw":notificados+=","+getValorParametro('notihardw')//notihardw
		  					  break//encargado mantenimiento redsis, KERLYN CASTRO,
          case "softhw":notificados+=","+getValorParametro('notisofthw')//notisofthw
		  					  break//encargado mantenimiento redsis, KERLYN CASTRO,
          case "vensoftapl":notificados+=","+getValorParametro('notisoftapl')//notisoftapl
							  break//encargado mantenimiento redsis, KERLYN CASTRO,
		  case "venconsop":notificados+=","+getValorParametro('noticonsop')//noticonsop
							  break//SOPORTE, THANIA PALOMINO, KERLYN CASTRO,MARLON
		  case "venadmin":notificados+=","+getValorParametro('notivenadmin')//notivenadmin
							  break//CONTR.ADMIN. JOSE TORRES, THANIA PALOMINO, KERLYN CASTRO
          case "venadmter":notificados+=","+getValorParametro('notiadmter')//notiadmter
							  break//encargado mantenimiento redsis, KERLYN CASTRO,
		  case "venarrend":notificados+=","+getValorParametro('notiarrend')
							  break//CONTR.ARREND. ANTONIO HABIB, VANESSA BARROS
		  case "venarrter":notificados+=","+getValorParametro('notiarrter')
						     break//encargado mantenimiento redsis, KERLYN CASTRO,
		  
		  
	   }
	   println "Lista de notificados antes de ... "+notificados
	   lista=convertirEnLista(notificados)
	   println "LISTA FINAL DE NOTIFICADOS ........"+lista	   	   
	   enviarCorreo(1,lista,asunto, cuerpo)
	   
	   
   }
   
   
   def  datosVencimientoExcel(String tipoVencimiento, String numeroPedido, String fechaInicio,String fechaVencimiento, String plataforma,String convenio,String cobertura,String contrato)
   {
	   
	   Map datosPlantilla = new HashMap()
	   String tipoVenci=''
	   Pedido pedido=Pedido.find{numPedido==numeroPedido}
	   switch(tipoVencimiento)
	   {
		   case 'Mantenimiento_de_hardware': 
		   			tipoVenci='venhardw';break;
					   
		   case 'Mantenimiento_de_software_asociado_al_hardware':
		   			tipoVenci='softhw' ;break;
					   
		   case 'Mantenimiento_de_software_aplicativo':
		   			tipoVenci='vensoftapl';break;					   
		   			
		   case 'Convenios_de_soporte_Redsis':
		   			tipoVenci='venconsop' ;break;
		   			
		   case 'Contratos_de_administracion_Servicios_Redsis':
		   			tipoVenci='venadmin' ;break;
		   			
		   case 'Contratos_de_administracion_servicios_terceros':
		   			tipoVenci='venadmter' ;break;
		   			
		   case 'Contratos_de_arrendamiento_Redsis':
		   			tipoVenci='venarrend' ;break;
		
		   case 'Contratos_de_arrendamiento_terceros':
		   			tipoVenci='venarrter' ;break;
					   
					   
		   			
	   }
	   datosPlantilla.put("tipoVencimiento", tipoVenci)
	   datosPlantilla.put("numPedido", pedido)
	   
	   
	   
	   Date fechaIni=stringToDate(fechaInicio)
	   Date fechaFin=stringToDate(fechaVencimiento)
	   datosPlantilla.put("fechaInicio", fechaIni)
	   datosPlantilla.put("fechaVencimiento", fechaFin)
	   datosPlantilla.put("estadoVencimiento",getEstadoVencimiento(fechaIni,fechaFin)[0])
	   
	   
	   def plataformaId=ValorParametro.where {valor==plataforma;idParametro==tipoVenci}.id.toList()[0]
	   datosPlantilla.put("plataforma", plataformaId)
	   
	   
	   def convenioId=ValorParametro.where {valor==convenio;idParametro=='tipoConve'}.id.toList()[0]
	   datosPlantilla.put("tipoConvenio", convenioId)
	   
	   def coberturaId=ValorParametro.where {valor==cobertura;idParametro=='tipocobert'}.id.toList()[0] 
	   datosPlantilla.put("tipoCobertura", coberturaId)
	   
	   def contratoId=ValorParametro.where {valor==contrato;idParametro=='tipoContra'}.id.toList()[0] //solo arrendamiento terceros
	   datosPlantilla.put("tipoContrato", contratoId)
	   
	   return datosPlantilla

   }

   def leerArchivoExcel(File archivo)
   {
	   String contenido=""
	   
	   try{
	   
	   FileInputStream file=new FileInputStream(archivo)
	   XSSFWorkbook workbook = new XSSFWorkbook(file)	   
	   //Get first/desired sheet from the workbook
	   XSSFSheet sheet = workbook.getSheetAt(0)	   
	   //Iterate through each rows one by one
	   Iterator<Row> rowIterator = sheet.iterator()
	   
	   while (rowIterator.hasNext())
	   {
		   Row row = rowIterator.next();
		   //For each row, iterate through all the columns
		   Iterator<Cell> cellIterator = row.cellIterator();
			
		   while (cellIterator.hasNext())
		   {
			   
			   Cell cell = cellIterator.next();
			   //Check the cell type and format accordingly
			   switch (cell.getCellType())
			   {
					     case Cell.CELL_TYPE_BOOLEAN:
				            contenido+=cell.getBooleanCellValue()+","
				            break;
				        case Cell.CELL_TYPE_NUMERIC:
				            contenido+=cell.getNumericCellValue()+","
				            break;
				        case Cell.CELL_TYPE_STRING:
				            contenido+=cell.getStringCellValue()+","
				            break;
				        case Cell.CELL_TYPE_BLANK:
				            break;
				        case Cell.CELL_TYPE_ERROR:
				            contenido+=cell.getErrorCellValue()+","
				            break;				
				        // CELL_TYPE_FORMULA will never occur
				        case Cell.CELL_TYPE_FORMULA: 
				            break;
							
							
			   }
			   
			   
		   }
		   contenido+="\n"
	   }
	   file.close()
	   }catch(Exception e)
	   {
		   e.printStackTrace()
	   }
	   
	   return contenido
	   
   }
   
   
   def usuarioExiste(String username,String password)
   {
	   def query = Usuario.where {
		   usuario ==username
		   contrasena==password
		   eliminado==0
		   idEstadoUsuario=="useractivo"
	   }
	   Usuario user = query.find()
	   if(user)
	   	return true
	   else
	   	return false
	   
   }
   
 
   
 def formatDateSRR(String fecha)//metodo para formatear fecha de SRR, as� la hizo desarrollo agil
 {
	 	DateFormat df=new SimpleDateFormat("yyyy-MM-dd")
		 
		Date fechaString=stringToDate(fecha)
		String fechaSRR=df.format(fechaString)
		
		return fechaSRR.toString()
 } 
 
 
 def devolverUrlSrr(String numSrr)//PARA ABRIR EL REQUERIMIENTO EN LA NUEVA HERRAMIENTA
 {
	 String id=numSrr.split("-")[1]
	 String direccion="http://srr.redsis.com:8080/SRR/srr/pages/requerimientos/editarRequerimiento.xhtml?req=${id}"
	 return direccion
 }

   
 def contarclientes()
 {
	 def consulta="Select e from Empresa e where  e.id<30 group by e.nit order by e.razonSocial"
	 def query=Empresa.executeQuery(consulta)
	 println query as JSON
 }


 def infoSiesa(){
     def siesaText=new URL ("http://siesalab01:8080/siesaadmin/siesa/modelo/API/rest/items").text
     JSONArray jsonArray=new  JSONArray(siesaText)
     jsonArray.each{
         JSONObject jsonObject=new JSONObject(it)
         def orden = it.orden
         def fecha = it.fecha
         def desc = it.descripcion
         def periodo = it.periodo
         def entrada = it.entrada
         def seriales = it.seriales
         def referencia = it.referencia
         //println jsonObject
     }
     render jsonArray as JSON
 }

 def infoSRR(String numOportunidad)
 {
	 def http = new HTTPBuilder('http://srr.redsis.com:8080/WSservices/')
	 //def http = new HTTPBuilder('http://192.168.36.112:8080/WSservices/')


		//def prueba=generalService.infoSRR(numOppty)
		
		def listaReq
		def transaccion
		http.request(POST) {
			uri.path = 'webresources/consultarRequerimientoOPP/'
			requestContentType = ContentType.JSON
			body = ["numOptty":numOportunidad]
			
			response.success = { resp,json ->
				println "Success! ${resp.status}"
				listaReq=json.Respuesta
				transaccion= json.Transaccion
				//render body as JSON
				
			}
		
			response.failure = { resp ->
				println "Request failed with status ${resp.status}"
			}
			 
		}
		
		def listaDocs=""
			if(transaccion=="1")
			{
				listaDocs=listaReq
			}
		
		//println "Aja mi vale la transaccion es "+transaccion
		//println "Toes mi pana los req son "+listaReq
		
		
		
		return listaDocs
 }
	
  
 
 
 def subirAnexoContratos(def request,def servletContext,def idContrato)
 {
	 Random rand=new Random()
	 String zruta=getValorParametro('ruta01')
	 println "Z R U T A "+zruta
	 
	 def contrato=Contrato.get(idContrato)
	 
	 def file2 = request.getFile('file')
	 
	 
	 def xruta2 = servletContext.getRealPath(zruta)
	 
	 String xnombre2=rand.nextInt(1000000).toString()+".xls"
	 contrato.archivoSeriales=xnombre2
	 def  rutayFile=new File( xruta2,xnombre2)
	 
	 
		 if 	(!rutayFile.exists()){
			 file2.transferTo(rutayFile)
		 //vencimientoInstance.serial=generalService.leerArchivoExcel(rutayFile)
		 }
		 
		 return rutayFile //ESTO ES PORQUE LA FUNCION DE IMPORTAR DE EXCEL LA PIDE Y NO TENGO FORMA DE ACCEDER A ELLA DESDE EL CONTROLLER
 }
 
 def importarSerialesExcel(def idContrato, def rutayFile)
 {
	 def contrato=Contrato.get(idContrato)
	 
	 println "EL VENCIMIENTO ES       "+contrato
	 
	 RecordExcelImporter importer=new RecordExcelImporter(rutayFile)
	 importer.CONFIG_RECORD_COLUMN_MAP=[sheet:'Seriales', startRow: 1,
		 columnMap:[ 'A':'Seriales']]
	 def recordsMapList = importer.getRecords()
	 if(recordsMapList)
	 {
		 int i=0
		 def serialInstance
		 recordsMapList.each(){
			if (it.Seriales!=null){
				//println vencimientoInstance.id
				serialInstance=new Seriales()
				serialInstance.contrato=contrato
				serialInstance.numSerial=it.Seriales.toString()
				serialInstance.eliminado=0
				serialInstance.save()
			}
		 }
	 }
 }
 
 def actualizarSeriales(def idContrato)//Cuando se carga otro archivo de seriales se borran los que estaban y se reemplaza por el nuevo
 {
	 
	 def query="Update Seriales set eliminado=1 where contrato=${idContrato}"
	 Seriales.executeUpdate(query)
 }
 
 
 def notificarVencimientos2()
 {	 	
	 
	 def query="""Select v.id,v.idTipoVencimiento,v.encvencimiento.empresa.razonSocial,v.empleado.id,v.descripcion,v.fechaInicio,v.fechaVencimiento,DATEDIFF(v.fechaVencimiento,current_date)
					  From Vencimiento v 
					  WHERE DATEDIFF(v.fechaVencimiento,current_date) BETWEEN -30 and 60 and v.idEstadoVencimiento in ('venvencido','venporvenc') and v.notificar=1 and v.eliminado=0
				   """
		 //WHERE DATEDIFF(v.fechaVencimiento,current_date) BETWEEN -30 and 60 and v.idEstadoVencimiento in ('venvencido','venporvenc')
		def resultado=Vencimiento.executeQuery(query)
		def tamano=resultado.size()
		log.info("\r\n\r\n\r\n\r Hay ${tamano} vencimientos vencidos o proximos a vencer y son los siguientes.. \r\n ${resultado} \n\r\n\r\n\r\n\r\n")
		
		resultado.eachWithIndex {r,ind->
		//println "parametrossdsssssssssss "+r
		String asunto=""
		String mensaje=""
		String empresaVenc=r[2]
		def diasParaVencer=r[7]
		String idTipoVencimiento=r[1]
		String tipoVen=getValorParametro(idTipoVencimiento)
		String fechaIni=stringDateWithTimeToDate(r[5].toString())
		String fechaFin=stringDateWithTimeToDate(r[6].toString())
		
		
		def venciId=r[0]
		String urlbase=getValorParametro('urlaplic')
		String descripcion=r[4]
		println "dias para vencer "+diasParaVencer
		
		
		if(diasParaVencer>0)//VENCIMIENTO POR VENCER
		{
				asunto="VENCIMIENTO PROXIMO A VENCER"
				mensaje="Se le informa que un vencimiento de tipo <b>${tipoVen}</b> para la empresa ${empresaVenc} se vencer&aacute; dentro de los pr&oacute;ximos <b>${diasParaVencer}</b> d&iacute;as.<br><br><b>Fecha de inicio:</b> ${fechaIni}<br><b>Fecha de vencimiento:</b> ${fechaFin}<br><br><b>Descripci&oacute;n:</b><br>${descripcion}<br><br>Para m&aacute;s detalles haga clic <a href='${urlbase}/vencimiento/show/${venciId}?&layout=main'> AQUI </a>"
		}
		else
		{
			if(diasParaVencer==0)//DIA DEL VENCIMIENTO
			{
				asunto="VENCIMIENTO HA LLEGADO A SU FECHA LIMITE"
				mensaje="Vencimiento para la empresa ${empresaVenc} de tipo <b>${tipoVen}</b> ha llegado a su fecha l&iacute;mite y  se vencer&aacute; hoy.<br><br><b>Fecha de inicio:</b> ${fechaIni}<br><b>Fecha de vencimiento:</b> ${fechaFin}<br><br><b>Descripci&oacute;n:</b><br>${descripcion}<br><br>Para m&aacute;s detalles haga clic <a href='${urlbase}/vencimiento/show/${venciId}?&layout=main'> AQUI </a>"
			}
			else//NEGATIVOS, VENCIMIENTO VENCIDO
			{
				//&iacute;				
				diasParaVencer=Math.abs(diasParaVencer)
				asunto="NOTIFICACION VENCIMIENTO VENCIDO."
				mensaje="Se le informa que un vencimiento de tipo <b>${tipoVen}</b> para la empresa ${empresaVenc} se venci&oacute; hace <b>${diasParaVencer}</b> d&iacute;as.<br><br><b>Fecha de inicio:</b> ${fechaIni}<br><b>Fecha de vencimiento:</b> ${fechaFin}<br><br><b>Descripci&oacute;n:</b><br>${descripcion}<br><br>Si no desea recibir m&aacute;s notificaciones de este vencimiento haga clic en <b>Acciones ----> Cliente no renov&oacute;</b> dentro del siguiente <a href='${urlbase}/vencimiento/show/${venciId}?&layout=main'> enlace </a>"
			}
		}
		
		
		def lista=[]
		
		def correos=Empleado.get(r[3]).email
		Long idVendedor=r[3]
		
		lista.add(correos)		
		
		println "TIPO DE VENCIMIENTO ES    "+idTipoVencimiento
		notificarVencimiento(idTipoVencimiento,idVendedor,asunto,mensaje)
		
		
		//println lista+" ${ind}"


		}
 	}
	 
	 
	 def traerRequerimientosSrrLotus(String numOptty)//Esto para traer los requerimientos que vienen de SRR y de LOTUS
	 {
		 Requerimiento req = new Requerimiento()
		 String urlbase=getValorParametro('urlReq')
		 String urlCompleta = urlbase+'mostrarInfoRequerimiento'
		 def respuestaSWLotus
		 respuestaSWLotus = req.leer(numOptty, '3', urlCompleta)//el 3 es porque viene de pedidos...si es 2 es porque viene de oportunidad
		 def  datoJSON = JSON.parse(respuestaSWLotus)
		 //println "URL COMPLETA ESSSSS "+urlCompleta
		 
		 def listaDocumentos
		 if(datoJSON.idTransaccion=="1"){  // la transaccion trajo documentos
			 listaDocumentos=datoJSON.respuesta
		 }else{
			 listaDocumentos=""
		 }	 
		 
		 return listaDocumentos		 
		 
	 }
	 
	 
	 def asignarVendedorDesdeOportunidad(def idOp)//Cuando el VENDEDOR no tiene cliente asociado, le asignamos el vendedor asignado en la Op.
	 //De tal manera que cuando se vaya a registrar un requerimiento a la optty o al pedido, el campo vendedor nunca llegue vac�o
	 {
		def oportunidad=Oportunidad.get(idOp) 
		def vendedorId=oportunidad.empleado.id
		def empresaId=oportunidad.empresa.id
		def empresaDesdeOppty=oportunidad.empresa.empleado //Si el cliente asociado a la Oppty no tiene vendedor...		
		if(!empresaDesdeOppty){
			
			def query="Update Empresa set empleado=${vendedorId} where id=${empresaId}"			
			Empresa.executeUpdate(query)
			log.info("${oportunidad.empleado} ha sido asignado(a) como vendedor para la empresa ${oportunidad.empresa}")			
			
		}
		
		println "La oportunidad es "+oportunidad
		println "El id del vendedor de esta oportunidad es... "+vendedorId
		println "El id de la empresa de esta ${oportunidad.empresa} es... "+empresaId
		println "EL VENDEDOR ES ............ "+empresaDesdeOppty
		

	 }
	 
	 def filtrarPedidosCableadoFacturados(params)
	 {		 		
		String procesarPara=""
		params.max=2700
		//generalService.filtrarPedidosCableadoFacturados(params)
		params.listDistinct=true
		params.uniqueCountColumn='numPedido'
		params['filter.op.detpedido.eliminado']="Equal"
		params['filter.detpedido.eliminado']="0"
		params['filter.op.detpedido.idProcesarPara']=params.filter.op.detpedido.idProcesarPara
			
					
		if(params.filter.detpedido.idProcesarPara=='Interno Redsis' || params.filter.detpedido.idProcesarPara=='pedprosp03')
		{					
			procesarPara='pedintered'			
			params['filter.detpedido.idProcesarPara']="pedprosp03"
		}
		
		if(params.filter.detpedido.idProcesarPara=='Cableado' || params.filter.detpedido.idProcesarPara=='pedprosp02')
		{
			procesarPara='pedfaccabl'
			params['filter.detpedido.idProcesarPara']="pedprosp02"
		}
		
		if(params.filter.detpedido.idProcesarPara=='Mayorista' || params.filter.detpedido.idProcesarPara=='pedprosp01')
		{					
			procesarPara='pedfacmay'
			//params['filter.detpedido.idProcesarPara']="pedprosp01"
		}
		return procesarPara//Esto realiza el filtro y devuelve el titulo para ser utilizado el reporte
	 }
	 
	 
	def tacticasPorEstrategia(def estrategiaId)
	{
		def query="From Tactica t where t.estrategia=${estrategiaId} and t.eliminado=0"
		def result=Tactica.executeQuery(query)
		return result
	}
	 
	 
	 
	 def traerInformacionAsociadaTactica(String nombreTactica)//Traer el numero de prospectos y de oportunidades surgidas a partir de una t�ctica
	 {
		 //def idTactica=Tactica.find{tactica==nombreTactica}.id
		 def idTactica=Tactica.executeQuery("Select t.id From Tactica t where t.tactica='${nombreTactica}' and t.eliminado=0")[0]
		 //println "El resultado es TAMA�O "+idTactica.size()
		 
		 
		 def queryProspectosAsignados="From Prospecto p Where p.idTactica=${idTactica} and p.eliminado=0"
		 def resultadoProspectos=Prospecto.executeQuery(queryProspectosAsignados)
		 
		 def queryOportunidadesGeneradas="From Oportunidad o Where o.idTactica=${idTactica} and o.eliminado=0"
		 def resultadoOportunidades=Prospecto.executeQuery(queryOportunidadesGeneradas)		 		 
		 return [resultadoProspectos,resultadoOportunidades]
		 
	 }
	 
	 def notificarRequerimientoCreado(String numeroReq)
	 {
		 String notificadosSRR=getValorParametro('notiSRR')
		 //println 	"LISTA ES ..."+notificadosSRR		 
		 def listaNotificados=convertirEnLista(notificadosSRR)
		 //println "Lista notificados "+listaNotificados
		 
		 enviarCorreo(1,listaNotificados,"Se ha registrado un nuevo requerimiento: ${numeroReq}","Favor verifique los detalles del requerimiento ${numeroReq} en la herramienta de SRR")
	 }
	 
	 
	 String formatearNitPedido(String nitConEspacios)
	 {
		 String nitSinEspacios=nitConEspacios.replaceAll(" ","").split("-")[0]
		 if(nitSinEspacios.length()>9)
			 nitSinEspacios=nitSinEspacios.substring(0,9)
		 return nitSinEspacios
	 }
	 
	 
	 def notificarProspectosSinAtender()
	 {
		 //Ajuste realizado el 25/01/2018
		 
		 def listaDestino=[]
		 
		 String urlRoot=getValorParametro('urlaplic')
		 String enlace=""
		 
		 
		 

		 def query="From Prospecto where eliminado=0 and idEstadoProspecto='proasignad' and DATEDIFF(fechaApertura,current_date)<=-3 and id>515"
		 //515 porque a partir de ese id son los prospectos de 2018
		 //def query="Select DATEDIFF(fechaApertura,current_date) From Prospecto p where eliminado=0 and idEstadoProspecto='proasignad' and DATEDIFF(fechaApertura,current_date)<-400"
		 def listaProspectos=Prospecto.executeQuery(query)
		 listaProspectos.each {
			 String xparam=getValorParametro('notiBitacora')
			 listaDestino=convertirEnLista(xparam)
			 
			 def notasProspecto="From Nota where nombreEntidad='prospectoAdj' and eliminado=0 and idEntidad=${it.id} and idTipoNota='notagesven'"
			 def numeroNotas=Nota.executeQuery(notasProspecto).size()
			 println "Id prosp es ... "+it.id
			 def emailEmpleado=Empleado.get(it.empleado?.id)?.email?:'auditorcorreocrm@redsis.com'
			 println "EM A I  L  E S "+emailEmpleado
			 listaDestino.add(emailEmpleado)
			 if(numeroNotas==0)
			 {
				String asunto="Prospecto ${it.numProspecto} - ${it.nombreCliente} no ha sido atendido"
				enlace="<br><br>Consulte los detalles del prospecto <a href='${urlRoot}/prospecto/show/${it.id}'> AQUI </a>"
				String mensaje="Usted tiene un prospecto asignado que no ha sido atendido.<br><br><br><b>N&uacute;mero prospecto: </b>${it.numProspecto}.<br><b>Proyecto: </b>${it.nombreProspecto}<br><b>Detalles: </b>${it.descProspecto?:'No tiene'}"+enlace
				enviarCorreo(1,listaDestino,asunto,mensaje)
			 }
				 
			 println "Numero de notas para el prospectoId:${it.id} = "+numeroNotas
			 listaDestino=[]
		 }
		 
	 }
	 
	 def eliminarSublineasFromLinea(String lineaId)
	 {		 		 
		 def query="Update Sublinea set eliminado=1 Where linea.id=${lineaId}"
		 Sublinea.executeUpdate(query)
	 }
	 
	 
	 def oportunidadesSinItems()
	 {
		 def query="Select O From Oportunidad O Where (idEstadoOportunidad='opocotizad' or idEstadoOportunidad= 'oporactiva')and eliminado=0"
		 def listaOportunidades=Oportunidad.executeQuery(query)
		 
		 List listaAExportar=[]
		 
		 listaOportunidades.each {oportunidad->			 
			 def listaItems=[]
			 def queryItems="Select count(ep) From ElementoPorOportunidad ep Where ep.oportunidad=${oportunidad.id} and ep.eliminado=0"
			 //println "La consulta para los items es... "+queryItems
			 def itemsOppty=ElementoPorOportunidad.executeQuery(queryItems)[0]
			 //println "Items Oppty es... "+itemsOppty
			 if(itemsOppty==0)//SI LA OPORTUNIDAD COTIZADA NO TIENE ITEMS
			 {
					 def optty=Oportunidad.findByNumOportunidad(oportunidad.numOportunidad).properties
					 //def item=Pedido.findByNumPedido(numpe).properties
					 //println "Oppty agregada .... "+optty
					 listaAExportar.add(optty)
			 }

		 }
		 
		 return listaAExportar
	 }
	 
	 def notificarArquitectos(List listaArquitectos, String numPedido)// PARA NOTIFICAR A LOS ARQUITECTOS QUE FIGURAN COMO RESPONSABLE DE UN PEDIDO
	 {
         listaArquitectos.each {
             println "ITERACION MM "+it
             String arquitecto=it
             Pedido pedido=Pedido.findByNumPedido(numPedido)
             String nombreCliente=pedido.nombreCliente
             String proyecto=pedido.oportunidad.nombreOportunidad
             def valorPedido
             String moneda
             String urlbase=getValorParametro('urlaplic')

             if(pedido.idTipoPrecio.equals("pedtprec01")&& pedido.valorPedido!=null)
             {
                 valorPedido=pedido.valorPedido
                 moneda="COP"
             }
             else
             {
                 if(pedido.idTipoPrecio.equals("pedtprec02")&& pedido.valorPedido!=null)
                 {
                     if(pedido.trm!=0)
                     {
                         valorPedido=pedido.valorPedido/pedido.trm
                         moneda="USD"
                     }
                     else
                         valorPedido=pedido.valorPedido
                 }
             }
             println "Envio de correo arquitecto"
             def query=ValorParametro.where{idValorParametro==arquitecto}
             def correo=[query.find().descValParametro?:'auditorcorreocrm@redsis.com']
             println "Correo del arquitecto seleccionado: ${correo}"
             //todo verificar la consulta de los parametros de comparacion
//             def query2 = ValorParametro.where{idParametro=="lstArqAles"}
//             println "${query2}"
//             if (query2[0] != null) { // Se valida que exista concordancia en la otra lista y se agrega el correo al que se le va a copiar el correo
//                 def arqAle = [query2.find().valor?:arquitecto]
//                 println "Consulta de Arquitecto en valor parametro: ${arqAle}"
//                 println "El Arquitecto es: ${arquitecto}"
//                 if (arquitecto == arqAle[0]) {
//                     println("Si concuerdan los arquitectos, agrego a Alessio para copia adimare@redsis.com")
//                     //def email= [query2.find().descValParametro?:'auditorcorreocrm@redsis.com']
//                     String c = query2.find().descValParametro ?: 'auditorcorreocrm@redsis.com'
//                     println "Consulta de Correo Valor: ${c}"
//                     correo.add(c)
//                 }
//             }/*
             if (arquitecto == "pedarqui14" || arquitecto == "pedarqui25" || arquitecto == "pedarqui10" || arquitecto == "pedarqui28"
                     || arquitecto == "pedarqui16" || arquitecto == "pedarqui94" || arquitecto == "pedarqui07" || arquitecto == "pedarqui09"
                     || arquitecto == "pedarqui95" || arquitecto == "pedarqui93" || arquitecto == "pedarqui08" || arquitecto == "pedarqui20"){
                 //Empanada para notificar al señor Alessio de los proyectos que tengan sus coequiperos. (José Castro)
                 correo.add("adimare@redsis.com")
                 correo.add("practpreventa@redsis.com")
             }
                //Empanada para notificar a Jazmin de los proyectos que tenga ingenieria, junto con el señor Marlon. (José Castro)
             if (arquitecto == "pedarqui22") correo.add("jrebolledo@redsis.com")


             String asunto="Usted ha sido agregado como arquitecto de soluciones al pedido numero ${numPedido} - ${nombreCliente}"
             String masInfo="Para visualizar el pedido o realizar seguimientos al mismo haga clic <a href='${urlbase}/pedido/show/${pedido.id}'> AQUI </a>"

             String cuerpo="<b>Cliente: </b>${nombreCliente}<br><b>Proyecto: </b>${proyecto}<br><b>Valor: </b>${valorPedido} ${moneda}<br><br>${masInfo}"

             println "El correo Arquitecto es "+ correo
             enviarCorreo(1,correo,asunto,cuerpo)
         }
         println "LISTA DE ARQUITECTOS: "+listaArquitectos
         println "NUM PEDIDO RECIBIDO: "+numPedido
	 }

     def notificarGEyC(String numPedido)//TODO Envair correo notificación a ajhabib para pedidos de EyC, capturar el usuario desde lista parametros correos varios
     {
         println "Notificación gerente EyC "
         Pedido pedido=Pedido.findByNumPedido(numPedido)
         String nombreCliente=pedido.nombreCliente
         String proyecto=pedido.oportunidad.nombreOportunidad
         String urlbase=getValorParametro('urlaplic')
         def valorPedido=pedido.valorPedido
         def cMateriales=pedido.costoMateriales
         def pMateriales=pedido.precioVentaMaterales
         def cManoObra=pedido.costoManoObra
         def pManoObra=pedido.preicoVentaManoObra
         def query=ValorParametro.where{idValorParametro=="geyc"}
         def correo=[query.find().valor?:'jdcastro@redsis.com']
         println "Correo del gerente EyC es: ${correo}"

         String asunto="Nuevo pedido de EyC ${numPedido} - ${nombreCliente}"
         String masInfo="Para visualizar el pedido o realizar seguimientos al mismo haga clic <a href='${urlbase}/pedido/show/${pedido.id}'> AQUI </a>"

         String cuerpo="<b>Cliente: </b>${nombreCliente}<br><b>Proyecto: </b>${proyecto}" +
                       "<br><b>Valor: </b>${valorPedido}" +
                       "<br><b>Costo materiales: </b>${cMateriales}" +
                       "<br><b>Costo mano obra: </b>${cManoObra}" +
                       "<br><b>Precio venta materiales: </b>${pMateriales}" +
                       "<br><b>Precio venta mano obra: </b>${pManoObra}" +
                       "<br><br>${masInfo}"
         enviarCorreo(1,correo,asunto,cuerpo)

     }

    def notificarServicioRedsis(String numPedido){
        println "Notificación Servicios redsis "
        Pedido pedido=Pedido.findByNumPedido(numPedido)
        String nombreCliente=pedido.nombreCliente
        String urlbase=getValorParametro('urlaplic')
        def valorPedido=pedido.valorPedido
        def query=ValorParametro.where{idValorParametro=="servRedsis"}
        def correo=[query.find().valor?:'jdcastro@redsis.com']
        println "Correo para notificar servicios redsis es: ${correo}"

        String asunto="Nuevo pedido con servicios redsis ${numPedido} - ${nombreCliente}"
        String masInfo="Para visualizar el pedido o realizar seguimientos al mismo haga clic <a href='${urlbase}/pedido/show/${pedido.id}'> AQUI </a>"

        String cuerpo="<b>Cliente: </b>${nombreCliente}<br>" +
                "<br><b>Valor: </b>${valorPedido}" +
                "<br><br>${masInfo}"

        enviarCorreo(1,correo,asunto,cuerpo)

    }
    def notificarServicioRedsisUpdate(String numPedido){
        println "Notificación Servicios redsis Update"
        Pedido pedido=Pedido.findByNumPedido(numPedido)
        String nombreCliente=pedido.nombreCliente
        String proyecto=pedido.oportunidad.nombreOportunidad
        String urlbase=getValorParametro('urlaplic')
        def valorPedido=pedido.valorPedido
        def query=ValorParametro.where{idValorParametro=="servRedsis"}
        def correo=[query.find().valor?:'jdcastro@redsis.com']
        println "Correo para notificar servicios redsis es: ${correo}"

        String asunto="Pedido modificado: ${numPedido} - ${nombreCliente}"
        String masInfo="Para visualizar el pedido o realizar seguimientos al mismo haga clic <a href='${urlbase}/pedido/show/${pedido.id}'> AQUI </a>"

        String cuerpo="<b>Cliente: </b>${nombreCliente}<br><b>Proyecto: </b>${proyecto}" +
                "<br><b>Valor: </b>${valorPedido}" +
                "<br><br>${masInfo}"
        enviarCorreo(1,correo,asunto,cuerpo)

    }

	 
	 def crearVencimientoDetPedido()//CREAR VENCIMIENTO A PARTIR DE DET PEDIDO
	 {
		 Vencimiento venci=new Vencimiento()
		 venci.idTipoVencimiento='venarrter'
		 venci.eliminado=0
		 venci.notificar=1
		 venci.fechaInicio= new Date()
		 venci.fechaVencimiento=new Date()
		 venci.idEstadoVencimiento='venvencido'
		 venci.refTipModNumContract='123423123'
		 venci.serialManual='N'
		 venci.pedido=Pedido.get(333)
		 venci.empleado=Empleado.get(23)
		 venci.encvencimiento=EncVencimiento.get(22)//--obligatorio
		 venci.detpedidop=DetPedido.get(8)
		 println "MI DUMP ES ..."+venci.dump()
		 venci.validate()
		 venci.save(flush:true)
		 
		 println "VENCIMIENTO CREADO EXITOSAMENTE... "
		 
	 }
	 
	 def crearOActualizarContrato(def request,def servletContext,Map params, DetPedido detPedidoInstance, String accion){
		 //accion indica 0=Creacion,1=Actualizacion
		 if(accion.equals("1"))
	     {
			if(params.tieneContrato=='S' && params.idContrato)
			{
				println "Entre a ACTUALIZAR EL CONTRATO......."
				Contrato c=Contrato.get(params.long('idContrato'))
				c.idTipoVencimiento=params.idTipoVencimiento //OBLIGATORIO
				c.serial=params.serial
				c.descripcion=params.descripcion
				c.idTipoCobertura=params.idTipoCobertura
				c.plataforma=params.plataforma
				c.fechaInicio=stringToDate(params.fechaInicio)//OBLIGATORIO
				c.fechaVencimiento=stringToDate(params.fechaVencimiento)//OBLIGATORIO
				c.observaciones=params.observaciones
				
				def respuestaEstado=getEstadoVencimiento(c.fechaInicio, c.fechaVencimiento)
				c.idEstadoVencimiento=respuestaEstado[0]//OBLIGATORIO
				
				c.idTipoContrato=params.idTipoContrato
				c.idTipoConvenio=params.idTipoConvenio
				c.refTipModNumContract=params.refTipModNumContract
				c.serialManual=params.serialManual

				c.eliminado=0
				
				c.save()
				
				
				if (params.hayAnexo=='S'){
					println "ENTRE AQUI Y NO EDITE ARCHIVO "+params
					def rutayFile=subirAnexoContratos(request,servletContext,c.id)
					actualizarSeriales(c.id)
					importarSerialesExcel(c.id,rutayFile)
				}
				
			}
		 }
		 else
	     {
		 
		 
				 if(params.esContrato)
					 detPedidoInstance.tieneContrato=params.esContrato
				 
				 if (params.idPedido)
					 detPedidoInstance.pedido=Pedido.get(params.long('idPedido'))		 
				 
				 if (params.idProveedor)
					 detPedidoInstance.empresa=Empresa.get(params.long('idProveedor'))
				 
				 
				 if(params.idProcesarPara=='pedprosp03')//Si el campo procesarPara = Interno Redsis
					 detPedidoInstance.idEstadoDetPedido='peddetpd07'
				 
				 
				 detPedidoInstance.cantidad=params.long('cantidad')
				 detPedidoInstance.valor=params.double('valor')
				 
				 detPedidoInstance.validate()
				
				 if (detPedidoInstance.hasErrors()) {
					 respond detPedidoInstance.errors, view: 'create'
					 return
				 }
				 
			
				 //detPedidoInstance.save()
				 
				 
				 if(params.esContrato=='S')
                 {
					 detPedidoInstance.tieneContrato=params.esContrato
					 Contrato c=new Contrato()
					 detPedidoInstance.contrato=c //OBLIGATORIO
					 c.idTipoVencimiento=params.idTipoVencimiento //OBLIGATORIO
					 
					 c.idTipoConvenio=params.idTipoConvenio
					 
					 if(params.plataforma)		
						 c.plataforma=params.plataforma			 
						 
					 if(params.idTipoContrato)
						 c.idTipoContrato=params.idTipoContrato			 
						 
					 if(params.refTipModNumContract)
						 c.refTipModNumContract=params.refTipModNumContract//OBLIGATORIO
					 
						 
					 if(params.serialManual){
						 println "Entr� ac� hubo serial manual.."
						 c.serialManual=params.serialManual//OBLIGATORIO
						 c.serial=params.serial
					 }
					 else
					 {
						 println "No hubo serial manual."
						 c.serialManual='N'
					 }
						 
					 if(params.descripcion)
						 c.descripcion=params.descripcion			 
						 
					 if(params.idTipoCobertura)
						 c.idTipoCobertura=params.idTipoCobertura
					 
					 if(params.fechaInicio)
						 c.fechaInicio=stringToDate(params.fechaInicio)//OBLIGATORIO
					 
					 if(params.fechaVencimiento)
						 c.fechaVencimiento=stringToDate(params.fechaVencimiento)//OBLIGATORIO
					 
					 if(params.observaciones)			
						c.observaciones=params.observaciones
					 
						 
					 def respuestaEstado=getEstadoVencimiento(c.fechaInicio, c.fechaVencimiento)
					 detPedidoInstance.contrato.idEstadoVencimiento=respuestaEstado[0]//OBLIGATORIO
					 detPedidoInstance.save flush: true

                     c.eliminado=0
				     //println "MI DUMP ES ... "+c.dump()
					 c.validate()
					 c.save flush:true,failOnError:true



                     //-----------------ACÁ TENEMOS QUE ENVIAR EL CORREO DE QUE SE CREÓ EL VENCIMIENTO
                     def idVendedor=c.detpedido.pedido.empleado.id
                     def session = request.session
                     def usuarioAccede = Empleado.findById(getIdEmpleado(session['idUsuario'].toLong())).id
                     def tipoVen=getValorParametro(params.idTipoVencimiento)
                     String fechaFin=params.fechaVencimiento
                     String fechaIni=params.fechaInicio
                     String urlbase=getValorParametro('urlaplic')
                     def usuarioL=Empleado.findById(usuarioAccede)
                     def numPedido=detPedidoInstance?.pedido?.numPedido


                     String empresaVenc=Empresa.get(params.empresaPedido).razonSocial
                     String asunto="NUEVO REGISTRO DE VENCIMIENTO - ${empresaVenc} - ${numPedido}"
                     String cuerpo="Registro elaborado por: ${usuarioL}<br><br>Se ha registrado un nuevo vencimiento de tipo <b>${tipoVen}</b> para la empresa ${empresaVenc} y usted figura como responsable del mismo.<br><br><b>Fecha de inicio:</b> ${fechaIni}<br><b>Fecha de vencimiento:</b> ${fechaFin}<br><br><b>Referencia del producto: </b>${params.refProducto}<br><b>Descripci&oacute;n: </b>${params.descProducto}<br>Para m&aacute;s detalles haga clic <a href='${urlbase}/pedido/show/${params.idPedido}?&layout=main'> AQUI </a>"

                     notificarVencimiento(params.idTipoVencimiento, idVendedor,asunto,cuerpo)
                     println "Params vencimiento creado... "+params

                     //-----------------ACÁ TENEMOS QUE ENVIAR EL CORREO DE QUE SE CREÓ EL VENCIMIENTO
				 }
				 else
					 detPedidoInstance.save flush: true
				 
				 
					 //-------------TIENE QUE GUARDARSE PRIMERO EL DETPEDIDO, LUEGO EL CONTRATO PARA SUBIR EL ARCHIVO
					 if(params.archivoSeriales && params.esContrato=='S')//SI EL CAMPO SERIAL ESTA VACÍO..ES DECIR SI SE ESCOGE LEER EL ARCHIVO
					 {
						 def rutayFile=subirAnexoContratos(request,servletContext,detPedidoInstance.contrato.id)
						 importarSerialesExcel(detPedidoInstance.contrato.id,rutayFile)
					 }
		 }//Cierre ELSE accion.equals(1)
     }
    def serviceLisCli(){//para montar webservice para listado de empresas
        //def cli = new SOAPClient('https://192.168.30.149/crm/empresa/serviceLisCli')
        def cli = new SOAPClient('http://localhost:8080/crm/empresa/serviceLisCli')
        cli.authorization = new HTTPBasicAuthorization('jdmaury','opqa94')
        cli.httpClient.sslTrustAllCerts = true
        def resp = cli.send(Empresa.servicelis)
        println(resp)

    }


}//Cierre GeneralService Class


