package crm

import static org.springframework.http.HttpStatus.*

import java.text.DateFormat;
import java.text.SimpleDateFormat
import java.util.Date;

import javax.swing.text.View

import org.apache.poi.xssf.usermodel.XSSFCell
import org.apache.poi.xssf.usermodel.XSSFSheet
import org.apache.poi.xssf.usermodel.XSSFWorkbook

import grails.transaction.Transactional
import groovy.xml.streamingmarkupsupport.BaseMarkupBuilder.Document

@Transactional(readOnly = true)
class VencimientoController extends BaseController{

	static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
	def generalService
	def exportService
	def filterPaneService
	def consecutivoService
	
	def index() {
		
	generalService.contarclientes()	
		
	   
	}

	
	@Transactional
	def pestanasVencimientos(Integer max)
	{
		//generalService.actualizarEstadoVencimientos()
		//generalService.notificarVencimientos2()

		String xoffset=paginacion(params.clicHardw)
		
		
		/*def lista=EncVencimiento.executeQuery("""select v.encvencimiento.empresa.razonSocial,v.empleado.id,v.descripcion,v.fechaVencimiento,
                                                 DATEDIFF(v.fechaVencimiento,current_date) 
                                                 from Vencimiento v where                                                   
                                                  v.eliminado=0 and (DATEDIFF(v.fechaVencimiento,current_date)=60 or  DATEDIFF(v.fechaVencimiento,current_date)=-30)
                                              """)*/
		
		println "Entre a notificar vencimientos 2"
		
		//generalService.actualizarEstadoVencimientos()
	 	int itemxview=generalService.getItemsxView(0)
		params.max=10
		String idenc=params.idenc?:params.xid//11
		def encVencimientoInstance=EncVencimiento?.get(params.long('idenc'))
		String xidemp=encVencimientoInstance?.empresa?.id
		def query="from Vencimiento v where v.encvencimiento.id='${idenc}' and v.eliminado=0 and v.idTipoVencimiento='venhardw' and (v.idEstadoVencimiento!='venvencido' and v.idEstadoVencimiento!='vennorenov') order by v.fechaVencimiento asc"
		def queryc="select count(v) from Vencimiento v where v.encvencimiento.id='${idenc}' and v.idTipoVencimiento='venhardw' and v.eliminado=0 and v.idEstadoVencimiento!='venvencido' and v.idEstadoVencimiento!='vennorenov'"
		def vencimientoInstanceList=Vencimiento.findAll(query,[max:params.max,offset:xoffset.toLong()])
		def num=Vencimiento.executeQuery(queryc)
		render(view:"venhardw",model:[vencimientoInstanceList:vencimientoInstanceList,vencimientoInstanceCount:num[0],
			xtitulo:generalService.getValorParametro('vencimit00'),sw:1,
			xidemp:xidemp,xidencven:idenc])
	}
	
	def softhw(Integer max)
	{
		String xoffset=paginacion(params.clicSofthw)
		
		int itemxview=generalService.getItemsxView(0)
		params.max=10
		

		String idenc=params.idenc?:params.xid//11
		def encVencimientoInstance=EncVencimiento?.get(params.long('idenc'))
		String xidemp=encVencimientoInstance?.empresa?.id
		def query="from Vencimiento v where v.encvencimiento.id='${idenc}' and v.eliminado=0 and v.idTipoVencimiento='softhw' and (v.idEstadoVencimiento!='venvencido' and v.idEstadoVencimiento!='vennorenov') order by v.fechaVencimiento asc"
		def queryc="select count(v) from Vencimiento v where v.encvencimiento.id='${idenc}' and v.idTipoVencimiento='softhw' and v.eliminado=0"
		def vencimientoInstanceList=Vencimiento.findAll(query,[max:params.max,offset:xoffset.toLong()])
		def num=Vencimiento.executeQuery(queryc)
		render(view:"softhw",model:[vencimientoInstanceList:vencimientoInstanceList,vencimientoInstanceCount:num[0],
			xtitulo:generalService.getValorParametro('vencimit00'),sw:1,
			xidemp:xidemp,xidencven:idenc])
	}
	
