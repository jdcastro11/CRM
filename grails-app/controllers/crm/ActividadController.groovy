package crm
import grails.converters.*
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ActividadController extends BaseController{

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def generalService
    def oportunidadService
    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max = itemxview
        String  xoffset=params.offset?:0
        Long xidempresa
        Long xidcontacto
        if (params.entidad=='oportunidad'){
            def  oportunidadInstance=Oportunidad.get(params.id)
            xidempresa=oportunidadInstance?.empresa?.id
            xidcontacto=oportunidadInstance?.persona?.id
        }else{
            xidempresa=0
            xidcontacto=0
        }

        def query="from Actividad  where idEntidad=${params.id} and nombreEntidad='${params.entidad}' and eliminado=0  order by idTipoActividad asc,id desc"
        def actividadInstanceList=Actividad.findAll(query,[max:params.max,offset:xoffset.toLong()])
       
        respond actividadInstanceList, model:[actividadInstanceCount: Actividad.countByEliminadoAndNombreEntidadAndIdEntidad(0,params.entidad,params.id),
            xtitulo:generalService?.getValorParametro('actividt00'),
            xidentidad:params.id,
            xentidad:params.entidad,
            xidempresa:xidempresa,xidcontacto:xidcontacto,xcerrada:oportunidadService.oportunidadCerrada(params.id)]
    }
    
    def indexp(Integer max) {      
        params.max = 5
        String  xoffset=params.offset?:0
        String xwherev
        xwherev=" and idResponsable=${generalService.getIdEmpleado(session['idUsuario'])}"                
        
        def query="from Actividad where nombreEntidad='oportunidad' and idEstadoActividad in ('actiesta01','actiesta04') and  eliminado=0 "+xwherev+" order by fechaFinal desc"
        
        def queryc="select count(a) from Actividad a where nombreEntidad='oportunidad' and idEstadoActividad in ('actiesta01','actiesta04') and eliminado=0"+xwherev
        
        def actividadInstanceList=Actividad.findAll(query,[max:params.max,offset:xoffset.toLong()]) 
        
        def xnum=Actividad.executeQuery(queryc)     
        
        render view: "indexp", model:[actividadInstanceList:actividadInstanceList, 
                                     actividadInstanceCount:Math.min(xnum[0],10)]
    }
    
    def indexh(Integer max) {// Listar Actividades Archivadas
         
        int itemxview=generalService.getItemsxView(0)
        params.max = itemxview
        String  xoffset=params.offset?:0
        Long xidempresa
        Long xidcontacto
        if (params.entidad=='oportunidad'){
            def  oportunidadInstance=OportunidadH.get(params.id)
            xidempresa=oportunidadInstance?.empresa?.id
            xidcontacto=oportunidadInstance?.persona?.id
        }else{
            xidempresa=0
            xidcontacto=0
        }
             
        def query="from ActividadH  where idEntidad=${params.id} and nombreEntidad='${params.entidad}' and eliminado=0  order by idTipoActividad asc,id desc"
        
        def actividadInstanceList=ActividadH.findAll(query,[max:params.max,offset:xoffset.toLong()])
       
        render view:"indexh", model:[actividadInstanceList:actividadInstanceList,
                              actividadInstanceCount: ActividadH.countByEliminadoAndNombreEntidadAndIdEntidad(0,params.entidad,params.id),
                              xidentidad:params.id,
                              xentidad:params.entidad,
                              xidempresa:xidempresa,xidcontacto:xidcontacto]
    }
    
    def listarBorrados(Integer max) {

        int itemxview=generalService.getItemsxView(0)
        params.max = Math.min(max ?: itemxview, 100)
        String  xoffset=params.offset?:0
        Long xidempresa
        Long xidcontacto
        if (params.entidad=='oportunidad'){
            def  oportunidadInstance=Oportunidad.get(params.id)
            xidempresa=oportunidadInstance?.empresa?.id
            xidcontacto=oportunidadInstance?.persona?.id
        }else{
            xidempresa=0
            xidcontacto=0
        }

        def query="from Actividad  where idEntidad=${params.id} and nombreEntidad='${params.entidad}' and eliminado=1 "
        def actividadInstanceList=Actividad.findAll(query,[max:params.max,offset:xoffset.toLong()])

        render view: "index" , model:[actividadInstanceList:actividadInstanceList,
            actividadInstanceCount:Actividad.countByEliminadoAndNombreEntidadAndIdEntidad(1,params.entidad,params.id),
            itemxview:itemxview,
            xtitulo:generalService?.getValorParametro('actividt05'),
            xidentidad:params.id, xentidad:params.entidad, xidempresa:xidempresa]
    }
    
    @Transactional
    def borrar(Actividad actividadInstance) {

        if (params.id == null) {
            notFound()
            return
        }

        actividadInstance= Actividad.get(params.id)

        actividadInstance.eliminado=1

        actividadInstance.save flush:true

        request.withFormat {
            form {
                flash.warning ="Actividad borrada exitosamente"
                redirect url:"/actividad/index/"+actividadInstance.idEntidad+"?entidad="+actividadInstance.nombreEntidad
            }
            '*'{ respond lineaInstance, [status: OK] }
        }
    }
    
    def show(Actividad actividadInstance) {
        respond actividadInstance
    }

    def create() {
        respond new Actividad(params)
    }

    @Transactional
    def save(Actividad actividadInstance) {
        if (actividadInstance == null) {
            notFound()
            return
        }

        if (actividadInstance.hasErrors()) {
            respond actividadInstance.errors, view: 'create'
            return
        }

        actividadInstance.save flush: true
       
        //  codigo que maneja el  log de prospectos via notas 
        def OportunidadInstance=Oportunidad.get(actividadInstance.idEntidad) 
        def xpadre=OportunidadInstance.prospecto?.id   
        if (xpadre !=null) {
            String xtipo='notaseguim'
            String xentidad='prospecto'
            String xnota="("+generalService.getValorParametro(actividadInstance?.idTipoActividad)+") "+actividadInstance.descActividad
            xnota+=" ("+generalService.getValorParametro(actividadInstance?.idEstadoActividad)+")"
            generalService.registrarNota(xentidad,xpadre.toString(),xtipo,xnota) 
        
        }
        request.withFormat {
            form {
                flash.message ="Actividad adicionada exitosamente" 
                redirect url:"/actividad/index/"+actividadInstance.idEntidad+"?entidad="+actividadInstance.nombreEntidad+"&sw='1'"
            }
            '*' { respond actividadInstance, [status: CREATED] }
        }
    }

    def edit(Actividad actividadInstance) {
        respond actividadInstance
    }

    @Transactional
    def update(Actividad actividadInstance) {
        if (actividadInstance == null) {
            notFound()
            return
        }

        if (actividadInstance.hasErrors()) {
            respond actividadInstance.errors, view: 'edit'
            return
        }

        actividadInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Actividad.label', default: 'Actividad'), actividadInstance.id])
                redirect url:"/actividad/index/"+actividadInstance.idEntidad+"?entidad="+actividadInstance.nombreEntidad+"&sw='1'"
            }
            '*' { respond actividadInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Actividad actividadInstance) {

        if (actividadInstance == null) {
            notFound()
            return
        }

        actividadInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Actividad.label', default: 'Actividad'), actividadInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.warning = message(code: 'default.not.found.message', args: [message(code: 'actividadInstance.label', default: 'Actividad'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
