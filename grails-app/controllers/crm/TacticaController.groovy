package crm

import static org.springframework.http.HttpStatus.*

import grails.converters.JSON
import grails.transaction.Transactional
import net.sf.json.JSONArray
import net.sf.json.JSONObject

@Transactional(readOnly = true)
class TacticaController extends BaseController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def generalService
    
    def index(Integer max) {
       
        int itemxview=generalService.getItemsxView(0) 
        params.max = itemxview
        String  xoffset=params.offset?:0
        
        //def query="from Tactica where eliminado=0 order by tactica"
        def query="from Tactica  where estrategia.id='${params.id}' and  eliminado=0 and idEstadoTactica!='tarchivada'"
        def queryc="Select count(s) from Tactica s where s.estrategia.id='${params.id}' and  s.eliminado=0  and idEstadoTactica!='tarchivada'"
        
        def tacticaInstanceList=Tactica.findAll(query,[max:params.max,offset:xoffset.toLong()])        
        def xnum = Tactica.executeQuery(queryc)[0]        
        respond tacticaInstanceList, model:[tacticaInstanceCount: xnum]
    }
	
	def listarArchivadas(Integer max) {
		
		 int itemxview=generalService.getItemsxView(0)
		 params.max = itemxview
		 String  xoffset=params.offset?:0
		 
		 //def query="from Tactica where eliminado=0 order by tactica"
		 def query="from Tactica  where estrategia.id='${params.estrategiaId}' and  eliminado=0 and idEstadoTactica='tarchivada'"
		 
		 def queryc="Select count(s) from Tactica s where s.estrategia.id='${params.estrategiaId}' and  s.eliminado=0  and idEstadoTactica='tarchivada'"
		 
		 def tacticaInstanceList=Tactica.findAll(query,[max:params.max,offset:xoffset.toLong()])
		 
		 println "Params es "+params
		 println "Resultado ES "+tacticaInstanceList
		 def xnum = Tactica.executeQuery(queryc)[0]
		 respond tacticaInstanceList, model:[tacticaInstanceCount: xnum]
	 }

    def show(Tactica tacticaInstance) {		
		session["tactica_id"]=params.id
        respond tacticaInstance
    }
    
    def listarBorrados(Integer max) {

        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview 
        String  xoffset=params.offset?:0
		
		def estrategia_id=session.getAttribute("estrategia_id")
		
		println "IDESTRA "+estrategia_id
		
        def query="from Tactica as t where t.eliminado=1 and t.estrategia=${estrategia_id}"
        def tacticaInstanceList=Tactica.findAll(query,[max:params.max,offset:xoffset.toLong()])		

        render view: "index" , model:[tacticaInstanceList:tacticaInstanceList,
                                      tacticaInstanceCount: Tactica.countByEliminado(1),itemxview:itemxview]
		
		
    }
    
     @Transactional   // Borrar
    def borrar(Tactica tacticaInstance) {

        if (params.id == null) {
            notFound()
            return
        }

        tacticaInstance= Tactica.get(params.id)

        tacticaInstance.eliminado=1

        tacticaInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Empresa.label', default: 'Empresa'), tacticaInstance.id])
                  redirect url :"/tactica/index/"+tacticaInstance?.estrategia?.id
            }
            '*'{ respond tacticaInstance, [status: OK] }
        }
    }

    def create() {
        respond new Tactica(params)
    }
	
	def tacticasDisponibles()
	{
		def query="Select t.tactica From Tactica t where t.estrategia=${params.idEstrategia} and t.eliminado=0"
		//def query="Select t.tactica From Tactica t where t.eliminado=0"
		def result=Tactica.executeQuery(query)
		println "MI RESULTADO ES "+result
		render result as JSON
	}
	
	

	
	def campanasYEventos()
	{
		//def tactico=Tactica.get(params.id?:24)
		println "esta gente si habla nojoda + "+params
		def query="from Estrategia  where eliminado=0 order by descripcion"
		def listaEstrategias=Estrategia.executeQuery(query) 
		
		
		
		def queryUrls="From ValorParametro where idParametro='cyeventos' and estadoValorParametro='A'"
		def	listaUrls=ValorParametro.executeQuery(queryUrls)
		listaUrls.each{
			println "URL "+it.valor
			println "TEXTO PARA MOSTRAR "+it.descValParametro
		}
		//println "La lista de URLS ES ........ "+listaUrls	
				
		render view:"detallesTactica",model:[listaEstrategias:listaEstrategias,listaUrls:listaUrls]
		
		
		
							
		//render(template: "holaJeje", model:[pruebaJAS:params.idP?:'HOLA'])
		
	}
	
	def traerInformacionAsociadaTactica()
	{
		println "HOLA DANNA "+params
		String fechaFiltro=params.fechaFiltro?:''
		String nombreTactica=params.nombreTactica?:''	
		
		String date=params.fechaFiltro?:''	

		def queryUrls="From ValorParametro where idParametro='cyeventos' and estadoValorParametro='A'"
		def	listaUrls=ValorParametro.executeQuery(queryUrls)
		
		//def idTactica=Tactica.find{tactica==nombreTactica}.id
		def idTactica=Tactica.executeQuery("Select t.id From Tactica t where t.tactica='${nombreTactica}' and t.eliminado=0")[0]
		
		
		println "la lista de Urls es  "+listaUrls
		println "El id de esta tactica es "+idTactica
		
		def piezasQuery="From Pieza where tactica=${idTactica} and eliminado=0"
		def listaDePiezas=Pieza.executeQuery(piezasQuery)
		
		println "Lista de piezas es "+listaDePiezas
		
		
		def queryProspectosAsignados="From Prospecto p Where p.idTactica=${idTactica} and p.idTactica IS NOT NULL and p.eliminado=0 and p.fechaApertura LIKE '%${fechaFiltro}%'"
		def resultadoProspectos=Prospecto.executeQuery(queryProspectosAsignados)
		
		def queryOportunidadesGeneradas="From Oportunidad o Where o.idTactica=${idTactica} and o.idTactica IS NOT NULL and o.eliminado=0 and o.fechaApertura LIKE '%${fechaFiltro}%'"
		def resultadoOportunidades=Oportunidad.executeQuery(queryOportunidadesGeneradas)
		//def datos=generalService.traerInformacionAsociadaTactica(nombreTactica)
		def queryOpptysPorCliente="Select o.nombreCliente, count(o.nombreCliente) From Oportunidad o Where o.idTactica=${idTactica} and o.idTactica IS NOT NULL and o.eliminado=0 and o.fechaApertura LIKE '%${fechaFiltro}%' group by o.nombreCliente  order by count(o.nombreCliente) desc"
		def resultadoOpptysAsignadasPorCliente=Oportunidad.executeQuery(queryOpptysPorCliente,[max:20])
		
		def queryProspsPorCliente="Select p.nombreCliente, count(p.nombreCliente) From Prospecto p Where p.idTactica=${idTactica} and p.idTactica IS NOT NULL and p.eliminado=0 and p.fechaApertura LIKE '%${fechaFiltro}%' group by p.nombreCliente  order by count(p.nombreCliente) desc"
		def resultadoProspsGeneradosPorCliente=Prospecto.executeQuery(queryProspsPorCliente,[max:20])
		
		

		//render datos
		render(template: "ProspectosOportunidadesPorTactica", model:[prospectoInstanceList:resultadoProspectos,
			oportunidadInstanceList:resultadoOportunidades,resultadoOpptysAsignadasPorCliente:resultadoOpptysAsignadasPorCliente,
			resultadoProspsGeneradosPorCliente:resultadoProspsGeneradosPorCliente,/*listaUrls:listaUrls,*/listaDePiezas:listaDePiezas])
	}
	

    @Transactional // save
    def save(Tactica tacticaInstance) {
        if (tacticaInstance == null) {
            notFound()
            return
        }
        tacticaInstance.estrategia=Estrategia.get(params.idestrategia)
        tacticaInstance.validate()
        
        if (tacticaInstance.hasErrors()) {
            respond tacticaInstance.errors, view:'create'
            return
        }
        
        tacticaInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tacticaInstance.label', default: 'Tactica'), tacticaInstance.id])
                redirect url :"/tactica/index/"+tacticaInstance?.estrategia?.id
            }
            '*' { respond tacticaInstance, [status: CREATED] }
        }
    }

    def edit(Tactica tacticaInstance) {
        respond tacticaInstance
    }

    @Transactional  //update 
    def update(Tactica tacticaInstance) {
        if (tacticaInstance == null) {
            notFound()
            return
        }

        if (tacticaInstance.hasErrors()) {
            respond tacticaInstance.errors, view:'edit'
            return
        }

        tacticaInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Tactica.label', default: 'Tactica'), tacticaInstance.id])
                redirect url :"/tactica/index/"+tacticaInstance?.estrategia?.id
            }
            '*'{ respond tacticaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Tactica tacticaInstance) {

        if (tacticaInstance == null) {
            notFound()
            return
        }

        tacticaInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Tactica.label', default: 'Tactica'), tacticaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tacticaInstance.label', default: 'Tactica'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    def getTacticas(){
        def query="from Tactica t where t.estrategia.id='${params.id}' and t.eliminado=0 and t.idEstadoTactica!='tarchivada'"
       
        def tacticaList=Tactica.findAll(query)
        
        render template:'/tactica/tacticas', model: [tacticaList:tacticaList]
    }
}