	def softapl(Integer max)
	{
		
		String xoffset=paginacion(params.clicSoftApl)
		
		int itemxview=generalService.getItemsxView(0)
		params.max=10
		

		String idenc=params.idenc?:params.xid//11
		def encVencimientoInstance=EncVencimiento?.get(params.long('idenc'))
		String xidemp=encVencimientoInstance?.empresa?.id
		def query="from Vencimiento v where v.encvencimiento.id='${idenc}' and v.eliminado=0 and v.idTipoVencimiento='vensoftapl' and (v.idEstadoVencimiento!='venvencido' and v.idEstadoVencimiento!='vennorenov') order by v.fechaVencimiento asc"
		def queryc="select count(v) from Vencimiento v where v.encvencimiento.id='${idenc}' and v.idTipoVencimiento='vensoftapl' and v.eliminado=0"
		def vencimientoInstanceList=Vencimiento.findAll(query,[max:params.max,offset:xoffset.toLong()])
		def num=Vencimiento.executeQuery(queryc)
		render(view:"vensoftapl",model:[vencimientoInstanceList:vencimientoInstanceList,vencimientoInstanceCount:num[0],
			xtitulo:generalService.getValorParametro('vencimit00'),sw:1,
			xidemp:xidemp,xidencven:idenc])
	}
	
	
	def consop(Integer max)
	{
		
		String xoffset=paginacion(params.clicConSop)
		
		int itemxview=generalService.getItemsxView(0)
		params.max=10
		

		String idenc=params.idenc?:params.xid//11
		def encVencimientoInstance=EncVencimiento?.get(params.long('idenc'))
		String xidemp=encVencimientoInstance?.empresa?.id
		def query="from Vencimiento v where v.encvencimiento.id='${idenc}' and v.eliminado=0 and v.idTipoVencimiento='venconsop' and (v.idEstadoVencimiento!='venvencido' and v.idEstadoVencimiento!='vennorenov') order by v.fechaVencimiento asc"
		def queryc="select count(v) from Vencimiento v where v.encvencimiento.id='${idenc}' and v.idTipoVencimiento='venconsop' and v.eliminado=0"
		def vencimientoInstanceList=Vencimiento.findAll(query,[max:params.max,offset:xoffset.toLong()])
		def num=Vencimiento.executeQuery(queryc)
		render(view:"venconsop",model:[vencimientoInstanceList:vencimientoInstanceList,vencimientoInstanceCount:num[0],
			xtitulo:generalService.getValorParametro('vencimit00'),sw:1,
			xidemp:xidemp,xidencven:idenc])
	}
	
	def adminRedsis(Integer max)
	{
		
		String xoffset=paginacion(params.clicVenAdmin)
		
		int itemxview=generalService.getItemsxView(0)
		params.max=10
		

		String idenc=params.idenc?:params.xid//11
		def encVencimientoInstance=EncVencimiento?.get(params.long('idenc'))
		String xidemp=encVencimientoInstance?.empresa?.id
		def query="from Vencimiento v where v.encvencimiento.id='${idenc}' and v.eliminado=0 and v.idTipoVencimiento='venadmin' and (v.idEstadoVencimiento!='venvencido' and v.idEstadoVencimiento!='vennorenov') order by v.fechaVencimiento asc"
		def queryc="select count(v) from Vencimiento v where v.encvencimiento.id='${idenc}' and v.idTipoVencimiento='venadmin' and v.eliminado=0"
		def vencimientoInstanceList=Vencimiento.findAll(query,[max:params.max,offset:xoffset.toLong()])
		def num=Vencimiento.executeQuery(queryc)
		render(view:"venadmin",model:[vencimientoInstanceList:vencimientoInstanceList,vencimientoInstanceCount:num[0],
			xtitulo:generalService.getValorParametro('vencimit00'),sw:1,
			xidemp:xidemp,xidencven:idenc])
	}
	
	def adminTerceros(Integer max)
	{
		
		String xoffset=paginacion(params.clicVenAdmTer)
		int itemxview=generalService.getItemsxView(0)
		params.max=10

		String idenc=params.idenc?:params.xid//11
		def encVencimientoInstance=EncVencimiento?.get(params.long('idenc'))
		String xidemp=encVencimientoInstance?.empresa?.id
		def query="from Vencimiento v where v.encvencimiento.id='${idenc}' and v.eliminado=0 and v.idTipoVencimiento='venadmter' and (v.idEstadoVencimiento!='venvencido' and v.idEstadoVencimiento!='vennorenov') order by v.fechaVencimiento asc"
		def queryc="select count(v) from Vencimiento v where v.encvencimiento.id='${idenc}' and v.idTipoVencimiento='venadmter' and v.eliminado=0"
		def vencimientoInstanceList=Vencimiento.findAll(query,[max:params.max,offset:xoffset.toLong()])
		def num=Vencimiento.executeQuery(queryc)
		render(view:"venadmter",model:[vencimientoInstanceList:vencimientoInstanceList,vencimientoInstanceCount:num[0],
			xtitulo:generalService.getValorParametro('vencimit00'),sw:1,
			xidemp:xidemp,xidencven:idenc])
	}
	
	def arrRedsis(Integer max)
	{
		
		String xoffset=paginacion(params.clicVenArrend)
		int itemxview=generalService.getItemsxView(0)
		params.max=10

		String idenc=params.idenc?:params.xid//11
		def encVencimientoInstance=EncVencimiento?.get(params.long('idenc'))
		String xidemp=encVencimientoInstance?.empresa?.id
		def query="from Vencimiento v where v.encvencimiento.id='${idenc}' and v.eliminado=0 and v.idTipoVencimiento='venarrend' and (v.idEstadoVencimiento!='venvencido' and v.idEstadoVencimiento!='vennorenov') order by v.fechaVencimiento asc"
		def queryc="select count(v) from Vencimiento v where v.encvencimiento.id='${idenc}' and v.idTipoVencimiento='venarrend' and v.eliminado=0"
		def vencimientoInstanceList=Vencimiento.findAll(query,[max:params.max,offset:xoffset.toLong()])
		def num=Vencimiento.executeQuery(queryc)
		render(view:"venarrend",model:[vencimientoInstanceList:vencimientoInstanceList,vencimientoInstanceCount:num[0],
			xtitulo:generalService.getValorParametro('vencimit00'),sw:1,
			xidemp:xidemp,xidencven:idenc])
	}
	
