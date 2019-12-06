package crm


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import wslite.soap.*
import grails.converters.*
import grails.converters.JSON
import grails.converters.XML
import java.nio.file.Files;
import java.nio.file.Path
import java.nio.file.Paths
import org.codehaus.groovy.grails.web.json.JSONObject
import static groovyx.net.http.Method.*



import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.ContentType.*
import static groovyx.net.http.Method.*
import groovyx.net.http.ContentType

@Transactional(readOnly = true)
class ReqLotusSwController {
	def generalService
	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE" ]

	/**
	def anexos(){
		render view: "anexoReq"
	}
	**/
   
	@Transactional
	def salvarAnexo(ReqLotusSw reqLotusSwInstance){
		def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
		//log.info InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + "  - Entrando preparandose para verificar los adjuntos al reqeurimiento"
		//validamos que los nombres esten ok
		String urlbase=generalService?.getValorParametro('urlReq')
		String urlCompleta = urlbase+'CrearReqLS'
		
		if (params.nombreArchivo !=""){
			def file = request.getFile('file')
			def resp=generalService.validarNombreArchivo(file.originalFilename)
			if  (resp){
				
			}else{
				// devolvemos a la ventana para que cambie el nombre
				flash.message = "El adjunto 1 no cumple estandar. por favor verifique"
				
				params.fechaAperturaReq = null
				params.fechaCierreEstimadaReq = null
				
				params.xronly = true
				params.numOportunidad = params.numOptty
				params.file = file.originalFilename
				params.xtitulo = generalService?.getValorParametro('opttyReq02')
				render view: "create",  model:[reqLotusSwInstance:params,numOportunidad:params.numOptty]
				//redirect  url:"/reqLotusSw/create/?numOportunidad="+params.numOptty
				
				return
			}
			
		}
		if (params.nombreArchivo1 !=""){
			def file1 = request.getFile('file1')
			def resp1=generalService.validarNombreArchivo(file1.originalFilename)
			if  (resp1){
				
			}else{
				// devolvemos a la ventana para que cambie el nombre del archivo dos
				flash.message = "El adjunto 2 no cumple estandar. por favor verifique"
				
				params.fechaAperturaReq = null
				params.fechaCierreEstimadaReq = null
				
				params.xronly = true
				params.numOportunidad = params.numOptty
				params.file1 = file1.originalFilename
				params.xtitulo = generalService?.getValorParametro('opttyReq02')
				render view: "create",  model:[reqLotusSwInstance:params,numOportunidad:params.numOptty]
				return
			}
			
		}
		//println "Parametros:" + params
		//Buscamos el usuario para pasarlo al lotus como usuario creador
		def nombreClienteOptty
		def nombreContactoOptty
		def idOptty
		String vienePedido
		String nombreUsuario = generalService.getNombreEmpleado(session['idUsuario'].toLong())
		if(params.tipoRequerimiento =="Servicio"){
			nombreClienteOptty = Pedido.findByNumPedido(params.numOptty).nombreCliente
			nombreContactoOptty = Pedido.findByNumPedido(params.numOptty).nombreContacto
			idOptty = Pedido.findByNumPedido(params.numOptty).id.toString()
			vienePedido ="Si"
		}else{
			nombreClienteOptty = Oportunidad.findByNumOportunidad(params.numOptty).nombreCliente
			nombreContactoOptty = Oportunidad.findByNumOportunidad(params.numOptty).nombreContacto
			idOptty = Oportunidad.findByNumOportunidad(params.numOptty).id.toString()
			 vienePedido ="No"
		}
		
		// creando el req en el aplicativo
		def rta
		Requerimiento reqCreacion = new Requerimiento()
		//quitamos los caracteres especiales de los campos a enviar al requerimiento
		def tema = generalService.quitarCaracteresEspeciales(params.tema)
		nombreClienteOptty =generalService.quitarCaracteresEspeciales(nombreClienteOptty)
		nombreContactoOptty=generalService.quitarCaracteresEspeciales(nombreContactoOptty)
		def descripcionReq =generalService.quitarCaracteresEspeciales(params.descripcionReq)
		
		try {
			rta = reqCreacion.crear(params.numOptty,
				params.tipoRequerimiento,
				nombreClienteOptty,
				nombreContactoOptty,
				tema,
				nombreUsuario,
				params.fechaCierreEstimadaReq.replace("-", "/"),
				descripcionReq,
				idOptty, urlCompleta)
		} catch (Exception e) {
			println 'Excepcion: ' + e.message
			log.error InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + "  - Error al crear el requerimiento al usar el servicio reqCreacion "
			
			 log.error InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + "Tipo Requerimiento "+  params.tipoRequerimiento
			 log.error InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + "Cliente "+  nombreClienteOptty
			 log.error InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + "Contacto "+  nombreContactoOptty
			 log.error InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + "Tema o proyecto "+  params.tema
			 log.error InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + "Fecha de cierre " +  params.fechaCierreEstimadaReq.replace("-", "/")
			 log.error InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + "Descripción "+  params.descripcionReq
			 log.error InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + "Oportunidad "+  idOptty
			 log.error InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + "URL "+  urlCompleta
		}
		
		//println "LA RESPUESTA DE LA CREACION: " +rta
		//reqLotusSwInstance.save flush:true
		// sacamos la informacion del listado de requerimientos
		def  numOptty = params.numOptty
		def respuestaSWcreacion
		Requerimiento req1 = new Requerimiento()
		try {
			urlCompleta = urlbase+'mostrarInfoRequerimiento'
			if( vienePedido =="No"){
			  respuestaSWcreacion = req1.leer(numOptty, '2', urlCompleta)
			}else{
			  respuestaSWcreacion = req1.leer(numOptty, '3', urlCompleta)
			}
			
		} catch (Exception e) {
			println 'Excepcion: ' + e.message
		}
			 
		def  datoJSON = JSON.parse(respuestaSWcreacion)  // Parse a JSON String
		
		//log.info  "el id: "+datoJSON.respuesta.id
		
		def  rtaJSON = JSON.parse(rta)
		//log.info  "La respuesta JSON "+ "="+rtaJSON.respuesta+ "="
	   
		//log.info InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + " La respuesta JSON es " + rtaJSON.respuesta
		def datoReq = rtaJSON.respuesta
		if(rta){
			def xtitulo = generalService?.getValorParametro('opttyReq01')
			flash.message = ("Documento creado satisfactoriamente en Requerimientos")
			//def numOportunidad  = params.numOptty
			//render(view:"index",  model:[numOportunidad: numOportunidad, xtitulo: xtitulo])
			def listaDocumentos
			if(datoJSON.idTransaccion=="1"){  // la transaccion trajo documentos
				listaDocumentos =datoJSON.respuesta
			}else{
				flash.message = (datoJSON.respuesta)
				listaDocumentos = ""
			}
			render(view:"index",  model:[requerimientoList : listaDocumentos, numOportunidad:numOptty, pedido:vienePedido])
		}else{
			log.error InetAddress.getLocalHost().getHostAddress()+" - NO FUE POSIBLE CREAR EL REQUERIMIENTO PARA LA OPORTUNIDAD " + params.numOptty
			println "No se pudo crear el requerimiento para la oportunidad" + params.numOptty
			def xtitulo = generalService?.getValorParametro('opttyReq01')
			flash.message = ("Error, no fue posible la creación del Requerimiento")
			def numOportunidad  = params.numOptty
			render(view:"index",  model:[numOportunidad: numOportunidad, xtitulo: xtitulo, pedido:vienePedido])
		}
		//=====================================================================================
		
		// procedemos a crear el anexo en el docuemnto
		 //log.info InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + " Procedemos a anexar los adjuntos al documento "
	  
		if (params.nombreArchivo !=""){
			if (params.hayAnexo=='S'){
				def file = request.getFile('file')
				def resp=generalService.validarNombreArchivo(file.originalFilename)
				def nombreOriginal
				//println "Nombre valido" +file.originalFilename
				println resp
				if  (resp){
					String urlCompletaAdjunto = urlbase+'AdjuntarArchivosReq'
					Random rand = new Random()
					String zruta =generalService.getValorParametro('ruta02')
					def xruta = servletContext.getRealPath(zruta)
					println "Hay?" + params.hayAnexo
					if (params.hayAnexo=='S'){
						try {
							//log.info InetAddress.getLocalHost().getHostAddress()+ " Nombre original del anexo" + file.originalFilename
							nombreOriginal =file.originalFilename
							
							String xnombre=rand.nextInt(1000).toString()+"_"+params.nombreArchivo
							//log.info InetAddress.getLocalHost().getHostAddress()+ " Nombre generado por el sistema" + xnombre
						 
							def  rutayFile=new File( xruta,xnombre)
							//println rutayFile
							 //log.info InetAddress.getLocalHost().getHostAddress()+ " Ruta del archivo en el sistema " + rutayFile
					
							if (!rutayFile.exists()){
								file.transferTo( rutayFile)
							}
							// Luego de colocarlo en la ruta procedemos a enviarlo a lotus
							def respuestaSW
							AnexoSW req = new AnexoSW()
							try {
								
								// buscamos la ruta en los parametros
								String tipoLibro = 'informacion usada por el WS'
								String titulo = 'informacion usada por el WS'
								String id = "SR-0000"  // "Información no requerida pra crear el anexo"
								
								// informacion requerida por el ws para crear el anexo
								String descripcion  = nombreOriginal
								String autor = datoReq
								String archivo = xruta+"/"+xnombre
								
								//log.info InetAddress.getLocalHost().getHostAddress()+ " Información antes de procesar el anexo, El numero de requerimiento y la ruta del adjunto" + autor + " -- "  +  archivo
					
								AnexoSW anexo = new AnexoSW()
								
								respuestaSW =  anexo.crear(tipoLibro, titulo, descripcion, autor, archivo, id, urlCompletaAdjunto)
							  
								//log.info InetAddress.getLocalHost().getHostAddress()+ " Adjunto 1 procesado en el requerimiento "
					
							} catch (Exception e) {
								log.error InetAddress.getLocalHost().getHostAddress()+ " Error al adjuntar el archivo al requerimiento satisfactoriamente " +e.message
								println 'Excepcion: ' + e.message
							}
							//println "Respuesta texto: " + respuestaSW
							if (params.nombreArchivo1 !=""){
								if (params.hayAnexo1=='S'){
								  
									log.info InetAddress.getLocalHost().getHostAddress()+ " Accediendo a la creacion del segundo adjunto"
									def file1 = request.getFile('file1')
									def resp1=generalService.validarNombreArchivo(file1.originalFilename)
									def nombreOriginal2
									//println "Nombre valido 2" +file1.originalFilename
									println resp1
									if  (resp1){
										Random rand1 = new Random()
										println "Hay?" + params.hayAnexo1
										if (params.hayAnexo1=='S'){
											try {
												nombreOriginal2 =file1.originalFilename
												//println "El nombre dle archivo"+params.nombreArchivo1
												//log.info InetAddress.getLocalHost().getHostAddress()+ " nombre del segundo archivo " + nombreOriginal2
												String xnombre1=rand.nextInt(1000).toString()+"_"+params.nombreArchivo1
												def  rutayFile1=new File( xruta,xnombre1)
												println rutayFile1
												if (!rutayFile1.exists()){
													file1.transferTo( rutayFile1)
												}
												// Luego de colocarlo en la ruta procedemos a enviarlo a lotus
												def respuestaSW1
												//AnexoSW req1 = new AnexoSW()
												try {
													
													// buscamos la ruta en los parametros
													String tipoLibro = 'informacion 2'
													String titulo = 'informacion 2'
													String id = "SR-0000" // 'info no valida'
													 
													// informacion necesaria para unicar el requerimiento y adjuntar el archivo
													String descripcion  = nombreOriginal
													String autor = datoReq
													String archivo = xruta+"/"+xnombre1
													
													//log.info InetAddress.getLocalHost().getHostAddress()+ " Antes de procesar el 2 adjunto información de # req y adjunto " + datoReq + " -- Aarchivo "+ archivo
													AnexoSW anexo1 = new AnexoSW()
													respuestaSW1 =  anexo1.crear(tipoLibro, titulo, descripcion, autor, archivo, id, urlCompletaAdjunto)
												} catch (Exception e) {
													log.error InetAddress.getLocalHost().getHostAddress()+ " Error al adjuntar el archivo 2 al requerimiento " +e.message
													println 'Excepcion: ' + e.message
												}
												// println "Respuesta texto: " + respuestaSW1
											  log.info InetAddress.getLocalHost().getHostAddress()+ " Adjunto 2 cargado satisfactoriamente, respuesta del domino" +  respuestaSW1
													
											} catch(ex){
												
												println ex
												
											}
										}
										
									} else{
										println "Nombre de Archivo Invalido. Solamente Letras,digitos,puntos,-,_"
										flash.message = "Nombre de Archivo Invalido. Solamente Letras,digitos,puntos,-,_"
									}
									
									
								}
							   
							}
							
							// fin segunda carga archivo si la hay
						} catch(ex){
							
							println ex
							
						}
					}
					
				} else{
					println "Nombre de Archivo Invalido. Solamente Letras,digitos,puntos,-,_"
					flash.message = "Nombre de Archivo Invalido. Solamente Letras,digitos,puntos,-,_"
				}
				
				
			}
		}
		
	}
	
