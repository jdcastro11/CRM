package crm



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PropuestaController extends BaseController{

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    
    def generalService
    def consecutivoService
    def oportunidadService
	def filterPaneService
	def propuestaInstanceListVista
    def exportarService
	def listaxpropuesta
	def propuestaInstanceListVista2
	def filterList
	
    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max = Math.min(max ?: itemxview, 100)
        String  xoffset=params.offset?:0

        def  oportunidadInstance=Oportunidad.get(params.id)
        Long xidempresa=oportunidadInstance.empresa.id

        def query="from Propuesta where oportunidad.id=${params.id} and eliminado=0 order by id desc"
        def queryc="select count(p) from Propuesta  p  where oportunidad.id=${params.id} and eliminado=0"

        def propuestaInstanceList=Propuesta.findAll(query,[max:params.max,offset:xoffset.toLong()])
        def num=Propuesta.executeQuery(queryc)
       
        respond propuestaInstanceList, model: [propuestaInstanceCount: num[0],
            xtitulo:message(code:'propuesta.index.label'),
            xidempresa:xidempresa,xcerrada:oportunidadService.oportunidadCerrada(params.id)]
    }

    def indexh(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max = Math.min(max ?: itemxview, 100)
        String  xoffset=params.offset?:0
      
        def  oportunidadInstance=OportunidadH.get(params.id)
        Long xidempresa=oportunidadInstance.empresa.id

        def query="from PropuestaH where oportunidadh.id=${params.id} and eliminado=0 order by fecha desc"
        def queryc="select count(p) from PropuestaH  p  where oportunidadh.id=${params.id} and eliminado=0"
         
        def propuestaInstanceList=PropuestaH.findAll(query,[max:params.max,offset:xoffset.toLong()])        
        def num=PropuestaH.executeQuery(queryc)
        render view:"indexh", model:[propuestaInstanceList:propuestaInstanceList,propuestaInstanceCount: num[0],
                                     xtitulo: generalService?.getValorParametro('propuest06'),
                                    xidempresa:xidempresa]
    }
    
    def listarBorrados(Integer max) {

        int itemxview=generalService.getItemsxView(0) 
        params.max = Math.min(max ?: itemxview, 100)
        String  xoffset=params.offset?:0

        def  oportunidadInstance=Oportunidad.get(params.id)
        Long xidempresa=oportunidadInstance.empresa.id

        def query="from Propuesta where oportunidad.id=${params.id} and eliminado=1 order by fecha desc"
        def queryc="select count(p) from Propuesta  p  where oportunidad.id=${params.id} and eliminado=1"

        def propuestaInstanceList=Propuesta.findAll(query,[max:params.max,offset:xoffset.toLong()])
        def num=Propuesta.executeQuery(queryc)
        render view: "index" , model:[propuestaInstanceList:propuestaInstanceList,
            propuestaInstanceCount:num[0],
            itemxview:itemxview,
            xtitulo:generalService?.getValorParametro('propuest05'),
            xidempresa:xidempresa]
    }
	
	
	
	def indexPropuesta()
	{
		if(!params.filter)params.filter = [op:[:],persona:[:],empleado:[:]]
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado='0'
		
		params.max = 10
		
		params.vista='perfectum'
		println "PROPUETSA PARAMS-> "+params
		
		propuestaInstanceListVista=filterPaneService.filter(params, Propuesta)
		updateFilterLength()
		render(view:"indexPropuesta", model:[filterParams:org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
			params:params,propuestaInstanceListVista:propuestaInstanceListVista,
			propuestaInstanceCount:filterPaneService.count( params, Propuesta ),xtitulo:'Propuestas'])
	}

    def show(Propuesta propuestaInstance) {
        respond propuestaInstance, model:[sw:0]
    }
	
	
	
	def showperfectum(Propuesta propuestaInstance) {
		respond propuestaInstance, model:[sw:0]
	}

    def create() {
        respond new Propuesta(params)
    }

    @Transactional //borrar
    def borrar(Propuesta propuestaInstance) {
     
        if (params.id == null) {
            notFound()
            return
        }
       
        propuestaInstance= Propuesta.get(params.id)

        propuestaInstance.eliminado=1

        propuestaInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Propuesta.label', default: 'Propuesta'), propuestaInstance.id])
                redirect  url:"/propuesta/index/"+propuestaInstance.oportunidadId
            }
            '*'{ respond propuestaInstance, [status: OK] }
        }
    }    
    
    @Transactional //save
    def save(Propuesta propuestaInstance) {
        if (propuestaInstance == null) {
            notFound()
            return
        }

        if (params.idOportunidad) {
            propuestaInstance.oportunidad=Oportunidad.get(params.idOportunidad.toLong())
        }
        
        if (params.idVendedor) {
            propuestaInstance.empleado=Empleado.get(params.idVendedor.toLong())
        }
        if (params.idContacto) {
            propuestaInstance.persona=Persona.get(params.idContacto.toLong())
        }  
        
        propuestaInstance.numPropuesta=consecutivoService.propuesta(propuestaInstance?.oportunidad?.idSucursal.toString())
        
        propuestaInstance.validate()
        
        if (propuestaInstance.hasErrors()) {
            respond propuestaInstance.errors, view: 'create'
            return
        }

        propuestaInstance.oportunidad.idEstadoOportunidad='opocotizad'
        propuestaInstance.oportunidad.idEtapa='posventx25'       
        
        def  idprosp=propuestaInstance.oportunidad?.prospecto?.id
       
        propuestaInstance.save flush: true
        if (idprosp){ // viene la oportunidad de un ptospecto
            Prospecto.withNewSession { s2 ->
             def prospectoInstance=Prospecto.get(idprosp)
               prospectoInstance?.evolucion='PR'
               prospectoInstance.save()
               s2.flush()
               s2.close()
            }
       }
         //  codigo que maneja el  log de prospectos via notas        
        def xpadre=propuestaInstance.oportunidad.prospecto?.id   
        if (xpadre) {
          String xtipo='notaseguim'
          String xentidad='prospecto'
          String xnota="Propuesta Numero : "+propuestaInstance.numPropuesta
          generalService.registrarNota(xentidad,xpadre.toString(),xtipo,xnota)         
       }
         
        request.withFormat {
            form {
                //flash.message = message(code: 'default.created.message', args: [message(code: 'propuestaInstance.label', default: 'Propuesta'), propuestaInstance.id])
                redirect url:"/propuesta/show/${propuestaInstance?.id}?idpos=${propuestaInstance.oportunidad?.id}&idemp=${propuestaInstance.oportunidad?.empresa?.id}"
                //redirect uri: request.getHeader('referer')
            }
            '*' { respond propuestaInstance, [status: CREATED] }
        }
    }

    def edit(Propuesta propuestaInstance) {
        respond propuestaInstance, model:[sw:1]
    }

    @Transactional  //update 
    def update(Propuesta propuestaInstance) {
        if (propuestaInstance == null) {
            notFound()
            return
        }

        if (params.idVendedor) {
            propuestaInstance.empleado=Empleado.get(params.idVendedor.toLong())
        }
        if (params.idContacto) {
            propuestaInstance.persona=Persona.get(params.idContacto.toLong())
        }
        
        propuestaInstance.validate()
        
        if (propuestaInstance.hasErrors()) {
            respond propuestaInstance.errors, view: 'edit'
            return
        }

        propuestaInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Propuesta.label', default: 'Propuesta'), propuestaInstance.id])
                redirect url:"/propuesta/index/"+propuestaInstance.oportunidadId+"?sw=1"
            }
            '*' { respond propuestaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Propuesta propuestaInstance) {

        if (propuestaInstance == null) {
            notFound()
            return
        }

        propuestaInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Propuesta.label', default: 'Propuesta'), propuestaInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'propuestaInstance.label', default: 'Propuesta'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
    
    @Transactional  //propuestaFinal
     def propuestaFinal(){  
       
        def posList=new ArrayList()
        if (params.propuestas==null ) {           
            flash.warning = message(code: 'default.select.one')
            redirect url:"/propuesta/index/${params.id}"  
            return
        }else {  
            posList.addAll(params.propuestas)
            // def elegidos=[params.prospectos].flatten()
            if (posList.size() > 1){                
                flash.warning = message(code: 'default.select.one')
                redirect url:"/propuesta/index/${params.id}"
                return
            }
        }
         def query="select count(a) from Anexo a where idEntidad=${posList[0]} and nombreEntidad='propuesta'"
         def num=Anexo.executeQuery(query)
         if (num[0]==0){
            flash.warning="Propuesta no tiene anexos. Verifique"
             redirect url:"/propuesta/index/${params.id}"
            return
        }
         def propuestaInstance=Propuesta.get(posList[0])
             propuestaInstance.idEstadoPropuesta='propfinal' 
             propuestaInstance?.oportunidad?.idPropuesta=posList[0].toLong()
             propuestaInstance.save()
        flash.message="Propuesta ha sido establecida como ganadora"    
        redirect url:"/propuesta/index/${params.id}"     
    }
     
    @Transactional  //propuestaNormal
     def propuestaNormal(){  
       
        def posList=new ArrayList()
        if (params.propuestas==null ) {           
            flash.warning = message(code: 'default.select.one')
            redirect url:"/propuesta/index/${params.id}"  
            return
        }else {  
            posList.addAll(params.propuestas)
            // def elegidos=[params.prospectos].flatten()
            if (posList.size() > 1){                
                flash.warning = message(code: 'default.select.one')
                redirect url:"/propuesta/index/${params.id}"
                return
            }
        }
         
         def propuestaInstance=Propuesta.get(posList[0])
             propuestaInstance.idEstadoPropuesta='propnormal' 
             propuestaInstance?.oportunidad?.idPropuesta=null
             propuestaInstance.save()
        flash.message="Propuesta ha sido establecida como normal"    
        redirect url:"/propuesta/index/${params.id}"     
    }
    
    def exportarDatos=
	{
		List lista_export=[]
		
		//el nombre de los campos fields es como están definidos en la clase dominio
		List fields = ["numPropuesta","oportunidad","empleado","persona","valor","fecha"]
		Map labels = ["numPropuesta": "Codigo","oportunidad":"Empresa","empleado":"Vendedor","persona":"Contacto","valor": "Valor","fecha":"Fecha"]		
		def opToEmpresaId={Propuesta,value->
			return Propuesta.oportunidad.empresa
		}
		
		def nombreCompleto={Propuesta,value->
			return Propuesta.empleado.nombreCompleto()
		}
		
		
		def nombreCompletoPersona={Propuesta,value->
			return Propuesta.empleado.nombreCompleto()
		}
		
		Map formatters = [oportunidad:opToEmpresaId,empleado:nombreCompleto,persona:nombreCompletoPersona]
		String filename=exportarService.setfilename(params.titulo)
		if(params.tipo_export=='1')//exportar todos
		{			
			List idss=propuestaInstanceListVista2.id
			lista_export=exportarService.obtenerItemsSeleccionados(Propuesta,idss)
		}
		else
		{
			List ids=params.list('itempropuesta')//ids de items seleccionados
			lista_export=exportarService.obtenerItemsSeleccionados(Propuesta,ids)//lista de checkbox seleccionados
		}
		
			exportarService.exportar(Propuesta,lista_export,fields,labels,response,formatters,filename)
		
		
					
			
	}
	
	
		def updateFilterLength()
		{
			filterList=params.clone()
			filterList['max']=5000
			filterList['offset']=0
			propuestaInstanceListVista2=filterPaneService.filter(filterList, Propuesta)//lista con base en el filtro
		}
}