	def arrTerceros(Integer max)
	{
		
		String xoffset=paginacion(params.clicVenArrTer)
		int itemxview=generalService.getItemsxView(0)
		params.max=10

		String idenc=params.idenc?:params.xid//11
		def encVencimientoInstance=EncVencimiento?.get(params.long('idenc'))
		String xidemp=encVencimientoInstance?.empresa?.id
		def query="from Vencimiento v where v.encvencimiento.id='${idenc}' and v.eliminado=0 and v.idTipoVencimiento='venarrter' and (v.idEstadoVencimiento!='venvencido' and v.idEstadoVencimiento!='vennorenov') order by v.fechaVencimiento asc"
		def queryc="select count(v) from Vencimiento v where v.encvencimiento.id='${idenc}' and v.idTipoVencimiento='venarrter' and v.eliminado=0"
		def vencimientoInstanceList=Vencimiento.findAll(query,[max:params.max,offset:xoffset.toLong()])
		def num=Vencimiento.executeQuery(queryc)
		render(view:"venarrter",model:[vencimientoInstanceList:vencimientoInstanceList,vencimientoInstanceCount:num[0],
			xtitulo:generalService.getValorParametro('vencimit00'),sw:1,
			xidemp:xidemp,xidencven:idenc])
	}
	
	def vencidos()
	{
		
		String xoffset=paginacion(params.clicVencidos)
		int itemxview=generalService.getItemsxView(0)
		params.max=10

		String idenc=params.idenc?:params.xid//11
		def encVencimientoInstance=EncVencimiento?.get(params.long('idenc'))
		String xidemp=encVencimientoInstance?.empresa?.id
		def query="from Vencimiento v where v.encvencimiento.id='${idenc}' and v.eliminado=0 and (v.idEstadoVencimiento='venvencido' or v.idEstadoVencimiento='vennorenov') order by v.fechaVencimiento asc"
		def queryc="select count(v) from Vencimiento v where v.encvencimiento.id='${idenc}' and v.eliminado=0 and (v.idEstadoVencimiento='venvencido' or v.idEstadoVencimiento='vennorenov')"
		def vencimientoInstanceList=Vencimiento.findAll(query,[max:params.max,offset:xoffset.toLong()])
		def num=Vencimiento.executeQuery(queryc)
		render(view:"venvencidos",model:[vencimientoInstanceList:vencimientoInstanceList,vencimientoInstanceCount:num[0],
			xtitulo:generalService.getValorParametro('vencimit00'),sw:1,
			xidemp:xidemp,xidencven:idenc])		

	}
	
	
	def getMarcas()
	{
		println "LA PLA TAFORMA ES  "+params.plataforma
		
		def query="Select v from Vencimiento v where v.id='${params.id}' and v.eliminado=0"
		//def marcaList=Vencimiento.executeQuery(query)
		
		def marcaList=generalService.getValoresParametro(params.plataforma)
		println "marcaList "+marcaList
		render template:'/vencimiento/marcas', model: [marcaList:marcaList]
	}

		
	
	
	def indexg(Integer max) {
		int itemxview=generalService.getItemsxView(0)
		params.max =itemxview
		String  xoffset=params.offset?:0
	  
		if(!params.filter) params.filter = [op:[:],empleado:[:]]
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado = '0'
		if(params.filter.idTipoVencimiento != null){
		  params.filter.idTipoVencimiento=generalService.getIdValorParametro('tipovencim',params.filter.idTipoVencimiento)
		}
		if(params.filter.idEstadoVencimiento != null){
		  params.filter.idEstadoVencimiento=generalService.getIdValorParametro('estadovenc',params.filter.idEstadoVencimiento)
		  
		}
		 if(params.filter.idTipoCobertura != null){
		  params.filter.idTipoCobertura=generalService.getIdValorParametro('tipocobert',params.filter.idTipoCobertura)
		  
		}
		def encVencimientoInstance=EncVencimiento?.get(params.idenc)
		String xidemp=encVencimientoInstance?.empresa?.id
		
		//def query="from Vencimiento v where v.eliminado=0"
	   // def vencimientoInstanceList=Vencimiento.findAll(query,[max:params.max,offset:xoffset.toLong()])
		def vencimientoInstanceList=filterPaneService.filter( params, Vencimiento )
  
		respond  vencimientoInstanceList, model:[vencimientoInstanceCount:filterPaneService.count(params,Vencimiento),
				 filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),params:params,
				 xtitulo:generalService.getValorParametro('vencimit00'),sw:1,xidemp:xidemp,xidencven:params.idenc]
	   
	}
	def listarBorrados(Integer max) {
		generalService.notificarVencimientos2()
		int itemxview=generalService.getItemsxView(0)
		params.max = Math.min(max ?: itemxview, 100)
		String  xoffset=params.offset?:0
		println "hola mundo"

	   
		def query="from Vencimiento as v where v.encvencimiento.id=${params.idenc} and v.eliminado=1"
		def vencimientoInstanceList=Vencimiento.findAll(query,[max:params.max,offset:xoffset.toLong()])
		
		render view: "listarBorrados", model:[vencimientoInstanceList:vencimientoInstanceList,
			vencimientoInstanceCount:Vencimiento.countByEliminado(1),
			itemxview:itemxview,
			xtitulo:generalService.getValorParametro('vencimit05'),sw:0,xidencven:params.idenc]
	}
	
	def listarSeriales(Integer max){
		
		//generalService.notificarVencimientos2()
		
		def vencimientoInstanceList
		
		println "VENCIMIENTO PARAMS "+params
		int itemxview=generalService.getItemsxView(0)
		params.max = Math.min(max ?: itemxview, 100)
		String  xoffset=params.offset?:0
		
		
		
		if(!params.filter) params.filter = [op:[:],seriales:[:]]		

		
		if(params.filter.idTipoVencimiento)
			params.filter.idTipoVencimiento=generalService.getIdValorParametro('tipovencim',params.filter.idTipoVencimiento)
			
		if(params.filter.idTipoCobertura)
			params.filter.idTipoCobertura=generalService.getIdValorParametro('tipocobert',params.filter.idTipoCobertura)
			
			

		if(params.filter.serial)
		{	
			vencimientoInstanceList=filterPaneService.filter(params,Vencimiento)
			
			def vencimientoInstanceList2=[]
			def query="Select s.vencimiento from Seriales as s Where s.numSerial like '%${params.filter.serial}%'"
			def resultado=Seriales.executeQuery(query)
			println "El id del vencimiento con este serial en archivo es... "+resultado
			vencimientoInstanceList.addAll(resultado)
			
						
		}else
			vencimientoInstanceList=filterPaneService.filter(params,Vencimiento)
			
		
		
		
		
		
		render view: "vencimientosPorSerial", model:[vencimientoInstanceList:vencimientoInstanceList,
			vencimientoInstanceCount: filterPaneService.count( params, Vencimiento ),params:params,
			filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
			itemxview:itemxview,
			xtitulo:generalService.getValorParametro('vencimit05'),sw:0]
	}
	
	
	@Transactional // borrar
	def borrar(Vencimiento vencimientoInstance) {
	 
		if (params.id == null) {
			notFound()
			return
		}
	   
		vencimientoInstance= Vencimiento.get(params.id)

		vencimientoInstance.eliminado=1

		vencimientoInstance.save flush:true

		request.withFormat {
			form {
				flash.message = message(code: 'default.updated.message', args: [message(code: 'Vencimiento.label', default: 'Vencimiento'), vencimientoInstance.id])
				redirect  url:"/vencimiento/index/"+vencimientoInstance.encvencimiento.id
			}
			'*'{ respond vencimientoInstance, [status: OK] }
		}
	}

	def show(Vencimiento vencimientoInstance) {
		respond vencimientoInstance

	}

	def create() {
		respond new Vencimiento(params)
	}

	@Transactional  // save
	def save(Vencimiento vencimientoInstance) {
		if (vencimientoInstance == null) {
			notFound()
			return
		}
		
		vencimientoInstance.detpedidop=DetPedido.get(576)
   
		println "VENCIMIENTO PARAMS ARCHIVO "+params
		
		
		def longIdPedido=params.long('idPedido')		
		def idVendedor=Pedido.get(longIdPedido).empleado.id		
		vencimientoInstance.empleado=Empleado.get(idVendedor)
		
		
		
		if(params.serial)
		{
			println "Entre aqui"
			vencimientoInstance.serial=params.serial			
		}


		vencimientoInstance.encvencimiento=EncVencimiento.get(params.idencvenc)
		
		if(params.serialManual)
			vencimientoInstance.serialManual=params.serialManual
		else
			vencimientoInstance.serialManual='N'
		
		if (params.idPedido){
			vencimientoInstance.pedido=Pedido.get(params.idPedido)
			//vencimientoInstance.numVencimiento=consecutivoService.vencimiento(params.idPedido)
		}
		
		if(params.idVendedor){
			vencimientoInstance.empleado=Empleado.get(params.idVendedor)
		}
		
		
		vencimientoInstance.notificar=1
		 
		vencimientoInstance.validate()
		
		if(vencimientoInstance.hasErrors()){
			respond vencimientoInstance.errors, view: 'create'
			return
		}
		
		
		DateFormat df=new SimpleDateFormat("dd-MM-yyyy")
		Date fechainicio=df.parse(params.fechaInicio)
		Date fechavencimiento=df.parse(params.fechaVencimiento)
		
		
		def respuestaEstado=generalService.getEstadoVencimiento(fechainicio, fechavencimiento)

		vencimientoInstance.idEstadoVencimiento=respuestaEstado[0]
		vencimientoInstance.save flush: true,failOnError: true
//---------------------------------------------------------CARGAR SERIALES DESDE EXCEL------------------------
		if(params.archivoSeriales)//SI EL CAMPO SERIAL ESTA VAC�O..ES DECIR SI SE ESCOGE LEER EL ARCHIVO
		{			
		  def rutayFile=generalService.subirAnexoVencimientos(request,servletContext,vencimientoInstance.id)
		  generalService.importarSerialesExcel(vencimientoInstance.id,rutayFile)			
		}
//-----------------------------------------------------------CARGAR SERIALES DESDE EXCEL------------------------
		
		
//-----------------------------------enviar correo cuando el vencimiento ha sido guardado-------------------------------------------
		def tipoVen=generalService.getValorParametro(params.idTipoVencimiento)
		def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong())).id
		def usuarioL=Empleado.findById(usuarioAccede)
		String urlbase=generalService.getValorParametro('urlaplic')
		def encabezadoId=Long.parseLong(params.idencvenc)
		String empresaVenc=EncVencimiento.get(encabezadoId).empresa.razonSocial
		String asunto="NUEVO REGISTRO DE VENCIMIENTO - ${empresaVenc}"
		String fechaFin=params.fechaVencimiento
		String fechaIni=params.fechaInicio
		String cuerpo="Registro elaborado por: ${usuarioL}<br><br>Se ha registrado un nuevo vencimiento de tipo <b>${tipoVen}</b> para la empresa ${empresaVenc} y usted figura como responsable del mismo.<br><br><b>Fecha de inicio:</b> ${fechaIni}<br><b>Fecha de vencimiento:</b> ${fechaFin}<br><br><b>Descripci&oacute;n:</b><br>${params.descripcion}<br><br>Para m&aacute;s detalles haga clic <a href='${urlbase}/vencimiento/show/${vencimientoInstance?.id}?&layout=main'> AQUI </a>"
		generalService.notificarVencimiento(params.idTipoVencimiento, idVendedor,asunto,cuerpo)
		println "envie esa joda"