	def index(Integer max) {
		
		
		params.max = Math.min(max ?: 10, 100)
		def xtitulo = generalService?.getValorParametro('opttyReq01')
		def numOportunidad
		def respuestaSW
		Requerimiento req = new Requerimiento()
		numOportunidad = params.numOptty
		def  numOptty = params.numOptty
		
		def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
		//log.info InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + "  - Accediendo al index del requerimiento"
		
		String urlbase=generalService?.getValorParametro('urlReq')
		String urlCompleta = urlbase+'mostrarInfoRequerimiento'
		//println "URL COMPLETA"+urlCompleta
		
		//println params
		
		if (params.pedido =='Si'){
			try {
				respuestaSW = req.leer(numOptty, '3', urlCompleta)
				
			} catch (Exception e) {
			   //log.error InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + "  - Errar al mostrar el requerimiento para la oportunidad -- "+ numOptty +"- URL - " + urlCompleta + " - Opción 3- "
			   render(view:"general/error",  model:[error:error])
				return
				// println 'Excepcion: ' + e.message
			}
		}else{
			try {
				respuestaSW = req.leer(numOptty, '2' , urlCompleta)
				
			} catch (Exception e) {
				//log.error InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + "  - Errar al mostrar el requerimiento para la oportunidad -- "+ numOptty +"- URL - " + urlCompleta + " - Opción 3- "
				def msgError = "Falla inesperada del aplicativo al visualizar el listado de requerimiento."
				render(view:"//general/error",  model:[error:msgError])
				return
				// println 'Excepcion: ' + e.message
			}
			
		}
	   
		//println "Respuesta texto: " + respuestaSW
		def  datoJSON = JSON.parse(respuestaSW)  // Parse a JSON String
		//println "datos: "+datoJSON.respuesta
		//println "datos: "+datoJSON.idTransaccion
		def listaDocumentos
		if(datoJSON.idTransaccion=="1"){  // la transaccion trajo documentos
			listaDocumentos =datoJSON.respuesta
		}else{
			listaDocumentos = ""
		}
		flash.message = null
		
		
		//--------------------------ESTA PARTE ES PARA TRAER LOS REQUERIMIENTOS DE LA NUEVA HERRAMIENTA DE REQUERIMIENTOS------------------- 
		
		def listaReq=generalService.infoSRR(numOptty)
		
		
		//println "El resultado es "+listaReq
		//--------------------------ESTA PARTE ES PARA TRAER LOS REQUERIMIENTOS DE LA NUEVA HERRAMIENTA DE REQUERIMIENTOS-------------------
		
		//println "LA LISTA DE DOCUMENTOS ES ..."+listaDocumentos
		
		if (params.pedido=='Si'){
		render(view:"index",  model:[requerimientoList : listaDocumentos , numOportunidad:numOportunidad,pedido:"Si", requerimientosListSrr:listaReq])
		}else{
		 render(view:"index",  model:[requerimientoList : listaDocumentos , numOportunidad:numOportunidad,pedido:"No"])
		}
	}
	
