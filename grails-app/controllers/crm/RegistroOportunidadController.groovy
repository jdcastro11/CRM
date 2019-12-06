package crm
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)

class RegistroOportunidadController extends BaseController{

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def generalService
    def oportunidadService
    def consecutivoService
        
    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview
        String  xoffset=params.offset?:0
        
        def query="from RegistroOportunidad where oportunidad.id = '${params.id}' and eliminado=0 order by fecha"
        def queryc="select count(r) from RegistroOportunidad r where oportunidad.id = '${params.id}' and eliminado=0"

        def registroOportunidadInstanceList=RegistroOportunidad.findAll(query,[max:params.max,offset:xoffset.toLong()])

        def num= RegistroOportunidad.executeQuery(queryc)

        render view:"index", model: [registroOportunidadInstanceList: registroOportunidadInstanceList,
            registroOportunidadInstanceCount:num[0],
            itemxview: itemxview,
            xtitulo:message(code:'regop.title.label') ,
            xidopor: params.id,xcerrada:oportunidadService.oportunidadCerrada(params.id)]
    }
    
    def indexh(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max = itemxview
        String  xoffset=params.offset?:0
        
        def query="from RegistroOportunidadH where oportunidadh.id = '${params.id}' and eliminado=0 order by fecha"
        
        def queryc="select count(r) from RegistroOportunidadH r where oportunidadh.id = '${params.id}' and eliminado=0"
        
        def registroOportunidadInstanceList=RegistroOportunidadH.findAll(query,[max:params.max,offset:xoffset.toLong()])
        def num= RegistroOportunidadH.executeQuery(queryc)
        render view:"indexh", model: [registroOportunidadInstanceList: registroOportunidadInstanceList,         
            registroOportunidadInstanceCount:num[0],itemxview: itemxview,
            xtitulo: generalService?.getValorParametro('regoport06'),xidopor: params.id]
    }

    def listarBorrados(Integer max){
        int itemxview=generalService.getItemsxView(0) 
        params.max = itemxview
        String  xoffset=params.offset?:0
        
        def query="from RegistroOportunidad where oportunidad.id = '${params.id}' and eliminado=1 order by fecha"
        def queryc="select count(r) from RegistroOportunidad r where oportunidad.id = '${params.id}' and eliminado=1"

        def registroOportunidadInstanceList=RegistroOportunidad.findAll(query,[max:params.max,offset:xoffset.toLong()])
        def num= RegistroOportunidad.executeQuery(queryc)
        render view: "index", model: [registroOportunidadInstanceList: registroOportunidadInstanceList,
            registroOportunidadInstanceCount:num[0],itemxview: itemxview,xidopor:params.id,
            xtitulo:message(code:'regop.borrados.title',default:'Lista de Registros de Oportunidad Borrados')]
    }
    
    def show(RegistroOportunidad registroOportunidadInstance) {
        respond registroOportunidadInstance
    }

    def create() {
        respond new RegistroOportunidad(params)
		
    }
    
    @Transactional //borrar
    def borrar(RegistroOportunidad registroOportunidadInstance) {
     
        if (params.id == null) {
            notFound()
            return
        }
       
        registroOportunidadInstance= RegistroOportunidad.get(params.id)
        
        registroOportunidadInstance.eliminado=1

        registroOportunidadInstance.save flush:true
        
        // Si se borra un registro de oportunidad hay que actualizar el cambo numOportunidadFabricante
        registroOportunidadInstance.oportunidad.numOportunidadFabricante=oportunidadService.getNumRegistros(registroOportunidadInstance?.oportunidad?.id)
        
        request.withFormat {
            form {
                flash.warning = "Registro ha sido borrado"
                redirect url:"/registroOportunidad/index/"+registroOportunidadInstance.oportunidad.id
            }
            '*'{ respond registroOportunidadInstance, [status: OK] }
        }
    }

    @Transactional //save
    def save(RegistroOportunidad registroOportunidadInstance) {
        if (registroOportunidadInstance == null) {
            notFound()
            return
        }
       
        registroOportunidadInstance.oportunidad = Oportunidad.get(params.idoportunidad)
        
		println "REGOP "+params
		
		
		
		
		
		
		
		
        
        registroOportunidadInstance.validate()
        
        if (registroOportunidadInstance.hasErrors()) {
            respond registroOportunidadInstance.errors, view: 'create'
            return
        }
       if (params.idEstadoRegistroOportunidad=='regnoaplic'){
           registroOportunidadInstance.numRegistroOportunidad='N/A'        
       }
        registroOportunidadInstance.save()
		
		
		
		
		
		
		
		
//-------------------------------------------------------------------------------------------------
		def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong())).id
		def usuarioL=Empleado.findById(usuarioAccede)
		String urlbase=generalService.getValorParametro('urlaplic')
		def opty=Oportunidad.get(params.idoportunidad)
		def vendedor=opty.empleado.email
		def lista=[]
		lista.push(vendedor)//correo del vendedor
		//lista.push(Empleado.get(81).email)
		String cliente=opty.nombreCliente
		String asunto="NUEVO REGISTRO DE OPORTUNIDAD - OP No. ${opty.numOportunidad}"
		String cuerpo="<b>Registro elaborado por:</b> ${usuarioL}<br><br>Se ha ingresado un nuevo registro de oportunidad a la oportunidad No. <b>${opty.numOportunidad}</b> de la empresa ${cliente} con los siguientes campos: <br><br><b>N&uacute;mero de registro de oportunidad: </b>${params.numRegistroOportunidad}<br><b>Valor: </b>${params.valorRegOp}<br><b>Fecha estimada de cierre: </b>${params.fechaCierreEstimada} <br><b>Comentarios:</b><br>${params.comentarioRegistroOportunidad}<br><br>Para m&aacute;s detalles haga clic <a href='${urlbase}/oportunidad/show/${opty?.id}?&layout=main'> AQUI </a>"
		generalService.enviarCorreo(1, lista, asunto, cuerpo)