//-----------------------------------enviar correo cuando el vencimiento ha sido guardado
		
		
		

		
		
	   /* def xvista='index'
		if (params?.layout=='main')
		   xvista='indexg'
		request.withFormat {
			form {
				flash.message = message(code: 'default.created.message', args: [message(code: 'vencimientoInstance.label', default: 'Vencimiento'), vencimientoInstance.id])
				redirect  url:"/vencimiento/${xvista}?idenc="+vencimientoInstance?.encvencimiento?.id + "&layout=${params.layout}"
			}
			'*' { respond vencimientoInstance, [status: CREATED] }*/
		
		redirect url:"/vencimiento/index?idenc=${vencimientoInstance?.encvencimiento?.id}"
		flash.message="Vencimiento creado exitosamente!"
		
	}

	def edit(Vencimiento vencimientoInstance) {
		respond vencimientoInstance
		
	}

	@Transactional  // update
	def update(Vencimiento vencimientoInstance) {
		if (vencimientoInstance == null) {
			notFound()
			return
		}
		
		

		if (params.idVendedor) {
			vencimientoInstance.empleado=Empleado.get(params.idVendedor)
		}
		if (params.idPedido) {
			vencimientoInstance.pedido=Pedido.get(params.idPedido)
			//if (vencimientoInstance.isDirty('pedido.id') )
			  //  vencimientoInstance.numVencimiento=consecutivoService.vencimiento(params.idPedido)
		}
		println "parametrooooooooos "+params
		if(params.serial){
			println "HOLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
			vencimientoInstance.serial=params.serial
		}
		vencimientoInstance.validate()
		
		if (vencimientoInstance.hasErrors()) {
			respond vencimientoInstance.errors, view: 'edit'
			return
		}
		
		
		
		DateFormat df=new SimpleDateFormat("dd-MM-yyyy")
		Date fechainicio=df.parse(params.fechaInicio)
		Date fechavencimiento=df.parse(params.fechaVencimiento)
		
		
		def respuestaEstado=generalService.getEstadoVencimiento(fechainicio, fechavencimiento)
		//println "VECTOR "+pml
		
		
		
		
//-----------------------------------------------------------REEMPLAZAR ARCHIVO DE SERIALES CUANDO SE ACTUALIZA
		
		println "PARAMS ARCHIVO SERIALES\n\n"+params.archivoSeriales
		
		println "VENCIMIENTO INSTANCE SERIALES\n\n"+vencimientoInstance.archivoSeriales
		
		
		println "Parametros ediciOOOOOOOOOOOOOOOOOOOOOOOOOOOOOON .................."+params
		
		if (params.hayAnexo=='S'){
			println "ENTRE AQUI Y NO EDITE ARCHIVO "+params
			def rutayFile=generalService.subirAnexoVencimientos(request,servletContext,vencimientoInstance.id)
			generalService.actualizarSeriales(vencimientoInstance.id)
			generalService.importarSerialesExcel(vencimientoInstance.id,rutayFile)
		}

		vencimientoInstance.idEstadoVencimiento=respuestaEstado[0]
		vencimientoInstance.save flush: true,failOnError: true
		
//-----------------------------------------------------------REEMPLAZAR ARCHIVO DE SERIALES CUANDO SE ACTUALIZA
		
		
		
//-----------------------------------enviar correo cuando el vencimiento ha sido modificado-------------------------------------------
		
		def tipoVen=generalService.getValorParametro(params.vencimientoEdit)
		def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong())).id
		def usuarioL=Empleado.findById(usuarioAccede)
		
		String urlbase=generalService.getValorParametro('urlaplic')
		def encabezadoId=Long.parseLong(params.idencvenc)
		String empresaVenc=EncVencimiento.get(encabezadoId).empresa.razonSocial
		//String asunto="CONTRATO DE VENCIMIENTO MODIFICADO - ${empresaVenc}"
		String asunto="CONTRATO DE VENCIMIENTO MODIFICADO - ${empresaVenc}"
		String cuerpo="Registro elaborado por: ${usuarioL}<br><br>Se ha modificado la informaci&oacute;n de un vencimiento de tipo <b>${tipoVen}</b> para la empresa ${empresaVenc} y usted figura como responsable del mismo.<br><br><b>Descripci&oacute;n:</b><br>${params.descripcion}<br><br>Para m&aacute;s detalles haga clic <a href='${urlbase}/vencimiento/show/${vencimientoInstance?.id}?&layout=main'> AQUI </a>"
		
		
		generalService.notificarVencimiento(params.vencimientoEdit, params.long('idVendedor'),asunto,cuerpo)
