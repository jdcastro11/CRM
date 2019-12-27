package crm

class DashboardController extends BaseController {
  def generalService
  
  def render=
  {
	  
	  
	  //def pc=Dashboard.
	  
	  def usuarioLogueado=generalService.getIdEmpleado(session['idUsuario'].toLong())
	  def userName = Usuario.where {empleado.id==usuarioLogueado}.toList()[0]
	  def userId=userName.id
	  def idsVendedores
	  def vendedores
	  def nombreUsuario=generalService.getNombreEmpleado(userId)
	  println "////////////////////////-----PARAMS.QZIZE---------/////////////"
	  String[]Q
	  if(params.QinfoQ.toString().length()==2)
	  Q=[params.QinfoQ]
	  else
	  Q=params.QinfoQ
	  
	  
	  def ciudadesprueba=generalService.stringToLongArray(params.sucursales.toString())
	  println "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%##################### "+ciudadesprueba
	  def a=Integer.valueOf(params.sucursales)//params.sucursales viene como character de dashboardMaury
	  println "------------------------P-A-R-A-M-S----------------------------------- "+a
	  def sucursalActual=Empleado.executeQuery("select idSucursal from Empleado where id=${usuarioLogueado}")[0]
	  Long[]ids=[9?:9]//id de la tabla empleados del usuario logueado
	  
	  

	  Long[]cityIds=[a]?:[sucursalActual]//id de la sucursal del usuario logueado
	  println params.sucursales
	  println "CITY IDS-> "+cityIds
	  println "--------------------------------------------ENTRE AQQU�-----------------------------------------------------------"+params.sucursales
	  def infoQ=generalService.infoQEmpleado(ids, Q, "2016",cityIds)
	  
	  
	  def forecastTemp=infoQ.porcentajeForecast  
	  if(forecastTemp.equals("No aplica"))
	  forecastTemp=0
	  
	  
	  def myDailyActivitiesColumns = [['string', 'Tarea'], ['number', 'Generado'],['number', 'Asignado'],['number', 'Forecast'],['number', 'Ganado'],['number', 'Facturado'],['number', 'Perdido']]
	  def myDailyActivitiesData = [['Indicadores',infoQ.porcentajeGenerado,infoQ.porcentajeAsignado,forecastTemp,infoQ.porcentajeGanada,infoQ.porcentajeFacturado,infoQ.porcentajePerdido]]
	  
	  render template: "plantillagchart", model: ["myDailyActivitiesColumns": myDailyActivitiesColumns,
	  "myDailyActivitiesData": myDailyActivitiesData]
  }
  
    def index() {
      def idUsuario=generalService.getRolUsuario(session['idUsuario'])
    if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())||
		'GERENTE'  in generalService.getRolUsuario(session['idUsuario'].toLong())) 
	{
       //render view :'index'
		redirect url:"/oportunidad/indicadoresPorQ"

	/*	

		def usuarioLogueado=generalService.getIdEmpleado(session['idUsuario'].toLong())
		def userName = Usuario.where {empleado.id==usuarioLogueado}.toList()[0]
		def userId=userName.id
		def idsVendedores
		def vendedores
		def nombreUsuario=generalService.getNombreEmpleado(userId)
		String[] Q=["Q3"]
		def sucursalActual=Empleado.executeQuery("select idSucursal from Empleado where id=${usuarioLogueado}")[0]
		Long[]ids=[9]//id de la tabla empleados del usuario logueado
		Long[]cityIds=[sucursalActual]//id de la sucursal del usuario logueado
		def infoQ=generalService.infoQEmpleado(ids, Q, "2016",cityIds)
		
		
		println "EL ID DEL USUARIO ESSSSSSSS "+usuarioLogueado
		
		
		def mimapa=generalService.oportunidadesPorProbabilidad(usuarioLogueado)
		
		//println "MI MAPA"+mimapa
		mimapa.op10
		mimapa.op25
		mimapa.op50
		mimapa.op75
		mimapa.op100
		

		if(generalService.getRolUsuario(userId).equals('GERENTE') || usuarioLogueado==61)
		{
			idsVendedores=generalService.traerVendedoresPorGerente("${userName}V")//userName + letra V(nomenclatura utilizada)
			vendedores=Empleado.getAll(idsVendedores)
			println "HA INGRESADO UN GERENTE"+userName
		}

		
		def oportunidades = [['string', 'Tarea'], ['number', 'Porcentaje']]
		def porcentajeOp = [['Opor10%', mimapa.op10], ['Opor25%', mimapa.op25], ['Opor50%', mimapa.op50], ['Opor75%', mimapa.op75],['Opor100%', mimapa.op100]]
		def forecastTemp=infoQ.porcentajeForecast

		if(forecastTemp.equals("No aplica"))
		forecastTemp=0
		def myDailyActivitiesColumns = [['string', 'Tarea'], ['number', 'Generado'],['number', 'Asignado'],['number', 'Forecast'],['number', 'Ganado'],['number', 'Facturado'],['number', 'Perdido']]
		def myDailyActivitiesData = [['Indicadores',infoQ.porcentajeGenerado,infoQ.porcentajeAsignado,forecastTemp,infoQ.porcentajeGanada,infoQ.porcentajeFacturado,infoQ.porcentajePerdido]]
		//def myDailyActivitiesData = [['Indicadores',infoQ.porcentajeGenerado,infoQ.porcentajeGenerado,infoQ.porcentajeGenerado,infoQ.porcentajeGenerado,infoQ.porcentajeGenerado,infoQ.porcentajeGenerado]]
		//def myDailyActivitiesData = [['Indicadores',500,500,900]]
	
		def idsSucursales=[1,2,3,4]
		def sucursales=Empresa.getAll(idsSucursales)
		
	   render view :'dashboarMaury',model:[hola:"holsssssa",myDailyActivitiesColumns:myDailyActivitiesColumns,myDailyActivitiesData:myDailyActivitiesData,
		   oportunidades:oportunidades,porcentajeOp:porcentajeOp,sucursales:sucursales,usuarioLogueado:nombreUsuario,vendedores:vendedores,
		   usuarioLogueadoId:usuarioLogueado]


		*/

    }else if('ASISTENTE_VENTAS'  in generalService.getRolUsuario(session['idUsuario'].toLong())  ){

			            redirect url:"/oportunidad/indexc"
    }else if('ADMIN_FUNCIONAL'  in generalService.getRolUsuario(session['idUsuario'].toLong())) {}

		redirect url:"/seguridad/index"
          
   }
}