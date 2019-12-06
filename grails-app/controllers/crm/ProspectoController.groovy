package crm
import static org.springframework.http.HttpStatus.*

import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ProspectoController extends BaseController{

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
    def generalService
    def oportunidadService
    def consecutivoService
    def filterPaneService
    def auditoriaService
    def exportService 
    def exportarService
	def resultadosfiltro_export
    def prueba
    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview 
        String  xoffset=params.offset?:0
       
        
        if(!params.filter) params.filter = [op:[:],empleado:[:]]
     
        params.filter.op.eliminado = "Equal"     
        params.filter.eliminado = '0' 
		
		println params as JSON
		//params.filter.op.idEstadoProspecto  = "InList"
		//params.filter.idEstadoProspecto ="Activo"

		
        if(params.filter.idEstadoProspecto != null){          
            params.filter.idEstadoProspecto=generalService.getIdValorParametro('eprospecto',params.filter.idEstadoProspecto)

        }
		
		//generalService.notificarProspectosSinAtender()
		
		
		if (params.filter.idSucursal){
			params.filter.idSucursal=generalService.getIdSucursal(params.filter.idSucursal)
		}
		
		params.filter.op.idEstadoProspecto="NotILike"
		params.filter.idEstadoProspecto="x"
        if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
           params.filter+=[empleado:[:]]
           params['filter.op.empleado.id']="Equal"             
           params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong()) 
        }      
        session.filterParams=params
		
		
		
		updateFilterLength()
			
		
		
         
        render view: "index",  model:[prospectoInstanceList:filterPaneService.filter(params, Prospecto),
            prospectoInstanceCount: filterPaneService.count( params, Prospecto ),
            filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
            xtitulo:message(code:"prospectoIndex.prospecto.label"),params:params,xcerrada:'N']
		
    }
	
	

  
    // ver prospecto convertidos
    def indexg(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview 
        String  xoffset=params.offset?:0
        
        if(!params.filter) params.filter = [op:[:],empleado:[:]]
     
        params.filter.op.eliminado = "Equal"     
        params.filter.eliminado = '0' 
        params.filter.op.idEstadoProspecto="Equal"
        params.filter.idEstadoProspecto="propasopox"
		
		if (params.filter.idSucursal){
			params.filter.idSucursal=generalService.getIdSucursal(params.filter.idSucursal)
		}
         
        if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
           params.filter+=[empleado:[:]]
           params['filter.op.empleado.id']="Equal"             
           params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong()) 
               
        }      
		
		updateFilterLength()
             
        render view: "index",  model:[prospectoInstanceList:filterPaneService.filter(params, Prospecto),
            prospectoInstanceCount: filterPaneService.count( params, Prospecto ),
            filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
            xtitulo:message(code:'prospectosConvertidos.label', default:'Prospectos convertidos') ,params:params,xcerrada:"S",xaccion:'indexg']
    }
	
	

    
    def indexp(Integer max) {//LISTA DE PROSPECTOS DESCALIFICADOS
        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview 
        String  xoffset=params.offset?:0
        
        if(!params.filter) params.filter = [op:[:],empleado:[:]]
     
        params.filter.op.eliminado = "Equal"     
        params.filter.eliminado = '0' 
        params.filter.op.idEstadoProspecto="Equal"
        params.filter.idEstadoProspecto="prodescalx"
		
		if (params.filter.idSucursal){
			params.filter.idSucursal=generalService.getIdSucursal(params.filter.idSucursal)
		}
         
        if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
           params.filter+=[empleado:[:]]
           params['filter.op.empleado.id']="Equal"             
           params.filter.empleado.id=generalService.getIdEmpleado(session['idUsuario'].toLong()) 
		   
		   
               
        }  
		updateFilterLength()
             
        render view: "index",  model:[prospectoInstanceList:filterPaneService.filter(params, Prospecto),
            prospectoInstanceCount: filterPaneService.count( params, Prospecto ),
            filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
            xtitulo:message(code:'descalificadosTitle.prospecto.label', default:'Prospectos descalificados') ,params:params,xcerrada:"S",xaccion:'indexp']
    }
    
    def filter(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview 
        String  xoffset=params.offset?:0
        String xwhere
        String xorder
        
        String query="from Prospecto as p join fetch p.empleado as e join fetch p.empresa as em join fetch p.persona as pe where  p.eliminado=0 "
        
        String queryc="select count(p) from  Prospecto as p join p.empleado as e  where  p.eliminado=0 "
         
        if ('VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())){
            def xnom=generalService.traerEmpleado(session['idUsuario'].toLong())
            def xnombre=xnom[0]        
         
            xwhere=" and e.primerNombre='${xnombre[0]}' and e.primerApellido='${xnombre[1]}' "
          
        }else{ 
            xwhere=""
        }

        if (params.sort !=null)
        xorder=" order by "+params.sort+" "+params.order
        
        query=query+xwhere+xorder
        queryc=queryc+xwhere 
       
        def prospectoInstanceList=Prospecto.findAll(query,[max:params.max,offset:xoffset.toLong()])
       
        def prospectoCount=Prospecto.executeQuery(queryc)
       
        respond prospectoInstanceList,  model:[prospectoInstanceCount: prospectoCount[0],          
            xtitulo:generalService?.getValorParametro('prospect01')]
    }

    def listarBorrados(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max = Math.min(max ?: itemxview, 100)
        String  xoffset=params.offset?:0
       
         if(!params.filter) params.filter = [op:[:]]   
        params.filter.op.eliminado = "Equal"     
        params.filter.eliminado = '1' 
		
		if (params.filter.idSucursal){
			params.filter.idSucursal=generalService.getIdSucursal(params.filter.idSucursal)
		}
		
		updateFilterLength()
		
        render view: "index", model: [ prospectoInstanceList: filterPaneService.filter( params, Prospecto ),
            prospectoInstanceCount:filterPaneService.count( params, Prospecto ),
            itemxview:itemxview,
            xtitulo:message(code:'listarProspectosBorrados.label',default:'Prospectos borrados'),sw:0,xaccion:"listarBorrados"]
    }


    def exportarDatos=
    {	
		
		List lista_export=[]
		//el nombre de los campos fields es como est�n definidos en la clase dominio
        List fields = ["numProspecto","empresa","nombreProspecto","empleado","nombreContacto","valorProspecto","fechaApertura","idEstadoProspecto"]
        Map labels = ["numProspecto": "Codigo", "empresa":"Empresa","nombreProspecto":"Proyecto","empleado":"Vendedor","nombreContacto": "Contacto","valorProspecto":"Valor","fechaApertura":"Fecha Apertura","idEstadoProspecto":"Estado"]
		
		def estadovalorparametro_to_string = {Prospecto, value ->
			return generalService.getValorParametro(Prospecto.idEstadoProspecto)//dado el string devuelve el estado del prospecto
		}		
		
		def date_solo_fecha = {Prospecto, value ->
			return Prospecto.fechaApertura.format("dd-MM-yyyy")
		}
		
		Map formatters = [idEstadoProspecto:estadovalorparametro_to_string,fechaApertura:date_solo_fecha]		
		String filename=exportarService.setfilename(params.titulo)		

		
		
		if(params.tipo_export=='1')//exportar todos
		{	
			List idss=resultadosfiltro_export.id
			lista_export=exportarService.obtenerItemsSeleccionados(Prospecto,idss)			
		}
		else //exportar seleccionados
		{
			List ids=params.list('prospectos')//ids de items seleccionados
			lista_export=exportarService.obtenerItemsSeleccionados(Prospecto,ids)//lista de checkbox seleccionados
			
		}
		exportarService.exportar(Prospecto,lista_export,fields,labels,response,formatters,filename)		
    }
    
    def show(Prospecto prospectoInstance) {        
        respond prospectoInstance,model:[sw:0]
    }

    def create() {          
        respond new Prospecto(params), model:[sw:1]
    }

    @Transactional //save
    def save(Prospecto prospectoInstance) {
        
        if (prospectoInstance == null) {
            notFound()
            return
        }
        if (params.idempresa){   
            prospectoInstance.empresa=Empresa.get(params.idempresa)
        }
        if (params.idVendedor) { 
            prospectoInstance.empleado=Empleado.get(params.idVendedor)
            prospectoInstance.nombreVendedor=prospectoInstance.empleado.nombreCompleto()
            prospectoInstance.idEstadoProspecto='proasignad'
        }
        if (params.idContacto) { 
            prospectoInstance.persona=Persona.get(params.idContacto)
            prospectoInstance.nombreContacto=prospectoInstance.persona.nombreCompleto()
        }  
        
        prospectoInstance.trimestre=generalService.getTrim(prospectoInstance.fechaApertura)
       
        prospectoInstance.validate()
        
        if (prospectoInstance.hasErrors()) {
            respond prospectoInstance.errors, view:'create'
            return
        }
        generalService.crearContacto(params.long('idempresa'),params.long('idContacto'))  
        
        prospectoInstance.numProspecto=consecutivoService.prospecto(params.idSucursal) 
        
        prospectoInstance?.empresa?.idUltimaTactica=params.idTactica.toLong()
        prospectoInstance.save flush:true
        
        
        auditoriaService.logIn('Prospecto',prospectoInstance?.id)
        
        request.withFormat {
            form {
                flash.message ="Nuevo registro creado exitosamente" 
                //redirect  url:"/Prospecto/index?sort=fechaApertura&order=desc"
				redirect  url:"/Prospecto/show/"+prospectoInstance.id
            }
            '*' { respond prospectoInstance, [status: CREATED] }
        }
    }

    def edit(Prospecto prospectoInstance) {
        respond prospectoInstance
    }

    @Transactional //Update
    def update(Prospecto prospectoInstance) {
       
        prospectoInstance=Prospecto.get(params.id)
        
        prospectoInstance.properties=params
        
       
        if (params.idempresa){  
            prospectoInstance.empresa=Empresa.get(params.idempresa)
        }
        
        if (params.idVendedor) {            
            prospectoInstance.empleado=Empleado.get(params.idVendedor)           
            prospectoInstance.nombreVendedor=prospectoInstance.empleado.nombreCompleto()
        }
        if (params.idContacto) { 
            prospectoInstance.persona=Persona.get(params.idContacto)
            prospectoInstance.nombreContacto=prospectoInstance.persona.nombreCompleto()
        } 
        prospectoInstance.trimestre=generalService.getTrim(prospectoInstance.fechaApertura)
      
        
        prospectoInstance.validate()        
        
        if (prospectoInstance.hasErrors()) {
            respond prospectoInstance.errors, view:'edit'
            return
        }
        
        generalService.crearContacto(params.long('idempresa'),params.long('idContacto'))          
      
        prospectoInstance.save()  
        if (params.idTactica){
        Empresa.withNewSession { s2 ->            
           def empresaInstance=Empresa.get(params.idempresa)
           empresaInstance.idUltimaTactica=params.idTactica.toLong()
           empresaInstance.save()
           s2.flush()
        }       
        }   
           
        request.withFormat {
            form {
                flash.message =message(code:'actualizado.exito.label',default:'Registro actualizado exitosamente') // "Registro actualizado exitosamente" 
                redirect  url:"/Prospecto/index?sort=fechaApertura&order=desc"
              
            }
            '*'{ respond prospectoInstance, [status: OK] }
        }
    }
    
    @Transactional  //borrar
    def borrar(Prospecto prospectoInstance) {
     
        if (params.id == null) {
            notFound()
            return
        }
       
        prospectoInstance= Prospecto.get(params.id)

        prospectoInstance.eliminado=1

        prospectoInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code:'borrado.exito.label',default:'Registro eliminado exitosamente')
                redirect url:"/prospecto/index?sort=fechaApertura&order=desc"
            }
            '*'{ respond prospectoInstance, [status: OK] }
        }
    }
    
    @Transactional  //delete
    def delete(Prospecto prospectoInstance) {

        if (prospectoInstance == null) {
            notFound()
            return
        }

        prospectoInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Prospecto.label', default: 'Prospecto'), prospectoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.warning = message(code: 'default.not.found.message', args: [message(code: 'prospectoInstance.label', default: 'Prospecto'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Transactional  //traerContactos
    def traerContactos(){
        def  xcontactoList= generalService.listaContactos(prospectoInstance.empresa.id)
        render template:'comboContacto', model:[xcontactoList:xcontactoList]
    }   

    def descalificar(){
        
		def posList=new ArrayList()
		def razonesList=generalService.getValoresParametro('trazon')
		
		if (params?.prospectos==null ) {
			
			if(params.idProsp)
			{posList.addAll(params.idProsp)
			render view :'descalificar', model:[razonesList:razonesList,prospectos:params.idProsp]}
			else{
            flash.warning = message(code: 'default.select.one','Seleccione por lo menos un registro')
            redirect url:"/prospecto/index?sort=fechaApertura&order=desc"  
            return}
        }else {  
            
            posList.addAll(params.prospectos) 
            
            render view :'descalificar', model:[razonesList:razonesList,prospectos:params.prospectos]
        }
    }
    
    @Transactional  //DescalificarDef
    def descalificarDef(){
        
        int sw=0
        if (params.prospectos!=null){         
            def elegidos = params.prospectos.split(',').collect{it}                      
            elegidos.each({
                    
                    def prospectoInstance=Prospecto.get(it)
                    if (!(prospectoInstance.idEstadoProspecto in ['propasopox','prodescalx'])){             
                        prospectoInstance.idEstadoProspecto='prodescalx'
                        prospectoInstance.idRazonCancelacion=params.idRazonCancelacion
                        prospectoInstance.otraRazonCancelacion=params.otraRazonCancelacion                        
                        prospectoInstance.save(flush:true)                        
                    }else sw=1                                
                })
            if (sw==0)
            flash.message=message(code:'descalificar.exito.label',default:'Descalificaci�n ha sido exitosa') //"Descalificación ha sido exitosa "
            else 
            flash.warning=message(code:'descalificar.error.label',default:'Alguno(s) prospectos no se descalificaron porque no aplica')                     
        }
        
        redirect url:"/prospecto/index?sort=fechaApertura&order=desc"
        
    }     
    
    @Transactional  //calificar
    def calificar(){
         
        if (params.prospectos!=null){  
            def posList=new ArrayList()
            posList.addAll(params.prospectos)            
            int sw=0
            posList.each({
                    def prospectoInstance=Prospecto.get(it)
                    if (prospectoInstance.idEstadoProspecto =='prodescalx'){
                        prospectoInstance.idEstadoProspecto='proasignad'
                        prospectoInstance.idRazonCancelacion=''
                        prospectoInstance.otraRazonCancelacion=''               
                        prospectoInstance.save()
                    }else sw=1  
                })
            if (sw==0)
            flash.message=message(code:'calificar.exito.label',default:'Calificaci�n ha sido exitosa')//"Calificación ha sido exitosa "
            else 
            flash.warning=message(code:'calificar.error.label',default:'Alguno(s) no se calificaron por no estar descalificados')  
        }
        redirect url:"/prospecto/index?sort=fechaApertura&order=desc"
    }
 
    def convertir(){   
        def posList=new ArrayList()
		def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
		
		
		if(params.idProsp)
			posList.addAll(params.idProsp)
		else
		{
			if (params.prospectos==null ) {
				flash.warning = message(code: 'default.select.one',default:'Por favor seleccione un registro')
				redirect url:"/prospecto/index?sort=fechaApertura&order=desc"
				return
			}else {
				posList.addAll(params.prospectos)
				// def elegidos=[params.prospectos].flatten()
				if (posList.size() > 1){
					flash.warning = message(code: 'default.select.one')
					redirect url:"/prospecto/index?sort=fechaApertura&order=desc"
					return
				}
			}
		}
		
		

        
        def xnump=Oportunidad.executeQuery("select count(p) from Oportunidad p where prospecto.id=${posList[0]} and p.eliminado=0")          
         
        if (xnump[0] > 0 ){            
            flash.warning=message(code:'prospecto.convertido.error', default:'El prospecto elegido, ya fue convertido en  oportunidad') 
            redirect url:"/prospecto/index?sort=fechaApertura&order=desc"  
            return
        }
        
        def prospectoInstance=Prospecto.get(posList[0]) 
        
        if (!prospectoInstance?.empresa?.nit /*|| !prospectoInstance?.empresa?.idCiudad*/){			
			//if(!prospectoInstance?.empresa?.nit)			
				flash.warning=message(code:'requiereNit.label',default:'Se requiere NIT del cliente potencial. Definalo mediante la accion interna Definir Nit')			
			/*else
				{					
					String idEmpresa=Prospecto.get(params.idProsp?:params.prospectos).empresa.id					
					String urlCliente="${generalService.getValorParametro('urlaplic')}/empresa/show/${idEmpresa}?tipo=2&layout=main&t=empresat08"					
					flash.warning=message(code:'requiereNit.label',default:'Este cliente no tiene una ciudad asociada. Por favor edite el cliente y modifique su ciudad <a href='+urlCliente+" target='_blank' style='text-decoration:underline'>AQUI</a>")
					log.warn("${usuarioAccede} intent\u00f3 convertir un prospecto del cliente "+prospectoInstance?.empresa+" a oportunidad. Fall\u00f3")

				}*/
           
		   if(params.prospectos)//SI SE SELECCIONO UN CHECKBOX
            redirect url:"/prospecto/index?sort=fechaApertura&order=desc"
		   if(params.idProsp)//SI SE SELECCIONO CONVERTIR DESDE ADENTRO			
			redirect url:"/prospecto/show/${params.idProsp}"			  
            return
        }

		
		
        def vendedoresList=Empleado.findAllByEliminadoAndIdTipoEmpleadoAndIdEstadoEmpleado(0,'pervendedo','empleactiv',[sort:'primerNombre'])
        render view :'convertir', model:[prospectoInstance:prospectoInstance, vendedoresList:vendedoresList]        
    }
 
    @Transactional // ConvertirDef
    def convertirDef(Prospecto prospectoInstance){
        def oportunidadInstance=new Oportunidad() 
        def empresaInstance=Empresa.get(prospectoInstance.empresa?.id)
        oportunidadInstance.empresa=empresaInstance
        oportunidadInstance.nombreCliente=empresaInstance.razonSocial
        oportunidadInstance.prospecto=prospectoInstance
        oportunidadInstance.empleado=Empleado.get(params.long('idVendedor'))
        oportunidadInstance.idSucursal=prospectoInstance.idSucursal
        oportunidadInstance.nombreVendedor=oportunidadInstance.empleado.nombreCompleto()
        oportunidadInstance.persona=Persona.get(prospectoInstance.persona?.id)
        oportunidadInstance.nombreOportunidad=prospectoInstance.nombreProspecto
        oportunidadInstance.descOportunidad=prospectoInstance.descProspecto
        oportunidadInstance.valorOportunidad=prospectoInstance.valorProspecto
        oportunidadInstance.estrategiaId=prospectoInstance?.estrategiaId
        oportunidadInstance.idTactica=prospectoInstance?.idTactica?.toLong()
        oportunidadInstance.fechaCierreEstimada=prospectoInstance.fechaCierreEstimada
        oportunidadInstance.fechaApertura=new Date()
        oportunidadInstance.idEstadoOportunidad='oporactiva'
        oportunidadInstance.eliminado=0
        oportunidadInstance.numOportunidadFabricante=prospectoInstance.numOportunidadFabricante
       
        render view:'generarOportunidad', model:[oportunidadInstance:oportunidadInstance,xidprospecto:prospectoInstance?.id, swconvertir:'S']
    }
    
    @Transactional   //revertirConversion()
    def revertirConversion(){   
        def posList=new ArrayList()
        if (params.prospectos==null ) {           
            flash.warning = message(code: 'default.select.one')
            redirect url:"/prospecto/index?sort=fechaApertura&order=desc"  
            return
        }else {  
            posList.addAll(params.prospectos)
            // def elegidos=[params.prospectos].flatten()
            if (posList.size() > 1){                
                flash.warning = message(code: 'default.select.one')
                redirect url:"/prospecto/index?sort=fechaApertura&order=desc"
                return
            }
        }
        def  prospectoInstance=Prospecto.get(posList[0])
       
        if (prospectoInstance.idEstadoProspecto=='propasopox'){  
            prospectoInstance.idEstadoProspecto='proasignad'
            prospectoInstance.save()
            Oportunidad.executeUpdate("update Oportunidad set eliminado=1 where prospecto.id=${posList[0]}")
             
            ElementoPorOportunidad.executeUpdate("""update ElementoPorOportunidad e set e.eliminado=1 
                                                     where e.oportunidad.id in (select id from Oportunidad
                                                     where prospecto.id=${posList[0]})""")
            
            Propuesta.executeUpdate("""update Propuesta e set e.eliminado=1 
                                                     where e.oportunidad.id in (select id from Oportunidad
                                                     where prospecto.id=${posList[0]})""")
            flash.message=message(code:'revertirProspecto.exito.label')
            redirect url:"/prospecto/index?sort=fechaApertura&order=desc"  
            return
        }else {
            flash.warning=message(code:'revertirProspecto.error.label')
            redirect url:"/prospecto/index?sort=fechaApertura&order=desc"  
            return
        } 
    }
 
    def asignarVendedor(){

        def posList=new ArrayList()
		if(params.idProsp)
			posList.addAll(params.idProsp)
		else
		{
			if(params?.prospectos !=null){
				posList.addAll(params?.prospectos)
				if (posList?.size()>1) {
					flash.warning = message(code:'default.select.one')
					redirect url:"/prospecto/index?sort=fechaApertura&order=desc"
				}
			}else{
				flash.warning = message(code:'default.select.one')
				redirect url:"/prospecto/index?sort=fechaApertura&order=desc"
			}
		}
		
		
		
        

        def vendedoresList=Empleado.findAllByEliminadoAndIdTipoEmpleadoAndIdEstadoEmpleado(0,'pervendedo','empleactiv',[sort:'primerNombre'])
        render view :'asignarVendedor', model:[vendedoresList:vendedoresList,
            posList:posList[0]]

    }
	
	def updateFilterLength()
	{
		prueba=params.clone()
		prueba['max']=5000
		prueba['offset']=0
		resultadosfiltro_export=filterPaneService.filter(prueba, Prospecto)//lista con base en el filtro
		params.max=10
	}
 
    @Transactional  //asignarVendedorDef
    def asignarVendedorDef(){

        def prospectoInstance=Prospecto.get(params?.posList)
		println "PA RA ME T RO S "+params
		println "KAJSKLAJSKLAJKLS "+prospectoInstance.nombreProspecto
		println "SDFSDFKLAJKLS "+prospectoInstance.nombreCliente
		println "HGJHJLAJKLS "+prospectoInstance.descProspecto
		
        
        prospectoInstance.empleado=Empleado.get(params.idVendedor.toLong())
        prospectoInstance.nombreVendedor=prospectoInstance.empleado.nombreCompleto()
        prospectoInstance.idEstadoProspecto='proasignad'
        prospectoInstance.save()
        // Envio de correo al nuevo vendedor
        def xdest=[]                
        xdest.push(params.idVendedor.toLong()) 
        String urlbase=generalService.getValorParametro('urlaplic')
        String xasunto="Se le ha asignado el siguiente prospecto: "+prospectoInstance?.numProspecto
		String sucursal=generalService.getSucursal(prospectoInstance?.idSucursal)
		String xcuerpo="Consulte el prospecto asignado <a href='${urlbase}/prospecto/show/${prospectoInstance.id}'> AQUI </a>"
		String mensaje="<b>Detalles del prospecto:</b><br><br><b>Sucursal:</b> ${sucursal}<br><b>Razon social:</b> ${prospectoInstance?.nombreCliente}<br><b>Proyecto:</b> ${prospectoInstance?.nombreProspecto}<br><b>Descripci&oacute;n:</b> ${prospectoInstance?.descProspecto}<br><br>"+xcuerpo
        
        generalService.enviarCorreo(0,xdest,xasunto, mensaje)
        //Fin Envio de correo 
        redirect url:"/prospecto/index?sort=fechaApertura&order=desc"        
    }
 
    def datosContacto(){        
        redirect url:"/contacto/mostrarCboContacto/${params.id}?idValue=${params.idValue}" 
    }
    
    def importarProspectos(){        
        render view :'importarProspectos'
    }
    
    @Transactional  //importarProspectosDef
    def importarProspectosDef(){
        def file = request.getFile('file')
        if (!file.isEmpty()){
            try{
                String zruta =generalService.getValorParametro('ruta01')
                def xruta = servletContext.getRealPath(zruta)
                file.transferTo( new File( xruta, file.originalFilename))
                String fileName = xruta+"/"+file.originalFilename
             
                RecordExcelImporter importer = new RecordExcelImporter(fileName);
               
            }catch(Exception e){              
                log.error "Error: ${e.message}", e 
                return
            }
            importer.CONFIG_RECORD_COLUMN_MAP = [
                sheet:'Hoja1', 
                startRow: 1,
                columnMap:  [
                            'A':'empresaP',                  
                            'B':'nombreProspecto',
                            'C':'fechaApertura',
                            'D':'fechaCierreEstimada',
                            'E':'identificacion',
                            'F':'primerNombre',
                            'G':'segundoNombre',
                            'H':'primerApellido',
                            'I':'segundoApellido',
                            'J':'celularPrincipal',
                            'K':'vendedor',
                            'L':'idSucursal',
                            'M':'valorProspecto'
                ]
            ]

            def count = 1;

            def requiredFields = ['empresaP': 'Empresa', 'identificacion':'Identificacion','celularPrincipal':'celularPrincipal']

            def errors = []
            def total = 0

            def recordsMapList = importer.getRecords();
			
            recordsMapList.each { Map recordParams ->
                count++;
                def sw = true
                requiredFields.each { field,title ->
					
                    if(recordParams[field] == null || recordParams[field] == ""){
                        errors.add(['message': "Campo requerido",
			                 'field': title, 
			                 'badValue': recordParams[field],
			                 'step':0,
			                 'row':count
                            ])
                        sw = false						
                        
                    }
                }

                if(sw) {
                    /* creacion de la instancia*/
                    Prospecto.withTransaction{ status ->
                        def prospectoInstance = new Prospecto()
                        try{           
                    
                            def empleadoInstance=Empleado.findByIdentificacion(recordParams['vendedor'])
                           
                            def sucur=recordParams['idSucursal'].toInteger()   
                            prospectoInstance.numProspecto=consecutivoService.prospecto(sucur.toString())
                            prospectoInstance.idSucursal=recordParams['idSucursal']
                            prospectoInstance.nombreProspecto=recordParams["nombreProspecto"]
                            prospectoInstance.nombreVendedor=empleadoInstance.nombreCompleto()
                            prospectoInstance.nombreContacto=recordParams["primerNombre"]+' '+recordParams["primerApellido"]
                            prospectoInstance.nombreCliente=recordParams["empresaP"]
                        
                            prospectoInstance.fechaApertura=new Date().parse("dd/MM/yyyy", recordParams["fechaApertura"])
                            prospectoInstance.fechaCierreEstimada=new Date().parse("dd/MM/yyyy", recordParams["fechaCierreEstimada"])
                            prospectoInstance.valorProspecto=  recordParams["valorProspecto"]
                            prospectoInstance.idEstadoProspecto='proasignad'
                            prospectoInstance.eliminado = 0;
                        }catch(Exception  e){
                          
                            errors.add(['message':'Formato incorrecto',
                                    'field':'', 
                                    'badValue':'' ,
                                    'row':count
                                ])
                            render view: 'indexz',  model:[ errors: errors, total: 0]
                            return
                        }
                        /* propiedad empresa: si no existe se crea una nueva empresa tipo prospecto */
                        def filter = recordParams["empresaP"]
                        def empresasList = Empresa.executeQuery("from Empresa where razonSocial = '${filter}'")
                        if(empresasList.size()>0){
                            prospectoInstance.empresa = Empresa.get(empresasList[0]?.id)
							
                        }else{
                            def empresaInstance = new Empresa([
                                                                'razonSocial':filter,
                                                                'idTipoEmpresa':'empprospec',
                                                                'idEstadoEmpresa':'empenproce',
                                                                'idTipoSede':'empprincip',
                                                                'eliminado':'0'
                                ])
                            empresaInstance.validate()
                            if (empresaInstance.hasErrors()) {
                                def error = empresaInstance.errors.allErrors.collect{
                                    ['message': message(error:it),
                                    'field': it.getField(), 
                                    'badValue': it.getRejectedValue(),
                                    'step':1,
                                    'row':count
                                    ]
                                }
                                errors.add(error)
                                sw = false						
								
                            }
                            if(sw){
                                empresaInstance.save flush:true
                                prospectoInstance.empresa = empresaInstance
                            }
							
                        }
                        if(sw){
                           
                            filter = recordParams["identificacion"]
                            def personasList = Persona.executeQuery("from Persona where identificacion ='${filter}'")
                            if(personasList.size()>0){
                                prospectoInstance.persona =Persona.get(personasList[0].id)
                            }else{
                                def personaInstance = new Persona([
                                                                    'identificacion':filter,
                                                                    'primerNombre':recordParams["primerNombre"],
                                                                    'segundoNombre':recordParams["segundoNombre"],
                                                                    'primerApellido':recordParams["primerApellido"],
                                                                    'segundoApellido':recordParams["segundoApellido"],
                                                                    'celularPrincipal':recordParams["celularPrincipal"],
                                                                    'idTipoPersona':'percontact',
                                                                    'idEstadoPersona':'genactivo',
                                                                    'eliminado':'0'
                                    ])
                                personaInstance.validate()
                                if (personaInstance.hasErrors()) {
                                    def error = personaInstance.errors.allErrors.collect{
                                        ['message': message(error:it),
                                        'field': it.getField(), 
                                        'badValue': it.getRejectedValue(),
                                        'step':1,
                                        'row':count
                                        ]
                                    }
                                    errors.add(error)
                                    sw = false						
									
                                }
                                if(sw){
                                    personaInstance.save flush:true, failOnError:true
                                    prospectoInstance.persona =Persona.get(personaInstance.id)
                                }
                            }
                            if(sw){
                                /* Guardar instancia */
								
                                prospectoInstance.validate()
                                if (prospectoInstance.hasErrors()) {
                                    def error = prospectoInstance.errors.allErrors.collect{
                                        ['message': message(error:it),
                                        'field': it.getField(), 
                                        'badValue': it.getRejectedValue(),
                                        'step':1,
                                          'row':count
                                        ]
                                    }
                                    errors.add(error)
                                    sw = false						
                                }
                                if(sw){
                                    prospectoInstance.save flush:true,failOnError:true
                                    generalService.crearContacto(prospectoInstance?.empresa?.id, prospectoInstance?.persona?.id)  
                                    total++	
                                }else{
                                    status.setRollbackOnly()
                                }
                            }else{
                                status.setRollbackOnly()
                            }
                        }else{
                            status.setRollbackOnly()
                        }
                    }			
                }
				
            }
            
            render view: 'indexz',  model:[ errors: errors, total: total]
            return
        }
        redirect url:"/prospecto/index?sort=fechaApertura&order=desc"   
        
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
        response.setHeader("Content-disposition", "attachment; filename=prospectos.${ext}")
         
        Map campos = ['1_Num_Op':'numProspecto',
                      '2_Cliente': 'nombreCliente',
                      '3_Proyecto':'descProspecto', 
                      '4_Contacto':'nombreContacto', 
                      '5_Valor':'valorProspecto',
                      '6_Apertura':'fechaApertura',
                      '7_Vendedor':'nombreVendedor',
                      '8_Estado':'idEstadoProspecto']
         
        Map formatters = [:]
        Map parameters = [:]
        def entidad="crm.Prospecto"
        def query="from Prospecto where  eliminado=0"
        def datos=generalService.preExportar(entidad,query,campos,true)      //true filtrado false via query   
        exportService.export(params.id, response.outputStream,datos, formatters, parameters) 
        
    }
}
