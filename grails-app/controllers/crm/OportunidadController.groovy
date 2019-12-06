
package crm
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import java.text.SimpleDateFormat

import org.mozilla.javascript.regexp.SubString

import grails.converters.JSON

@Transactional(readOnly = true)
class OportunidadController extends BaseController {

	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	def generalService
	def consecutivoService
	def oportunidadService
	def filterPaneService
	def auditoriaService
	def exportService
	def exportarService
	def resultadosfiltro_export
	def listadef
		
	@Transactional		
	def index(Integer max) {
		

		
		int itemxview=generalService.getItemsxView(0)
		params.max = Math.min(max?:itemxview,100)
		String  xoffset=params.offset?:0

		if(!params.filter) params.filter = [op:[:],empleado:[:],propuesta:[:]]
   
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado = '0'
		

		if(params.filter.estrategiaId){
			println "Params.filter.estrategiaId "+params.filter.estrategiaId			 
			params.filter.estrategiaId=generalService.getIdEstrategia(params.filter.estrategiaId)
		}
		
		if(params.filter.idFabricante){
			params.filter.idFabricante=generalService.getIdValorParametro('fabricante',params.filter.idFabricante)
		}
	   
			   
		if (params.filter.idSucursal){
			params.filter.idSucursal=generalService.getIdSucursal(params.filter.idSucursal)
		}
		
		if(params.filter.idEtapa){
		  
			params.filter.idEtapa=generalService.getIdValorParametro('etapasvent',params.filter.idEtapa)
		}else {
		   
		 params.filter.op.idEtapa = "ILike"
		 params.filter.idEtapa='x'
		}
	   
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
		   params.filter+=[empleado:[:]]
		   params['filter.op.empleado.id']="Equal"
		   params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong())
		}
	 
		 session.filterParams=params
		 
		updateFilterLength()
		 
		def oportunidadInstanceList=filterPaneService.filter( params, Oportunidad )
			
		
		respond oportunidadInstanceList,  model:[
			oportunidadInstanceCount: filterPaneService.count( params, Oportunidad ),params:params,
			filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
			xtitulo:message(code:'oportunidades.titulo.label') ,xcerrada:'N']
	}

	//MODIFICACIONES REALIZADAS POR MARIO QUINTERO
	
	def indexCat(Integer max) {
		
		int itemxview=generalService.getItemsxView(0)
	   
		String  xoffset=params.offset?:0
		params.sort ="nombreCliente"

		if(!params.filter) params.filter = [op:[:],empleado:[:]]
   
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado = '0'
		
		if(params.filter.idFabricante){
			params.filter.idFabricante=generalService.getIdValorParametro('fabricante',params.filter.idFabricante)
		}
		
		if(params.filter.idEtapa){
			params.filter.idEtapa=generalService.getIdValorParametro('etapasvent',params.filter.idEtapa)
		}else {
		 params.filter.op.idEtapa = "ILike"
		 params.filter.idEtapa='x'
		}
			
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
		   params.filter+=[empleado:[:]]
		   params['filter.op.empleado.id']="Equal"
		   params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong())
		}
	 
		 session.filterParams=params
		 
		def oportunidadInstanceList=filterPaneService.filter( params, Oportunidad )
		// llamada al servicio para traer la informacion de cuota y estado del EC
		//def idUsuario=generalService.getIdEmpleado(session['idUsuario'])
		def idUsuario= session['idUsuario'].toLong()
		def infoEmpleadoQ = generalService.informacionEstadoQempleado(idUsuario)
		
		def datoAnterior =""
		def  empresaOportunidad = []
		 oportunidadInstanceList.each{
			 // println "Empresa: " + it?.nombreCliente
			if(it?.nombreCliente == datoAnterior){
				//println "EMPRESA REPETIDA " + it?.nombreCliente
			}else{
			  empresaOportunidad.add([label:it?.nombreCliente, id:it?.empresa.id])
			}
			datoAnterior = it?.nombreCliente
		 }
		 def total = empresaOportunidad.size()
		 
		 render(view:"indexn",  model:[
			oportunidadInstanceCount: total ,
			xtitulo:generalService?.getValorParametro('oportunt01'),xcerrada:'N', infoEmpleadoQ:infoEmpleadoQ, empresaOportunidad : empresaOportunidad, params:params])
	}
	
	
	def indexn(Integer max) {
		int itemxview=generalService.getItemsxView(0)
	   
		String  xoffset=params.offset?:0
		params.sort ="nombreCliente"

		if(!params.filter) params.filter = [op:[:],empleado:[:]]
   
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado = '0'
		
		if(params.filter.idFabricante){
			params.filter.idFabricante=generalService.getIdValorParametro('fabricante',params.filter.idFabricante)
		}
		
		if(params.filter.idEtapa){
			params.filter.idEtapa=generalService.getIdValorParametro('etapasvent',params.filter.idEtapa)
		}else {
		 params.filter.op.idEtapa = "ILike"
		 params.filter.idEtapa='x'
		}
			
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
		   params.filter+=[empleado:[:]]
		   params['filter.op.empleado.id']="Equal"
		   params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong())
		}
	 
		 session.filterParams=params
		 
		def oportunidadInstanceList=filterPaneService.filter( params, Oportunidad )
		
		// llamada al servicio para traer la informacion de cuota y estado del EC
		def idUsuario= session['idUsuario'].toLong()
		def infoEmpleadoQ = generalService.informacionEstadoQempleado(idUsuario)
		
		// sacamos el listado de categorias con sus respectivos id
		def nodo = generalService.sacarListaCategoria(oportunidadInstanceList, "nombreCliente", "empresaId")
	   
		def total = nodo.size()
	  
		  render(view:"indexn",  model:[
			oportunidadInstanceCount: total ,params:params,
			xtitulo:message(code:'oportunidades.titulo.label'),xcerrada:'N', infoEmpleadoQ:infoEmpleadoQ, empresaOportunidad : nodo])
		
	}
	
	def indexf(Integer max) {
		int itemxview=generalService.getItemsxView(0)
	   
		String  xoffset=params.offset?:0
		params.sort ="trimestre"

		if(!params.filter) params.filter = [op:[:],empleado:[:]]
   
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado = '0'
		
		if(params.filter.idFabricante){
			params.filter.idFabricante=generalService.getIdValorParametro('fabricante',params.filter.idFabricante)
		}
		
		if(params.filter.idEtapa){
			params.filter.idEtapa=generalService.getIdValorParametro('etapasvent',params.filter.idEtapa)
		}else {
		 params.filter.op.idEtapa = "ILike"
		 params.filter.idEtapa='x'
		}
			
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
		   params.filter+=[empleado:[:]]
		   params['filter.op.empleado.id']="Equal"
		   params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong())
				
		}
	 
		 session.filterParams=params
		 
		def oportunidadInstanceList=filterPaneService.filter( params, Oportunidad )
		
		  // llamada al servicio para traer la informacion de cuota y estado del EC
		//def idUsuario=generalService.getIdEmpleado(session['idUsuario'])
		def idUsuario= session['idUsuario'].toLong()
		def infoEmpleadoQ = generalService.informacionEstadoQempleado(idUsuario)
		
		// sacamos el listado de categorias con sus respectivos id
		def nodo = generalService.sacarListaCategoria(oportunidadInstanceList, "trimestre", "trimestre")
	   
		def total = nodo.size()
	  
		
		
		  render(view:"indexf",  model:[
			oportunidadInstanceCount: total ,params:params,
			xtitulo:generalService?.getValorParametro('oportunt01'),xcerrada:'N', infoEmpleadoQ:infoEmpleadoQ, nodos:nodo])
		
	}
	
		// Vista Categorizada por ciudad / vendedor / empresa
	def indexc(Integer max) {
		int itemxview=generalService.getItemsxView(0)
	   
		String  xoffset=params.offset?:0
		params.sort ="idSucursal"

		if(!params.filter) params.filter = [op:[:],empleado:[:]]
   
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado = '0'
		
		if(params.filter.idFabricante){
			params.filter.idFabricante=generalService.getIdValorParametro('fabricante',params.filter.idFabricante)
		}
		
		if(params.filter.idEtapa){
			params.filter.idEtapa=generalService.getIdValorParametro('etapasvent',params.filter.idEtapa)
		}else {
		 params.filter.op.idEtapa = "ILike"
		 params.filter.idEtapa='x'
		}
			
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
			def xnom=generalService.traerEmpleado(session['idUsuario'].toLong())
			def xnombre=xnom[0]
		   
			params.filter+=[empleado:[:]]
			params['filter.op.empleado.primerNombre']="Equal"
			params.filter.empleado.primerNombre=xnombre[0]
		   
			params['filter.op.empleado.primerApellido']="Equal"
			params.filter.empleado.primerApellido=xnombre[1]
				
		}
	 
		 session.filterParams=params
		 
		def oportunidadInstanceList=filterPaneService.filter( params, Oportunidad )
		
		 // llamada al servicio para traer la informacion de cuota y estado del EC
		//def idUsuario=generalService.getIdEmpleado(session['idUsuario'])
		def idUsuario= session['idUsuario'].toLong()
		def infoEmpleadoQ = generalService.informacionEstadoQempleado(idUsuario)
		
		// sacamos el listado de categorias con sus respectivos id
		def nodo = generalService.sacarListaCategoria(oportunidadInstanceList, "idSucursal", "idSucursal")
		
		def total = nodo.size()
	  
		  render(view:"indexc",  model:[
			oportunidadInstanceCount: total ,params:params,
			xtitulo:message(code:'oportunidades.ciudad.label'),xcerrada:'N', infoEmpleadoQ:infoEmpleadoQ, nodos:nodo])
		
	}
	
	
	def exportarDatos=
	{
		println "PARAMETROS EXPORTAR DATOS "+params
		
		List lista_export=[]
		//el nombre de los campos fields es como est�n definidos en la clase dominio
		List fields = ["numOportunidad","nombreCliente","nombreOportunidad","regOportunidad","valorOportunidad","nombreVendedor","trimestre","idEstadoOportunidad"]
		Map labels = ["numOportunidad":"Nro.","nombreCliente":"Empresa","nombreOportunidad":"Proyecto","regOportunidad":"Op. Fabricante","valorOportunidad":"Valor","nombreVendedor":"Vendedor","trimestre":"Q","idEstadoOportunidad":"Probabilidad"]
		
		
		//def date_solo_fecha = {Oportunidad, value ->
			//return Oportunidad.fechaCierreEstimada.format("dd-MM-yyyy")
		//}
		//def opFabricante={Oportunidad,value->
		//return oportunidadService.getNumRegistros2(Oportunidad.id)
		//}
		def getProbabilidad={Oportunidad,value->
			return generalService.getValorParametro(Oportunidad.idEtapa)
		}
		
		//Map formatters = [/*fechaCierreEstimada:date_solo_fecha,idEtapa:getProbabilidadregOportunidad:opFabricante*/:]
		Map formatters = [idEstadoOportunidad:getProbabilidad]
		String filename=exportarService.setfilename(params.titulo)
		println "params.titulo= "+params.titulo
		
		
		if(params.tipo_export=='1')//exportar todos
		{
			List idss=resultadosfiltro_export.id
			lista_export=exportarService.obtenerItemsSeleccionados(Oportunidad,idss)
		}
		else //exportar seleccionados
		{
			if(params.tipo_export=='3')//exportar oportunidades sin items
			{
				lista_export=generalService.oportunidadesSinItems()
			}
			else
			{
				List ids=params.list('oportunidades')//ids de items seleccionados
				lista_export=exportarService.obtenerItemsSeleccionados(Oportunidad,ids)//lista de checkbox seleccionados
			}
			
			
		}
		exportarService.exportar(Oportunidad,lista_export,fields,labels,response,formatters,filename)
	}
	
	   
	def buscarListadoRegistros ={
		//recibo el id de la empresa y procedo a filtrar para devolver solo las
		//oportunidades referentes a este id
	   def idRegistro = params.numeroId
		
		/**realizamos la busqueda de las oportunidades teniendo en cuenta que
		no este en estado eliminado, que contenga el usuario como vendedor
		que no este cerrada.
		*/
	 
	   def query = " from Oportunidad where empresa_id ="+idRegistro.toLong() +"and idEstadoOportunidad  in ('oposinasig','oporactiva','opocotizad') and eliminado = 0 order by numOportunidad asc"
	   def oportunidadInstanceList=Oportunidad.findAll(query)
	   
	   /** construimos la tabla mediante el fragmento a usar que contiene el listado
	   de oportunidades
	   **/
		   def resultado =[:]
		String templateTablaOportunidad = (g.render(template: "/oportunidad/listadoOportunidades",
		model : [oportunidadInstanceList: oportunidadInstanceList, empresa:idRegistro]))?.toString()
		resultado.templateTablaOportunidad = templateTablaOportunidad
	
		render  resultado as JSON
	}
	
	
	def updateFilterLength()
	{
		listadef=params.clone()
		listadef['max']=5000
		listadef['offset']=0
		resultadosfiltro_export=filterPaneService.filter(listadef, Oportunidad)//lista con base en el filtro
		params.max=10
	}
   
	//funcion para traer los nodos de las vistas con mas de una categoria en las oportunidades
	def traerNodo1() {
	 //println "ENTRANDO A TRAER NODO1"
	   // int itemxview=generalService.getItemsxView(0)
	   
		def idSplit = params.numeroId.split('-')
		 // println "split:"+idSplit + "orden: " + params.orden
		def idRegistro =  params.numeroId
		params.sort = params.orden
	
		if(!params.filter) params.filter = [op:[:],empleado:[:]]
   
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado = '0'
		
		if(params.filter.idFabricante){
			params.filter.idFabricante=generalService.getIdValorParametro('fabricante',params.filter.idFabricante)
		}
		
		if(params.filter.idEtapa){
			params.filter.idEtapa=generalService.getIdValorParametro('etapasvent',params.filter.idEtapa)
		}else {
		 params.filter.op.idEtapa = "ILike"
		 params.filter.idEtapa='x'
		}
			
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
			def xnom=generalService.traerEmpleado(session['idUsuario'].toLong())
			def xnombre=xnom[0]
		   
			params.filter+=[empleado:[:]]
			params['filter.op.empleado.primerNombre']="Equal"
			params.filter.empleado.primerNombre=xnombre[0]
		   
			params['filter.op.empleado.primerApellido']="Equal"
			params.filter.empleado.primerApellido=xnombre[1]
		}
		
	   //  adicion del filtrado de las oportunidades con el filterpane
		if(params.campoFiltro1 != ''){
		 if(params.campoFiltro1 == 'trimestre'){
				params['filter.op.trimestre']="Equal"
				params.filter.trimestre= idSplit[0]
		 }else{
			 if(params.campoFiltro1 == 'idSucursal'){
				params['filter.op.idSucursal']="Equal"
				params.filter.idSucursal= idSplit[0]
		 }
			 
		 }
		}
		 if(params.campoFiltro2 != ''){
		 if(params.campoFiltro2 == 'idSucursal'){
				params['filter.op.idSucursal']="Equal"
				params.filter.idSucursal = idSplit[1]
		 }else{
			if(params.campoFiltro2 == 'nombreVendedor'){
				params['filter.op.empleado.id']="Equal"
				params.filter.empleado.id = idSplit[1]
		 }
		 }
		}
		
		if(params.campoFiltro3 != ''){
		 if(params.campoFiltro3 == 'nombreVendedor'){
				params['filter.op.empleado.id']="Equal"
				params.filter.empleado.id = idSplit[2]
		 }else{
			if(params.campoFiltro3 == 'empresa'){
				params['filter.op.empleado.id']="Equal"
				def nombEmpresa = Empresa.findById(idSplit[2])
				params['filter.op.empresa']="Equal"
				params.filter.empresa = nombEmpresa
		 }
			 
		 }
		}
		
		 if(params.campoFiltro4 != ''){
		   if(params.campoFiltro4 == 'empresa'){
			   //buscamos la razon social debido a que no es posible aplicarle el filtro a una llave foranea
			   def nombEmpresa = Empresa.findById(idSplit[3])
				params['filter.op.empresa']="Equal"
				params.filter.empresa = nombEmpresa
		   }
		 }

		 session.filterParams=params
		
		/** println "ORDENAMIENTO:"+  params.sort
		 println "select :" + params.numeroId
		 println "categoria:" + params.categoria
		 println "idGuardar:" + params.idGuardar **/
		 
		 def listaGeneralRegistros=filterPaneService.filter( params, Oportunidad )
		  //println "NUMERO OPORTUNIDAD "+listaGeneralRegistros.numOportunidad
		   
		// sacamos el listado de categorias con sus respectivos id
		def nodo
		if(params.ultimoNodo=='No'){
		  nodo = generalService.sacarListaCategoria(listaGeneralRegistros, params.categoria, params.idGuardar)
		  //println nodo.label
		}else{
		  nodo = listaGeneralRegistros
		}
		
		def total = nodo.size()
		def resultado =[:]
	   if(params.plantilla =='2'){
	String templateTablaOportunidad = (g.render(template: "/oportunidad/listadoNodos2",
	model : [nodo: nodo, empresa:idRegistro]))?.toString()
	resultado.templateTablaOportunidad = templateTablaOportunidad
	   }else{
	   if(params.plantilla =='3'){
	String templateTablaOportunidad = (g.render(template: "/oportunidad/listadoNodos3",
	model : [nodo: nodo, cId:idSplit[0]+"-"+idSplit[1]]))?.toString()
	resultado.templateTablaOportunidad = templateTablaOportunidad
	   }else{
		 if(params.plantilla =='4'){
	String templateTablaOportunidad = (g.render(template: "/oportunidad/listadoNodos4",
	model : [nodo: nodo, cId:idSplit[0]+"-"+idSplit[1]+"-"+idSplit[2]]))?.toString()
	resultado.templateTablaOportunidad = templateTablaOportunidad
		}else{
		   if(params.plantilla =='5'){
		String templateTablaOportunidad = (g.render(template: "/oportunidad/listadoNodoFinalOptty",
		model : [nodo: nodo, cId:idSplit[0]+"-"+idSplit[1]+"-"+idSplit[2]+"-"+idSplit[3]]))?.toString()
		resultado.templateTablaOportunidad = templateTablaOportunidad
		   }else{
		   if(params.plantilla =='6'){
				String templateTablaOportunidad = (g.render(template: "/oportunidad/listadoNodos2_CiudadVendedorEmpresa",
				model : [nodo: nodo, empresa:idRegistro]))?.toString()
				resultado.templateTablaOportunidad = templateTablaOportunidad
		   }else{
			 if(params.plantilla =='7'){
				String templateTablaOportunidad = (g.render(template: "/oportunidad/listadoNodos3_CiudadVendedorEmpresa",
				model : [nodo: nodo, cId:idSplit[0]+"-"+idSplit[1]]))?.toString()
			resultado.templateTablaOportunidad = templateTablaOportunidad
			 }else{
				if(params.plantilla =='8'){
			  String templateTablaOportunidad = (g.render(template: "/oportunidad/listadoNodoFinalOptty",
			  model : [nodo: nodo, cId:idSplit[0]+"-"+idSplit[1]+"-"+idSplit[2]]))?.toString()
			  resultado.templateTablaOportunidad = templateTablaOportunidad
				}
								
			 }
		   }
		   
		   }
		}
	   }
	   }
		render  resultado as JSON
	   
	   
	}
	
	
	def traerDatosGraficaCuotaVsCump = {
	   def respuesta
	   def parametro = params.paramTipo
	  
		if(parametro == 'anual'){
			def dato = [
		 ["Trimestre", "Q", "Y2G"],
		 ["Q1", 133, 20],
		 ["Q2", 107, 47],
		 ["Q3", 27, 53],
		 ["Q4", 171, 113],
		 
		
	   ];
	 
			render dato as JSON
		}
	  
	   return respuesta
	}
	//cambios realizados 06/03/2015
	 def  totalOpttyPerdidas(vendedor) {
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
                      idMotivoPerdida = 'poscompete'
                      """
	   
		def resp=Oportunidad.executeQuery(query)
		resp=resp[0]
		// println "La respuesta es: " +resp
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
				lista[0].valor= resp[0]/1000
				lista[0].cant = resp[1]
				lista[0].save(flush: true)
			}
			 
		}else{
			
			
		}
		
 
	}
	
   
  // FIN DE LAS FUNCIONES REALIZADAS
	
	def indexg(Integer max) { //forecast x Technet
		
		int itemxview=generalService.getItemsxView(0)
		params.max = itemxview
		String  xoffset=params.offset?:0

		def hoy = new Date()
		def xmes =hoy[Calendar.MONTH]+1
		int q=(xmes+2)/3
		def Qactual="Q"+q
		 
		if(!params.filter) params.filter = [op:[:],empleado:[:]]
   
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado = '0'
		if (!params.id ){
			if (!params.filter.trimestre) {
				params.filter.op.trimestre = "Equal"
				params.filter.trimestre ="${Qactual}"
			}
		}
		 
		if(params.filter.idFabricante){
			params.filter.idFabricante=generalService.getIdValorParametro('fabricante',params.filter.idFabricante)
		}
		
		if(params.filter.idSucursal){//truco para corregir Id de filtro
			params.filter.idSucursal=generalService.getIdSucursal(params.filter.idSucursal)
		}
		
		if(params.filter.idEstadoOportunidad != null){
			params.filter.idEstadoOportunidad=generalService.getIdValorParametro('eoportunid',params.filter.idEstadoOportunidad)
		}else{
			params.filter.op.idEstadoOportunidad="Equal"
			params.filter.idEstadoOportunidad='opocotizad'
		}
	   
		if(params.filter.idEtapa){
			params.filter.idEtapa=generalService.getIdValorParametro('etapasvent',params.filter.idEtapa)
		}
	   
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
		   params.filter+=[empleado:[:]]
		   params['filter.op.empleado.id']="Equal"
		   params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong())
		}
		
		// parametro parambitac dias maximo para actualizar bitacora
		 String xparam=generalService.getValorParametro('maxdiasnot')
		 Integer  xdiasmax=xparam.toInteger()
		 def xhoy=new Date()
		 
		session.filterParams=params
		
		def oportunidadInstanceList=filterPaneService.filter( params, Oportunidad )
 
		
		render view:"indexg",  model:[ oportunidadInstanceList:oportunidadInstanceList,
			oportunidadInstanceCount: filterPaneService.count( params, Oportunidad ),params:params,
			filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
			xtitulo:generalService?.getValorParametro('oportunt01'),xcerrada:'N',xdiasmax:xdiasmax,xhoy:xhoy,Qactual:Qactual]
	}
   
	def indexp(Integer max) {
		// vista para el Panel de control
		params.max =5
		String  xoffset=params.offset?:0
		String xwherev; String xorden
		if (params.sort)
		xorden=" order by ${params.sort}"
		else
		xorden=" order by fechaApertura desc"
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
			xwherev=" and empleado.id=${generalService.getIdEmpleado(session['idUsuario'])}"
		} else  xwherev=''
	  
		def query ="from Oportunidad where idEstadoOportunidad  in ('oposinasig','oporactiva','opocotizad')  and eliminado=0"+xwherev+xorden
		def queryc ="select count(p) from Oportunidad p  where  idEstadoOportunidad  in ('oposinasig','oporactiva','opocotizad') and eliminado=0"+xwherev
		
		def oportunidadInstanceList = Oportunidad.findAll(query,[max:params.max,offset:xoffset.toLong()])
		def xnum=Oportunidad.executeQuery(queryc)
		render view:"indexp", model:[oportunidadInstanceList:oportunidadInstanceList,oportunidadInstanceCount:Math.min(xnum[0],10)]
	}
	
	def indexh(Integer max) { // oportunidades archivadas
		
		int itemxview=generalService.getItemsxView(0)
		params.max = Math.min(max?:itemxview,100)
		String  xoffset=params.offset?:0

		if(!params.filter) params.filter = [op:[:],empleado:[:]]
   
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado = '0'
		
		if(params.filter.idEstadoOportunidad != null){
			params.filter.idEstadoOportunidad=generalService.getIdValorParametro('eoportunid',params.filter.idEstadoOportunidad)
		}
	   
		
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
		   params.filter+=[empleado:[:]]
		   params['filter.op.empleado.id']="Equal"
		   params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong())
				
		}
	 
		def oportunidadInstanceList=filterPaneService.filter(params,OportunidadH )
	   
		render view:"indexh", model:[ oportunidadInstanceList: oportunidadInstanceList,
			oportunidadInstanceCount: filterPaneService.count( params, OportunidadH ),params:params,
			filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
			xtitulo:generalService?.getValorParametro('oportunt05')]
	}
	
	def listarBorrados(Integer max) {
		int itemxview=generalService.getItemsxView(0)
		params.max = itemxview
		String  xoffset=params.offset?:0

				
		if(!params.filter) params.filter = [op:[:]]
   
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado = '1'
		
		updateFilterLength()
		
		render view: 'index',  model:[ oportunidadInstanceList: filterPaneService.filter( params, Oportunidad ),
			oportunidadInstanceCount: filterPaneService.count( params, Oportunidad ),
			filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
			params:params, xtitulo:message(code:'borradas.oportunidad.label'),xcerrada:'N',xaccion:"listarBorrados"]
	}

	def listarGanadas(Integer max) {
		int itemxview=generalService.getItemsxView(0)
		params.max = itemxview
		String  xoffset=params.offset?:0
		
		if(!params.filter) params.filter = [op:[:],empleado:[:]]
		
		params.filter.op.idEstadoOportunidad = "Equal"
		params.filter.op.eliminado = "Equal"
		params.filter.idEstadoOportunidad = 'xganada'
		 
		if (params.filter.idSucursal){
			params.filter.idSucursal=generalService.getIdSucursal(params.filter.idSucursal)
		}
	 
		
		params.filter.eliminado = '0'

		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
			params.filter+=[empleado:[:]]
		   params['filter.op.empleado.id']="Equal"
		   params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong())
		}
		
		updateFilterLength()
		
		
		render view: 'index',  model:[ oportunidadInstanceList: filterPaneService.filter( params, Oportunidad ),
			oportunidadInstanceCount: filterPaneService.count( params, Oportunidad ),
			filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
			params:params, xtitulo:message(code:'ganadas.oppty.label'),xcerrada:'S',xaccion:"listarGanadas"]
	}

	def listarPerdidas(Integer max) {
		int itemxview=generalService.getItemsxView(0)
		 params.max = itemxview
		String  xoffset=params.offset?:0
		
		if(!params.filter) params.filter = [op:[:],empleado:[:]]
		params.filter.op.idEstadoOportunidad = "Equal"
		params.filter.idEstadoOportunidad ="xperdida"
		
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado = '0'
		
		if (params.filter.idSucursal){
			params.filter.idSucursal=generalService.getIdSucursal(params.filter.idSucursal)
		}
		
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
		   params.filter+=[empleado:[:]]
		   params['filter.op.empleado.id']="Equal"
		   params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong())

		}
		updateFilterLength()
		render view: 'perdidas',  model:[ oportunidadInstanceList: filterPaneService.filter( params, Oportunidad ),
			oportunidadInstanceCount: filterPaneService.count( params, Oportunidad ),
			filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
			params:params, xtitulo:message(code:'perdidas.oppty.label'),xcerrada:'S']
	}
	
	def listaPendientesPorNota(){
		params.max =5
		String  xoffset=params.offset?:0
		String xwherev; String xorden
		if (params.sort)
		xorden=" order by ${params.sort}"
		else
		xorden=" order by op.fechaApertura desc"
		if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
			xwherev=" and op.empleado.id=${generalService.getIdEmpleado(session['idUsuario'])}"
		} else  xwherev=''
	  
		def maxdias=generalService.getValorParametro('maxdiasnot')
	   
		def query ="""select op.id,op.numOportunidad,op.nombreCliente,n.fecha
                      from Oportunidad op, Nota n                       
                      where op.idUltimaNota=n.id and 
                      datediff(current_date(),n.fecha)>${maxdias} and  
                      n.eliminado=0 and op.eliminado=0"""+xwherev+xorden
	  
		def queryc ="""select count(op)
                      from Oportunidad op, Nota n                       
                      where op.idUltimaNota=n.id and 
                      datediff(current_date(),n.fecha)>${maxdias} and  
                      n.eliminado=0 and op.eliminado=0"""+xwherev
		
		def oportunidadInstanceList=Oportunidad.executeQuery(query,[max:params.max,offset:xoffset.toLong()])
			 
		def num=Oportunidad.executeQuery(queryc)
		
		render view:"notasPendientes", model:[oportunidadInstanceList:oportunidadInstanceList,
			oportunidadInstanceCount:num[0] ]
	}

	def show(Oportunidad oportunidadInstance) {
		respond oportunidadInstance
	}

	def showh() {
		def oportunidadInstance=OportunidadH.get(params.id)
		render view:"showh", model:[oportunidadInstance:oportunidadInstance]
	}
	
	def create() {
	   
		respond new Oportunidad(params),model:[swconvertir:'N']
	   
	}

	@Transactional //save
	def save(Oportunidad oportunidadInstance) {
   
	   
		
		if (oportunidadInstance == null) {
			notFound()
			return
		}
		
		if (params.idVendedor) {
			def empleadoInstance=Empleado.get(params.idVendedor.toLong())
			oportunidadInstance.empleado=empleadoInstance
			oportunidadInstance.nombreVendedor=empleadoInstance?.nombreCompleto()
		}
		
		if (params.idContacto !=null) {
			oportunidadInstance.persona=Persona.get(params.idContacto.toLong())
		}
		 
		if (params.idempresa !=null) {
			def empresaInstance=Empresa.get(params.idempresa)
			oportunidadInstance.empresa=empresaInstance
			oportunidadInstance.nombreCliente=empresaInstance.razonSocial
		}
		
		oportunidadInstance.trimestre=generalService.getTrim(oportunidadInstance.fechaCierreEstimada)
	   
		oportunidadInstance.numOportunidad=consecutivoService.oportunidad(params.idSucursal)
		
		if(params.swconvertir=='S') {
			oportunidadInstance.prospecto=Prospecto.get(params.idProspecto)
			oportunidadInstance?.prospecto?.idEstadoProspecto='propasopox'
			oportunidadInstance?.prospecto?.evolucion='10'    //mostrara chulo en propectos
		}
		oportunidadInstance.validate()
		if (oportunidadInstance.hasErrors()) {
		   // flash.message="Numero de Oportunidad ya existe. Intente de nuevo"
		   respond oportunidadInstance.errors, view:'create'
		   return
		}
	   
		generalService.crearContacto(params.long('idempresa'),params.long('idContacto'))
		
		oportunidadInstance?.empresa?.idUltimaTactica=oportunidadInstance.idTactica
		 
		oportunidadInstance.save(flush:true)

	   
		if (params.idautor && params.idVendedor){
			def xidautor=generalService.getIdEmpleado(params.long('idautor'))
		   
			if (xidautor != params.long('idVendedor')){
				
				println "ok notificando a vendedor sobre oportunidad"
			  // El creador de la oportunidad no es el vendedor final . hay que notificarlo
			   def xto=[]
			   
			   String urlbase=generalService.getValorParametro('urlaplic')
			   def xcierre=generalService.getValorParametro(oportunidadInstance.idEstadoOportunidad)
				xto.push(params.idVendedor)
				def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
				String xasunto="Se le ha asignado la siguiente oportunidad: "+oportunidadInstance.numOportunidad +" - "+oportunidadInstance?.empresa?.razonSocial
				String sucursal=generalService.getSucursal(oportunidadInstance?.idSucursal)
				String xcuerpo="<br><br>Consulte la oportunidad asignada <a href='${urlbase}/oportunidad/show/${oportunidadInstance.id}'> AQUI </a>"
				String mensaje="Enviado por: "+usuarioAccede+"<br><b>Detalles de la oportunidad:</b><br><br><b>Sucursal:</b> ${sucursal}<br><b>Raz&oacute;n social: </b>${oportunidadInstance?.empresa?.razonSocial}<br><b>Proyecto: </b>${oportunidadInstance?.nombreOportunidad}<br><b>Descripción:</b> ${oportunidadInstance?.descOportunidad?:'No tiene'}"+xcuerpo
				generalService.enviarCorreo(0,xto,xasunto, mensaje)
			}
		}
		 auditoriaService.logIn('Oportunidad',oportunidadInstance?.id)
		request.withFormat {
			form {
				// flash.message = message(code: 'default.created.message', args: [message(code: 'oportunidadInstance.label', default: 'Oportunidad'), oportunidadInstance.id])
				redirect  url:"/oportunidad/show/"+oportunidadInstance.id
			}
			'*' { respond oportunidadInstance, [status: CREATED] }
		}
	 
	}

	def edit(Oportunidad oportunidadInstance) {
	   
		respond oportunidadInstance, model:[sw:1]
	}
	
	@Transactional // update
	def update(Oportunidad oportunidadInstance) {
	  
	   // oportunidadInstance=Oportunidad.get(params.id)
		if (oportunidadInstance == null) {
			notFound()
			return
		}
		
	 
		if (params.idempresa) {
			oportunidadInstance.empresa=Empresa.get(params.idempresa.toLong())
			oportunidadInstance.nombreCliente=oportunidadInstance.empresa.razonSocial
		}
		
		if (params.idVendedor) {
		   oportunidadInstance.empleado=Empleado.get(params.idVendedor)
		   oportunidadInstance.nombreVendedor=oportunidadInstance.empleado.nombreCompleto()
		}
		if (params.idContacto) {
			oportunidadInstance.persona=Persona.get(params.idContacto.toLong())
			oportunidadInstance.nombreContacto=oportunidadInstance.persona.nombreCompleto()
		}
		
		def empresaInstance=Empresa.get(oportunidadInstance.empresa.id)

		if (!empresaInstance.nit){
			flash.warning="Nit es obligatorio Edite cliente y agréguelo"
			respond oportunidadInstance.errors, view:'edit'
			return
		}
		 
		if (oportunidadInstance?.idEtapa=='posventx50') oportunidadInstance?.idCondicion ='poscondi02'
		
		if (oportunidadInstance?.idEtapa=='posventa00') oportunidadInstance?.idEstadoOportunidad ='xperdida'
		
		if (oportunidadInstance?.idCondicion=='poscondi02'){
			oportunidadInstance?.idEtapa ='posventx50'
			
			def  idprosp=oportunidadInstance?.prospecto?.id
			if (idprosp){
				Prospecto.withNewSession { s2 ->
					def prospectoInstance=Prospecto.get(idprosp)
					prospectoInstance?.evolucion='CO' //muestra icono  $    en prospectos
					prospectoInstance.save()
					s2.flush()
					s2.close()
				}
			}
		}
		oportunidadInstance.trimestre=generalService.getTrim(oportunidadInstance.fechaCierreEstimada)
	  
		 
		oportunidadInstance.validate()
		
		if (oportunidadInstance.hasErrors()) {
			respond oportunidadInstance.errors, view:'create'
			return
		}
		
		generalService.crearContacto(params.long('idempresa'),params.long('idContacto'))
	   
		oportunidadInstance.save()
	   
		if (params.idTactica){
			Empresa.withNewSession { s2 ->
			   def empresaInstance1=Empresa.get(params.idempresa)
			   empresaInstance1.idUltimaTactica=params.idTactica.toLong()
			   empresaInstance1.save()
			   s2.flush()
			   s2.close()
			}
		}
		request.withFormat {
			form {
				flash.message = message(code: 'default.updated.message', args: [message(code: 'Oportunidad.label', default: 'Oportunidad'), oportunidadInstance.id])
				redirect  url:"/oportunidad/index?sort=fechaApertura&order=desc"
			  
			}
			'*'{ respond oportunidadInstance, [status: OK] }
		}
	   
	}
	
	@Transactional //borrar
	def borrar(Oportunidad oportunidadInstance) {
	 
		if (params.id == null) {
			notFound()
			return
		}
	   
		oportunidadInstance= Oportunidad.get(params.id)

		oportunidadInstance.eliminado=1

		oportunidadInstance.save flush:true

		request.withFormat {
			form {
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'Posigbilidad.label', default: 'Oportunidad'), oportunidadInstance.id])
				redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
			}
			'*'{ respond oportunidadInstance, [status: OK] }
		}
	}
	
	@Transactional //delete
	def delete(Oportunidad oportunidadInstance) {

		if (oportunidadInstance == null) {
			notFound()
			return
		}

		oportunidadInstance.delete flush:true

		request.withFormat {
			form {
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'Oportunidad.label', default: 'Oportunidad'), oportunidadInstance.id])
				redirect action:"index", method:"GET"
			}
			'*'{ render status: NO_CONTENT }
		}
	}

	protected void notFound() {
		request.withFormat {
			form {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'oportunidadInstance.label', default: 'Oportunidad'), params.id])
				redirect action: "index", method: "GET"
			}
			'*'{ render status: NOT_FOUND }
		}
	}

	@Transactional  //traerContactos
	def traerContactos(){
		render template:'comboContacto', model:[xcontactoList:Persona.findAllByIdTipoPersonaAndEliminado('percontact',0)]
		//[xcontactoList:Persona.findAllByIdTipoPersonaAndEliminado('percontact',0)]
	}


	def asignarVendedor(){

		def posList=new ArrayList()
		
		
		if(params.idOp)//ID de la oportunidad para cambiar o asignar el vendedor desde adentro
			posList.addAll(params.idOp)
		else
		{
			if(params?.oportunidades !=null){
				posList.addAll(params?.oportunidades)
				if (posList?.size()>1) {
					flash.warning = "Seleccione solo un registro"
					redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
				}
			}else{
				// flash.message = message(code: 'default.select.one')
				flash.warning = "Debe Seleccionar un registro"
				redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
			}
		}
		def vendedoresList=Empleado.findAllByEliminadoAndIdTipoEmpleadoAndIdEstadoEmpleado(0,'pervendedo','empleactiv')
		
		render view :'asignarVendedor', model:[vendedoresList:vendedoresList,
			posList:posList[0],
			xempresa:params.xempresa]
	}
 
	@Transactional //asignarVenderoDef
	def asignarVendedorDef(){
		def oportunidadInstance=Oportunidad.get(params.posList)
		if (params.idVendedor != null ){
			oportunidadInstance.empleado=Empleado.get(params.idVendedor.toLong())
			oportunidadInstance.nombreVendedor=oportunidadInstance.empleado
		}
		oportunidadInstance.observCambioVendedor=params.observCambioVendedor
		oportunidadInstance.save()
		// Envio de correo al nuevo vendedor
		def xdest=[]
		xdest.push(params.idVendedor.toLong())
		println xdest
		String urlbase=generalService.getValorParametro('urlaplic')
		def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
		String xasunto="Se le ha asignado la siguiente oportunidad: "+oportunidadInstance.numOportunidad +" - "+oportunidadInstance?.empresa?.razonSocial
		String sucursal=generalService.getSucursal(oportunidadInstance?.idSucursal)		
		String xcuerpo="<br><br>Consulte la oportunidad asignada <a href='${urlbase}/oportunidad/show/${oportunidadInstance.id}'> AQUI </a>"
		String mensaje="Enviado por: "+usuarioAccede+"<br><b>Detalles de la oportunidad:</b><br><br><b>Sucursal:</b> ${sucursal}<br><b>Raz&oacute;n social: </b>${oportunidadInstance?.empresa?.razonSocial}<br><b>Proyecto: </b>${oportunidadInstance?.nombreOportunidad}<br><b>Descripción:</b> ${oportunidadInstance?.descOportunidad?:'No tiene'}"+xcuerpo
		generalService.enviarCorreo(0,xdest,xasunto, mensaje)
		
		//Fin Envio de correo
		redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
	}

	def cerrarOportunidad(){		

		
		def posList=new ArrayList()
		
		if(params.idOp)//Ide de la oportunidad a borrar desde adentro
			posList.addAll(params.idOp)
		else
		{
			if(params?.oportunidades !=null)
			{
				posList.addAll(params?.oportunidades)
				if (posList?.size()>1)
				{
					flash.warning = message(code: 'default.select.one')
					redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
					return
				}
			}
			else
			{
				flash.warning = message(code: 'default.select.one')
				redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
				return
			}
		}
		
		
		
		
		def oportunidadInstance=Oportunidad.get(posList[0])
		
		if(!generalService.tieneItems(oportunidadInstance))//validar si la oportunidad tiene items
		{
				flash.warning="Oportunidad aun no tiene items. Por favor verifique"
				if(params.oportunidades)
				redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
				if(params.idOp)
				redirect url:"/oportunidad/show/${oportunidadInstance.id}"
				return
		}
		
		
		if (oportunidadInstance.idEstadoOportunidad in ['xganada','xperdida']){
			flash.warning="Oportunidad ya está cerrada. Verifique"
			redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
			return
		}
		render view :'cerrarOportunidad', model:[oportunidadInstance:oportunidadInstance]
	}
	
	@Transactional   //abrirOportunidad
	def abrirOportunidad(){
		
		def posList=new ArrayList()
		
		//JOSEDMAURY->22/07/2016
		if(params.idOp)//id de la oportunidadInstance desde adentro
			posList.addAll(params.idOp)
		else
		{
			if(params?.oportunidades !=null){
				posList.addAll(params?.oportunidades)
				if (posList?.size()>1) {
					flash.warning = message(code: 'default.select.one')
					redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
					return
				}
			}
			else
			{
				flash.warning = message(code: 'default.select.one')
				redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
				return
			}
		}
		
		
		def oportunidadInstance=Oportunidad.get(posList[0])
		
		if (oportunidadInstance.idEstadoOportunidad =='xperdida'){
			oportunidadInstance.idEstadoOportunidad="oporactiva"
			oportunidadInstance.idEtapa="posventx10"
			oportunidadInstance.observCierre=""
			oportunidadInstance.idMotivoPerdida=""
			flash.message="Oportunidad ha sido abierta"
			redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
			return
		}else{
			flash.warning="No aplica apertura de esta Oportunidad. Verifique"
			redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
			return
		}
		
	}
	
	@Transactional  // cerrarOportunidadDef
	def cerrarOportunidadDef(Oportunidad oportunidadInstance){
	
		oportunidadInstance.idEstadoOportunidad='xperdida'
		oportunidadInstance.idEtapa='posventa00'
		oportunidadInstance.idMotivoPerdida=params.idMotivoPerdida
		oportunidadInstance.observCierre=params.observCierre
		oportunidadInstance.fechaCierreReal= new Date()
	
		oportunidadInstance.eliminado=0
		 
		oportunidadInstance.save flush:true /*,failOnError: true*/
		
		if (oportunidadService.tieneRegistroFabricante('regmayibm',oportunidadInstance?.id.toString())){
			def xdest=[]
			def xcierre=generalService.getValorParametro(oportunidadInstance.idEstadoOportunidad)
			
			String xparam=generalService.getValorParametro('regoportun')
			xdest=generalService.convertirEnLista(xparam)
			String urlbase=generalService.getValorParametro('urlaplic')
			def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
			String xasunto="Oportunidad No.: "+oportunidadInstance.numOportunidad +", para "+oportunidadInstance?.empresa?.razonSocial+" --  Cerrada como "+xcierre
			String xcuerpo="Enviado por: "+usuarioAccede+"<br><br>Realice los cambios respectivos en el Registro de Oportunidad <a href='${urlbase}/oportunidad/show/${oportunidadInstance.id}'> AQUI </a>"
			generalService.enviarCorreo(1,xdest,xasunto, xcuerpo)
		}
		flash.message="Cierre de Oportunidad Realizado"
		redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
	}

	def datosCliente(){

		def clienteInstance=Empresa.get(params.id)
		render template :'infoCliente', model:[clienteInstance:clienteInstance,xidEmpresa:params.id]

	}
	
	def datosContacto(){
		redirect url:"/contacto/mostrarCboContacto/${params.id}?idValue=${params.idValue}"
	}
	   
	def datosPerdida(){

		String xronly="false"
		if (params?.sw=='xperdida') xronly="false"
		render template :'infoPerdida', model:[xronly:xronly]

	}
	
	def generarPedido(){ //todo validar que este el anexo Solicitud de oferta RFI/RFP (obligaorio)
	   
		def falla=oportunidadService.validarOportunidad(params.id)
		def oportunidadInstance=Oportunidad.get(params.id)
		
		if(!generalService.tieneItems(oportunidadInstance))//validar si la oportunidad tiene items
		{
				flash.warning="Oportunidad aun no tiene items. Por favor verifique"
				redirect url:"/oportunidad/show/${oportunidadInstance.id}"
				return
		}

		if (falla !=0){
			if (falla==1)  flash.warning="Vaya a pestaña 'propuestas' (abajo) y anexe o elija propuesta aprobada x cliente"
			if (falla==2) flash.warning="Antes de generar Pedido debe adicionar items"
			redirect url:"/oportunidad/show/${params.id}"
			return
		}

		redirect url:"/pedido/generarPedido/${params.id}"
	}
	
	def solicitarRegistro() {
		def posList=new ArrayList()
		if(params?.oportunidades !=null){
			posList.addAll(params?.oportunidades)
			if (posList?.size()>1) {
				flash.warning = "Seleccione solo un registro"
				redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
			}else{
				render view:'solicitarRegistro', model:[idOp:posList[0]]
			}
		}else{
			flash.warning = "Debe Seleccionar un registro"
			redirect url:"/oportunidad/index?sort=fechaApertura&order=desc"
		}
		
	}
	
	@Transactional //solicitarregistroDef
	def solicitarRegistroDef(){
			 
		def  OportunidadInstance= Oportunidad.get(params.idOp)
		Long xidsolicitante=generalService.getIdEmpleado(session['idUsuario'].toLong())
		def xfechaHora=generalService.getHoy(1)
		def xregistradores=generalService.getUsuariosFromParametro('usersregop',1)
		
		def registroOportunidadInstance=new RegistroOportunidad()
		
		registroOportunidadInstance.idRegistroEn=params.idRegistroEn
		registroOportunidadInstance.fecha=xfechaHora
		registroOportunidadInstance.idAutor=xidsolicitante
		registroOportunidadInstance.idAsignadoA=xregistradores[0]
		registroOportunidadInstance.idEstadoRegistroOportunidad='regenproc'
		registroOportunidadInstance.oportunidad=OportunidadInstance
		registroOportunidadInstance.eliminado=0
		
		registroOportunidadInstance.save()
		//  codigo que maneja el  log de prospectos via notas
		def xpadre=registroOportunidadInstance.oportunidad.prospectoId
		if (xpadre !=null) {
			String xtipo='notaseguim'
			String xentidad='prospecto'
			String xnota="Registro ante fabricante con estado: "+generalService.getValorParametro(registroOportunidadInstance.idEstadoRegistroOportunidad)
			generalService.registrarNota(xentidad,xpadre.toString(),xtipo,xnota)
		}
		// envio notificacion
		def xdest=[]
		String xparam=generalService.getValorParametro('regoportun')
		xdest=generalService.convertirEnLista(xparam)
		String urlbase=generalService.getValorParametro('urlaplic')
		def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
		String xasunto="Solicitud de registro de la oportunidad No.:"+OportunidadInstance.numOportunidad +" - "+oportunidadInstance?.empresa?.razonSocial
		String xcuerpo="Enviado por: "+usuarioAccede+"<br><br>Complete el registro creado ante el mayorista <a href='${urlbase}/oportunidad/show/${oportunidadInstance.id}'> AQUI </a>"
		generalService.enviarCorreo(1,xdest,xasunto, xcuerpo)
		flash.message="Registro de OPortunidad Solicitado"
		redirect url:"/Oportunidad/index?sort=fechaApertura&order=desc"
	}
   
	def archivarOportunidad(){

		def posList=new ArrayList()
		if(params?.oportunidades !=null){
			posList.addAll(params?.oportunidades)
			int sw=0
			posList[0].each(){
				def oportunidadInstance=Oportunidad.get(it)
				if (!(oportunidadInstance.idEstadoOportunidad in ['xganada','xperdida'])) sw=1
				else{
				  
				}
			}
			if (sw==1) flash.message="Hubo oportunidades no archivadas por estar abiertas"
			else  flash.message="Oportunidades elegidas han sido archivadas"
		}else{
			flash.warning = "Debe seleccionar uno o más registros"
		}
		redirect  url:"/oportunidad/index?sort=fechaApertura&order=desc"
	}
	
	def exportar(){
		String ext
		if (!params.id  in ['excel','json','xml']) {
			flash.warning="Format de exportación no permitido.Verifique"
			return
		}
		
		if (params.id=='excel') ext='xls'
		else if (params.formato=='json')  ext='json'  else ext='xml'
		  
		response.contentType = grailsApplication.config.grails.mime.types[params.id]
		response.setHeader("Content-disposition", "attachment; filename=oportunidades.${ext}")
		 
		Map campos = ['1_Num_Op':'numOportunidad',
						'2_Cliente': 'nombreCliente',
						'3_Proyecto':"nombreOportunidad",
						'4_Num_Reg':'numOportunidadFabricante',
						'5_Valor':'valorOportunidad',
						'6_Apertura':'fechaApertura',
						'7_Vendedor':'nombreVendedor',
						'8_Estado':'idEstadoOportunidad']
		 
		Map formatters = [:]
		Map parameters = [:]
		def entidad="crm.Oportunidad"
		def query="from Oportunidad where  eliminado=0"
		def datos=generalService.preExportar(entidad,query,campos,true)      //true filtrado false via query
		exportService.export(params.id, response.outputStream,datos, formatters, parameters)
	}
	def exportarPerdidas(){
		String ext
		if (!params.id  in ['excel','json','xml']) {
			flash.warning="Format de exportación no permitido.Verifique"
			return
		}

		if (params.id=='excel') ext='xls'
		else if (params.formato=='json')  ext='json'  else ext='xml'

		response.contentType = grailsApplication.config.grails.mime.types[params.id]
		response.setHeader("Content-disposition", "attachment; filename=oportunidades.${ext}")

		Map campos = ['1_Num_Op':'numOportunidad',
					  '2_Cliente': 'nombreCliente',
					  '3_Proyecto':"nombreOportunidad",
					  '4_Num_Reg':'numOportunidadFabricante',
					  '5_Valor':'valorOportunidad',
					  '6_Apertura':'fechaApertura',
					  '7_Vendedor':'nombreVendedor',
					  '8_Estado':'idEstadoOportunidad',
					  '9_Motivo_Perdida':'idMotivoPerdida']

		Map formatters = [:]
		Map parameters = [:]
		def entidad="crm.Oportunidad"
		def query="""from Oportunidad where  eliminado=0 and idEstadoOportunidad='xperdida'"""
		def datos=generalService.preExportar(entidad,query,campos,true)      //true filtrado false via query
		exportService.export(params.id, response.outputStream,datos, formatters, parameters)
	}
	 def exportar1(){ // Exporta vista forecast
		String ext
		if (!params.id  in ['excel','json','xml']) {
			flash.warning="Format de exportación no permitido.Verifique"
			return
		}
		
		if (params.id=='excel') ext='xls'
		else if (params.formato=='json')  ext='json'  else ext='xml'
		  
		response.contentType = grailsApplication.config.grails.mime.types[params.id]
		response.setHeader("Content-disposition", "attachment; filename=forecast.${ext}")
		 
		Map campos = ['1_Num_Op':'numOportunidad',
					  '2_Cliente': 'nombreCliente',
					  '3_Proyecto':"nombreOportunidad",
					  '4_Valor':'valorOportunidad',
					  '5_Vendedor':'nombreVendedor',
					  '6_Q':'trimestre',
					  '7_Prob':'idEtapa',
					  '8_Ultima_Gestion':'idUltimaNota']
		 
		Map formatters = [:]
		Map parameters = [:]
	   
		def entidad="crm.Oportunidad"
		def  entidadInstanceList=generalService.filtrar(session.filterParams,entidad)
		 List datos=[];def xnota;def xetapa
		 Map reg
		for (def entidadInstance in entidadInstanceList){
			reg=[:]
			xnota=Nota.get(entidadInstance?.idUltimaNota)
			
			xetapa=generalService.getValorParametro(entidadInstance.idEtapa)
			
			for (x in campos){
				if(x.value=='idEtapa'){
					reg[x.key]=xetapa
				}else if (x.value=='idUltimaNota'){
				   reg[x.key]=xnota
				}else
				  reg[x.key]=entidadInstance["${x.value}"]
			}
			datos.add(reg)
		}
		
		exportService.export(params.id, response.outputStream,datos, formatters, parameters)
	}
	
	def requerimiento(Integer max) {
		def requerimientoList
		 render(view:"requerimiento",  model:[requerimientoList : requerimientoList])
		
	}
	
	
	def retornarValor= //LO QUE SE CARGARA CUANDO SE HAGA CLIC EN ALGUN RADIOBUTTON
	{
		def vAsociados
		def ciudadesAsociadas
		Long[]ids
		Long[]cityIds		
		def usuarioLogueado=generalService.getIdEmpleado(session['idUsuario'].toLong())
		println "|||||||||||||||||||||||||||||PARAMS.Q||||||||||||||||||||| "+params.Q
		String Ques=params.Q.toString()?:"Q1"
		
		println "QUEEEEEEEEEEEEEEEEEEEEEEEEES ////////////////////////////"+Ques
		def userName = Usuario.where {empleado.id==usuarioLogueado}.toList()[0]
		def userId=userName.id
		
		
		String[]Q=Ques.split(",")
		println "LLLLLLLLLLLLLLLLLLLAS QQQQQQQQQQ SLOOOOOOOOOOOOOOON2"+Q
		if(params.ciudadesAsociadas)
		{
			ciudadesAsociadas=generalService.stringToLongArray(params.ciudadesAsociadas)//ciudades Asociados
			cityIds=ciudadesAsociadas
		}
		else
		{
			def sucursalActual=Empleado.executeQuery("select idSucursal from Empleado where id=${usuarioLogueado}")[0]
			cityIds=sucursalActual
		}
		println "CITY IDS "+cityIds
		
		if(params.vAsociados)//si algun vendedor se selecciona
		{
			vAsociados=generalService.stringToLongArray(params.vAsociados)//vendedores Asociados
			ids=vAsociados
		}
		else
		{
			ids=[usuarioLogueado]
		}

		
		
		 //9 GBATISTA , 13 JBORELLY
		def infoEmpleadoQ=generalService.infoQEmpleado(ids, Q, "2017",cityIds)
		
		
		//lo que viene es para no da?r la logica
		if(generalService.getRolUsuario(userId).equals('GERENTE'))
		{
			if(!params.vAsociados||!params.ciudadesAsociadas||!params.Q)//SI SE DEJA DE SELECCIONAR ALGUNA CIUDAD O VENDEDOR O Q
			{
				infoEmpleadoQ.each {k,v->
					infoEmpleadoQ.put(k,0)
				}
			}
		}
		
		if(generalService.getRolUsuario(userId).equals('VENDEDOR'))
		{
			if(!params.ciudadesAsociadas||!params.Q)//SI SE DEJA DE SELECCIONAR ALGUNA CIUDAD O VENDEDOR O Q
			{
				infoEmpleadoQ.each {k,v->
					infoEmpleadoQ.put(k,0)
				}
			}
		}
		
		//println "infoEmpleadoQ "+infoEmpleadoQ
		
		render infoEmpleadoQ as JSON // ME DEVUELVE VIA AJAX LA RESPUESTA
	}
	
	//def infoQMaury()//LO QUE SE CARGARA POR DEFECTO EN LA PAGINA
	def indicadoresPorQ()//LO QUE SE CARGARA POR DEFECTO EN LA PAGINA
	{
		//CODIGO POR JOSE DANIEL MAURY

		
		//println "USUARIO LOGUEADO"+generalService.getRolUsuario(9)
		
		def usuarioLogueado=generalService.getIdEmpleado(session['idUsuario'].toLong())
		def userName = Usuario.where {empleado.id==usuarioLogueado}.toList()[0]
		def userId=userName.id
		
		
		
		//LOS GERENTES SON EMPLEADO.ID=33,85,43
		
		def idsVendedores
		def vendedores
		
		def nombreUsuario=generalService.getNombreEmpleado(userId)
		//println "PRUEBAAAAA PARAMS"+params
		String[] Q=["Q1"]
		
		println "USUARIO LOGUEADO ID "+usuarioLogueado
		def sucursalActual=Empleado.executeQuery("select idSucursal from Empleado where id=${usuarioLogueado}")[0]
		
		Long[]ids=[usuarioLogueado]//id de la tabla empleados del usuario logueado
		Long[]cityIds=[sucursalActual]//id de la sucursal del usuario logueado
		
		println "sucursalActual "+sucursalActual
		def infoEmpleadoQ=generalService.infoQEmpleado(ids, Q, "2018",cityIds)
		
		if(generalService.getRolUsuario(userId).equals('GERENTE'))
		{
			idsVendedores=generalService.traerVendedoresPorGerente("${userName}V")//userName + letra V(nomenclatura utilizada)
			vendedores=Empleado.getAll(idsVendedores)
			println "HA INGRESADO UN GERENTE"+userName
		}

		def idsSucursales=[1,2,3,4]
		def sucursales=Empresa.getAll(idsSucursales)
		

		//println "Info Empleado Q "+infoEmpleadoQ
		render(view:"indexInfoQ",  model:[infoEmpleadoQ:infoEmpleadoQ,vendedores:vendedores,usuarioLogueado:nombreUsuario,
			sucursales:sucursales,usuarioLogueadoId:usuarioLogueado])
		
		//def HinfoEmpleadoQ=generalService.infoQEmpleado("9", "Q1", "2016").asignado
		//println "ASIGNADO"+HinfoEmpleadoQ
		//render(view:"indexInfoQ")*/
		
		//render(view:"indexInfoQ")
	}
}
