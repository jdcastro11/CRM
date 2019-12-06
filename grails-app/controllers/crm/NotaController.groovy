package crm
import static org.springframework.http.HttpStatus.*

import grails.converters.JSON
import grails.transaction.Transactional
import net.sf.json.JSONArray
import net.sf.json.JSONObject

@Transactional(readOnly = true)
class NotaController extends BaseController{

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def generalService
    def pedidoService

  
   
    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max = Math.min(max?: itemxview, 100)
        String  xoffset=params.offset?:0
        def query="from Nota  where idEntidad=${params.id} and nombreEntidad='${params.entidad}' and eliminado=0  order by id desc"
        def notaInstanceList=Nota.findAll(query,[max:params.max,offset:xoffset.toLong()])
        def queryc="select count(a) from Nota a where a.idEntidad=${params.id} and a.nombreEntidad='${params.entidad}' and a.eliminado=0"
        def num=Nota.executeQuery(queryc)
       
        String xsololec='S'; String xtit=''
        
        if (params.zw){ xsololec='N'} else xtit=generalService?.getValorParametro('notat00')
            
       if(params.entidad =="oportunidad" || params.entidad=="prospecto" || params.entidad=="prospectoAdj"){
           if (params.entidad=="prospecto"){
               xtit=""
           }
        render view:'index',  model:[notaInstanceList:notaInstanceList,
                                     notaInstanceCount:num[0],
                                     xtitulo:xtit,
                                     xidentidad:params.id,xentidad:params.entidad,xtiponota:params.tnota,xsololec:xsololec]
        }else if(params.entidad =="pedido"){
           
          render view:'indexNotifica',  model:[notaInstanceList:notaInstanceList,
                                     notaInstanceCount:num[0],
                                     xtitulo:xtit,
                                     xidentidad:params.id,xentidad:params.entidad,xtiponota:params.tnota,xsololec:xsololec]
        }
    }

    def listarBorrados(Integer max) {

        int itemxview=generalService.getItemsxView(0)
        params.max = Math.min(max ?: itemxview, 100)
        String  xoffset=params.offset?:0

        def query="from Nota  where idEntidad=${params.id} and nombreEntidad='${params.entidad}' and eliminado=1 "
       
        def queryc="select count(n) from Nota n where idEntidad=${params.id} and nombreEntidad='${params.entidad}' and eliminado=1 "
        def notaInstanceList=Nota.findAll(query,[max:params.max,offset:xoffset.toLong()])
        def num=Nota.executeQuery(queryc)
        
        render view: "index" , model:[notaInstanceList:notaInstanceList,
                notaInstanceCount: num[0], xidentidad:params.id,xentidad:params.entidad,
                itemxview:itemxview,xtitulo:message(code:'bitacora.borradas.label'),xsololec:'N']
    }
    
    @Transactional  //borrar
    def borrar(Nota notaInstance) {

        if (params.id == null) {
            notFound()
            return
        }

        notaInstance= Nota.get(params.id)

        notaInstance.eliminado=1

        notaInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Nota.label', default: 'Nota'), notaInstance.id])
                //redirect url:"/nota/index/"+notaInstance.idEntidad+"?entidad="+notaInstance.nombreEntidad
               // redirect url:"/crm/nota/index/${notaInstance?.id}?entidad=oportunidad&zw=1"
                redirect url:"/nota/index/"+notaInstance.idEntidad+"?entidad="+notaInstance.nombreEntidad+"&zw=1"  
            }
            '*'{ respond lineaInstance, [status: OK] }
        }
    }

    def show(Nota notaInstance) {
        respond notaInstance
    }

    def create() {
        String destinatarios =""
        def tipoFuncionarios		
        if(params.entidad == "pedido"){
       
        def documentoPadreInstance=Pedido.get(params.ident) 
        
        if(documentoPadreInstance.idEstadoPedido =="pedenelab1" ||
           documentoPadreInstance.idEstadoPedido =="pedanuladx") {
           tipoFuncionarios = 1  //  si es solo el vendedor  
        }else if(documentoPadreInstance.idEstadoPedido =="pedenrevi2"){
           tipoFuncionarios = 2  // 2 si son el vendedor y los funcionarios de financiera
        }else if(documentoPadreInstance.idEstadoPedido =="pedpencom3"){
           tipoFuncionarios = 3  // 3 si son el vendedor, financiera y compradores
        }else if(documentoPadreInstance.idEstadoPedido =="pedpenfp23" || 
                 documentoPadreInstance.idEstadoPedido =="pedpenfac2" || 
                 documentoPadreInstance.idEstadoPedido =="pedfacpar2" || 
                 documentoPadreInstance.idEstadoPedido =="pedfacturx" ){
                 tipoFuncionarios = 4  // 1 si son todos vendedor, financiera, compradores y bodega
        }
        
        
        def xiddestinatarios = pedidoService.sacarNotificadosPorDefectoPedidos(params, tipoFuncionarios)
        xiddestinatarios.each{ nombreDestinatario ->
            destinatarios+= "${nombreDestinatario}"+","
            //println destinatarios
        }
        params.funcionariosNotificados =  destinatarios
        }
        respond new Nota(params)
    }

    @Transactional //save
    def save(Nota notaInstance) {
        
      
       if (notaInstance == null) {
            notFound()
            return
        }     
        
        //println notaInstance.properties
        if (notaInstance.hasErrors()) {
            respond notaInstance.errors, view: 'create'
            return
        }
		
		println "Nota creada... "+params

		
		def listaDestino=[]
		String xparam=generalService.getValorParametro('notiBitacora')
		listaDestino=generalService.convertirEnLista(xparam)
		String asunto=""
		String urlRoot=generalService.getValorParametro('urlaplic')
		String enlace=""
		String cuerpo=""
		String comentarios=params.nota
        String nombreVendedor=""
		
		def razonSocial
		def numEntidad
		def usuarioLogueado=Empleado.get(params.idAutor)
		def proyecto
		def detallesProyecto
				
		
	
		
		
        
    
        notaInstance.save flush: true
		//------------------------------------MODIFICACION PARA NOTIFICAR BITACORA-----------------------------------------
		
		if(params.nombreEntidad=='prospectoAdj')
		{
			def prospectoInstance=Prospecto.get(params.idEntidad)
			razonSocial=prospectoInstance?.nombreCliente
			numEntidad=prospectoInstance?.numProspecto			
			proyecto=prospectoInstance?.nombreProspecto
			detallesProyecto=prospectoInstance?.descProspecto?:'No tiene'
			
			
			asunto="Nueva bitacora registrada para el prospecto ${numEntidad} ${razonSocial}"
			enlace="<br><br>Consulte los detalles del prospecto <a href='${urlRoot}/prospecto/show/${prospectoInstance.id}'> AQUI </a>"
			cuerpo="Registro creado por: ${usuarioLogueado}<br><br><b>Detalles de la bit&aacute;cora:</b><br><br><b>Cliente: </b>${razonSocial}<br><b>Numero Prospecto: </b>${numEntidad}<br><b>Proyecto: </b>${proyecto}<br><b>Detalles Proyecto: </b>${detallesProyecto}<br><b>Comentarios: </b>${comentarios}"+enlace
			
			generalService.enviarCorreo(1,listaDestino,asunto, cuerpo)
			
			log.info("${asunto}")
		
		}
		//------------------------------------MODIFICACION PARA NOTIFICAR BITACORA-----------------------------------------
		
         if(params.nombreEntidad=='oportunidad' && params.idTipoNota=='notagesven'){
           def oportunidadInstance=Oportunidad.get(params.idEntidad)
           oportunidadInstance.idUltimaNota=notaInstance.id
           oportunidadInstance.save()
		   
		   numEntidad=oportunidadInstance?.numOportunidad
		   razonSocial=oportunidadInstance?.nombreCliente
		   proyecto=oportunidadInstance?.nombreOportunidad
		   detallesProyecto=oportunidadInstance?.descOportunidad?:'No tiene'
           nombreVendedor=oportunidadInstance?.nombreVendedor?:''
		   
		   asunto="Nueva bitacora registrada para la oportunidad ${numEntidad} ${razonSocial}"
		   enlace="<br><br>Consulte los detalles de la oportunidad <a href='${urlRoot}/oportunidad/show/${oportunidadInstance.id}'> AQUI </a>"
		   cuerpo="Registro creado por: ${usuarioLogueado}<br><br><b>Detalles de la bit&aacute;cora:</b><br><br><b>Ejecutivo de cuenta: </b>${nombreVendedor}<br><b>Cliente: </b>${razonSocial}<br><b>Numero Oportunidad: </b>${numEntidad}<br><b>Proyecto: </b>${proyecto}<br><b>Detalles Proyecto: </b>${detallesProyecto}<br><b>Comentarios: </b>${comentarios}"+enlace
		   
		   generalService.enviarCorreo(1,listaDestino,asunto, cuerpo)
		   log.info("${asunto}")
		   
          } 
            
        if(params.nombreEntidad=='pedido'){
			def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
			def pedidoAsociado=Pedido.get(params.idEntidad)
			println "Pedido asociado e............"+pedidoAsociado
			println params
			println "usuarioAccedees"+usuarioAccede
			String usuariosNoti=params.funcionariosNotificados1.toString().replaceAll("\\s","")
			
			//---------------MODIFICACION REQUERIDA POR SRA MONICA Y EDWIN FLOREZ 07/JUNIO/2017
			println "Usuarios ingresados en la nota........"+usuariosNoti
			//usuariosNoti=usuariosNoti+",atecnico@redsis.com"
			notaInstance.funcionariosNotificados =usuariosNoti
			
			//---------------MODIFICACION REQUERIDA POR SRA MONICA Y EDWIN FLOREZ 07/JUNIO/2017
            notaInstance.save flush: true
            List xdest
            xdest = usuariosNoti.split(",")  
			println "Lista de correos de notificados luego de split..."+xdest
			log.info("\r\n----------------------------------------------------------\n\r")
			log.info("Documento de seguimiento creado por.... ${usuarioAccede}")
			log.info("Mensaje seguimiento: ${params.nota}")
			log.info("Usuarios ingresados en la nota antes de split...... ${usuariosNoti}")
			log.info("Lista notificados despues de split......... ${xdest}")
			log.info("\r\n----------------------------------------------------------\n\r")
			
			
			if(pedidoAsociado.toString().contains('BOG') && usuarioAccede.toString()!='Ibana Fabregas')//Para que los seguimientos de Ibana realizados a bogot� 
				//no le notifiquen a ella...
			{
				println "Este pedido contiene BOG"
				//xdest.add("ifabregas@redsis.com")
				xdest.add("Ifabregas@redsis.com")
				log.info("Ifabregas@redsis.com agregado al pedido ${pedidoAsociado}")
				
			}				
          
			def pedidoInstance=Pedido.get(params.idEntidad.toLong())    
            String xasunto="Seguimiento al pedido: " + pedidoInstance.numPedido +" - "+pedidoInstance?.empresa?.razonSocial
          		
		    String urlbase=generalService.getValorParametro('urlaplic')
            
            String xcuerpo="Nuevo documento de seguimiento creado por: "+ usuarioAccede +"<br><br><b>Observaciones de seguimiento</b>:\n"+params.nota   + "<br><br>Para ir al pedido y verificar la informaci&oacute;n, haga click  <a href='${urlbase}/pedido/show/${params.idEntidad}'> AQUI </a>"
			
			generalService.enviarCorreo(1,xdest,xasunto, xcuerpo)    
        } 
          
          flash.message = "Nota creada exitosamente"
          redirect url:"/nota/index/"+notaInstance.idEntidad+"?entidad="+notaInstance.nombreEntidad+"&zw=1"      
        
    }

    def edit(Nota notaInstance) {
        respond notaInstance,model:[xtiponota:params.tnota]
    }

    @Transactional //update
    def update(Nota notaInstance) {

        notaInstance=Nota.get(params.id)
        
        if (notaInstance == null) {
            notFound()
            return
        }
        
        notaInstance.validate()
        
        if (notaInstance.hasErrors()) {
            respond notaInstance.errors, view: 'edit'
            return
        }

        notaInstance.save flush: true
         flash.message = "Nota actualizada  exitosamente"
        redirect url:"/nota/index/"+notaInstance.idEntidad+"?entidad="+notaInstance.nombreEntidad+"&zw=1"
    }

    @Transactional //delete
    def delete(Nota notaInstance) {

        if (notaInstance == null) {
            notFound()
            return
        }

        notaInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Nota.label', default: 'Nota'), notaInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.warning = message(code: 'default.not.found.message', args: [message(code: 'notaInstance.label', default: 'Nota'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
    
    def anexarArchivo(){

        render view: "/general/importarArchivo", model:[zregreso:'/regresar1.html']
    }
    
    def mostrarNota(){        
        if(params.id){                  
           
            def oportunidadInstance=Oportunidad.get(params.id)
            render view:"mostrarNota", model:[oportunidadInstance:oportunidadInstance]        
        }else{
            redirect url:"/oportunidad/indexg"            
        }         
    }
	
	
	
	def empleadosNoti()
	{
	   JSONArray listaEmpleados= new JSONArray()
	   
	   
	   def query="Select e From Empleado e where e.eliminado=0 order By e.primerNombre"
	   def result=Empleado.executeQuery(query)
	   
	   result.each{
		   JSONObject empleado=new JSONObject()
		   empleado.put("value",it.email)
		   empleado.put("label", it.nombreCompleto())
		   listaEmpleados.push(empleado)
		   
	   }
	   
	   
	   render listaEmpleados as JSON
	}
}