//-----------------------------------enviar correo cuando el vencimiento ha sido modificado
		
		
		
		
		
		
		
		
		def xvista='index'
		if (params?.layout=='main')
		   xvista='indexg'
		/*request.withFormat {
			form {
				flash.message = message(code: 'default.updated.message', args: [message(code: 'Vencimiento.label', default: 'Vencimiento'), vencimientoInstance.id])
								
				//redirect  url:"/vencimiento/${xvista}?idenc="+vencimientoInstance?.encvencimiento?.id+"&layout=${params.layout}"
				redirect  url:"http://www.google.com"
			}
			//POR FAVOR NO BORRAR ESTO, ESTO SIRVE PARA HACER PETICIONES DEPENDIENDO DE LOS staticAllowedMethods definidos arriba..creo
			'*' { respond vencimientoInstance, [status: OK] }*/
		   //println "TONCES CUADROOOOOOOOOO "+
		   String idVenci=vencimientoInstance?.encvencimiento?.id
		   
		   flash.message = message(code: 'default.updated.message', args: [message(code: 'Vencimiento.label', default: 'Vencimiento'), vencimientoInstance.id])
		   redirect  url:"/vencimiento/${xvista}?idenc=${idVenci}&layout=${params.layout}"
		   
		
	}

	@Transactional  // delete
	def delete(Vencimiento vencimientoInstance) {

		if (vencimientoInstance == null) {
			notFound()
			return
		}

		vencimientoInstance.delete flush: true

		request.withFormat {
			form {
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'Vencimiento.label', default: 'Vencimiento'), vencimientoInstance.id])
				redirect action: "index", method: "GET"
			}
			'*' { render status: NO_CONTENT }
		}
	}

	protected void notFound() {
		request.withFormat {
			form {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'vencimientoInstance.label', default: 'Vencimiento'), params.id])
				redirect action: "index", method: "GET"
			}
			'*' { render status: NOT_FOUND }
		}
	}
	
	 def infoVencimiento(){
		render view:"infoVencimiento"
	}
	 
	 @Transactional
	def importarVencimientos()
	{
		println "Parametros vencimientos nat"+params
		Date a=generalService.stringToDate('04/10/2016')
		Date b=generalService.stringToDate('04/10/2017')
		println generalService.getEstadoVencimiento(a,b)
		render view:'importarVencimientos'
		
		
	}
	
	
	@Transactional
	def importarVencimientosDef()
	{

		
		println "JAJAJAJA params "+params
		Random rand = new Random()
		//try {
			def file = request.getFile('file')
			String zruta =generalService.getValorParametro('ruta02')
			def xruta = servletContext.getRealPath(zruta)
			String xnombre=rand.nextInt(1000000).toString()+".xls"
			def  rutayFile=new File( xruta,xnombre)
			
			if (!rutayFile.exists()){
				file.transferTo( rutayFile)
			}
			
			
			
		RecordExcelImporter  importer=new RecordExcelImporter(rutayFile)
			importer.CONFIG_RECORD_COLUMN_MAP =[sheet:'Plantilla_vencimientos', startRow: 1,
				columnMap:[ 'A':'Tipo_Vencimiento',
							'B':'Nro_Pedido',
							'C':'Plataforma_Marca',
							'D':'Numero_de_Serie',
							'E':'Modelo_Numero_Referencia',
							'F':'Tipo_Convenio',
							'G':'Tipo_Cobertura',
							'H':'TipoContrato',
							'I':'Descripcion',
							'J':'FechaInicio',
							'K':'FechaVencimiento',
							'L':'Observaciones']]
			def recordsMapList = importer.getRecords();
			 if(recordsMapList){
				 int i=0
				 
				recordsMapList.each(){
					if (it.Tipo_Vencimiento!=null){
						
						def datosPlantilla=generalService.datosVencimientoExcel(it.Tipo_Vencimiento,it.Nro_Pedido,it.FechaInicio,it.FechaVencimiento,it.Plataforma_Marca,it.Tipo_Convenio,it.Tipo_Cobertura,it.Tipo_Contrato)
						def venci=new Vencimiento()
						Date dm=new Date()
						
//----------------------CAMPOS OBLIGATORIOS------------------------------
						venci.idTipoVencimiento=datosPlantilla.tipoVencimiento
						venci.pedido=datosPlantilla.numPedido
						venci.refTipModNumContract=it.Modelo_Numero_Referencia //El mismo campo para referencia/tipomodelo y num contrato
						venci.fechaInicio=datosPlantilla.fechaInicio
						venci.fechaVencimiento=datosPlantilla.fechaVencimiento
						venci.idEstadoVencimiento=datosPlantilla.estadoVencimiento
						
						venci.empleado=Empleado.get(8)
						//venci.encvencimiento=encVencimientoId
						venci.encvencimiento=EncVencimiento.get(params.vencimientoId)//EncVencimiento.get(53)
						venci.eliminado=0
						venci.notificar=1
//----------------------CAMPOS OBLIGATORIOS------------------------------
						
						
						venci.plataforma=datosPlantilla.plataforma//LISTO
						
						
												
						venci.idTipoConvenio=datosPlantilla.tipoConvenio//LISTO
						venci.idTipoCobertura=datosPlantilla.tipoCobertura//LISTO
						venci.idTipoContrato=datosPlantilla.tipoContrato//LISTO

						
						
												
						venci.serial=it.Numero_de_Serie//LISTO
						venci.descripcion=it.Descripcion//LISTO
						venci.observaciones=it.Observaciones//LISTO
						
						
						
						venci.save(flush:true)
						
							
							
							i++
						
					 }
				  }
				  flash.message="("+i.toString()+") Productos importados !!!"
				  
				  
			 }else{
				  //flash.warning="Archivo no cumple estandar para carga exitosa.Verifique"
			 }
			 flash.message="Productos importados !!!"
			redirect url:"/vencimiento/index?idenc=${params.vencimientoId}"
			
			/*} catch(ex){
				 flash.warning="Archivo no cumple estandar catch para carga exitosa.Verifique"
				
				 redirect url:"/vencimiento/index"
			}*/
			
		
	}
	
	def infoVencimientoDef(){
		response.contentType = grailsApplication.config.grails.mime.types[params.id]
		response.setHeader("Content-disposition", "attachment; filename=RepoVencimientos.xls")
		
		def xmes1 =params.fechaInicio[Calendar.MONTH]+1
		def xanio1=params.fechaInicio[Calendar.YEAR]
		def xmes2 =params.fechaFinal[Calendar.MONTH]+1
		def xanio2=params.fechaFinal[Calendar.YEAR]
		Map formatters = [:]
		Map parameters = [:]
		Map reg
		List datos=[]
		def query="""select encvencimiento.empresa.razonSocial as emp,descripcion,idTipoVencimiento,idTipoCobertura,
                            fechaInicio,fechaVencimiento,idEstadoVencimiento                            
                       from Vencimiento 
                       where eliminado=0 and 
                             month(fechaVencimiento)>=${xmes1} and year(fechaVencimiento)=${xanio1} and
                             month(fechaVencimiento)<=${xmes2} and year(fechaVencimiento)=${xanio2} 
                       order by idEstadoVencimiento,emp """        
	   
		def entidadInstanceList=Vencimiento.executeQuery(query)
	   
		if (entidadInstanceList==[]) {
			flash.message="No hay datos para el período elegido. Verifique"
			redirect url:"/vencimiento/infoVencimiento"
			return
		}
		 def xestado
		for (def entidadInstance in entidadInstanceList){
			
			xestado=generalService.getEstadoVencimiento(entidadInstance[4],entidadInstance[5])
			
			reg=[:]
			reg['1_Empresa']=entidadInstance[0]
			reg['2_Descripción']=entidadInstance[1]
			reg['3_Tipo_Vencimineto']=generalService.getValorParametro(entidadInstance[2])
			reg['4_Tipo_Cobertura']=generalService.getValorParametro(entidadInstance[3])
			reg['5_Fecha_Inicio']=entidadInstance[4]
			reg['6_Fecha_Vence']=entidadInstance[5]
			reg['7_Estado']=generalService.getValorParametro(xestado[0])
			datos.add(reg)
		}
		exportService.export('excel', response.outputStream,datos, formatters, parameters)
	}
	
	def renovarVencimiento(Vencimiento vencimientoInstance){				
			
	   
	   render view:"renovar", model:[vencimientoInstance:vencimientoInstance]
	}
	@Transactional
	def renovarVencimientoDef(){
		 
		println "PARAMETROS RENOVAR VENCIMIENTO "+params
		Vencimiento vencimientoInstance=Vencimiento.get(params.vencimientoId)//params.vencimientoInstance//new Vencimiento(params)
		 
		if (params.idencvenc)
		   vencimientoInstance.encvencimiento=EncVencimiento.get(params.long('idencvenc'))
		   
		if (params.idPedido) {
			vencimientoInstance.pedido=Pedido.get(params.idPedido)
		}
		
		if (params.idVendedor) {
			vencimientoInstance.empleado=Empleado.get(params.idVendedor)
		}
		
		if(params.idTipoConvenio)
		{
			vencimientoInstance.idTipoConvenio=params.idTipoConvenio				
		}
		
		if (params.hayAnexo=='S'){
			println "ENTRE AQUI Y NO EDITE ARCHIVO "+params
			def rutayFile=generalService.subirAnexoVencimientos(request,servletContext,vencimientoInstance.id)
			generalService.actualizarSeriales(vencimientoInstance.id)
			generalService.importarSerialesExcel(vencimientoInstance.id,rutayFile)
		}
		
		
		

		
		
		vencimientoInstance.refTipModNumContract=params.refTipModNumContract
		vencimientoInstance.idEstadoVencimiento=params.idEstadoVencimiento
		//vencimientoInstance.cantidad=params.long('cantidad')
		vencimientoInstance.descripcion=params.descripcion
		vencimientoInstance.idTipoVencimiento=params.vencimientoEdit
		vencimientoInstance.observaciones=params.observaciones
		vencimientoInstance.serial=params.serial
		vencimientoInstance.idTipoCobertura=params.idTipoCobertura
		vencimientoInstance.plataforma=params.plataforma
		
		Date fechaInicio=generalService.stringToDate(params.fechaInicio)
		Date fechaVencimiento=generalService.stringToDate(params.fechaVencimiento)
		
		vencimientoInstance.fechaInicio=fechaInicio
		vencimientoInstance.fechaVencimiento=fechaVencimiento
		
		def respuestaEstado=generalService.getEstadoVencimiento(fechaInicio, fechaVencimiento)
		//println "VECTOR "+pml
		vencimientoInstance.idEstadoVencimiento=respuestaEstado[0]
		vencimientoInstance.notificar=1
		vencimientoInstance.validate()
		   
		if (vencimientoInstance.hasErrors()) {
			respond vencimientoInstance.errors, view: 'create'
			return
		}
		
		//fechaVencimiento.
		//fechaInicio.
		
 //-----------------------------------enviar correo cuando el vencimiento ha sido modificado-------------------------------------------
		def tipoVen=generalService.getValorParametro(params.vencimientoEdit)
		def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong())).id
		def usuarioL=Empleado.findById(usuarioAccede)
		String urlbase=generalService.getValorParametro('urlaplic')
		def encabezadoId=Long.parseLong(params.idencvenc)
		
		println "PARMETROS RENOVAR VENCIMIENTO JEJEKASLK  "+params
		
		
		
		String oldFechaVencimiento = vencimientoInstance.getPersistentValue('fechaVencimiento').toString()
		def newFechaVencimiento=params.fechaVencimiento
		String oldFechaInicio=vencimientoInstance.getPersistentValue('fechaInicio').toString()
		def newFechaInicio=params.fechaInicio
		String oldFechaVenci=generalService.stringDateWithTimeToDate(oldFechaVencimiento)
		String oldFechaIni=generalService.stringDateWithTimeToDate(oldFechaInicio)

		String empresaVenc=EncVencimiento.get(encabezadoId).empresa.razonSocial
		String asunto="RENOVACION CONTRATO DE VENCIMIENTO - ${empresaVenc}"
		String cuerpo="Registro elaborado por: ${usuarioL}<br><br>Se ha efectuado la renovaci&oacute;n de un vencimiento tipo <b>${tipoVen}</b> para la empresa ${empresaVenc} y usted figura como responsable del mismo.<br><br><b>Descripci&oacute;n:</b><br>${params.descripcion}<br><br>Fecha de inicio anterior: <b>${oldFechaIni}</b><br>Nueva fecha de inicio: <b>${newFechaInicio}</b><br><br>Fecha vencimiento anterior: <b>${oldFechaVenci}</b><br>Nueva fecha vencimiento: <b>${newFechaVencimiento}</b><br><br> Para m&aacute;s detalles haga clic <a href='${urlbase}/vencimiento/show/${vencimientoInstance?.id}?&layout=main'> AQUI </a>"
		generalService.notificarVencimiento(params.vencimientoEdit, params.long('idVendedor'),asunto,cuerpo)
 //-----------------------------------enviar correo cuando el vencimiento ha sido modificado
		
		
	   vencimientoInstance.save flush: true,failOnError: true
	   
	   
	   

	   String idVenci=vencimientoInstance?.encvencimiento?.id
	   //flash.message="Vencimiento  renovado exitosamente"
	   redirect url:"/vencimiento/show/${params.vencimientoId}?layout=detalle&idenc=${idVenci}"
	   flash.message="Vencimiento  renovado exitosamente"
	}
	
	
	//@Transactional
	def clienteNoRenovo()
	{
		println "PARAMETROS NO RENOVO"+params
		def vencimientoInstance=Vencimiento.get(params.idVencimiento)
		render (view:'noRenovacion', model:[vencimientoInstance:vencimientoInstance])
		
		/*println "PARAMETROS NO RENOVO "+params
		
		
		Vencimiento vencimientoInstance=Vencimiento.get(params.id)
		
		vencimientoInstance.idEstadoVencimiento="vennorenov"
		vencimientoInstance.notificar=0
		println "DESPUES "+vencimientoInstance.idEstadoVencimiento
		
		
		vencimientoInstance.save(flush:true,failOnError:true)
		flash.message="Vencimiento ha pasado a estado No renovado exitosamente"		
		println "Lo pase a no renovado exitosaaaaaaaaa"
		
		//flash.message = message(code: 'default.updated.message', args: [message(code: 'Vencimiento.label', default: 'Vencimiento'), vencimientoInstance.id])
		//redirect  url:"/vencimiento/${xvista}?idenc=${idVenci}&layout=${params.layout}"
		
		redirect url:"/vencimiento/show/${params.id}?layout=detalle&idenc=${params.idEnc}"
	    flash.message="Vencimiento marcado como vencido no renovado exitosamente"*/
	}
	
	@Transactional
	def clienteNoRenovoDef(Vencimiento vencimientoInstance)
	{
		println "aja vengo del nojoda "+params
		vencimientoInstance.idEstadoVencimiento="vennorenov"
		vencimientoInstance.notificar=0
		vencimientoInstance.save(flush:true,failOnError:true)
		flash.message="Vencimiento ha pasado a estado No renovado exitosamente"	
		
		
		redirect url:"/vencimiento/show/${params.id}?layout=detalle&idenc=${params.idEnc}"
		
	}
	
	@Transactional
	def actualizarEstadoVencimientos(){
	 generalService.actualizarEstadoVencimientos()
	 flash.warning="Estados de vencimientos han sido actualizados a la fecha de hoy"
	 redirect url:"/vencimiento/indexg?layout=main&sort=encvencimiento&max=10&order=asc"
	}
	
	def paginacion(String hizoClic)//HIZO CLIC ES LA VARIABLE QUE VIENE DE LA PAGINACION
	{
		String  xoffset=''
		if(params.offset && hizoClic)
		xoffset=params.offset
		else
		{
			if(params.offset)
			params.remove("offset")
			xoffset=0
		}
		return xoffset
	}
}