//-------------------------------------------------------------------------------------------
		
        
        if (params.idEstadoRegistroOportunidad=='regnoaplic'){           
           registroOportunidadInstance.oportunidad.numOportunidadFabricante=oportunidadService.getNumRegistros(params.idoportunidad)
       }
        //  codigo que maneja el  log de prospectos via notas 
        def xpadre=registroOportunidadInstance.oportunidad.prospectoId   
        if (xpadre !=null) {
            String xtipo='notaseguim'
            String xentidad='prospecto'
            String xnota="Oportunidad "+registroOportunidadInstance.oportunidad.numOportunidad+" asociada registro en  estado: "+generalService.getValorParametro(registroOportunidadInstance.idEstadoRegistroOportunidad)
            generalService.registrarNota(xentidad,xpadre.toString(),xtipo,xnota)         
        }    
        def xdest=[] 
        //String urlbase=generalService.getValorParametro('urlaplic')
        xdest+=registroOportunidadInstance?.idAsignadoA
		println "X D E S T "+xdest 
        String xasunto="Solicitud de registro de la oportunidad No.: ${registroOportunidadInstance?.oportunidad?.numOportunidad}" 
        String xcuerpo="Complete el registro creado ante el mayorista respectivo  <a href='${urlbase}/oportunidad/show/${registroOportunidadInstance?.oportunidad?.id}'>AQUI </a>"
       
        generalService.enviarCorreo(0,xdest,xasunto, xcuerpo) 
        flash.warning="Registro de Oportunidad Solicitado"
           
        //redirect url:"/registroOportunidad/index/"+registroOportunidadInstance.oportunidad?.id
		
		
		redirect url:"/registroOportunidad/show/"+registroOportunidadInstance.id+"?idop="+params.idoportunidad//REDIRECCIONAR AL R_OP 
		//RECIEN CREADO
          
    }

    def edit(RegistroOportunidad registroOportunidadInstance) {
        respond registroOportunidadInstance
    }

    @Transactional //update
    def update(RegistroOportunidad registroOportunidadInstance) {

		
		def oldValue=generalService.getValorParametro(registroOportunidadInstance.getPersistentValue('idEstadoRegistroOportunidad'))		
		def newValue=generalService.getValorParametro(params.idEstadoRegistroOportunidad)
		
		
		
		if(oldValue!=newValue)
		{
			def numOportunidad= registroOportunidadInstance.oportunidad.numOportunidad
			def cliente=registroOportunidadInstance.oportunidad.empresa.razonSocial
			String urlbase=generalService.getValorParametro('urlaplic')
			def idusuarioLogueado=generalService.getIdEmpleado(session['idUsuario'].toLong())
			def userName=Empleado.findById(idusuarioLogueado)
			String asunto="Actualizacion de registro de oportunidad ante el fabricante. No. de oportunidad ${numOportunidad}- ${cliente}"
			String cuerpo="Registro realizado por: ${userName}<br><br> La oportunidad ha pasado de ${oldValue} a ${newValue}<br><br> Para detalles haga clic <a href='${urlbase}/oportunidad/show/${registroOportunidadInstance.oportunidad.id}'> AQUI </a>"
			def idemp=registroOportunidadInstance.oportunidad.empleado.id
			List correovendedor=[]
			correovendedor.add(generalService.traerCorreoEmpleado(idemp))			
			generalService.enviarCorreo(1, correovendedor, asunto, cuerpo)
		}
		
		
        registroOportunidadInstance = RegistroOportunidad.get(params.id)
		
        if (registroOportunidadInstance == null) {
            notFound()
            return
        }
        
        registroOportunidadInstance.oportunidad=Oportunidad.get(params.idoportunidad)
		println "WAAAWA"+registroOportunidadInstance.oportunidadId
        
        if (params.idEstadoRegistroOportunidad=='regnoaplic'){          
           registroOportunidadInstance.numRegistroOportunidad='N/A'            
        }  
           
        registroOportunidadInstance.validate()
        
        if (registroOportunidadInstance.hasErrors()) {
            respond registroOportunidadInstance.errors, view: 'edit'
            return
        }


        registroOportunidadInstance.save()
		
		
		
        
        //  codigo que maneja el  log de prospectos via notas 
        
        if (params.swcambio=='1'){ 
            def xpadre=registroOportunidadInstance.oportunidad.prospecto?.id
            if (xpadre !=null) {
                String xtipo='notaseguim'
                String xentidad='prospecto'
                String xnota="Oportunidad "+registroOportunidadInstance.oportunidad.numOportunidad+" asociada con registro en estado: "+generalService.getValorParametro(registroOportunidadInstance.idEstadoRegistroOportunidad)
                generalService.registrarNota(xentidad,xpadre.toString(),xtipo,xnota)         
            }
        }
		
        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'RegistroOportunidad.label', default: 'RegistroOportunidad'), registroOportunidadInstance.id])
				redirect url:"/registroOportunidad/index/"+registroOportunidadInstance.oportunidadId+"?sw=1"
            }
            '*' { respond registroOportunidadInstance, [status: OK] }
        }
    }

    @Transactional //delete
    def delete(RegistroOportunidad registroOportunidadInstance) {

        if (registroOportunidadInstance == null) {
            notFound()
            return
        }

        registroOportunidadInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'RegistroOportunidad.label', default: 'RegistroOportunidad'), registroOportunidadInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.warning = message(code: 'default.not.found.message', args: [message(code: 'registroOportunidadInstance.label', default: 'RegistroOportunidad'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