	/*def index2()
	{
		String numOptyPed=params.numOptty
		def listaReq=generalService.infoSRR(numOptyPed)
				
		//render "..."+listaReq
		render(view:"index",  model:[requerimientoList : listaReq , numOportunidad:numOptyPed,pedido:"Si"])
		
	}*/

	/**
	def show(ReqLotusSw reqLotusSwInstance) {
		respond reqLotusSwInstance
	}
	**/
	def create() {
		//println "HOLA ENTRE AC�d"
		//println params
		params.xronly = true
		//println "la variable pedido"+params.pedido
		 def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
		 //log.info InetAddress.getLocalHost().getHostAddress()+" - "+usuarioAccede + "  - Entrando preparandose para verificar los adjuntos al reqeurimiento"
	
		if(params.pedido == "S"){
		 params.vienedepedido = "Si"
		 params.xtitulo='Crear Requerimiento a partir del pedido'
		 
		}else{
		 params.vienedepedido = "No"
		 params.xtitulo='Crear Requerimiento a partir de la Oportunidad'
		 
		 
		}
	   
		//println "ahora si la variable"+params.vienedepedido
		params.numOportunidad = params.numOportunidad		
		respond new ReqLotusSw(params)
	}

	/**
	@Transactional
	def save(ReqLotusSw reqLotusSwInstance) {
	   
		//println "Parametros:" + params
		//Buscamos el usuario para pasarlo al lotus como usuario creador
		String nombreUsuario = generalService.getNombreEmpleado(session['idUsuario'].toLong())
		if(params.tipoRequerimiento !="Servicio"){
		def nombreClienteOptty = Oportunidad.findByNumOportunidad(params.numOptty).nombreCliente
		}else{
		   def nombreClienteOptty = Pedido.findByNnumPedido(params.numOptty).nombreCliente
		}
		def nombreContactoOptty = Oportunidad.findByNumOportunidad(params.numOptty).nombreContacto
		def idOptty = Oportunidad.findByNumOportunidad(params.numOptty).id.toString()
		//println "EL ID DEL USUARIO: " +idOptty
		
		// creando el req en el aplicativo
		def rta
		def respuestaSW
			
		if (params.hayAnexo=='S'){
			try {
				def file = request.getFile('file')
				String zruta =generalService.getValorParametro('ruta02')
				def xruta = servletContext.getRealPath(zruta)
				String xnombre=rand.nextInt(1000000).toString()+".xls"
				def  rutayFile=new File( xruta,xnombre)
				println rutayFile
				if (!rutayFile.exists()){
					file.transferTo( rutayFile)
				}
			}catch (Exception e) {
				println 'Excepcion: ' + e.message
			}
				
		}
			
		return
		Requerimiento req = new Requerimiento()
		try {
			rta = req.crear(params.numOptty,
				params.tipoRequerimiento,
				nombreClienteOptty,
				nombreContactoOptty,
				params.tema,
				nombreUsuario,
				params.fechaCierreEstimadaReq.replace("-", "/"),
				params.descripcionReq,
				idOptty)
		} catch (Exception e) {
			println 'Excepcion: ' + e.message
		}
				
		//println "LA RESPUESTA DE LA CREACION: " +rta
		//reqLotusSwInstance.save flush:true
		// sacamos la informacion del listado de requerimientos
		def  numOptty = params.numOptty
		def respuestaSW1
		Requerimiento req1 = new Requerimiento()
		try {
			respuestaSW1 = req1.leer(numOptty, '2')
	
		} catch (Exception e) {
			println 'Excepcion: ' + e.message
		}
		//println "Respuesta texto: " + respuestaSW1
		def  datoJSON = JSON.parse(respuestaSW1)  // Parse a JSON String
		//println "datos: "+datoJSON.respuesta

	   
	   
		
		if(rta){
			def xtitulo = generalService?.getValorParametro('opttyReq01')
			flash.message = ("Documento creado satisfactoriamente en Requerimientos")
			//def numOportunidad  = params.numOptty
			//render(view:"index",  model:[numOportunidad: numOportunidad, xtitulo: xtitulo])
			def listaDocumentos
			if(datoJSON.idTransaccion=="1"){  // la transaccion trajo documentos
				listaDocumentos =datoJSON.respuesta
			}else{
				flash.message = (datoJSON.respuesta)
				listaDocumentos = ""
			}
			render(view:"index",  model:[requerimientoList : listaDocumentos, numOportunidad:numOptty])
		}else{
			println "No se pudo crear el requerimiento para la oportunidad" + params.numOptty
			def xtitulo = generalService?.getValorParametro('opttyReq01')
			flash.message = ("Error, no fue posible la creación del Requerimiento")
			def numOportunidad  = params.numOptty
			render(view:"index",  model:[numOportunidad: numOportunidad, xtitulo: xtitulo])
		}
	}
   **/
	
