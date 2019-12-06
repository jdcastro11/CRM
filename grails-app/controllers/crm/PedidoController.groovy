package crm

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.converters.JSON
import jxl.Workbook
import jxl.write.Label
import jxl.write.WritableSheet
import jxl.write.WritableWorkbook
import jxl.write.WritableCellFormat
import jxl.write.WritableFont
import jxl.write.Alignment
import jxl.write.NumberFormat
import jxl.write.Number
import jxl.write.Formula

import java.text.DecimalFormat
import java.text.SimpleDateFormat

import javax.validation.constraints.Size





@Transactional(readOnly = true)
class PedidoController extends BaseController{

	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def generalService
	def consecutivoService
	def pedidoService
	def filterPaneService
	def auditoriaService
	def oportunidadService
	def exportService
	def exportarService
	def pedidoInstanceList2
	def pedidoInstanceList
	def listaFiltro
	def filterList
	   
	@Transactional
	def index(Integer max) {			
		
		
		int itemxview=generalService.getItemsxView(0)
		params.max=itemxview
		String  xoffset=params.offset?:0
		String  xtitulo
		
		
	   
		if(!params.filter) params.filter = [op:[:],empleado:[:],factura:[:],empresa:[:],detpedido:[:]]
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado='0'
		
		//params.filter.op.idEstadoPedido="InList"
		//params.filter.idEstadoPedido=["'Pendiente x compra'","'Anulado'"].toString()


		
		//params['filter.op.empresa.razonSocial']="NotILike"
		//params['filter.empresa.razonSocial']="vaina"
		
		 
		def ztitulos=['','pedenelabo','pedidosfin','pedidoscom']
		//xtitulo='pedidosenp'
	  
		xtitulo=titulos(params.estado)
		//------------------------JOSE DANIEL MAURY 11/08/16
		if(params.filter.detenidoEnCompra=='Si')
		{
			xtitulo='pedDetenid'
			params['filter.op.detenidoEnCompra']="Equal"
			params['filter.detenidoEnCompra']="1"
		}
		//------------------------JOSE DANIEL MAURY 11/08/16
		

		
		//variable hace que se vean solo los pedidos menos 1000 dias a la fecha de hoy
		def haceUnAnio=new Date()-450
		
		if (params.id)
			 session.xid=params.id
		else
			 params.id=session.xid
			 
			 
		if (params.filter.idSucursal){			  
			  params.filter.idSucursal=generalService.getIdSucursal(params.filter.idSucursal)
		 }
		 
		
		 if(params.filter.idEstadoPedido ){
			
				params.filter.idEstadoPedido=generalService.getIdValorParametro('estapedido',params.filter.idEstadoPedido)
				
		 }else{
			   if (params.id){
				   
				if (params.id=='0'){ //el index de todos los pedidos
					//params.filter.op.fechaApertura="GreaterThan"
					//params.filter.fechaApertura=haceUnAnio
					params.filter.op.idEstadoPedido="NotILike"
					params.filter.idEstadoPedido="x"
					
					
					//-------------JOSÉ DANIEL MAURY 18/08/2016					
					if(params.filter?.detpedido?.idProcesarPara)
					{
						
						params.max=3500
						params.listDistinct=true
						params.uniqueCountColumn='numPedido'
						params['filter.op.detpedido.eliminado']="Equal"
						params['filter.detpedido.eliminado']="0"
						params['filter.op.detpedido.idProcesarPara']=params.filter.op.detpedido.idProcesarPara
						
						
						if(params.filter.detpedido.idProcesarPara=='Cableado' || params.filter.detpedido.idProcesarPara=='pedprosp02')
						{
							xtitulo='pedcable'
							params['filter.detpedido.idProcesarPara']="pedprosp02"	
													
							
						}
						
						if(params.filter.detpedido.idProcesarPara=='Mayorista' || params.filter.detpedido.idProcesarPara=='pedprosp01')
						{
							xtitulo='pedmayori'
							params['filter.detpedido.idProcesarPara']="pedprosp01"
						}
						
						if(params.filter.detpedido.idProcesarPara=='Interno Redsis' || params.filter.detpedido.idProcesarPara=='pedprosp03')
						{
								xtitulo='pedintered'
								params['filter.detpedido.idProcesarPara']="pedprosp03"
						}
					}
					
					//-------------JOSÉ DANIEL MAURY 18/08/2016
					
					
				}else if (params.id=='pedfacturx' || params.id=='pedanuladx'){
					  /* lista pedidos cerrados (facturados o anulados */
					params.filter.op.idEstadoPedido="Equal"
					params.filter.idEstadoPedido=params.id
					xtitulo=(params.id=='pedfacturx')?'pedidosfac' :'pedidosanu'
					
					
					
					//seccion temporal para solucionar lo de pedidos facturado para cableado--laura perez 13/07/2017//
					
					if(params.filter?.detpedido?.idProcesarPara)				
						xtitulo=generalService.filtrarPedidosCableadoFacturados(params)
					
					//seccion temporal para solucionar lo de pedidos facturado para cableado--laura perez 13/07/2017//

				}else if(params.id=='pedidosbor'){
				params.filter.op.eliminado="Equal"
				params.filter.eliminado="1"
				xtitulo='pedidosbor'
				}
				
				else if (params.id == '2'){
					params.filter.op.idEstadoPedido="Equal"
					params.filter.idEstadoPedido="pedenrevi2"
					xtitulo=ztitulos[2]
				}else if (params.id in ['1','3']){
					// lista pedidos segun etapa  compras y almacen

					params.filter.op.idEstadoPedido="Like"
					params.filter.idEstadoPedido=params.id
					params['filter.op.detpedido.idEstadoDetPedido']="Equal"
					params['filter.detpedido.idEstadoDetPedido']="peddetpd01"
					
					xtitulo=ztitulos[params.int('id')]
				}
		  }
		}
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
		   params.filter+=[empleado:[:]]
		   params['filter.op.empleado.id']="Equal"
		   params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong())				
		}

		/*Prueba para autorizar segundo usuario a un pedido
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
			params.filter+=[empleado:[:]]
			params['filter.op.']="Equal"
			params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong())
		}*/
		
		if (!('GERENTE' in generalService.getRolUsuario(session['idUsuario'].toLong()))){
			println "Usted no es GERENTE"
			Calendar cal=Calendar.getInstance()
			//cal.set(2017,Calendar.AUGUST,1)
			cal.set(2015,Calendar.DECEMBER,31)
			Date date=cal.getTime()
			params.filter.op.fechaApertura="GreaterThan"
			params.filter.fechaApertura=date
		}
		
		
		
		session.filterParams=params  // para recordar parmeros para exportaciÃ³n
		String ztrm=generalService.getValorParametro('trm')
		def xtrm=new BigDecimal(ztrm)
		
		
		
		
		pedidoInstanceList = filterPaneService.filter(params, Pedido)//el unique es para q no se repitan
		//elementos...(se repiten al momento de obtener aquellos que tengan items pendientes x comprar)
		
		updateFilterLength()
		listaFiltro=pedidoInstanceList2
		
		String subtotalpesos=calcularValor(pedidoInstanceList,1)//pesos
		String subtotaldolares=calcularValor(pedidoInstanceList,2)//dolares
		String valortotalpesos=calcularValor(pedidoInstanceList2,1)//pesos
		String valortotaldolares=calcularValor(pedidoInstanceList2,2)//dolares
		
		
		def facturaDolares=0
		def facturaPesos=0
		
		if(params.id=='0')//Esto es para que unicamente se muestren el total de las facturas en la vista de todos los pedidos..
		{
			facturaDolares=pedidoService.totalFacturaPedidos(pedidoInstanceList2).facturaDolares
			facturaPesos=pedidoService.totalFacturaPedidos(pedidoInstanceList2).facturaPesos
		}
		
		//println "HAY ESTE NUMERO DE ARCHIVOS EN ESTA LISTA "+pedidoInstanceList2.size()
		
		
		
		respond pedidoInstanceList,  model:[
			pedidoInstanceCount: filterPaneService.count( params, Pedido ),
			filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
			params:params, xtitulo:generalService?.getValorParametro(xtitulo),xtrm:xtrm,totalPesos:valortotalpesos,totalDolares:valortotaldolares,subpesos:subtotalpesos,subdolar:subtotaldolares,
			facturaDolares:facturaDolares,facturaPesos:facturaPesos]

			//params.max=10
			
	 }
	 
	// MODIFICACIONES REALIZADAS POR MARIO QUINTERO 09/01/2015   //
	def indexn(Integer max) {
		//int itemxview=generalService.getItemsxView(0)
		//params.max =itemxview
		params.sort ="id"
		String  xoffset=params.offset?:0
		String xtitulo
	   
		if(!params.filter) params.filter = [op:[:],empleado:[:]]
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado = '0'
		def ztitulos=['','pedenelabo','pedidosfin','pedidoscom']
		xtitulo='pedidosenp'
		
		if (params.estado){
			if (params.estado in ['1','2','3']){  // lista pedidos segun etapa
				params.filter.op.idEstadoPedido="Like"
				params.filter.idEstadoPedido=params.estado
				xtitulo=ztitulos[params.int('estado')]
			}else {
				/* lista pedidos cerrados (facturados o anulados */
				params.filter.op.idEstadoPedido="Equal"
				params.filter.idEstadoPedido=params.estado
				xtitulo=(params.estado=='pedfacturx')?'pedidosfac' :'pedidosanu'}
		}else {
		  
			if(params.filter.idEstadoOportunidad != null){
				params.filter.idEstadoPedido=generalService.getIdValorParametro('estapedido',params.filter.idEstadoPedido)
			}else{ /* pedidos activos  */
				params.filter.op.idEstadoPedido="NotLike"
				params.filter.idEstadoPedido="x"
			}
		}
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
		   params.filter+=[empleado:[:]]
		   params['filter.op.empleado.id']="Equal"
		   params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong())
				
		}
		String ztrm=generalService.getValorParametro('trm')
		def xtrm=new BigDecimal(ztrm)
		
		def pedidoInstanceList = filterPaneService.filter( params, Pedido )
		 //println "Pedidos completo"+ pedidoInstanceList
		/*pedidoInstanceList.each
		{
			
			println it.properties
			return
		}*/
  
		 // llamada al servicio para traer la informacion de cuota y estado del EC
		def idUsuario=generalService.getIdEmpleado(session['idUsuario'])
		//def infoEmpleadoQ = generalService.informacionEstadoQempleado(idUsuario)
		def infoEmpleadoQ = []
		// sacamos el listado de categorias con sus respectivos id
		def nodo = generalService.sacarListaCategoria(pedidoInstanceList, "numPedido", "id")
		 //println nodo.label
		def total = nodo.size()
		
			render(view:"indexn",  model:[
			pedidoInstanceCount: total ,params:params
		   , infoEmpleadoQ:infoEmpleadoQ, nodo : nodo, xtitulo:generalService?.getValorParametro(xtitulo),xtrm:xtrm])
	  
	}
	
	 def indexe(Integer max) {  //Pedidos por Estado
		//int itemxview=generalService.getItemsxView(0)
		//params.max =itemxview
		params.sort ="idEstadoPedido"
		String  xoffset=params.offset?:0
		String xtitulo
	   
		if(!params.filter) params.filter = [op:[:],empleado:[:]]
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado = '0'
		def ztitulos=['','pedenelabo','pedidosfin','pedidoscom']
		xtitulo='pedidosenp'
		
		
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
		   params.filter+=[empleado:[:]]
		   params['filter.op.empleado.id']="Equal"
		   params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong())
				
		}
		String ztrm=generalService.getValorParametro('trm')
		def xtrm=new BigDecimal(ztrm)
		
		def pedidoInstanceList = filterPaneService.filter( params, Pedido )
		
		
		// llamada al servicio para traer la informacion de cuota y estado del EC
		def idUsuario=generalService.getIdEmpleado(session['idUsuario'])
		//def infoEmpleadoQ = generalService.informacionEstadoQempleado(idUsuario)
		def infoEmpleadoQ =[];
		// sacamos el listado de categorias con sus respectivos id
		def nodo = generalService.sacarListaCategoria(pedidoInstanceList, "idEstadoPedido", "idEstadoPedido")
		  //println nodo.label
		def total = nodo.size()
	  
		render(view:"indexe",  model:[
		pedidoInstanceCount: total ,params:params
		, infoEmpleadoQ:infoEmpleadoQ,  nodos:nodo, xtitulo:generalService?.getValorParametro(xtitulo),xtrm:xtrm])
		
	   
	}
	 
	 
	 def indexcompra()
	 {
		 //def query="SELECT p.* FROM pedidos as p, det_pedidos as dp WHERE p.id=dp.pedido_id and p.eliminado=0 and dp.id_estado_det_pedido='peddetpd01' GROUP BY p.nombre_cliente"
			 if(!params.filter)params.filter = [op:[:],empleado:[:],detpedido:[:]]
			 
			 params.filter.op.eliminado = "Equal"
			 params.filter.eliminado='0'
			 params.filter.op.idEstadoPedido="NotEqual"
			 params.filter.idEstadoPedido="pedanuladx"
			 params['filter.op.detpedido.idEstadoDetPedido']="Equal"
			 params['filter.detpedido.idEstadoDetPedido']="peddetpd01"//pendiente x compra
			 params['filter.op.detpedido.eliminado']="Equal"
			 params['filter.detpedido.eliminado']="0"//eliminados igual a 0
			 params['filter.op.detpedido.idProcesarPara']="NotEqual"
			 params['filter.detpedido.idProcesarPara']="pedprosp02" //cableado
			 
			 if(params.filter.detenidoEnCompra=='Si')
			 {
				 
				 params['filter.op.detenidoEnCompra']="Equal"
				 params['filter.detenidoEnCompra']="1"
			 }
			 
			 
			 if(params.filter.detenidoEnCompra=='No')
			 {
				 
				 params['filter.op.detenidoEnCompra']="Equal"
				 params['filter.detenidoEnCompra']="0"
			 }
			 
			 
			 if (params.filter.idSucursal){
				   params.filter.idSucursal=generalService.getIdSucursal(params.filter.idSucursal)
			  }
			  

			 listaFiltro=filterPaneService.filter(params, Pedido).unique()//el unique es para q no se repitan
			 
			 
			 String ztrm=generalService.getValorParametro('trm')
			 def xtrm=new BigDecimal(ztrm)
			 String valortotalpesos=calcularValor(listaFiltro,1)//pesos
			 String valortotaldolares=calcularValor(listaFiltro,2)//dolares
			 
			 def facturaDolares=pedidoService.totalFacturaPedidos(listaFiltro).facturaDolares
			 def facturaPesos=pedidoService.totalFacturaPedidos(listaFiltro).facturaPesos
	
	
		 // pedidoInstanceList
//			 pedidoInstanceCount: filterPaneService.count( params, Pedido )
		 render(view:"indexcompra", model:[filterParams:org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
			 params:params,listaFiltro:listaFiltro,xtrm:xtrm,totalPesos:valortotalpesos,totalDolares:valortotaldolares,
			 pedidoInstanceCount:listaFiltro.size(),xtitulo:generalService?.getValorParametro('pedidoscom'),facturaDolares:facturaDolares,
			 facturaPesos:facturaPesos]
		 )

			
	 }
	
	def calcularValor(def list, int tipo)//1=pesos 2=dolares
	{
		def subtotal=0		
			list.each {
				if(it.idTipoPrecio.equals("pedtprec0"+"${tipo}")&& it.valorPedido!=null)
				{
					if(tipo==1)
					subtotal+=it.valorPedido
					else
					{
						if(it.trm!=0)
						subtotal+=it.valorPedido/it.trm
						else
						{
							subtotal+=it.valorPedido
						}
					}
				}
		
		}
		return exportarService.formatNumber(subtotal.toString())
	}
	
	
	def exportarDatos=
	{
		List lista_export=[]
		//el nombre de los campos fields es como están definidos en la clase dominio
		List fields = ["numPedido","nombreCliente","oportunidad.nombreOportunidad","valorPedido","idMondedaFactura","facturacionParcial","fechaApertura","idEstadoPedido","empleado"]
		Map labels = ["numPedido": "Codigo","nombreCliente":"Empresa","oportunidad.nombreOportunidad":"Descripcion Proyecto","valorPedido":"Valor en dolares","idMondedaFactura":"Valor en pesos","facturacionParcial":"Total Facturado","fechaApertura": "Fecha","idEstadoPedido":"Estado","empleado":"Vendedor"]

		def convertirMoneda={Pedido,value->
			if(Pedido.idTipoPrecio.equals("pedtprec01")&& Pedido.valorPedido!=null)//pesos
			{				
				if(Pedido.idEstadoPedido=='pedfacturx' || Pedido.idEstadoPedido=='pedanuladx')
				{
					return Pedido.valorPedido
				}
				else
				{
					def facturasPedido=pedidoService.valorFacturado(Pedido.id.toString())['subtotal']
					return Pedido.valorPedido//-facturasPedido
				}
			}		
		}


		def convertirMoneda2={Pedido,value->
			if(Pedido.idTipoPrecio.equals("pedtprec02")&& Pedido.valorPedido!=null)//pesos
			{
				if(Pedido.trm!=0)
				{
					if(Pedido.idEstadoPedido=='pedfacturx' || Pedido.idEstadoPedido=='pedanuladx')
					{//Es para no ralentizar el rendimiento al intentar calcular el total de las facturas de pedidos ya facturados o
					 //anulados
						return Pedido.valorPedido/Pedido.trm
					}
					else
					{
						def facturasPedido=pedidoService.valorFacturado(Pedido.id.toString())['subtotal']
						return (Pedido.valorPedido/Pedido.trm)//-facturasPedido
					}
				}
				else
					return Pedido.valorPedido
			}
		}
		
		def getPedidoValue={Pedido,value->
			//println "pedido "+Pedido.idEstadoPedido
			/*switch(Pedido.idEstadoPedido)
			{
				case 'pedenelab1':
				return "En elaboración";break;
				case 'pedenrevi2':
				return "En revision";break;
				case 'pedpencom3':
				return "Pendiente x compra";break;
				case 'pedpenfp23':
				return "Pendiente x Facturar Parcial";break;
				case 'pedpenfac2':
				return "Pendiente x Facturar";break;
				case 'pedfacpar2':
				return "Facturado Parcialmente";break;
				case 'pedfacturx':
				return "Facturado";break;
				case 'pedanuladx':
				return "Anulado";break;
				
			}*/
			//return generalService.getValorParametro(Pedido.idEstadoPedido)
			
			return ValorParametro.findByIdValorParametro(Pedido.idEstadoPedido)
		}

		println("Suma de facturas...")
		def sumaFacturas={Pedido,value->			
			if(Pedido.idEstadoPedido=='pedfacpar2' || Pedido.idEstadoPedido=='pedfacturx' ||Pedido.idEstadoPedido=='pedpenfp23' )
			{
				def facturasPedido=pedidoService.valorFacturado(Pedido.id.toString())['subtotal']
				return facturasPedido
			}
			else
				return '-'
		}
		println("Fin Suma de facturas...")
//		def date_solo_fecha = {Pedido, value ->
	//		return Pedido.fechaApertura.format("dd-MM-yyyy")
		//}
		
		Map formatters = [valorPedido:convertirMoneda2,idMondedaFactura:convertirMoneda,idEstadoPedido:getPedidoValue,facturacionParcial:sumaFacturas]
		String filename=exportarService.setfilename(params.titulo)
		if(params.tipo_export=='1')//exportar todos
		{
			println("Exportar todos")
			List idss=listaFiltro.id
			lista_export=exportarService.obtenerItemsSeleccionados(Pedido,idss)
		}
		else if(params.tipo_export=='2')//exportar seleccionados
		{
			println("Exportar seleccionados...")
			fields = ["arqui","numPedido","nombreCliente","valorPedido","idMondedaFactura","fechaApertura","idEstadoPedido"]
			labels = ["arqui":"ArquitectoAsociado","numPedido": "Codigo","nombreCliente":"Empresa","valorPedido":"Valor en dolares","idMondedaFactura":"Valor en pesos","fechaApertura": "Fecha","idEstadoPedido":"Estado"]
			lista_export=generalService.traerPedidosxArquitecto()
			

			//lista_export=generalService.traerPedidosxArquitecto()
			//def queryArquitectosxPedido="Select numPedido,nombreCliente,valorPedido,idMondedaFactura,fechaApertura,idEstadoPedido from Pedido p group by p.listaArquitectos"
			
			//fields = ["arqui","numeropedido","valorDolar","monedaFactura","estadoPedido"]
			//labels = ["arqui":"Arquitecto","numeropedido":"Numero pedido","valorDolar":"Valor en dolaress","monedaFactura":"Valor en pesos","estadoPedido":"Estado"]
			//formatters = [valorDolar:convertirMoneda2,monedaFactura:convertirMoneda,estadoPedido:getPedidoValue]
			//lista_export=generalService.traerPedidosxArquitecto()
			//println "asdasdsad"+p
			
			
		}
		else
		{
			println("Exp ids items...")
			List ids=params.list('pedidos')//ids de items seleccionados
			lista_export=exportarService.obtenerItemsSeleccionados(Pedido,ids)//lista de checkbox seleccionados
		}
		println("exportando")
		exportarService.exportar(Pedido,lista_export,fields,labels,response,formatters,filename)
		
	}
	
	
	def buscarListadoRegistros ={
	  def query
	  def listaRegistro
	  def plantilla
		/**Dependiendo del parametro mostrar recibido realizamos el query y mostramos la plantilla
		 * mostrar:'pedidoXq'  mostramos el listado de pedidos que se visualiza por q
		 **/
	   
		//recibo el id de la empresa y procedo a filtrar para devolver solo las
		//oportunidades referentes a este id
	   def idRegistro = params.numeroId
		
		/**realizamos la busqueda de las oportunidades teniendo en cuenta que
		no este en estado eliminado, que contenga el usuario como vendedor
		que no este cerrada.
		*/
	  if(params.mostrar =='pedidoXq'){  // select usado para visualizar los registros de la vista Registros X Q
		query = " from Pedido where trimestre ="+"'"+idRegistro +"'"
		listaRegistro =Pedido.findAll(query)
		plantilla ="/pedido/listadoPedidosQ"
	  }else{
		  if(params.mostrar =='pedidoXitem'){
		query = " from DetPedido where pedido_id ="+idRegistro.toLong() +"and eliminado = 0 order by id asc"
		listaRegistro =DetPedido.findAll(query)
	  
		plantilla ="/pedido/listadoItems"
		  } else{
				query = " from DetPedido where pedido_id ="+idRegistro.toLong() +"and eliminado = 0 order by id asc"
				listaRegistro =DetPedido.findAll(query)
				plantilla ="/pedido/listadoItems1"
		  }
				
	  }
	   //println listaRegistro
	   /** construimos la tabla mediante el fragmento a usar que contiene el listado
	   de oportunidades
	   **/
	  
		String ztrm=generalService.getValorParametro('trm')
		def xtrm=new BigDecimal(ztrm)
		
		   def resultado =[:]
	String templateTablaOportunidad = (g.render(template: plantilla,
	model : [listaRegistro: listaRegistro, id:idRegistro, xtrm:xtrm]))?.toString()
	resultado.templateTablaOportunidad = templateTablaOportunidad
	
		render  resultado as JSON
	}

	
	def traerNodo() {
		//int itemxview=generalService.getItemsxView(0)
		//params.max =itemxview
		params.sort = params.orden
		def idRegistro =  params.numeroId
		def idSplit = params.numeroId.split('-')
		 //println "PARAMETRO SPLIT: " + idSplit
		String  xoffset=params.offset?:0
		String xtitulo
	   
		if(!params.filter) params.filter = [op:[:],empleado:[:]]
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado = '0'
		def ztitulos=['','pedenelabo','pedidosfin','pedidoscom']
		xtitulo='pedidosenp'
		
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
		   params.filter+=[empleado:[:]]
		   params['filter.op.empleado.id']="Equal"
		   params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong())
				
		}
		
		println "PEDIDO PARAMS "+params
		String ztrm='2938'//generalService.getValorParametro('trm')
		def xtrm=new BigDecimal(ztrm)
		
		// averiguamos por que campo es que debemos filtrar, sacandolos de los parametros
		if(params.campoFiltro1 != ''){
			if(params.campoFiltro1 == 'idEstadoPedido'){
				params['filter.op.idEstadoPedido']="Equal"
				params.filter.idEstadoPedido= idSplit[0]
			}
		}
		
		if(params.campoFiltro2 != ''){
			if(params.campoFiltro2 == 'idSucursal'){
				params['filter.op.idSucursal']="Equal"
				params.filter.idSucursal= idSplit[1]
			}
		}
		
		 if(params.campoFiltro3 != ''){
			if(params.campoFiltro3 == 'empresa'){
				def nombEmpresa = Empresa.findById(idSplit[2])
				params['filter.op.empresa']="Equal"
				params.filter.empresa = nombEmpresa
			}
		}
		
		 if(params.campoFiltro4 != ''){
			if(params.campoFiltro4 == ''){
				
			}
		}

		def pedidoInstanceList = filterPaneService.filter( params, Pedido )
		//println "SUCUARSALES:"+ pedidoInstanceList
		
		def nodo
		if(params.ultimoNodo=='No'){
		  nodo = generalService.sacarListaCategoria(pedidoInstanceList, params.categoria, params.idGuardar)
		  //println nodo.label
		}else{
		  nodo = pedidoInstanceList
		}
		
		def total = nodo.size()
		def resultado =[:]
		
	   if(params.plantilla =='EstCiuEmp2'){
	String templateTablaOportunidad = (g.render(template: "/pedido/listadoNodos2_EstadoCiudadEmpresa",
	model : [nodo: nodo, empresa:idRegistro]))?.toString()
	resultado.templateTablaOportunidad = templateTablaOportunidad
	   }
	   
		if(params.plantilla =='EstCiuEmp3'){
			String templateTablaOportunidad = (g.render(template: "/pedido/listadoNodos3_EstadoCiudadEmpresa",
			 model : [nodo: nodo, cId:idSplit[0]+"-"+idSplit[1], empresa:idRegistro]))?.toString()
			resultado.templateTablaOportunidad = templateTablaOportunidad
		}
		
		 if(params.plantilla =='EstCiuEmp4'){
			String templateTablaOportunidad = (g.render(template: "/pedido/listadoPedidos",
			 model : [nodo: nodo, cId:idSplit[0]+"-"+idSplit[1]+"-"+idSplit[2], empresa:idRegistro, xtrm:xtrm]))?.toString()
			resultado.templateTablaOportunidad = templateTablaOportunidad
		}
		render  resultado as JSON
	}
   
	/** FIN DE LAS MODIFICACIONES REALIZADAS POR MARIO  **/
	
	def indexp(Integer max) {
		 // vista para el Panel de control
		params.max =5
		String  xoffset=params.offset?:0
		String xwherev; String xorden
		if (params.sort)
		   xorden=" order by ${params.sort}"
		else
		   xorden=" order by fechaApertura desc-"
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
			xwherev=" and empleado.id=${generalService.getIdEmpleado(session['idUsuario'])}"
		} else  xwherev=''
	  
		def query ="from Pedido where idEstadoPedido !='pedfacturx' and idEstadoPedido !='pedanuladx'  and eliminado=0"+xwherev+xorden
		def queryc ="select count(p) from Pedido p  where  idEstadoPedido !='pedfacturx' and idEstadoPedido !='pedanuladx' and eliminado=0"+xwherev
		
		def pedidoInstanceList = Pedido.findAll(query,[max:params.max,offset:xoffset.toLong()])
	   
		def xnum=Pedido.executeQuery(queryc)
		render view:"indexp", model:[pedidoInstanceList:pedidoInstanceList,pedidoInstanceCount:Math.min(xnum[0],10)]
	}
	
	def listarBorrados(Integer max) {
		
		//def a=generalService.formatearNitPedido("d456456f14f56-dsd  ")
		//println "La respuesta es "+a		
		
		
		int itemxview=generalService.getItemsxView(0)
		params.max = Math.min(max ?: itemxview, 100)
		String  xoffset=params.offset?:0
	   
		def query="from Pedido as p where  p.eliminado=1"
		def pedidoInstanceList=Pedido.findAll(query,[max:params.max,offset:xoffset.toLong()])
		
		params.id='pedidosbor'
		
		render view: "index", model: [ pedidoInstanceList: pedidoInstanceList,
			pedidoInstanceCount:Pedido.countByEliminado(1),
			itemxview:itemxview,
			xtitulo:generalService?.getValorParametro('pedidosbor')]
	}
	
	@Transactional //borrar
	def borrar(Pedido pedidoInstance) {
	 
		if (params.id == null) {
			notFound()
			return
		}
	   
		pedidoInstance= Pedido.get(params.id)

		pedidoInstance.eliminado=1

		pedidoInstance.save flush:true
	  
		redirect url:"/pedido/index?sort=fechaApertura&order=desc"
	  
	}

	def show(Pedido pedidoInstance) {
	   
		respond pedidoInstance, model:[sw:0]
	}

	def create() {
		respond new Pedido(params),model:[swgenerar:'N']
	}

	@Transactional // save
	def save(Pedido pedidoInstance) {
		
		if (pedidoInstance == null) {
			notFound()
			return
		}
		
		def listaAnexos=['anexo02']
		
		if (params.clienteNuevo=='S') listaAnexos.add('anexo09')
		if (params.handOff=='S') listaAnexos.add('anexo11')
		if (params.idBidNexsy=='S') listaAnexos.add('anexo05')
		if (params.bidIbm=='S') listaAnexos.add('anexo07')
		if (params.servicioIbm=='S') listaAnexos.add('anexo08')
		
		
		pedidoInstance.oportunidad=Oportunidad.get(params.idOportunidad)
		pedidoInstance.empresa=Empresa.get(params.idempresa)
		
		if (params.idVendedor)
			 pedidoInstance.idUsuarioAutor=params.idVendedor.toLong()
		
		pedidoInstance.nombreCliente= pedidoInstance.empresa.razonSocial
		
		if(params.idContacto){
			pedidoInstance.persona=Persona.get(params.idContacto.toLong())
			pedidoInstance.nombreContacto=pedidoInstance.persona.nombreCompleto()
		}
		
		if(params.idVendedor){
			pedidoInstance.empleado=Empleado.get(params.idVendedor.toLong())
			pedidoInstance.nombreVendedor=pedidoInstance.empleado.nombreCompleto()
		}
		pedidoInstance.fechaApertura =new Date()
		pedidoInstance.trimestre=generalService.getTrim(pedidoInstance.fechaApertura)
		
		pedidoInstance.validate()
		
		if (pedidoInstance.hasErrors()) {
			respond pedidoInstance.errors, view: 'create'
			return
		}
		

		pedidoInstance.numPedido=consecutivoService.pedido(params?.idSucursal)
		

		pedidoInstance.save flush: true
		
		pedidoService.crearAnexos(listaAnexos,pedidoInstance?.id) // crea los anexos pertinentes


		auditoriaService.logIn('Pedido',pedidoInstance?.id)

		def query=ValorParametro.where{idValorParametro=="notservredsis"}
		def notservredsis =[query.find().valor?:'desactivada']
		println "Notificar a servicios redsis siempre:" +notservredsis[0]



		if(pedidoInstance.handOff=='S' || notservredsis[0] == 'activa'){
			println "Servicios Redsis activado (S)"
			generalService.notificarServicioRedsis(pedidoInstance.numPedido)
			println "Correo enviado a Ingenieria!"

			log.info("Pedido ${pedidoInstance.numPedido} con servicios redsis.")

		}

		redirect url:"/pedido/show/"+pedidoInstance?.id
	}

	def edit(Pedido pedidoInstance) {
		respond pedidoInstance
	}

	@Transactional // update
	def update(Pedido pedidoInstance) {
		
		
		println "Los parametros que recibo cuando genero un pedido son.... "+params
		
		//   pedidoInstance=Pedido.get(params.id)
		
		if (pedidoInstance == null) {
			notFound()
			return
		}
		
		
		generalService.asignarVendedorDesdeOportunidad(params.idOportunidad)//Para asignar un ejecutivo de cuenta al cliente en caso de no tenerlo..
		
		
		
				 
	   
		def listaAnexos
		if (params.swgenerar=='N') listaAnexos=['anexo03'] else listaAnexos=[]
		 
		if (params.clienteNuevo=='S') listaAnexos.add('anexo09')
		if (params.handOff=='S') listaAnexos.add('anexo11')
		if (params.idBidNexsy=='S') listaAnexos.add('anexo05')
		if (params.bidIbm=='S') listaAnexos.add('anexo07')
		if (params.servicioIbm=='S') listaAnexos.add('anexo08')
		
		pedidoInstance.trm = params.float('trm')
		println "trm convertida a float="
		println pedidoInstance.trm
		pedidoInstance.oportunidad=Oportunidad.get(params.idOportunidad)
		
		

		
		pedidoInstance.empresa=Empresa.get(params.idempresa)
	   
		if (pedidoInstance.dirDespacho==null){
			pedidoInstance.dirDespacho=pedidoInstance?.empresa?.direccion
		}
		if (pedidoInstance.dirEntregaFactura==null){
			pedidoInstance.dirDespacho=pedidoInstance?.empresa?.direccion
		}
		
		pedidoInstance.nombreCliente= pedidoInstance.empresa.razonSocial
		
		if(params.idContacto){
			pedidoInstance.persona=Persona.get(params.idContacto.toLong())
			pedidoInstance.nombreContacto=pedidoInstance.persona.nombreCompleto()
		}
		
		if(params.idFacturarA){
		   
			pedidoInstance.idFacturarA=params.idFacturarA.toLong()
		}
		
		if(params.idVendedor){
			pedidoInstance.empleado=Empleado.get(params.idVendedor.toLong())
			pedidoInstance.nombreVendedor=pedidoInstance.empleado.nombreCompleto()
		}
		
		if(params.arquitectoSol=='N'){
			pedidoInstance.razonesSinArquitecto=params.comentariosSinArquitecto
		}
		
		
		
		pedidoInstance.validate()
		
		if (pedidoInstance.hasErrors()) {
			respond pedidoInstance.errors, view: 'edit'
			return
		}

		if (pedidoInstance.numPedido==null){
			pedidoInstance.numPedido=consecutivoService.pedido(params?.idSucursal)
		}
			 
		
		if (params.swgenerar=='S' ){
			// Pedido  creado por generacion de  Oportunidad
			println "Entre aca generar pedido "
			pedidoInstance.oportunidad.idEstadoOportunidad='xganada'
			pedidoInstance.oportunidad.idEtapa='posventa75'//LO CAMBIE DE 100 A 75 EL 31/10/2016
			pedidoInstance.oportunidad.fechaCierreReal=new Date()
			pedidoInstance.fechaApertura =new Date()
			
			pedidoInstance.trimestre=generalService.getTrim(pedidoInstance.fechaApertura)
		  
			if (oportunidadService.tieneRegistroFabricante('regmayibm',params.idOportunidad)){
				def xdest=[]
				String xparam=generalService.getValorParametro('regoportun')
				xdest=generalService.convertirEnLista(xparam)
			   String urlbase=generalService.getValorParametro('urlaplic')
			   def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
				String xasunto="Oportunidad No.: "+pedidoInstance.oportunidad.numOportunidad+" Cerrada como ganada"
				String xcuerpo="Enviado por: "+ usuarioAccede +"<br><br>Realice los cambios que apliquen en el Fabricante respectivo <br><br> Para ver el pedido hága click <a href='${urlbase}/oportunidad/show/${pedidoInstance.oportunidad.id}'> AQUI </a>"
				generalService.enviarCorreo(1,xdest,xasunto, xcuerpo)
			}
		}
		
	   
		// cambio en tipo de precio implica recalcular valor pedido
		def swcambio=0
		BigDecimal xvalorpedido
		   println "swcp=";println params.swcp
		if (pedidoInstance.isDirty('idTipoPrecio')){
			   def xcaso
			if (params.swcp=='1'){ // se quiere modificar precios de los productos  segun moneda
				if (params.idTipoPrecio=='pedtprec02') xcaso=1 else xcaso=2
					 pedidoService.convertirValorProductos(xcaso, pedidoInstance?.id,pedidoInstance?.trm)
			  }
			  
			  swcambio=1
			  xvalorpedido=pedidoService.valorPedido(pedidoInstance?.id.toString())
			 if (params.idTipoPrecio=='pedtprec02')
				pedidoInstance?.valorPedido=generalService.valorEnPesoTrm(xvalorpedido,pedidoInstance?.trm)
			  else
				pedidoInstance?.valorPedido=xvalorpedido
			 
		}
		// cambio en la TRM   implica recalcular valor pedido
		if (pedidoInstance.isDirty('trm')){
			println "Hey entre al cambio TRM"
			  swcambio=1
			  xvalorpedido=pedidoService.valorPedido(pedidoInstance?.id.toString())
			 if (params.idTipoPrecio=='pedtprec02') // En dolares
				pedidoInstance?.valorPedido=generalService.valorEnPesoTrm(xvalorpedido,pedidoInstance?.trm)
			  else
				pedidoInstance?.valorPedido=xvalorpedido
			 
		}
		 
		if (swcambio==1){
		   if (pedidoInstance.oportunidad?.id )
			   if (params.idTipoPrecio=='pedtprec01')  // valor oportunidsd siempre esta en dolares
				  {
					  pedidoInstance.oportunidad.valorOportunidad=generalService.valorEnDolarTrm(xvalorpedido,pedidoInstance?.trm)
					  println "El nuevo valor de la oportunidad es....."+pedidoInstance.oportunidad.valorOportunidad
				  }
			   else
				 pedidoInstance.oportunidad.valorOportunidad=pedidoInstance?.valorPedido
		}
//------------------CAMPOS PARA NOTIFICACION CUENTA DE COBRO JDMAURY
					
		def sucursal=Empresa.get(params.idSucursal)
		def parametro=sucursal.iniciales+"ctaco"

		
//------------------CAMPOS PARA NOTIFICACION REQUIERE POLIZAS JDMAURY
		def parametroPoliza=sucursal.iniciales+"poliza"
		println "PARAM CUENTA POLIZA   ->"+parametroPoliza

//------------------CAMPOS PARA NOTIFICACION REQUIERE POLIZAS JDMAURY
 
				
		
		pedidoInstance.save(flush:true ,failOnError: true)
		

		
//JDMAURY 12/08/16
//------------------CAMPOS PARA REGISTRAR LA CREACION DE PEDIDO EN LOG
		auditoriaService.logIn('Pedido',pedidoInstance?.id)
		println "creado pedido Log"
//------------------CAMPOS PARA REGISTRAR LA CREACION DE PEDIDO EN LOG
		
		//todo crear aqui notificacion a para servicios redsis a ingenieria (Marlon Neira), crear en lista parametros correos varios
		//------------NOTIFICAR si tiene servicios redsis-------------------------JDCASTRO (Mayo 2019)
		if(pedidoInstance.handOff=='S'){
			println "Servicios Redsis activado (S)"
			generalService.notificarServicioRedsisUpdate(pedidoInstance.numPedido)
			println "Correo enviado a ingenieria!"

			log.info("Pedido ${pedidoInstance.numPedido} con servicios redsis.")

		}

		
		//-----------JOSE DANIEL MAURY 18/07/2016
		
		//Agregamos un registro de seguimiento cuando el pedido es creado
		def campos=[]
		campos[0]=pedidoInstance.numPedido //numero Pedido
		campos[1]=pedidoInstance.nombreCliente //nombre Cliente
		String xentidad='pedido'
		String xpadre= pedidoInstance.id
		def autor = generalService.getIdEmpleado(session['idUsuario'].toLong())
		String urlbase=generalService.getValorParametro('urlaplic')
		
		if(pedidoInstance.notificarCuentaCobro=='S')
		{
			def notaexiste=Nota.findWhere(idEntidad:pedidoInstance.id,idTipoNota:"notactaco")
			//println "numPedido-> "+pedido
			if(!notaexiste)
			{
				String xtipo='notactaco'
				String xnota="Notificación para creación cuenta de cobro al pedido"
				String asunto="Notificación de cuenta de cobro - Pedido: ${campos[0]} - ${campos[1]}"//numPedido - Empresa
				String body="Elaboraci&oacute;n cuenta de cobro para el pedido: ${campos[0]} - ${campos[1]}<br><br>Haga clic <a href=${urlbase}/pedido/show/${xpadre}>aqui</a>"
				generalService.registrarNotaEnPedido(autor,xentidad,xpadre.toString(),xtipo,xnota,parametro,asunto,body)
			}
		}
		
		
		
		if(pedidoInstance.requierePolizas=='S')
		{
			def notaexiste=Nota.findWhere(idEntidad:pedidoInstance.id,idTipoNota:"notapoliza")
			//println "numPedido-> "+pedido
			if(!notaexiste)
			{
				String xtipo='notapoliza'
				String xnota="Notificación para creación póliza al pedido"
				String asunto="Notificación de poliza - Pedido: ${campos[0]} - ${campos[1]}"//numPedido - Empresa
				String body="El siguiente pedido: ${campos[0]} para el cliente:  ${campos[1]}<br>requiere p&oacute;lizas y usted figura como responsable de su elaboraci&oacute;n y gestion<br><br>P&oacute;liza:<br>Descripci&oacute;n:<br>${pedidoInstance.descPolizas}<br><br>Para mas detalles haga clic <a href=${urlbase}/pedido/show/${xpadre}>aqui</a>"
				generalService.registrarNotaEnPedido(autor,xentidad,xpadre.toString(),xtipo,xnota,parametroPoliza,asunto,body)
			}

		}

		//-----------JOSE DANIEL MAURY 18/07/2016

		pedidoService.crearAnexos(listaAnexos,pedidoInstance?.id) // crea los anexos pertinentes
		if (params.swgenerar=='S' ){ // viene de oportunidad
			// copiar anexo propuesta aprob cliente de oportunidades a  Anexo pedids pedidos
			def idop=pedidoInstance?.oportunidad?.id
			def query="""select a.nombreArchivo from  Anexo a, Propuesta p
                         where  a.idEntidad=p.id and  
                                p.oportunidad.id=${idop} and 
                                a.nombreEntidad='propuesta' and 
                                a.idTipoAnexo='anexo03' and 
                                a.eliminado=0 and p.eliminado=0
                                order by p.fecha desc """ 
			def xnoms=Anexo.executeQuery(query)
			
			if (xnoms[0]){
				def anexoInstance=new Anexo()
				anexoInstance.idEntidad=pedidoInstance.id
				anexoInstance.nombreEntidad='pedido'
				anexoInstance.idTipoAnexo='anexo03'
				anexoInstance.nombreArchivo= xnoms[0]
				anexoInstance.fechaCreacion=new Date()
				anexoInstance.idEstadoAnexo='genactivo'
				anexoInstance.eliminado=0
				anexoInstance.save failOnError: true
			}
		}
		
		
		
		redirect  url:"/pedido/show/"+pedidoInstance.id
		flash.message="Pedido actualizado exitosamente"
	}

	@Transactional // delete
	def delete(Pedido pedidoInstance) {

		if (pedidoInstance == null) {
			notFound()
			return
		}

		pedidoInstance.delete flush: true

		request.withFormat {
			form {
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'Pedido.label', default: 'Pedido'), pedidoInstance.id])
				redirect action: "index", method: "GET"
			}
			'*' { render status: NO_CONTENT }
		}
	}

	protected void notFound() {
		request.withFormat {
			form {
				flash.warning = message(code: 'default.not.found.message', args: [message(code: 'pedidoInstance.label', default: 'Pedido'), params.id])
				redirect action: "index", method: "GET"
			}
			'*' { render status: NOT_FOUND }
		}
	}
	
	@Transactional   //generar Pedido
	def generarPedido(Pedido pedidoInstance){
	   
	   /* def query="select count(p) from Pedido p where p.oportunidad.id=${params.id} and p.eliminado=0"
		def cantpedidos=Pedido.executeQuery(query)
		
		if (cantpedidos[0] > 0) {
			flash.message = "Pedido ya fue generado.Verifique"
			redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
			return
		}*/
		pedidoInstance=new Pedido()
		def  oportunidadInstance=Oportunidad.get(params.long('id'))
		
		//pedidoInstance.dirDespacho=oportunidadInstance?.empresa?.direccion
		
		//pedidoInstance.dirEntregaFactura=oportunidadInstance?.empresa?.direccion
		
		pedidoInstance.oportunidad=oportunidadInstance
	   
		pedidoInstance?.oportunidad?.prospecto?.evolucion='GA'
 
		pedidoInstance.persona=oportunidadInstance.persona
			   
		pedidoInstance.empleado=oportunidadInstance.empleado
				
		pedidoInstance.idSucursal=oportunidadInstance.idSucursal
   
		pedidoInstance.idEstadoPedido="pedenelab1"

		//------------NOTIFICAR si tiene servicios redsis al momento de crear el nuevo pedido a partir de la oportunidad-------------------------JDCASTRO (Mayo 2019)
		if(pedidoInstance.handOff=='S'){
			println "Servicios Redsis activado (S)"
			generalService.notificarServicioRedsis(pedidoInstance.numPedido)
			//println "Correo enviado al señor Marlon!"

			log.info("Pedido ${pedidoInstance.numPedido} con servicios redsis.")

		}
	   
		respond pedidoInstance, model:[sw:1,xidempresa:oportunidadInstance.empresa.id,xidpos:params.id,swgenerar:'S']
	}
	
	def anularPedido(){
		
		def pedList=new ArrayList()
		if(params.idPed)
			pedList.addAll(params.idPed)
		else
		{
			if(params?.pedidos !=null)
			pedList.addAll(params?.pedidos)
		}
		if (pedList?.size()==1)
		{
			def pedidoInstance=Pedido.get(pedList[0])
			if (pedidoInstance?.idEstadoPedido in ['pedenelab1','pedenrevi2','pedpencom3'])
			
			{
				
				render view :'anularPedido', model:[pedidoInstance:pedidoInstance]
			}
				
			else
			{
				flash.warning="En este estado pedido no puede anularse .Verifique"
				redirect url:"/pedido/index?sort=fechaApertura&order=desc"
				return
			}
		}
		else
		{
			 flash.warning = message(code: 'default.select.one')
			 redirect url:"/pedido/index?sort=fechaApertura&order=desc"
			 return
		}

			   
	}
   
	def anularPedidoDef(Pedido pedidoInstance){
		
		def creadorPedidoLogId=EncLog.executeQuery("Select el.usuario.empleado.id from EncLog as el where el.idEntidad=${pedidoInstance.id} and el.idTipoLog='enclogcrea' and el.nomEntidad='Pedido'")
		def correoCreador=generalService.traerCorreoEmpleado(creadorPedidoLogId[0])
		def correoVendedor=generalService.traerCorreoEmpleado(pedidoInstance.empleado.id.toLong())
		
		pedidoInstance.idEstadoPedido='pedanuladx'
		pedidoInstance.save()
		
		def notificarA
		
		if(correoCreador!=null)
		notificarA=correoCreador+","+correoVendedor
		else
		notificarA=correoVendedor
		
		log.info("Usuarios notificados al anular este pedido "+notificarA)
		
		def listadest=generalService.convertirEnLista(notificarA)
		def numpedido=pedidoInstance.numPedido
		
		def empresaPedido=pedidoInstance.empresa.razonSocial
		
		String asunto="PEDIDO ANULADO - No. ${numpedido} - ${empresaPedido}"
		def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
		String urlbase=generalService.getValorParametro('urlaplic')
		
		String cuerpo="El pedido ha sido anulado. Se envía este mensaje para su información. <br>Para mas detalles haga clic <a href='${urlbase}/pedido/show/${pedidoInstance.id}'> AQUI </a>"
		
		generalService.enviarCorreo(1,listadest,asunto,cuerpo)
		
		flash.message="Pedido Anulado exitosamente"
		redirect url:"/pedido/index?sort=fechaApertura&order=desc"
	}
	
	def datosContacto(){
		redirect url:"/contacto/mostrarCboContacto/${params.id}"
	}

	def cambiarDestinatarioFactura(){
		def pedList=new ArrayList()
		if(params?.pedidos !=null){
			pedList.addAll(params?.pedidos)
			if (pedList?.size()>1) {
				flash.warning = message(code: 'default.select.one')
				redirect url:"/pedido/index?sort=fechaApertura&order=desc"
			}else {
				def pedidoInstance=Pedido.get(pedList[0])
				respond pedidoInstance
			}
		}else{
			flash.warning = message(code: 'default.select.one')
			redirect url:"/pedido/index?sort=fechaApertura&order=desc"
		}
	}

	@Transactional //cambiarDestinatarioFacturaDef
	def cambiarDestinatarioFacturaDef(Pedido pedidoInstance){
		pedidoInstance.save()
		flash.message="Cambio Destinatario de Factura realizado exitosamente"
		redirect url:"/pedido/index?sort=fechaApertura&order=desc"
	}

	def cambiarEstadoPedido(){
		def estadosList
		if (params.swv){ // cambiar estado dentro del pedido
			estadosList=ValorParametro.executeQuery("from ValorParametro where idValorParametro  in ('pedpenfac2','pedfacpar2','pedfacturx') and estadoValorParametro='A' and eliminado=0")
			def pedidoInstance=Pedido.get(params.id.toLong())
			respond pedidoInstance,model:[estadosList:estadosList]
			return
		}
	   
		if (params.swc=='0')
		  estadosList=ValorParametro.executeQuery("from ValorParametro where idParametro='estapedido' and eliminado=0 and estadoValorParametro='A' order by valor")
		 else
		  estadosList=ValorParametro.executeQuery("from ValorParametro where idValorParametro  in ('pedpenfac2','pedfacpar2','pedfacturx') and estadoValorParametro='A' and eliminado=0")
		
		def pedList=new ArrayList()
		if(params?.pedidos !=null){
			pedList.addAll(params?.pedidos)
			if (pedList?.size()>1) {
				flash.warning = message(code: 'default.select.one')
				redirect url:"/pedido/index?sort=fechaApertura&order=desc"
			}else{
				def pedidoInstance=Pedido.get(pedList[0])
				respond pedidoInstance,model:[estadosList:estadosList]
			}
		}else{
			flash.warning = message(code: 'default.select.one')
			redirect url:"/pedido/index?sort=fechaApertura&order=desc"
		}
   
	}
	
	@Transactional //cambiarEstadoPedidoDef
	def cambiarEstadoPedidoDef(Pedido pedidoInstance){
		pedidoInstance.save()
		
		/*def estadodelPedido=pedidoInstance.idEstadoPedido
		if(estadodelPedido=='peddetcomp')//SI EL PEDIDO SE PASA A DETENIDO EN COMPRAS SE PROCEDE A ENVIAR CORREO
		{
			String asunto=""
			String mensaje=""
			
			
			generalService.enviarCorreo(1, null, message, message)
		}*/
		
		
		flash.message="Cambio de estado del pedido realizado exitosamente"
		redirect url:"/pedido/index?sort=fechaApertura&order=desc"
	}

	def cambiarOportunidad(){
		def pedList=new ArrayList()
		if(params?.pedidos !=null){
			pedList.addAll(params?.pedidos)
			if (pedList?.size()>1) {
				flash.warning = message(code: 'default.select.one')
				redirect url:"/pedido/index?sort=fechaApertura&order=desc"
			}else{
				def pedidoInstance=Pedido.get(pedList[0])
				respond pedidoInstance
			}
		}else{
			flash.warning = message(code: 'default.select.one')
			redirect url:"/pedido/index?sort=fechaApertura&order=desc"
		}
	}

	@Transactional
	def cambiarOportunidadDef(Pedido pedidoInstance){
		pedidoInstance.save()
		flash.message="Cambio de Oportunidad realizado exitosamente"
		redirect url:"/pedido/index?sort=fechaApertura&order=desc"
	}

	def CambiarVendedor(){
		def pedList=new ArrayList()
		if(params?.pedidos !=null){
			pedList.addAll(params?.pedidos)
			if (pedList?.size()>1) {
				flash.warning = message(code: 'default.select.one')
				redirect url:"/pedido/index/"
			}else{
				def pedidoInstance=Pedido.get(pedList[0])
				def vendedoresList=Empleado.executeQuery("from Empleado where id !=${pedidoInstance.empleado?.id} and idTipoEmpleado='pervendedo' and  idEstadoEmpleado='empleactiv' and eliminado=0")
				respond pedidoInstance,  model:[vendedoresList:vendedoresList]
			}
		}else{
			flash.warning = message(code: 'default.select.one')
			redirect url:"/pedido/index?sort=fechaApertura&order=desc"
		}
	}

	@Transactional  //cambiarVendedorDef
	def cambiarVendedorDef(Pedido pedidoInstance){
	 
		if(params.idVendedor != null){
			pedidoInstance.empleado=Empleado.get(params.idVendedor.toLong())
		}
		 
		pedidoInstance.save()
		String urlbase=generalService.getValorParametro('urlaplic')
		def xiddestinatarios=[pedidoInstance.empleado?.id,pedidoInstance.idVendedorAnterior ]
		def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
		
		String xasunto="Notificación  cambio de Ejecutivo de cuenta para el pedido :${pedidoInstance.numPedido}"
		String xcuerpo="Enviado por: "+usuarioAccede+"<br><br>Nuevo Ejecutivo de Cuenta  para el <a href='${urlbase}/pedido/show/${pedidoInstance.id}'> PEDIDO </a> de la referencia :<br>"+
					"Ejecutivo de Cuenta Anterior :${Empleado.get(pedidoInstance.idVendedorAnterior)}"
		generalService.enviarCorreo(0,xiddestinatarios,xasunto, xcuerpo)

   
		flash.message="Cambio de venddor y notificaciones respectivas realizadas"
		redirect url:"/pedido/index?sort=fechaApertura&order=desc"
		
	}
	
	@Transactional //enviarARevision
	def enviarARevision(){
		
		def falla
		def pedidoInstance
		def pedidoDentroId=params.list('pedidos')[0]
		if(params.id)
		{
			falla=pedidoService.validarPedido(params.id)
			pedidoInstance=Pedido.get(params.id)
		}
		else
		{	if(params.list('pedidos').size()!=1)
			{
				
				flash.warning = message(code: 'default.select.one')
				redirect url:"/pedido/index?sort=fechaApertura&order=desc"
				return
			}
			else
			{
				falla=pedidoService.validarPedido(pedidoDentroId)
				pedidoInstance=Pedido.get(pedidoDentroId)
				
				if(pedidoInstance.idEstadoPedido!='pedenelab1')
				{
					
					flash.warning="Para enviar a revisión el pedido debe estar en elaboración"
					redirect url:"/pedido/index?sort=fechaApertura&order=desc"
					return
				}
			}
		}


		if (falla !=0 ){
			if (falla==1) flash.warning="Antes de enviar a Revisión debe ingresar al menos un Producto"
			if (falla==2) flash.warning="Antes de enviar a Revisión debe anexar  inf. cliente nuevo Verifique"
			if (falla==3) flash.warning="Antes de enviar a Revisión debe anexar doc Hand-Off. Verifique"
			if (falla==4) flash.warning="Antes de enviar a Revisión debe anexar aprobación de nexsys. Verifique"
			if (falla==5) flash.warning="Antes de enviar a Revisión debe anexar aprobación Ibm. Verifique"
			if (falla==6) flash.warning="Antes de enviar a Revisión debe anexar propuesta de Servicios IBM. Verifique"
			if (falla==7) flash.warning="Antes de enviar a Revisión debe anexar OC del Cliente o contrato. Verifique"
			if (falla==8) {
				flash.warning="Debe anexar propuesta aprobada x cliente.HÃ¡galo"
				flash.link="<a href='#'>AquÃ­</a>"
			}
			redirect url:"/pedido/show/${params.id?:pedidoDentroId}"
			return
		}
	
		pedidoInstance.idEstadoPedido='pedenrevi2'
		pedidoInstance.save()
		
		log.info("Valor anterior de oportunidad para el pedido ${pedidoInstance?.numPedido}: ${pedidoInstance?.oportunidad?.valorOportunidad}")
		//-------------------------------ACA PARA ACTUALIZAR EL VALOR DE LA OPORTUNIDAD SEGUN EL PEDIDO
		
		def valorActualizado=pedidoInstance?.valorPedido/pedidoInstance?.trm
		pedidoInstance?.oportunidad?.valorOportunidad=valorActualizado
		log.info("Nuevo valor de oportunidad para el pedido ${pedidoInstance?.numPedido}: ${valorActualizado}")
		
		
		
		//-------------------------------ACA PARA ACTUALIZAR EL VALOR DE LA OPORTUNIDAD SEGUN EL PEDIDO
		
		println "PARAMS ENVIADO A REVISION "+params
		
		println "ID DEL CLIENTE ES... "+pedidoInstance.empresa.id
		

		def xdest=[]
		String xparam=generalService.getValorParametro('enccompras')
		xdest=generalService.convertirEnLista(xparam)
		String urlbase=generalService.getValorParametro('urlaplic')
		def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
		String xasunto="Notificación: Pedido No."+pedidoInstance.numPedido+" para  su Revisión"
		String xcuerpo="<b>Enviado por: </b>"+usuarioAccede+"<br><br>Favor Procesar Pedido <a href='${urlbase}/pedido/show/${pedidoInstance.id}'> AQUI </a>"
		
		//-------------------------------CAMBIO PARA INDICAR Y NOTIFICAR QUE EL PEDIDO ES DE MARIOHABIB
		
		
		def listaIdEmpresas=generalService.getValorParametro('idMHabib').toString().split(",")//IDs de empresas asociadas a Mario Habib
		def empresaMHabib=Arrays.asList(listaIdEmpresas).contains(pedidoInstance.empresa.id.toString())
		
		if(empresaMHabib)//SI EL CLIENTE ASOCIADO AL PEDIDO PERTENECE A LOS IDS DE LOS CLIENTES DE MARIO HABIB..
		{	
		   def cliente=pedidoInstance.empresa.razonSocial
		   def proyecto=pedidoInstance?.oportunidad?.nombreOportunidad?:'No tiene'
		   def descProyecto=pedidoInstance?.oportunidad?.descOportunidad?:'No tiene'
		   xasunto="IMPORTANTE - Notificación: Pedido MARIO HABIB No. "+pedidoInstance.numPedido+" para  su Revisión"			
		   xcuerpo="<b>Enviado por: </b>"+usuarioAccede+"<br><b>Cliente: </b>${cliente}<br><b>Proyecto: </b>${proyecto}<br><b>Detalles proyecto: </b>${descProyecto}<br><br>Favor procesar pedido <a href='${urlbase}/pedido/show/${pedidoInstance.id}'> AQUI </a>"
		}
		
		//-------------------------------CAMBIO PARA INDICAR Y NOTIFICAR QUE EL PEDIDO ES DE MARIOHABIB
		
		generalService.enviarCorreo(1,xdest,xasunto, xcuerpo)

		
//----------------NOTIFICAR ARQUITECTO DE SOLUCIONES-------------------------
		if(pedidoInstance.arquitectoSol=='S')
		{
			List listaArqui=new ArrayList<String>(Arrays.asList(pedidoInstance.listaArquitectos.split(",")));//
			generalService.notificarArquitectos(listaArqui,pedidoInstance.numPedido)
			log.info("Lista de arquitectos ${listaArqui} notificados para el pedido ${pedidoInstance.numPedido}")
		}		
//----------------NOTIFICAR ARQUITECTO DE SOLUCIONES-------------------------

// ----------------NOTIFICAR GERENTE DE PROYECTOS----------------------------JDCASTRO
		if(pedidoInstance.gerenteProye=='S')
		{
			println "Check gerente proyecto activado"
			String proyecto=pedidoInstance.oportunidad.nombreOportunidad
			def query=ValorParametro.where{idValorParametro=="gerproye01"}
			def correo=[query.find().descValParametro?:'auditorcorreocrm@redsis.com']

			println "preparando correo al Gerente " + correo
			//gproy.add(correo)

			String asunto="Asignar Gerente de Proyecto al pedido ${pedidoInstance.numPedido} - ${pedidoInstance.nombreCliente}"
			String masInfo="Para visualizar el pedido o realizar seguimientos al mismo haga clic <a href='${urlbase}/pedido/show/${pedidoInstance.id}'> AQUI </a>"
			String cuerpo="<b>Cliente: </b>${pedidoInstance.nombreCliente}<br><b>Proyecto: </b>${proyecto}<br><b>Valor: </b>${pedidoInstance.valorPedido} <br><br>${masInfo}" +
					"<br><br>Asignar Gerente <a href='${urlbase}/pedido/modificaGerenteProye/${pedidoInstance.id}'>AQUI</a>"
			generalService.enviarCorreo(1,correo,asunto,cuerpo)
			println "Correo enviado al Gerente Proyecto!"

			//List listaGProye=new ArrayList<String>(Arrays.asList(pedidoInstance.listaGerenteProye.split(",")));//
			//generalService.notificarArquitectos(listaGProye,pedidoInstance.numPedido)
			log.info("Lista de Gproyectos ${correo} notificados para el pedido ${pedidoInstance.numPedido}")
		}
//----------------NOTIFICAR GERENTE DE PROYECTO-------------------------

//--------------------NOTIFICAR si tiene servicios redsis-------------------------JDCASTRO (Mayo 2019)
		if(pedidoInstance.handOff=='S'){
			println "Servicios Redsis activado (S)"
			generalService.notificarServicioRedsisUpdate(pedidoInstance.numPedido)
			println "Correo enviado al señor Marlon!"

			log.info("Pedido ${pedidoInstance.numPedido} con servicios redsis notificado a ingenieria.")

		}


//----------------NOTIFICAR ENERGIA Y CONECTIVIDAD A ANTONIO JOSE-------------------------JDCASTRO (abril 2019)
		if(pedidoInstance.eyc=='S'){
			println "Check Energia y conectividad en si"
			generalService.notificarGEyC(pedidoInstance.numPedido)
			println "Correo enviado al Gerente de EyC!"

			log.info("Pedido de Energia y Conectividad, notificando para el pedido ${pedidoInstance.numPedido}")

		}

//----------------NOTIFICAR ENERGIA Y CONECTIVIDAD A ANTONIO JOSE-------------------------

		flash.message="Pedido enviado y notificado al área financiera"
		redirect url:"/pedido/index?sort=fechaApertura&order=desc"
	}
	
   
	
	def devolverAVendedor(){
		
		def notaInstance=new Nota()
		notaInstance.idEntidad=params.ident.toLong()
		notaInstance.nombreEntidad='pedido'
		notaInstance.idTipoNota='notadevolu'
		def pedidoInstance=Pedido.get(params.long('ident'))
		
		
		
		def creadorPedidoLogId=EncLog.executeQuery("Select el.usuario.empleado.id from EncLog as el where el.idEntidad=${pedidoInstance.id} and el.idTipoLog='enclogcrea' and el.nomEntidad='Pedido'")
		def correoCreador=generalService.traerCorreoEmpleado(creadorPedidoLogId[0])
		def correoVendedor=generalService.traerCorreoEmpleado(pedidoInstance.empleado.id.toLong())
		
		if(correoCreador)
		notaInstance.funcionariosNotificados=correoCreador+","+correoVendedor
		else
		notaInstance.funcionariosNotificados=correoVendedor
		
		
		
		
		
		//notaInstance.funcionariosNotificados=generalService.traerCorreoEmpleado(pedidoInstance.empleado.id.toLong())
		String xtitulo="Comentarios Devolución de Pedido"
		render view :"devolverPedido", model:[notaInstance:notaInstance,xtitulo:xtitulo]
		
	 }
	  @Transactional //devolverAVendedor
	   def devolverAVendedorDef(){
	   
	   def notaInstance=new Nota(params)
	   notaInstance.save()
		
	   def pedidoInstance=Pedido.get(params.long('idEntidad'))
	   pedidoInstance.idEstadoPedido='pedenelab1'
	   pedidoInstance.save()
	   
	   println "El id de este pedido es ..-----> "+pedidoInstance.id
	   
	   //pedidoService.actualizarEstadoDetPedido(pedidoInstance.id)//actualizar el estado de los detPedidos..a 'En elaboracion'
	   
	   def xdest=generalService.convertirEnLista(params.funcionariosNotificados)
	   //xdest+= pedidoInstance.empleado?.id
	   
		String xasunto="Notificación: Devolución  del Pedido No."+pedidoInstance.numPedido+" para  su corrección"
		String urlbase=generalService.getValorParametro('urlaplic')
		def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
	   
		String xcuerpo="Enviado por: "+usuarioAccede+"<br><br><b>Observaciones: </b>${params.nota}<br><br>Favor realizar las correcciones pertinentes al pedido <a href='${urlbase}/pedido/show/${pedidoInstance.id}'> AQUI </a>"
		generalService.enviarCorreo(1,xdest,xasunto, xcuerpo)
	   flash.message="Pedido devuelto y notificado a Vendedor"
	   redirect url:"/pedido/index?sort=fechaApertura&order=desc&estado=2"
	}
	
	@Transactional //asignarACompras
	def asignarACompras(){
		def  pedidoInstance=Pedido.get(params.id)
		pedidoInstance.idEstadoPedido='pedpencom3'
		pedidoInstance.save()
		
		pedidoService.setEstadoProductos(params.id.toLong(),'peddetpd01')  // productos pasan a compras
		
		def xdest=[]

		if(pedidoInstance.eyc=='S'){
			String xparam=generalService.getValorParametro('compraEyC')
			xdest=generalService.convertirEnLista(xparam)
			String urlbase=generalService.getValorParametro('urlaplic')
			def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
			String xasunto="Notificación: Iniciar compra de productos del Pedido No."+pedidoInstance.numPedido+" - ${pedidoInstance.nombreCliente}"
			String xcuerpo="<b>Enviado por:</b> "+usuarioAccede+"<br><b>Detalles:</b> ${pedidoInstance?.oportunidad?.nombreOportunidad}<br><br>Favor realizar las compras de productos asociados al pedido de la referencia <a href='${urlbase}/pedido/show/${pedidoInstance.id}'> AQUI </a>"
			generalService.enviarCorreo(1,xdest,xasunto, xcuerpo)
			flash.message="Pedido asignado  y notificado a compras cableado"
			redirect url:"/pedido/index?sort=fechaApertura&order=desc&estado=2"
		}else{

			String xparam=generalService.getValorParametro('compradore')
			xdest=generalService.convertirEnLista(xparam)
			String urlbase=generalService.getValorParametro('urlaplic')
			def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
			String xasunto="Notificación: Iniciar compra de productos del Pedido No."+pedidoInstance.numPedido+" - ${pedidoInstance.nombreCliente}"
			String xcuerpo="<b>Enviado por:</b> "+usuarioAccede+"<br><b>Detalles:</b> ${pedidoInstance?.oportunidad?.nombreOportunidad}<br><br>Favor realizar las compras de productos asociados al pedido de la referencia <a href='${urlbase}/pedido/show/${pedidoInstance.id}'> AQUI </a>"
			generalService.enviarCorreo(1,xdest,xasunto, xcuerpo)
			flash.message="Pedido asignado  y notificado a compras"
			redirect url:"/pedido/index?sort=fechaApertura&order=desc&estado=2"
		}

	}
	
	def aplicarDescuento(){
		def pedList=new ArrayList()
		if(params?.pedidos !=null){
			pedList.addAll(params?.pedidos)
			if (pedList?.size()>1) {
				flash.warning = message(code: 'default.select.one')
				redirect url:"/pedido/index?sort=fechaApertura&order=desc"
			}else{
				def pedidoInstance=Pedido.get(pedList[0])
				respond pedidoInstance
			}
		}else{
			flash.warning = message(code: 'default.select.one')
			redirect url:"/pedido/index?sort=fechaApertura&order=desc"
		}
	}
	
	@Transactional //aplicarDescuentoDef
	def aplicarDescuentoDef(Pedido pedidoInstance){
		
		pedidoInstance.save()
		flash.message="Descuento registrado exitosamente"
		redirect url:"/pedido/index?sort=fechaApertura&order=desc"
		
	}
	
	@Transactional //cerrarPedido
	def cerrarPedido(){
		def pedidoInstance=Pedido.get(params.id)
		String query
		/* Numero de Facturas del pedido */
		query="select count(f) from Factura f  where pedido.id=${params.id} and eliminado=0"
		def num=Factura.executeQuery(query)
		if (num[0]> 0) {
			pedidoInstance?.idEstadoPedido='pedfacturx'
			pedidoInstance.save()
			flash.message="Pedido Cerrado Exitosamente"
		}else {
			flash.warning="Antes de Cerrar pedido debe agregar Facturas. Verifique"
		}
		redirect url:"/pedido/index?sort=fechaApertura&order=desc&estado=2"
	}

	def autorizarCambioPedido(){
		def pedidoInstance=Pedido.get(params.id)
		render view:"autorizarPedido", model:[pedidoInstance:pedidoInstance]
	}
	def modificaGerenteProye(){
		def pedidoInstance=Pedido.get(params.id)
		render view:"modificaGProyecto", model:[pedidoInstance:pedidoInstance]
	}
	@Transactional  //modificaGerenteProyeDef
	def modificaGerenteProyeDef(Pedido pedidoInstance){
		String urlbase=generalService.getValorParametro('urlaplic')
		String proyecto=pedidoInstance.oportunidad.nombreOportunidad
		pedidoInstance.listaGerenteProye=params.gproyec
		//println "Gerente Proyecto asignado " +  pedidoInstance.listaGerenteProye
		pedidoInstance.save()
		def query=ValorParametro.where{idValorParametro==params.gproyec}
		def correo=[query.find().descValParametro?:'auditorcorreocrm@redsis.com']

		String asunto="Usted a sido asignado como Gerente de Proyecto al pedido ${pedidoInstance.numPedido} - ${pedidoInstance.nombreCliente}"
		String masInfo="Para visualizar el pedido o realizar seguimientos al mismo haga clic <a href='${urlbase}/pedido/show/${pedidoInstance.id}'> AQUI </a>"
		String cuerpo="<b>Cliente: </b>${pedidoInstance.nombreCliente}<br><b>Proyecto: </b>${proyecto}<br><b>Valor: </b>${pedidoInstance.valorPedido} <br><br>${masInfo}" +
				"<br><br>Asignar Gerente <a href='${urlbase}/pedido/modificaGerenteProye/${pedidoInstance.id}'>AQUI</a>"
		generalService.enviarCorreo(1,correo,asunto,cuerpo)
		flash.message="el gerente de proyecto fue agregado correctamente al pedido"
		redirect url:"/pedido/index?sort=fechaApertura&order=desc"
	}
	
	@Transactional  //autorizarCambioPedidoDef
	def autorizarCambioPedidoDef(Pedido pedidoInstance){
		pedidoInstance.idAutorizado=params.long('idEmpleado')
		pedidoInstance.save()
		flash.message="Pedido ha sido autorizado para ser modificado"
		redirect url:"/pedido/index?sort=fechaApertura&order=desc"
	}
	
	 @Transactional  //resetCambioPedido
	def resetCambioPedido(){
		def pedidoInstance=Pedido.get(params.long('id'))
		pedidoInstance.idAutorizado=null
		pedidoInstance.save()
		flash.message="Autorizacion de cambio ha sido reseteada exitosamente"
		redirect url:"/pedido/index?sort=fechaApertura&order=desc"
	}
	
	@Transactional  // facturacionParcial
	def facturacionParcial(){
		def pedidoInstance=Pedido.get(params.id)
		String query
		/* Numero de Facturas del pedido */
		query="select count(f) from Factura f  where pedido.id=${params.id} and eliminado=0"
		def num=Factura.executeQuery(query)
		if (num[0]> 0) {
			pedidoInstance?.idEstadoPedido='pedfacpar2'
			pedidoInstance.save()
			flash.message="Pedido Facturado Parcialmente"
		}else {
			flash.warning="Antes de Cambiar estado  debe agregar Facturas. Verifique"
		}
		redirect url:"/pedido/index?sort=fechaApertura&order=desc&estado=2"
	}
	  
	def moverPedido(){
		
		def prodList=new ArrayList()
		if(params?.pedidos !=null){
			prodList.addAll(params?.pedidos)
			if (prodList?.size()>1) {
				flash.warning = message(code: 'default.select.one')
					redirect url:"/pedido/index?sort=fechaApertura&order=desc"
			}
			else {
				def pedidoInstance=Pedido.get(prodList[0])
				respond pedidoInstance
			}
		}else{
			flash.warning = message(code: 'default.select.one')
			 redirect url:"/pedido/index?sort=fechaApertura&order=desc"
		}
	}
	
	@Transactional // moverPedidoDef
	def moverPedidoDef(Pedido pedidoInstance){
		pedidoInstance.oportunidad=Oportunidad.get(params.idOportunidad)
		pedidoInstance.save()
		flash.message="Movimiento realizado. Consulte el pedido respectivo "
		redirect url:"/pedido/index?sort=fechaApertura&order=desc"
	}
	
	@Transactional
	def actualizarIndicadores(){
   
		def idvendedor=params.id.toLong()
		
		pedidoService.totalesPorPeriodoAll(idvendedor,'M','pedido')
		pedidoService.totalesPorPeriodoAll(idvendedor,'Q','pedido')
		pedidoService.totalesPorPeriodoAll(idvendedor,'M','prospecto')
		pedidoService.totalesPorPeriodoAll(idvendedor,'Q','prospecto')
		pedidoService.totalesPorPeriodoAll(idvendedor,'M','oportunidad')
		pedidoService.totalesPorPeriodoAll(idvendedor,'Q','oportunidad')
		
		//modificaciones MQ 06/03/2015
		  // generaciÃ³n de indicador para oportunidades generadas por el vendedor en el Q
		 oportunidadService.totalOpttyGeneradas(idvendedor)
		 oportunidadService.totalOpttyAsignadas(idvendedor)
		 oportunidadService.totalOpttyPerdidas(idvendedor)
		 pedidoService.totalPedidosFacturadosQ(idvendedor)
		
		// moficaciones MQ 16/03/2015
		oportunidadService.totalOpttyGanadas(idvendedor)
		oportunidadService.totalOpttyForecast(idvendedor)
		generalService.getVendedores()
		redirect url:"/"
	}
	
	def vistaPedido(){
	   
	   def pedidoInstance=Pedido.get(params.id)
	   def xsucursal=Empresa.get(pedidoInstance.idSucursal)
	   def xformaPago=generalService.getValorParametro(pedidoInstance.idFormaPago)
	   def xpreciosEn=generalService.getValorParametro(pedidoInstance?.idTipoPrecio)
	   def xestado=generalService.getValorParametro(pedidoInstance?.idEstadoPedido)
	   def xfacturarEn=generalService.getValorParametro(pedidoInstance?.idMondedaFactura)
	   
		def xdireccionEmpresa
		def xnitEmpresa
		def xnitEmpresaFacturar                                                         //AGREGADO JD

		if (pedidoInstance?.empresaId){
		   xdireccionEmpresa=Empresa.get(pedidoInstance?.empresaId).direccion
		   xnitEmpresa = Empresa.get(pedidoInstance?.empresaId).nit
		   xnitEmpresaFacturar=Empresa.get(pedidoInstance?.idFacturarA).nit               //AGREGADO JD
		}else {
		   xdireccionEmpresa=''
		   xnitEmpresa=''
		}
		
		def xfacturarA
		if (pedidoInstance?.idFacturarA)
		   xfacturarA=Empresa.get(pedidoInstance?.idFacturarA).razonSocial
		  else
		   xfacturarA=''
		   
	   def xvalorpedido=0
	   def listaArqui=pedidoService.getArquitectosPedido(pedidoInstance?.id)
	   def xpoliza="N"
	   if (pedidoInstance?.requierePolizas=='S')
			xpoliza=pedidoInstance?.descPolizas
			
	   def xcampania="N"
	   if (pedidoInstance?.campaniaRedsis=='S')
		  xcampania=pedidoInstance?.descCampania
		
	   def xibm="N";def xdisp
	   if (pedidoInstance?.compraIbm=='S'){
		  xdisp=generalService.getValorParametro(pedidoInstance?.idProductoDisponible)
		  xibm=pedidoInstance?.numCliente
	   }
		def listaDef=[]
		if (pedidoInstance?.arquitectoSol=='S'){
			listaArqui.each(){
			   listaDef.add(generalService.getValorParametro(it))
		   }
	   }else
		   listaDef=['N']
			
			String ztrm=generalService.getValorParametro('trm')
			BigDecimal xtrm=new BigDecimal(ztrm)
			xtrm=pedidoInstance?.trm?:xtrm
	   if (pedidoInstance?.idTipoPrecio=='pedtprec02' && pedidoInstance?.valorPedido)
			 xvalorpedido=pedidoInstance?.valorPedido/xtrm
	   else
			 xvalorpedido=pedidoInstance?.valorPedido
	   
		def query="from DetPedido  where pedido.id=${params.id} and eliminado=0"
		def detPedidoInstanceList=DetPedido.findAll(query)
		  
		def xsubtotal=pedidoService.valorPedido(params.id)
		def xdescuento=pedidoInstance?.descuentoPedido?:0
		def xiva=0.16*(xsubtotal-xdescuento)
		
		//-------------------------------------CORRECCION TOTAL-------------------------------
		
		def anioPedido=pedidoInstance.numPedido.toString().split("-")[2]
		println "Anio pedido:________________________________________________"+ anioPedido
		if(anioPedido=="17"||anioPedido=="18"||anioPedido=="19")
			xiva=0.19*(xsubtotal-xdescuento)		
			
		def listaPed16Iva19=generalService.getValorParametro('ped16iva19').toString().split(",")			
		def listaPed17Iva16=generalService.getValorParametro('ped17iva16').toString().split(",")
		def listaPed18Iva16=generalService.getValorParametro('ped18iva16').toString().split(",")
		
		if(listaPed18Iva16.contains(pedidoInstance.numPedido))//Si el pedido actual se encuentra en la lista de casos especiales de 2018 con iva 16%
			xiva=0.16*(xsubtotal-xdescuento)
						
		if(listaPed17Iva16.contains(pedidoInstance.numPedido))//Si el pedido actual se encuentra en la lista de casos especiales de 2017 con iva 16%
			xiva=0.16*(xsubtotal-xdescuento)
				
		if(listaPed16Iva19.contains(pedidoInstance.numPedido))//Si el pedido actual se encuentra en la lista de casos especiales de 2016 con iva 19%
			xiva=0.19*(xsubtotal-xdescuento)


				
		//-------------------------------------CORRECCION TOTAL-------------------------------



		def xtotal=xsubtotal-xdescuento+xiva
		
		render view:"vistaPedido", model:[pedidoInstance:pedidoInstance,xsucursal:xsucursal,
										   xformaPago:xformaPago,xpreciosEn:xpreciosEn,xvalorpedido:xvalorpedido,
										   xfacturarEn:xfacturarEn,xfacturarA:xfacturarA,xestado:xestado,
										   listaDef:listaDef,xpoliza:xpoliza,xcampania:xcampania,
										   xibm:xibm,xdisp:xdisp,detPedidoInstanceList:detPedidoInstanceList,
										   xsubtotal:xsubtotal,xdescuento:xdescuento,xiva:xiva,xtotal:xtotal,
										   xdireccionEmpresa:xdireccionEmpresa,xnitEmpresa:xnitEmpresa,xnitEmpresaFacturar:xnitEmpresaFacturar]
		

	}
	
	def titulos(x){
		String resp
		   switch (x){
			case 'pedfacturx':
				 resp='pedidosfac'
				 break
			case 'pedanuladx' :
			  resp='pedidosanu'
			  break
			default :
			   resp='pedidosenp'
			  break
		}
		return resp
	}
	
	
	  def exportar(){ //todo revisar desde aca el colocar las observaciones en los export
		String ext
		 int  xcuantos =filterPaneService.count(session.filterParams, Pedido )
		 
		 if  (xcuantos ==0){
			  flash.warning="En el filtro anterior no se obtuvieron datos para exportar. Verifique"
			  redirect url:"/pedido/index/0?sort=fechaApertura&order=desc&estado=2"
			  return
		 }
		if (!params.id  in ['excel','json','xml']) {
			flash.message="Format de exportaciÃ³n no permitido.Verifique"
			return
		}
		
		if (params.id=='excel') ext='xls'
		else if (params.formato=='json')  ext='json'  else ext='xml'
		  
		response.contentType = grailsApplication.config.grails.mime.types[params.id]
		def posfijo= generalService.getHoy(1)
		 posfijo=posfijo.replaceAll(' ','-')
		 posfijo=posfijo.replaceAll(':','-')
		response.setHeader("Content-disposition", "attachment; filename=pedido${posfijo}.${ext}")
		 
		Map campos = ['1_Codigo':'numPedido',
					  '2_Cliente': 'nombreCliente',
					  '3_Valor_En_Pesos':'valorPedido',
					  '4_Fecha':'fechaApertura',
					  '5_Estado':'idEstadoPedido',
					  '6_Observaciones':'observacionesPedido']
		 
		Map formatters = [:]
		Map parameters = [:]
		def entidad="crm.Pedido"
		def query="select numPedido,nombreCliente,valorPedido, fechaApertura,idEstadoPedido from Pedidos where  eliminado=0"
		def datos=generalService.preExportar(entidad,query,campos,true)      //true filtrado false via query
		 exportService.export(params.id, response.outputStream,datos, formatters, parameters)
		
	}
	  
	  
	  def updateFilterLength()
	  {
		  filterList=params.clone()
		  filterList['max']=5000
		  filterList['offset']=0
		  pedidoInstanceList2=filterPaneService.filter(filterList, Pedido)//lista con base en el filtro
//		  params.max=10
	  }

	  def todosLosPedidos(Integer max)//TODOS EXCLUYENDO ANULADOS
	  {
		  
		  
		  int itemxview=generalService.getItemsxView(0)
		  params.max = 10
		  String  xoffset=params.offset?:0
		  
		  params.sort="fechaApertura"
		  params.order="desc"
		  
		  
		  println params
		  
		  if(!params.filter) params.filter = [op:[:],empleado:[:],factura:[:],empresa:[:],detpedido:[:]]
		  params.filter.op.eliminado = "Equal"
		  params.filter.eliminado='0'
		  
		  //params.filter.op.idEstadoPedido = "NotEqual"
		  //params.filter.idEstadoPedido='Anulado'
		  
		  if (params.filter.idSucursal)
			  params.filter.idSucursal=generalService.getIdSucursal(params.filter.idSucursal)
		  if(params.filter.idEstadoPedido ){
			
				params.filter.idEstadoPedido=generalService.getIdValorParametro('estapedido',params.filter.idEstadoPedido)
				
		 }
			  
			  println "PRUEBA ID ESTADO PEDIDO"+params.filter.idEstadoPedido
		  
		  def pedidoInstanceList=filterPaneService.filter(params, Pedido)
			updateFilterLength()
		  listaFiltro=pedidoInstanceList2
		  
		  //String subtotalpesos=calcularValor(pedidoInstanceList,1)//pesos
		  //String subtotaldolares=calcularValor(pedidoInstanceList,2)//dolares
		  String valortotalpesos=calcularValor(pedidoInstanceList2,1)//pesos
		  String valortotaldolares=calcularValor(pedidoInstanceList2,2)//dolares
		  
		  
		  
	  respond pedidoInstanceList,  model:[
			pedidoInstanceCount: filterPaneService.count( params, Pedido ),
			filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
			params:params, xtitulo:'Todos los pedidos',xtrm:2500,totalPesos:valortotalpesos,totalDolares:valortotaldolares]

			//params.max=10
		  
	  }
	
	
	def generarReporteFinanciera() {
		response.setContentType('application/vnd.ms-excel')
		response.setHeader('Content-Disposition', 'Attachment;Filename="Pedidos por estados.xls"')
		WritableWorkbook wworkbook = Workbook.createWorkbook(response.outputStream)
		WritableSheet wsheet = wworkbook.createSheet("Pedidos En Revision", 0);
	  
		def cf
		def cell
		
		//Estilos
		WritableFont boldTitulo = new WritableFont(WritableFont.ARIAL, WritableFont.DEFAULT_POINT_SIZE, WritableFont.BOLD)
		WritableFont bold = new WritableFont(WritableFont.ARIAL, 9, WritableFont.BOLD)
		WritableFont empresa = new WritableFont(WritableFont.ARIAL, 13, WritableFont.BOLD)
		
		wsheet.addCell(new Label(0, 0, "REPORTE DE PEDIDOS EN REVISION"))
		wsheet.mergeCells(0, 0, 7, 0)
		cell = wsheet.getWritableCell(0, 0)
		cf = new WritableCellFormat(empresa)
		cell.setCellFormat(cf)
		
		wsheet.addCell(new Label(10, 0, "Creado el dia"))
		cell = wsheet.getWritableCell(10, 0)
		cf = new WritableCellFormat()
		cf.setAlignment(Alignment.RIGHT)
		cell.setCellFormat(cf)
		
		String hoy = generalService.getHoy(1)
		wsheet.addCell(new Label(11, 0, hoy))
		wsheet.mergeCells(11, 0, 12, 0)
		cell = wsheet.getWritableCell(11, 0)
		cf = new WritableCellFormat()
		cf.setAlignment(Alignment.RIGHT)
		cell.setCellFormat(cf)
	   
		// Creamos el encabezado del reporte para los pedidos
		def filaEmpiesa = 4
		wsheet.addCell(new Label(0, filaEmpiesa, "Pedido No."))
		cell = wsheet.getWritableCell(0, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet.addCell(new Label(1, filaEmpiesa, "Empresa"))
		cell = wsheet.getWritableCell(1, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
	 
		wsheet.addCell(new Label(2, filaEmpiesa, "Forma de Pago"))
		cell = wsheet.getWritableCell(2, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
	 
		wsheet.addCell(new Label(3, filaEmpiesa, "Precios En"))
		cell = wsheet.getWritableCell(3, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet.addCell(new Label(4, filaEmpiesa, "Moneda a Facturar"))
		cell = wsheet.getWritableCell(4, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet.addCell(new Label(5, filaEmpiesa, "Valor USD"))
		cell = wsheet.getWritableCell(5, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		 wsheet.addCell(new Label(6, filaEmpiesa, "Valor COP"))
		cell = wsheet.getWritableCell(6, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		def pedidos = Pedido.executeQuery("FROM Pedido p WHERE p.idEstadoPedido =:estado and  p.eliminado=0 order by p.nombreCliente", [estado:"pedenrevi2"] )
	//println "Pedidos"+pedidos.idEstadoPedido
		def i =1
		pedidos.each{
			
			def filaReporte = filaEmpiesa + i
			// numero del pedido
			wsheet.addCell(new Label(0, filaReporte, it.numPedido))
				  
			// nommre de la empresa
			 def xempresa=Empresa.get(it.empresaId)
			 wsheet.addCell(new Label(1, filaReporte, xempresa.toString()))
			 
			def xformaPago=generalService.getValorParametro(it.idFormaPago)
			wsheet.addCell(new Label(2, filaReporte, xformaPago.toString()))
		   
			def xpreciosEn=generalService.getValorParametro(it?.idTipoPrecio)
			wsheet.addCell(new Label(3, filaReporte, xpreciosEn.toString()))
		   
		   //def xestado=generalService.getValorParametro(it?.idEstadoPedido)
		   //  println "ESTADO DEL PEDIDO"+xestado
			 
			def xfacturarEn=generalService.getValorParametro(it?.idMondedaFactura)
			wsheet.addCell(new Label(4, filaReporte, xfacturarEn.toString()))
			  
			def xvalorpedido
			String ztrm=generalService.getValorParametro('trm')
			BigDecimal xtrm=new BigDecimal(ztrm)
			xtrm=it?.trm?:xtrm
		 
				NumberFormat  decimalNo = new NumberFormat("#.0");
				WritableCellFormat numberFormat = new WritableCellFormat(decimalNo);
			  if (it?.idTipoPrecio=='pedtprec02' && it?.valorPedido){
			   xvalorpedido=it?.valorPedido/xtrm
			  
				//write to datasheet
			   Number numberCell = new Number(5, filaReporte, xvalorpedido, numberFormat);
			   wsheet.addCell(numberCell);
		   
			  }else{
			   xvalorpedido=it?.valorPedido
			   Number numberCell = new Number(6, filaReporte, xvalorpedido, numberFormat);
			   wsheet.addCell(numberCell);
			  }
			 def listaArqui=pedidoService.getArquitectosPedido(it?.id)
			  //println "LISTA DE ARQUITECTOS"+listaArqui
			
			i++
		}
		
	   // PEDIDOS EN COMPRA
		 WritableSheet wsheet1 = wworkbook.createSheet("Pedidos Pendiente X Compra", 1);
	 
		wsheet1.addCell(new Label(0, 0,"REPORTE DE PEDIDOS X COMPRA"))
		wsheet1.mergeCells(0, 0, 7, 0)
		cell = wsheet1.getWritableCell(0, 0)
		cf = new WritableCellFormat(empresa)
		cell.setCellFormat(cf)
		
		wsheet1.addCell(new Label(10, 0, "Creado el dia"))
		cell = wsheet1.getWritableCell(10, 0)
		cf = new WritableCellFormat()
		cf.setAlignment(Alignment.RIGHT)
		cell.setCellFormat(cf)
		
		wsheet1.addCell(new Label(11, 0, hoy))
		wsheet1.mergeCells(11, 0, 12, 0)
		cell = wsheet1.getWritableCell(11, 0)
		cf = new WritableCellFormat()
		cf.setAlignment(Alignment.RIGHT)
		cell.setCellFormat(cf)
		
		// Creamos el encabezado del reporte para los pedidos
		def filaEmpiezaHoja1 = 4
		wsheet1.addCell(new Label(0, filaEmpiezaHoja1, "Pedido No."))
		cell = wsheet1.getWritableCell(0, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet1.addCell(new Label(1, filaEmpiezaHoja1, "Empresa"))
		cell = wsheet1.getWritableCell(1, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
	 
		wsheet1.addCell(new Label(2, filaEmpiesa, "Forma de Pago"))
		cell = wsheet1.getWritableCell(2, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
	 
		wsheet1.addCell(new Label(3, filaEmpiesa, "Precios En"))
		cell = wsheet1.getWritableCell(3, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet1.addCell(new Label(4, filaEmpiesa, "Moneda a Facturar"))
		cell = wsheet1.getWritableCell(4, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
	
		wsheet1.addCell(new Label(5, filaEmpiezaHoja1, "Valor USD"))
		cell = wsheet1.getWritableCell(5, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet1.addCell(new Label(6, filaEmpiezaHoja1, "Valor COP"))
		cell = wsheet1.getWritableCell(6, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet1.addCell(new Label(7, filaEmpiezaHoja1, "Arquitectos"))
		cell = wsheet1.getWritableCell(7, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		def pedidosH1 = Pedido.executeQuery("FROM Pedido p WHERE p.idEstadoPedido =:estado and  p.eliminado=0  order by p.nombreCliente", [estado:"pedpencom3"] )
	//println "Pedidos"+pedidos.idEstadoPedido
		 i =1
		pedidosH1.each{
			def filaReporte = filaEmpiezaHoja1 + i
			// numero del pedido
		  
			wsheet1.addCell(new Label(0, filaReporte, it.numPedido))

			// nommre de la empresa
			 def xsucursal=Empresa.get(it.empresaId)
		   
			wsheet1.addCell(new Label(1, filaReporte, xsucursal.toString()))
			  
			def xformaPago=generalService.getValorParametro(it.idFormaPago)
			wsheet1.addCell(new Label(2, filaReporte, xformaPago.toString()))
		   
			def xpreciosEn=generalService.getValorParametro(it?.idTipoPrecio)
			wsheet1.addCell(new Label(3, filaReporte, xpreciosEn.toString()))
				   
		   //def xestado=generalService.getValorParametro(it?.idEstadoPedido)
		   //  println "ESTADO DEL PEDIDO"+xestado
			 
			def xfacturarEn=generalService.getValorParametro(it?.idMondedaFactura)
			wsheet1.addCell(new Label(4, filaReporte, xfacturarEn.toString()))
			  
			def xvalorpedido
			String ztrm=generalService.getValorParametro('trm')
			BigDecimal xtrm=new BigDecimal(ztrm)
			xtrm=it?.trm?:xtrm
			   
				NumberFormat  decimalNo = new NumberFormat("#.0");
				WritableCellFormat numberFormat = new WritableCellFormat(decimalNo);
			  if (it?.idTipoPrecio=='pedtprec02' && it?.valorPedido){
			   xvalorpedido=it?.valorPedido/xtrm
			  
				//write to datasheet
			   Number numberCell = new Number(5, filaReporte, xvalorpedido, numberFormat);
			   wsheet1.addCell(numberCell);
		   
			  }else{
			   xvalorpedido=it?.valorPedido
			   Number numberCell = new Number(6, filaReporte, xvalorpedido, numberFormat);
			   wsheet1.addCell(numberCell);
			  }
			 def listaArqui=pedidoService.getArquitectosPedido(it?.id)
			 def listaDef=[]
			   if (it?.arquitectoSol=='S'){
				listaArqui.each(){
				 listaDef.add(generalService.getValorParametro(it))
				}
				}else
				  listaDef=['N']
			
				wsheet1.addCell(new Label(7, filaReporte, listaDef.toString()))
			i++
		}
		
	   // FIN DE PEDIDOS EN COMPRA
		
		
		// PEDIDOS EN FACTURADOS PARCIALMENTE
		 WritableSheet wsheet2 = wworkbook.createSheet("Pedidos Facturados Parcialmente", 2);
  
		wsheet2.addCell(new Label(0, 0,"REPORTE DE FACTURADOS PARCIALMENTE"))
		wsheet2.mergeCells(0, 0, 7, 0)
		cell = wsheet2.getWritableCell(0, 0)
		cf = new WritableCellFormat(empresa)
		cell.setCellFormat(cf)
		
		wsheet2.addCell(new Label(10, 0, "Creado el dia"))
		cell = wsheet2.getWritableCell(10, 0)
		cf = new WritableCellFormat()
		cf.setAlignment(Alignment.RIGHT)
		cell.setCellFormat(cf)
		
		wsheet2.addCell(new Label(11, 0, hoy))
		wsheet2.mergeCells(11, 0, 12, 0)
		cell = wsheet1.getWritableCell(11, 0)
		cf = new WritableCellFormat()
		cf.setAlignment(Alignment.RIGHT)
		cell.setCellFormat(cf)
			  
		// Creamos el encabezado del reporte para los pedidos
		def filaEmpiezaHoja2 = 4
		wsheet2.addCell(new Label(0, filaEmpiezaHoja2, "Pedido No."))
		cell = wsheet2.getWritableCell(0, filaEmpiezaHoja2)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet2.addCell(new Label(1, filaEmpiezaHoja2, "Empresa"))
		cell = wsheet1.getWritableCell(1, filaEmpiesa)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
			 
		wsheet2.addCell(new Label(2, filaEmpiezaHoja2, "Forma de Pago"))
		cell = wsheet2.getWritableCell(2, filaEmpiezaHoja2)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
	 
		wsheet2.addCell(new Label(3, filaEmpiezaHoja2, "Precios En"))
		cell = wsheet2.getWritableCell(3, filaEmpiezaHoja2)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet2.addCell(new Label(4, filaEmpiezaHoja2, "Moneda a Facturar"))
		cell = wsheet2.getWritableCell(4, filaEmpiezaHoja2)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet2.addCell(new Label(5, filaEmpiezaHoja2, "Valor USD"))
		cell = wsheet2.getWritableCell(5, filaEmpiezaHoja2)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet2.addCell(new Label(6, filaEmpiezaHoja2, "Valor COP"))
		cell = wsheet2.getWritableCell(6, filaEmpiezaHoja2)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet2.addCell(new Label(7, filaEmpiezaHoja2, "Fecha ultima Factura"))
		cell = wsheet2.getWritableCell(7, filaEmpiezaHoja2)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet2.addCell(new Label(8, filaEmpiezaHoja2, "Num.Factura"))
		cell = wsheet2.getWritableCell(8, filaEmpiezaHoja2)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet2.addCell(new Label(9, filaEmpiezaHoja2, "Valor Factura"))
		cell = wsheet2.getWritableCell(9, filaEmpiezaHoja2)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet2.addCell(new Label(10, filaEmpiezaHoja2, "Total Facturado"))
		cell = wsheet2.getWritableCell(10, filaEmpiezaHoja2)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet2.addCell(new Label(11, filaEmpiezaHoja2, "Pendiente por Facturar"))
		cell = wsheet2.getWritableCell(11, filaEmpiezaHoja2)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		wsheet2.addCell(new Label(12, filaEmpiezaHoja2, "Lista de Arquitectos"))
		cell = wsheet2.getWritableCell(12, filaEmpiezaHoja2)
		cf = new WritableCellFormat(boldTitulo)
		cell.setCellFormat(cf)
		
		def pedidosH2 = Pedido.executeQuery("FROM Pedido p WHERE p.idEstadoPedido =:estado and  p.eliminado=0  order by p.nombreCliente", [estado:"pedfacpar2"] )
	//println "Pedidos"+pedidos.idEstadoPedido
		 i =1
		pedidosH2.each{
			
			def filaReporte = filaEmpiezaHoja2 + i
			// numero del pedido
		  
			wsheet2.addCell(new Label(0, filaReporte, it.numPedido))
				   

			// nommre de la empresa
			 def xsucursal=Empresa.get(it.empresaId)
		   
			wsheet2.addCell(new Label(1, filaReporte, xsucursal.toString()))
			  
			def xformaPago=generalService.getValorParametro(it.idFormaPago)
			wsheet2.addCell(new Label(2, filaReporte, xformaPago.toString()))
		   
			def xpreciosEn=generalService.getValorParametro(it?.idTipoPrecio)
			wsheet2.addCell(new Label(3, filaReporte, xpreciosEn.toString()))
			
		   //def xestado=generalService.getValorParametro(it?.idEstadoPedido)
		   //  println "ESTADO DEL PEDIDO"+xestado
		   
			def xfacturarEn=generalService.getValorParametro(it?.idMondedaFactura)
			wsheet2.addCell(new Label(4, filaReporte, xfacturarEn.toString()))
			  
			def xvalorpedido
			String ztrm=generalService.getValorParametro('trm')
			BigDecimal xtrm=new BigDecimal(ztrm)
			xtrm=it?.trm?:xtrm
			
				NumberFormat  decimalNo = new NumberFormat("#.0");
				WritableCellFormat numberFormat = new WritableCellFormat(decimalNo);
			  if (it?.idTipoPrecio=='pedtprec02' && it?.valorPedido){
			   xvalorpedido=it?.valorPedido/xtrm
			  
				//write to datasheet
			   Number numberCell = new Number(5, filaReporte, xvalorpedido, numberFormat);
			   wsheet2.addCell(numberCell);
			   
				  // celda de pendiente por facturar
			   def celdaProcesar = "SUMA(F"+(filaReporte+1) + "-K"+(filaReporte+1)+")"
			   Formula sum2 = new Formula(11, filaReporte, celdaProcesar)
			   wsheet2.addCell(sum2)
			   
			  }else{
			   xvalorpedido=it?.valorPedido
			   Number numberCell = new Number(6, filaReporte, xvalorpedido, numberFormat);
			   wsheet2.addCell(numberCell);
			   
			   // celda de pendiente por facturar
			   def celdaProcesar = "SUMA(G"+(filaReporte+1) + "-K"+(filaReporte+1)+")"
			   Formula sum2 = new Formula(11,filaReporte , celdaProcesar)
			   wsheet2.addCell(sum2)

			  }
		   
			 // buscamos el total cancelado para este pedido
			def query = "from Factura where pedido.id = '${it.id}' and eliminado=0 order by fechaFactura desc"
			def queryc = "select sum(valorFactura) from Factura f  where pedido.id = '${it.id}' and eliminado=0"
		
			def facturaList = Factura.find(query)
 
			if(facturaList){
			   def sdf = new SimpleDateFormat("dd-MM-yyyy")
			   def fecha = sdf.format(facturaList.fechaFactura).toString()
			   wsheet2.addCell(new Label(7, filaReporte, fecha))
			   wsheet2.addCell(new Label(8, filaReporte, facturaList?.numFactura.toString()))
			   Number numberCell1 = new Number(9, filaReporte, facturaList?.valorFactura , numberFormat);
			   wsheet2.addCell(numberCell1);
			}
			
			def totalFacturado = Factura.executeQuery(queryc)
			//println "el total de la fatura"+totalFacturado[0]
			Number numberCell1 = new Number(10, filaReporte, totalFacturado[0] , numberFormat);
			wsheet2.addCell(numberCell1);
			
		  
			
			
			// listado de arquitectos
			def listaArqui=pedidoService.getArquitectosPedido(it?.id)
			 def listaDef=[]
			   if (it?.arquitectoSol=='S'){
				listaArqui.each(){
				 listaDef.add(generalService.getValorParametro(it))
				}
				}else
				  listaDef=['N']
			
				wsheet2.addCell(new Label(12, filaReporte, listaDef.toString()))
					  
			i++
		}
		
	   // FIN DE PEDIDOS EN FACTURADOS PARCIALMENTE
		
		
	   //PEDIDOS PENDIENTES X RECIBIR
		   WritableSheet wsheet4 = wworkbook.createSheet("Pedidos Pendiente X Recibir", 1);
		
		   wsheet4.addCell(new Label(0, 0,"REPORTE DE PEDIDOS PENDIENTES X RECIBIR"))
		   wsheet4.mergeCells(0, 0, 7, 0)
		   cell = wsheet4.getWritableCell(0, 0)
		   cf = new WritableCellFormat(empresa)
		   cell.setCellFormat(cf)
		   
		   wsheet4.addCell(new Label(10, 0, "Creado el dia"))
		   cell = wsheet4.getWritableCell(10, 0)
		   cf = new WritableCellFormat()
		   cf.setAlignment(Alignment.RIGHT)
		   cell.setCellFormat(cf)
		   
		   wsheet4.addCell(new Label(11, 0, hoy))
		   wsheet4.mergeCells(11, 0, 12, 0)
		   cell = wsheet4.getWritableCell(11, 0)
		   cf = new WritableCellFormat()
		   cf.setAlignment(Alignment.RIGHT)
		   cell.setCellFormat(cf)
		   
		   // Creamos el encabezado del reporte para los pedidos
		   def filaEmpiezaHoja4 = 4
		   wsheet4.addCell(new Label(0, filaEmpiezaHoja4, "Pedido No."))
		   cell = wsheet4.getWritableCell(0, filaEmpiesa)
		   cf = new WritableCellFormat(boldTitulo)
		   cell.setCellFormat(cf)
		   
		   wsheet4.addCell(new Label(1, filaEmpiezaHoja4, "Empresa"))
		   cell = wsheet4.getWritableCell(1, filaEmpiesa)
		   cf = new WritableCellFormat(boldTitulo)
		   cell.setCellFormat(cf)
		
		   wsheet4.addCell(new Label(2, filaEmpiesa, "Forma de Pago"))
		   cell = wsheet4.getWritableCell(2, filaEmpiesa)
		   cf = new WritableCellFormat(boldTitulo)
		   cell.setCellFormat(cf)
		
		   wsheet4.addCell(new Label(3, filaEmpiesa, "Precios En"))
		   cell = wsheet4.getWritableCell(3, filaEmpiesa)
		   cf = new WritableCellFormat(boldTitulo)
		   cell.setCellFormat(cf)
		   
		   wsheet4.addCell(new Label(4, filaEmpiesa, "Moneda a Facturar"))
		   cell = wsheet4.getWritableCell(4, filaEmpiesa)
		   cf = new WritableCellFormat(boldTitulo)
		   cell.setCellFormat(cf)
	   
		   wsheet4.addCell(new Label(5, filaEmpiezaHoja4, "Valor USD"))
		   cell = wsheet4.getWritableCell(5, filaEmpiesa)
		   cf = new WritableCellFormat(boldTitulo)
		   cell.setCellFormat(cf)
		   
		   wsheet4.addCell(new Label(6, filaEmpiezaHoja4, "Valor COP"))
		   cell = wsheet4.getWritableCell(6, filaEmpiesa)
		   cf = new WritableCellFormat(boldTitulo)
		   cell.setCellFormat(cf)
		   
		   wsheet4.addCell(new Label(7, filaEmpiezaHoja4, "Arquitectos"))
		   cell = wsheet4.getWritableCell(7, filaEmpiesa)
		   cf = new WritableCellFormat(boldTitulo)
		   cell.setCellFormat(cf)
		   
		   def pedidosH4 = Pedido.executeQuery("FROM Pedido p WHERE p.idEstadoPedido =:estado and  p.eliminado=0  order by p.nombreCliente", [estado:"pedpenrec4"] )
	   //println "Pedidos"+pedidos.idEstadoPedido
			i =1
		   pedidosH4.each{
			   def filaReporte = filaEmpiezaHoja4 + i
			   // numero del pedido
			 
			   wsheet4.addCell(new Label(0, filaReporte, it.numPedido))
   
			   // nommre de la empresa
				def xsucursal=Empresa.get(it.empresaId)
			  
			   wsheet4.addCell(new Label(1, filaReporte, xsucursal.toString()))
				 
			   def xformaPago=generalService.getValorParametro(it.idFormaPago)
			   wsheet4.addCell(new Label(2, filaReporte, xformaPago.toString()))
			  
			   def xpreciosEn=generalService.getValorParametro(it?.idTipoPrecio)
			   wsheet4.addCell(new Label(3, filaReporte, xpreciosEn.toString()))
					  
			  //def xestado=generalService.getValorParametro(it?.idEstadoPedido)
			  //  println "ESTADO DEL PEDIDO"+xestado
				
			   def xfacturarEn=generalService.getValorParametro(it?.idMondedaFactura)
			   wsheet4.addCell(new Label(4, filaReporte, xfacturarEn.toString()))
				 
			   def xvalorpedido
			   String ztrm=generalService.getValorParametro('trm')
			   BigDecimal xtrm=new BigDecimal(ztrm)
			   xtrm=it?.trm?:xtrm
				  
				   NumberFormat  decimalNo = new NumberFormat("#.0");
				   WritableCellFormat numberFormat = new WritableCellFormat(decimalNo);
				 if (it?.idTipoPrecio=='pedtprec02' && it?.valorPedido){
				  xvalorpedido=it?.valorPedido/xtrm
				 
				   //write to datasheet
				  Number numberCell = new Number(5, filaReporte, xvalorpedido, numberFormat);
				  wsheet4.addCell(numberCell);
			  
				 }else{
				  xvalorpedido=it?.valorPedido
				  Number numberCell = new Number(6, filaReporte, xvalorpedido, numberFormat);
				  wsheet4.addCell(numberCell);
				 }
				def listaArqui=pedidoService.getArquitectosPedido(it?.id)
				def listaDef=[]
				  if (it?.arquitectoSol=='S'){
				   listaArqui.each(){
					listaDef.add(generalService.getValorParametro(it))
				   }
				   }else
					 listaDef=['N']
			   
				   wsheet4.addCell(new Label(7, filaReporte, listaDef.toString()))
			   i++
		   }
		
	   //PEDIDOS PENDIENTES X RECIBIR
		   
		   
		   
	   //PEDIDOS PENDIENTES X FACTURAR
		   WritableSheet wsheet6 = wworkbook.createSheet("Pedidos Pendiente X Facturar", 1);
		   
			  wsheet6.addCell(new Label(0, 0,"REPORTE DE PEDIDOS PENDIENTES X FACTURAR"))
			  wsheet6.mergeCells(0, 0, 7, 0)
			  cell = wsheet6.getWritableCell(0, 0)
			  cf = new WritableCellFormat(empresa)
			  cell.setCellFormat(cf)
			  
			  wsheet6.addCell(new Label(10, 0, "Creado el dia"))
			  cell = wsheet6.getWritableCell(10, 0)
			  cf = new WritableCellFormat()
			  cf.setAlignment(Alignment.RIGHT)
			  cell.setCellFormat(cf)
			  
			  wsheet6.addCell(new Label(11, 0, hoy))
			  wsheet6.mergeCells(11, 0, 12, 0)
			  cell = wsheet6.getWritableCell(11, 0)
			  cf = new WritableCellFormat()
			  cf.setAlignment(Alignment.RIGHT)
			  cell.setCellFormat(cf)
			  
			  // Creamos el encabezado del reporte para los pedidos
			  def filaEmpiezaHoja6 = 4
			  wsheet6.addCell(new Label(0, filaEmpiezaHoja6, "Pedido No."))
			  cell = wsheet6.getWritableCell(0, filaEmpiesa)
			  cf = new WritableCellFormat(boldTitulo)
			  cell.setCellFormat(cf)
			  
			  wsheet6.addCell(new Label(1, filaEmpiezaHoja6, "Empresa"))
			  cell = wsheet6.getWritableCell(1, filaEmpiesa)
			  cf = new WritableCellFormat(boldTitulo)
			  cell.setCellFormat(cf)
		   
			  wsheet6.addCell(new Label(2, filaEmpiesa, "Forma de Pago"))
			  cell = wsheet6.getWritableCell(2, filaEmpiesa)
			  cf = new WritableCellFormat(boldTitulo)
			  cell.setCellFormat(cf)
		   
			  wsheet6.addCell(new Label(3, filaEmpiesa, "Precios En"))
			  cell = wsheet6.getWritableCell(3, filaEmpiesa)
			  cf = new WritableCellFormat(boldTitulo)
			  cell.setCellFormat(cf)
			  
			  wsheet6.addCell(new Label(4, filaEmpiesa, "Moneda a Facturar"))
			  cell = wsheet6.getWritableCell(4, filaEmpiesa)
			  cf = new WritableCellFormat(boldTitulo)
			  cell.setCellFormat(cf)
		  
			  wsheet6.addCell(new Label(5, filaEmpiezaHoja6, "Valor USD"))
			  cell = wsheet6.getWritableCell(5, filaEmpiesa)
			  cf = new WritableCellFormat(boldTitulo)
			  cell.setCellFormat(cf)
			  
			  wsheet6.addCell(new Label(6, filaEmpiezaHoja6, "Valor COP"))
			  cell = wsheet6.getWritableCell(6, filaEmpiesa)
			  cf = new WritableCellFormat(boldTitulo)
			  cell.setCellFormat(cf)
			  
			  wsheet6.addCell(new Label(7, filaEmpiezaHoja6, "Arquitectos"))
			  cell = wsheet6.getWritableCell(7, filaEmpiesa)
			  cf = new WritableCellFormat(boldTitulo)
			  cell.setCellFormat(cf)
			  
			  def pedidosH6 = Pedido.executeQuery("FROM Pedido p WHERE p.idEstadoPedido =:estado and  p.eliminado=0  order by p.nombreCliente", [estado:"pedpenfac2"] )
		  //println "Pedidos"+pedidos.idEstadoPedido
			   i =1
			  pedidosH6.each{
				  def filaReporte = filaEmpiezaHoja6 + i
				  // numero del pedido
				
				  wsheet6.addCell(new Label(0, filaReporte, it.numPedido))
	  
				  // nommre de la empresa
				   def xsucursal=Empresa.get(it.empresaId)
				 
				  wsheet6.addCell(new Label(1, filaReporte, xsucursal.toString()))
					
				  def xformaPago=generalService.getValorParametro(it.idFormaPago)
				  wsheet6.addCell(new Label(2, filaReporte, xformaPago.toString()))
				 
				  def xpreciosEn=generalService.getValorParametro(it?.idTipoPrecio)
				  wsheet6.addCell(new Label(3, filaReporte, xpreciosEn.toString()))
						 
				 //def xestado=generalService.getValorParametro(it?.idEstadoPedido)
				 //  println "ESTADO DEL PEDIDO"+xestado
				   
				  def xfacturarEn=generalService.getValorParametro(it?.idMondedaFactura)
				  wsheet6.addCell(new Label(4, filaReporte, xfacturarEn.toString()))
					
				  def xvalorpedido
				  String ztrm=generalService.getValorParametro('trm')
				  BigDecimal xtrm=new BigDecimal(ztrm)
				  xtrm=it?.trm?:xtrm
					 
					  NumberFormat  decimalNo = new NumberFormat("#.0");
					  WritableCellFormat numberFormat = new WritableCellFormat(decimalNo);
					if (it?.idTipoPrecio=='pedtprec02' && it?.valorPedido){
					 xvalorpedido=it?.valorPedido/xtrm
					
					  //write to datasheet
					 Number numberCell = new Number(5, filaReporte, xvalorpedido, numberFormat);
					 wsheet6.addCell(numberCell);
				 
					}else{
					 xvalorpedido=it?.valorPedido
					 Number numberCell = new Number(6, filaReporte, xvalorpedido, numberFormat);
					 wsheet6.addCell(numberCell);
					}
				   def listaArqui=pedidoService.getArquitectosPedido(it?.id)
				   def listaDef=[]
					 if (it?.arquitectoSol=='S'){
					  listaArqui.each(){
					   listaDef.add(generalService.getValorParametro(it))
					  }
					  }else
						listaDef=['N']
				  
					  wsheet6.addCell(new Label(7, filaReporte, listaDef.toString()))
				  i++
			  }
		   
	   //PEDIDOS PENDIENTES X FACTURAR
		   
		wworkbook.write();
		wworkbook.close();
		   
	}
	
	@Transactional
	def detenidoEnCompras()
	{
			
		def pedidoInstance=Pedido.get(params.id)
		def notificados="${generalService.getValorParametro('financiera')}"+","+"${pedidoInstance.empleado.email}"
		
		
		if(pedidoInstance.detenidoEnCompra==1)
			
		{
			pedidoInstance.detenidoEnCompra=0
			pedidoInstance.save()
			flash.message="Pedido ha sido desmarcado de detenido en compras"
			redirect url:"/pedido/index?sort=fechaApertura&order=desc"
			//return
		}
		else
			render view:"detenidoEnCompras", model:[pedidoInstance:pedidoInstance,notificados:notificados]
	}
	
	
	@Transactional
	def detenidoEnComprasDef(Pedido pedidoInstance)
	{
		
		//registrarNotaEnPedido(autorid,xentidad,xpadre,xtipo,xnota,notificarA,asunto,cuerpo)
		
		def idusuarioLogueado=generalService.getIdEmpleado(session['idUsuario'].toLong())
		def numpedido=pedidoInstance.numPedido
		def userName=Empleado.findById(idusuarioLogueado)
		def empresaPedido=pedidoInstance.empresa.razonSocial
		String urlbase=generalService.getValorParametro('urlaplic')
		String xentidad='pedido'
		String xpadre=params.id
		String xtipo='notadetcom'
		String xnota="Notificacion detenido en compra"
		String asunto="DETENIDO EN COMPRAS - No. PEDIDO ${numpedido} - ${empresaPedido}"
		String cuerpo="Enviado por: ${userName}<br><br> El siguiente pedido se encuentra detenido en compras.<br><br> <b>Observaciones:</b> ${params.observaciones}. <br><br> Haga clic <a href='${urlbase}/pedido/show/${pedidoInstance.id}'> AQUI </a> "
		String notificarA=params.notificarA
		println "notificarA"+notificarA
		//def listaDestino=generalService.convertirEnLista(notificarA)
		pedidoInstance.detenidoEnCompra=1
		//HAY QUE NOTIFICAR A FINANCIERA,VENDEDOR
		generalService.registrarNotaEnPedido(idusuarioLogueado,xentidad,xpadre.toString(),xtipo,xnota,notificarA,asunto,cuerpo)
		//generalService.enviarCorreo(1,listaDestino,asunto,cuerpo)
		
		
		
		
		//CREAR NOTA CON LOS CAMPOS NECESARIOS.....
		
		/*def notaInstance=new Nota()
		notaInstance.idEntidad=xpadre.toLong()
		notaInstance.nombreEntidad=xentidad
		notaInstance.idAutor=idusuarioLogueado
		notaInstance.nota=xnota
		notaInstance.fecha=new Date()
		notaInstance.idTipoNota=xtipo
		notaInstance.idEstadoNota='genactivo'
		notaInstance.funcionariosNotificados=notificarA
		notaInstance.eliminado=0
		notaInstance.save(flush:true,failOnError:true)*/
		
		
		
		
		
		
		
		
		redirect url:"/pedido/index?sort=fechaApertura&order=desc"
	}

	def informacionSiesa()
	{
		
		def pedidoInstance=Pedido.get(params.id)
		render view:"informacionSiesa", model:[pedidoInstance:pedidoInstance]
	}
	
	
	@Transactional  //autorizarCambioPedidoDef
	def informacionSiesaDef(Pedido pedidoInstance){
		
	 
		
		def valorPed= new BigDecimal(params.valorpedido)
		def trmd= new BigDecimal(params.trmd)
		
		def infoSiesaInstance=new InfoSiesa()
		infoSiesaInstance.numPedido=pedidoInstance.numPedido
		infoSiesaInstance.nombreCliente=pedidoInstance.nombreCliente
		infoSiesaInstance.nit=Empresa.get(pedidoInstance.empresa.id).nit
		infoSiesaInstance.valorPedido=valorPed
		infoSiesaInstance.trm=trmd
		infoSiesaInstance.idFormaPago=params.formadepago
		infoSiesaInstance.idTipoPrecio=params.tipoprecio
		infoSiesaInstance.pedido=Pedido.get(pedidoInstance.id)//ID DEL PEDIDO EN CUESTION
		infoSiesaInstance.save(flush: true)
		flash.message="Pedido SIESA"
		redirect url:"/pedido/index?sort=fechaApertura&order=desc"
		
	}
	
	
}