	/**
	def edit(ReqLotusSw reqLotusSwInstance) {
		respond reqLotusSwInstance
	}
	**/
	

	@Transactional
	def update(ReqLotusSw reqLotusSwInstance) {
		if (reqLotusSwInstance == null) {
			notFound()
			return
		}

		if (reqLotusSwInstance.hasErrors()) {
			respond reqLotusSwInstance.errors, view:'edit'
			return
		}

		reqLotusSwInstance.save flush:true

		request.withFormat {
			form {
				flash.message = message(code: 'default.updated.message', args: [message(code: 'ReqLotusSw.label', default: 'ReqLotusSw'), reqLotusSwInstance.id])
				redirect reqLotusSwInstance
			}
			'*'{ respond reqLotusSwInstance, [status: OK] }
		}
	}

	@Transactional
	def delete(ReqLotusSw reqLotusSwInstance) {

		if (reqLotusSwInstance == null) {
			notFound()
			return
		}

		reqLotusSwInstance.delete flush:true

		request.withFormat {
			form {
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'ReqLotusSw.label', default: 'ReqLotusSw'), reqLotusSwInstance.id])
				redirect action:"index", method:"GET"
			}
			'*'{ render status: NO_CONTENT }
		}
	}

	protected void notFound() {
		request.withFormat {
			form {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'reqLotusSwInstance.label', default: 'ReqLotusSw'), params.id])
				redirect action: "index", method: "GET"
			}
			'*'{ render status: NOT_FOUND }
		}
	}
	
	
	def leerLibro(Integer max) {
		
		def respuestaSW
		Anexo req = new Anexo()
		try {
			String notesId = '9EA'
			AnexoSW anexo = new AnexoSW()
			respuestaSW =  anexo.leerLibro(notesId)
		} catch (Exception e) {
			println 'Excepcion: ' + e.message
		}
		println "Respuesta texto: " + respuestaSW
		
	}
	
	def crearLibro(Integer max) {
		
		def respuestaSW
		AnexoSW req = new AnexoSW()
		try {
			
			// buscamos la ruta en los parametros
			String zruta =generalService.getValorParametro('ruta02')
			def xruta = servletContext.getRealPath(zruta)
				   
			String tipoLibro = 'Fiction'
			String titulo = 'PRUEBAS REALIZADAS MARIO QUINTERO DIC 5 VER 2'
			String descripcion  = 'archivo word'
			String autor = 'SR-6058'
					
			String archivo = xruta+'/pruebasSabado05.docx'
			println("El archivo"+archivo)
			String id = "SR-1002"
			AnexoSW anexo = new AnexoSW()
			respuestaSW =  anexo.crear(tipoLibro, titulo, descripcion, autor, archivo, id)
		} catch (Exception e) {
			println 'Excepcion: ' + e.message
		}
		println "Respuesta texto: " + respuestaSW
		
	}
	
	
	
	def sendJson=
	{
		try{
		println "MY PARAMS "+params
		String descripcionTema=params.tema
		String descripcionReq=params.descripcionReq
		String fechaCierreEstimadaReq=generalService.formatDateSRR(params.fechaCierreEstimadaReq)
		String numOptty=''
		String numPedido=''
		
		
		//empanada para decir si el campo NumOportunidad es Oportunidad o Pedido
		if(params.vienedepedido=='Si')
			numPedido=params.numOptty
		else
			numOptty=params.numOptty
		
		//----------------------------------------------------------------------
		
		
		String idClienteOptty=''
		String nombreClienteOptty=''
		String idUsrEjecutivo=''
		String nombreUsrEjecutivo=''
		
		String numSrrDevuelto=""//Aqui guardaremos el numero que devuelve la herramienta de SRR
		
		
		String estFacturado=''
		String nombreContactoOptty=''
		String nombreContactoIT=''
		String vlrPedido=''
		String usrSolicitante=''
		String nombreUsrSolicitante=''
		String idLiderEncargado=''
		String nombreLiderEncargado=''
		String categoria=''
		String idDivision=''
		String division=''
		String tipoRequerimiento=''
		
		String cedulaSolicitante=''
		
		if(params.tipoRequerimiento=='Servicio')//Si es un pedido
		{
			idClienteOptty=Pedido.findByNumPedido(params.numOptty).empresa.nit.toString()//AJUSTAR AC� PARA LOS NIT MAYORES A 9
			idClienteOptty=generalService.formatearNitPedido(idClienteOptty)
			/*AJUSTE
			if(idClienteOptty.length()>9)
				idClienteOptty=idClienteOptty.substring(0,9)
			AJUSTADO*/
			nombreClienteOptty=Pedido.findByNumPedido(params.numOptty).empresa.razonSocial
			log.info("Nombre Cliente Optty es "+nombreClienteOptty)
						
			idUsrEjecutivo=Pedido.findByNumPedido(params.numOptty).empleado?.identificacion.toString()
			nombreUsrEjecutivo=Pedido.findByNumPedido(params.numOptty).empleado.nombreCompleto()?:"No hay ejecutivo"
			
			Pedido ped=Pedido.findByNumPedido(params.numOptty)
			
			println "idClienteOptty es "+idClienteOptty
			println "nombreClienteOptty "+nombreClienteOptty
			println "idUsrEjecutivo "+idUsrEjecutivo
			println "nombreUsrEjecutivo "+nombreUsrEjecutivo
			
			
			if(ped.idEstadoPedido=='pedfacturx')
				estFacturado="Si"
				else
					estFacturado="No"
					
			
			nombreContactoOptty=ped.persona.nombreCompleto()
			vlrPedido=ped.valorPedido.toString()
			usrSolicitante=Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong())).id
			nombreUsrSolicitante=Empleado.findById(usrSolicitante).nombreCompleto()
			
			cedulaSolicitante=Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong())).identificacion.toString()
		
			
			categoria='Servicio'
			idDivision='1'//ingenier�a
			division='Ingenierias'
			tipoRequerimiento='Servicio'
		}
		
		String numReq=''
		
		//println "La fecha llega de la forma "+fechaCierreEstimadaReq
		
		//def http = new HTTPBuilder('http://192.168.30.136:8080/WSservices/')
		def http = new HTTPBuilder('http://srr.redsis.com:8080/WSservices/')
		//def http = new HTTPBuilder('http://192.168.36.112:8080/WSservices/')
		
		http.request(POST) {
			uri.path = 'webresources/crearRequerimiento'
			// Note: Set ConentType before body or risk null pointer.
			requestContentType = ContentType.JSON
			body = [ "DescripcionTema":descripcionTema,
			 "DescripcionReq":descripcionReq,
			 "fechaCierreEstimadaReq":fechaCierreEstimadaReq,
			 "numOptty":numPedido,
			 "numPedido": "",
			 "idClienteOptty":idClienteOptty, //NIT PROMIGAS S.A E.S.P
			 "nombreClienteOptty":nombreClienteOptty,
			 "idUsrEjecutivo":idUsrEjecutivo, //Cedula Carmen Palacios
			 "nombreUsrEjecutivo":nombreUsrEjecutivo,
			 "estFacturado":estFacturado,
			 "nombreContactoOptty":"",
			 "nombreContactoIT":"", //ESTE CAMPO SE ENV�A VAC�O
			 "vlrPedido":vlrPedido, //VALORES COP O USD??
			 "usrSolicitante":cedulaSolicitante, //OBSERVACION
			 "nombreUsrSolicitante":nombreUsrSolicitante,
			 "idLiderEncargado":"1", //OBSERVACION
			 "nombreLiderEncargado":"",
			 "Categoria":categoria,
			 "idDivision":idDivision, //1 porque 1 es ingenieria
			 "Division":division,
			 "tipoRequerimiento":tipoRequerimiento]
			
			/*println "PARAMETROS A CONTINUACION\n\n"

			println "DescripcionTema "+descripcionTema
				println "DescripcionReq "+descripcionReq
				println "fechaCierreEstimadaReq "+fechaCierreEstimadaReq
				println "numOptty "+numPedido
				println "numPedido "+""
				println "idClienteOptty "+idClienteOptty //NIT PROMIGAS S.A E.S.P
				println "nombreClienteOptty "+nombreClienteOptty
				println "idUsrEjecutivo "+idUsrEjecutivo //Cedula Carmen Palacios
				println "nombreUsrEjecutivo "+nombreUsrEjecutivo
				println "estFacturado "+estFacturado
				println "nombreContactoOptty "+""
				println "nombreContactoIT "+"" //ESTE CAMPO SE ENV�A VAC�O
				println "vlrPedido "+vlrPedido //VALORES COP O USD??
				println "usrSolicitante "+cedulaSolicitante //OBSERVACION
				println "nombreUsrSolicitante "+nombreUsrSolicitante
				println "idLiderEncargado 1" //OBSERVACION
				println "nombreLiderEncargado "
				println "Categoria "+categoria
				println "idDivision "+idDivision //1 porque 1 es ingenieria
				println "Division "+division
				println "tipoRequerimiento "+tipoRequerimiento*/
			
				
				log.info("\r\n------------------CAMPOS DE REQUERIMIENTOS ENVIADOS---------------------------\r\n")
				log.info("DescripcionTema: "+descripcionTema)
				log.info("DescripcionReq: "+descripcionReq)
				log.info("fechaCierreEstimadaReq: "+fechaCierreEstimadaReq)
				log.info("numOptty: "+numPedido)
				log.info("numPedido: "+"AUN NO HAY")
				log.info("idClienteOptty: "+idClienteOptty)
				log.info("nombreClienteOptty: "+nombreClienteOptty)
				log.info("idUsrEjecutivo: "+idUsrEjecutivo)
				log.info("nombreUsrEjecutivo: "+nombreUsrEjecutivo)
				log.info("estFacturado: "+estFacturado)
				log.info("nombreContactoOptty: "+"AUN NO HAY")
				log.info("nombreContactoIT: "+"AUN NO HAY")
				log.info("vlrPedido: "+vlrPedido)
				log.info("usrSolicitante: "+cedulaSolicitante)
				log.info("nombreUsrSolicitante: "+nombreUsrSolicitante)
				log.info("idLiderEncargado: "+"AUN NO HAY")
				log.info("nombreLiderEncargado: "+"AUN NO HAY")
				log.info("Categoria: "+categoria)
				log.info("idDivision: "+idDivision)
				log.info("Division: "+division)
				log.info("tipoRequerimiento: "+tipoRequerimiento)
				
				
			
			//println "PARAMETROS FINALIZACION \n\n"
			
			
			/*body = ["DescripcionTema":descripcionTema,
				"DescripcionReq":descripcionReq,
				"fechaCierreEstimadaReq":fechaCierreEstimadaReq,
				"numOptty":numPedido,
				"numPedido": "",
				"idClienteOptty":idClienteOptty,
				"nombreClienteOptty":nombreClienteOptty,
				"idUsrEjecutivo":idUsrEjecutivo,
				"nombreUsrEjecutivo":nombreUsrEjecutivo,
				"estFacturado":estFacturado,
				"nombreContactoOptty":nombreContactoOptty,
				"nombreContactoIT":nombreContactoIT,
				"vlrPedido":vlrPedido,
				"usrSolicitante":usrSolicitante,
				"nombreUsrSolicitante":nombreUsrSolicitante,
				"idLiderEncargado":idLiderEncargado,
				"nombreLiderEncargado":nombreLiderEncargado,
				"Categoria":categoria,
				"idDivision":idDivision,
				"Division":division,
				"tipoRequerimiento":tipoRequerimiento]*/
			
			
		
			response.success = { resp,json ->
				println "Exitoooooooo! ${resp.status}"
				log.info("Respuesta del WS : "+json)
				
				//println json
				numReq=json.NoRequerimiento.toString()
				
				//println "El numero de requerimiento es "+numReq
				/*render "El numero de requerimiento es \n"+numReq+"\n"
				render "....   El nit del cliente es es \n"+idClienteOptty
				render "....   El nombre del cliente es \n"+nombreClienteOptty
				render "....   El nombre del ejecutivo es \n"+nombreUsrEjecutivo
				render "....   La cedula del id user ejecutivo es \n"+idUsrEjecutivo
				render "....   El usuario solicitante es \n"+nombreUsrSolicitante
				render "....   La cedula del user solicitante es \n"+cedulaSolicitante*/
				
				//render body as JSON
				
				
				def listaDocumentos=generalService.traerRequerimientosSrrLotus(numPedido)				
				def listaReqSrr=generalService.infoSRR(numPedido)
				
				//generalService.enviarCorreo(1,["jmaury@redsis.com"],"SRR ${numReq} creado","Srr creado exitosamente")
				generalService.notificarRequerimientoCreado(numReq)
				
				
				render(view:"index",  model:[requerimientoList : listaDocumentos, numOportunidad:numPedido,requerimientosListSrr:listaReqSrr, pedido:'Si'])
				flash.message="Requerimiento ${numReq} creado exitosamente"
				//render(view:"index",  model:[requerimientoList : listaDocumentos, numOportunidad:numOptty, pedido:vienePedido]) --ESTA ES LA LINEA QUE NECESITO
				
			}
		
			response.failure = { resp ->
				println "Request failed with status ${resp.status}"
			}
		}
		}catch(Exception ex)
		{
			log.error("Ha ocurrido un error", ex)	
		}
		
		
	}
	   
	
}

