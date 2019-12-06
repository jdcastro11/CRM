package crm



import static org.springframework.http.HttpStatus.*

import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = false)
class ElementoPorOportunidadController extends BaseController{

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def generalService
    def oportunidadService
	def filterPaneService
	def resultadosfiltro_export
	def exportarService
	def elementosList
	def elementosList2
	def filterList
	def listaItems
    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max = itemxview
        String  xoffset=params.offset?:0
        
        
        def query="from ElementoPorOportunidad e where e.oportunidad.id=${params.id} and e.eliminado=0"
        
        def queryc="select count(e) from ElementoPorOportunidad e where e.oportunidad.id=${params.id} and e.eliminado=0"
        
        def num=ElementoPorOportunidad.executeQuery(queryc)
        
        //def oportunidadInstance=Oportunidad.get(params.id)
        
        def elementoPorOportunidadInstanceList=ElementoPorOportunidad.findAll(query,[max:params.max,offset:xoffset.toLong()])
        respond elementoPorOportunidadInstanceList, model: [elementoPorOportunidadInstanceCount:num[0],
            xoportunidad:params.id,xtitulo:message(code:'elementoPorOportunidad.label',default:'Lista de Items') ,xcerrada:oportunidadService.oportunidadCerrada(params.id)]
    }
    
    def indexh(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max = itemxview
        String  xoffset=params.offset?:0
        
        
        def query="from ElementoPorOportunidadH e where e.oportunidadh.id=${params.id} and e.eliminado=0"
        
        def queryc="select count(e) from ElementoPorOportunidadH e where e.oportunidadh.id=${params.id} and e.eliminado=0"
        
        def num=ElementoPorOportunidadH.executeQuery(queryc)
        
        def elementoPorOportunidadInstanceList=ElementoPorOportunidadH.findAll(query,[max:params.max,offset:xoffset.toLong()])
        render view:"indexh",  model: [elementoPorOportunidadInstanceList:elementoPorOportunidadInstanceList,
                                       elementoPorOportunidadInstanceCount:num[0],xoportunidad:params.id]
    }

    def listarBorrados(Integer max) {

        int itemxview=generalService.getItemsxView(0)
        params.max = Math.min(max ?: itemxview, 100)
        String  xoffset=params.offset?:0

        def query="from ElementoPorOportunidad e where e.oportunidad.id=${params.id} and e.eliminado=1"
        def elementoPorOportunidadInstanceList=ElementoPorOportunidad.findAll(query,[max:params.max,offset:xoffset.toLong()])

        def queryb="select count(e) from ElementoPorOportunidad e where e.oportunidad.id=${params.id} and e.eliminado=1"
        def num=ElementoPorOportunidad.executeQuery(queryb)
        render view: "index" , model:[ elementoPorOportunidadInstanceList: elementoPorOportunidadInstanceList,
            elementoPorOportunidadInstanceCount:num[0],xoportunidad:params.id,
            itemxview:itemxview,xtitulo:message(code:'listarItems.borrados.label')]
    }

    def show(ElementoPorOportunidad elementoPorOportunidadInstance) {
        respond elementoPorOportunidadInstance
    }
    
    def showh() {
       def elementoPorOportunidadInstance=ElementoPorOportunidadH.get(params.id) 
       render view:"showh", model:[elementoPorOportunidadInstance:elementoPorOportunidadInstance]
    }

    def borrar(ElementoPorOportunidad elementoPorOportunidadInstance) {

        if (params.id == null) {
            notFound()
            return
        }

        elementoPorOportunidadInstance= ElementoPorOportunidad.get(params.id)

        elementoPorOportunidadInstance.eliminado=1

        elementoPorOportunidadInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ElementoPorOportunidad.label', default: 'Empresa'), elementoPorOportunidadInstance.id])
                //redirect urli: request.getHeader('referer')
                redirect url:"/ElementoPorOportunidad/index/"+elementoPorOportunidadInstance.oportunidad?.id
            }
            '*'{ respond lineaInstance, [status: OK] }
        }
    }

    def create() {
        respond new ElementoPorOportunidad(params)
    }

    @Transactional // save
    def save(ElementoPorOportunidad elementoPorOportunidadInstance) {
        if (elementoPorOportunidadInstance == null) {
            notFound()
            return
        }
        
        elementoPorOportunidadInstance.oportunidad=Oportunidad.get(params.idOportunidad)
        
        elementoPorOportunidadInstance.linea=Linea.get(params.idLinea)
        
        elementoPorOportunidadInstance.sublinea=Sublinea.get(params.idSublinea)
        
        elementoPorOportunidadInstance.cantidad=params.long('cantidad')
        elementoPorOportunidadInstance.valor=params.double('valor')
         
        elementoPorOportunidadInstance.validate()
        
        if (elementoPorOportunidadInstance.hasErrors()) {
            respond elementoPorOportunidadInstance.errors, view: 'create'
            return
        }

        elementoPorOportunidadInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'elementoPorOportunidadInstance.label', default: 'ElementoPorOportunidad'), elementoPorOportunidadInstance.id])
                redirect url:"/ElementoPorOportunidad/index/"+elementoPorOportunidadInstance?.oportunidad.id+"?sw=1"
            }
            '*' { respond elementoPorOportunidadInstance, [status: CREATED] }
        }
    }

    def edit(ElementoPorOportunidad elementoPorOportunidadInstance) {
        respond elementoPorOportunidadInstance
    }

    @Transactional

    def update(ElementoPorOportunidad elementoPorOportunidadInstance) {
        
        if (elementoPorOportunidadInstance == null) {
            notFound()
            return
        }
        elementoPorOportunidadInstance.oportunidad=Oportunidad.get(params.idOportunidad)
        
        elementoPorOportunidadInstance.linea=Linea.get(params.idLinea)
        
        elementoPorOportunidadInstance.sublinea=Sublinea.get(params.idSublinea)
        
        elementoPorOportunidadInstance.cantidad=params.long('cantidad')
        elementoPorOportunidadInstance.valor=params.double('valor')
        
        elementoPorOportunidadInstance.validate()

        if (elementoPorOportunidadInstance.hasErrors()) {
            respond elementoPorOportunidadInstance.errors, view: 'edit'
            return
        }

        elementoPorOportunidadInstance.save flush: true

        request.withFormat {
            form {
                //flash.message = message(code: 'default.updated.message', args: [message(code: 'ElementoPorOportunidad.label', default: 'ElementoPorOportunidad'), elementoPorOportunidadInstance.id])
                redirect url:"/ElementoPorOportunidad/index/"+elementoPorOportunidadInstance?.oportunidad.id+"?sw=1"
            }
            '*' { respond elementoPorOportunidadInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ElementoPorOportunidad elementoPorOportunidadInstance) {

        if (elementoPorOportunidadInstance == null) {
            notFound()
            return
        }

        elementoPorOportunidadInstance.delete flush: true

        request.withFormat {
            form {
                // flash.message = message(code: 'default.deleted.message', args: [message(code: 'ElementoPorOportunidad.label', default: 'ElementoPorOportunidad'), elementoPorOportunidadInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.warning = message(code: 'default.not.found.message', args: [message(code: 'elementoPorOportunidadInstance.label', default: 'ElementoPorOportunidad'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }


    }

    def infoSublineas(){

        def query="from Sublinea s where s.linea.id='${params.id}' and s.eliminado=0"
        def sublineaList=Sublinea.findAll(query)
        render template:'/sublinea/sublineas', model: [sublineaList:sublineaList]
    }
	
	
	def indexItems()
	{
		int itemxview=generalService.getItemsxView(0)		
		params.max = itemxview		
		String  xoffset=params.offset?:0		
		
		if(!params.filter)params.filter = [op:[:],oportunidad:[:]]		
		
		/*def query="from ElementoPorOportunidad e where e.oportunidad.id=3198 and e.eliminado=0"		
		def queryc="select count(e) from ElementoPorOportunidad e where e.oportunidad.id=3198 and e.eliminado=0"		
		def num=ElementoPorOportunidad.executeQuery(queryc)		
		//def oportunidadInstance=Oportunidad.get(params.id)		
		def elementoPorOportunidadInstanceList=ElementoPorOportunidad.findAll(query,[max:params.max,offset:xoffset.toLong()])
		respond elementoPorOportunidadInstanceList, model: [elementoPorOportunidadInstanceCount:num[0],
			xoportunidad:params.id,xtitulo:generalService?.getValorParametro('prodoprt00'),xcerrada:'S']*/
		
		params.filter.op.eliminado = "Equal"
		params.filter.eliminado='0'
		
		params['filter.op.oportunidad.eliminado']="Equal"		
		params['filter.oportunidad.eliminado']="0"
		
		//params.filter.op.oportunidad.idEtapa ="ILike"
		//params.filter.oportunidad.idEtapa='x'
		
		params.filter.op.oportunidad.idEtapa="InList"
		//params.filter.oportunidad.idEtapa="[posventx10,posventx25,posventx50]"
		params.filter.oportunidad.idEtapa=["posventx10","posventx25"]
		
		
		params.filter.op.oportunidad.fechaApertura="GreaterThan"
		//params['filter.oportunidad.fechaAperturaTo']="date.struct"
		params.filter.oportunidad.fechaAperturaTo="date.struct"
		params.filter.oportunidad.fechaApertura="date.struct"
		params.filter.oportunidad.fechaApertura_day="1"
		params.filter.oportunidad.fechaApertura_month="1"
		params.filter.oportunidad.fechaApertura_year="2015"
		params.filter.oportunidad.fechaAperturaTo_day="1"
		params.filter.oportunidad.fechaAperturaTo_month="1"
		params.filter.oportunidad.fechaAperturaTo_year="2030"
		//filter.Prospecto.fechaApertura_isDayPrecision=y&filter.fechaApertura_day=5&filter.fechaAperturaTo_month=3&filter.fechaAperturaTo_year=2017&filter.fechaApertura_month=3&filter.fechaAperturaTo=date.struct&filter.fechaApertura_year=2015&filter.fechaAperturaTo_day=5&filter.fechaApertura=date.struct&filter.op.fechaApertura=GreaterThan&
		//filter.op.oportunidad.fechaApertura=GreaterThan&offset=10&max=10

		elementosList=filterPaneService.filter(params, ElementoPorOportunidad)
		updateFilterLength()
		listaItems=elementosList2
		render(view:"indexItems", model:[filterParams:org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
			params:params,elementoPorOportunidadInstanceList:elementosList,
			elementoPorOportunidadInstanceCount:filterPaneService.count(params,ElementoPorOportunidad ),
			xtitulo:generalService?.getValorParametro('prodoprt00')])
		
		
	}
	
	
	
	def updateFilterLength()
	{
		filterList=params.clone()
		filterList['max']=5000
		filterList['offset']=0
		elementosList2=filterPaneService.filter(filterList, ElementoPorOportunidad)//lista con base en el filtro
//		  params.max=10
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	def exportarDatos=
	{
		
		List lista_export=[]
		//el nombre de los campos fields es como est�n definidos en la clase dominio
		//en este caso idMarca la utilizaremos para mostrar el total(cant*valor)
		//List fields = ["linea","sublinea","cantidad","valor","idMarca","oportunidad.numOportunidad","oportunidad.id","oportunidad.empleado.primerNombre"]
		List fields = ["linea","sublinea","oportunidad.numOportunidad","cantidad","valor","idMarca","oportunidad.empleado.primerNombre","oportunidad.valorOportunidad","oportunidad.trimestre","oportunidad.empresa.razonSocial","oportunidad.idEstadoOportunidad"]
		Map labels = ["linea":"Linea","sublinea":"Sublinea","oportunidad.numOportunidad":"Numero","cantidad":"Cantidad","valor":"Valor","idMarca":"Total","oportunidad.empleado.primerNombre":"Vendedor","oportunidad.valorOportunidad":"Valor Oportunidad","oportunidad.trimestre":"Q","oportunidad.empresa.razonSocial":"Empresa","oportunidad.idEstadoOportunidad":"Estado"]
		
		def xcant
		def xvalor
		
		def estadoOppty={ElementoPorOportunidad, value ->
			def estadoOportunidad=ElementoPorOportunidad.oportunidad.idEstadoOportunidad.toString()
			if(estadoOportunidad=='opocotizad')
				return "Cotizada"
			if(estadoOportunidad=='oporactiva')
				return "Activa"
				
		}
		
		def idMarcaTo_Total = {ElementoPorOportunidad, value ->
			
			   if (ElementoPorOportunidad?.cantidad==null)
                  xcant=0
	           else
			      xcant=ElementoPorOportunidad?.cantidad
               if (ElementoPorOportunidad?.valor==null)
                   xvalor=0
               else
			       xvalor=ElementoPorOportunidad?.valor 
				   return xcant*xvalor}
		
		def nombreCompleto={ElementoPorOportunidad,value->
			return ElementoPorOportunidad.oportunidad.empleado.nombreCompleto()
		}
		
		/*def regOportunidad={ElementoPorOportunidad,value->
			def stringOp=ElementoPorOportunidad.oportunidad.numOportunidadFabricante.toString()
			if(stringOp.contains('span'))
			return	stringOp.substring(stringOp.indexOf('>')+1, stringOp.indexOf('</')) 
			else
			return ElementoPorOportunidad.oportunidad.numOportunidadFabricante
		}*/

		//}
		//def opFabricante={Oportunidad,value->
		//return oportunidadService.getNumRegistros2(Oportunidad.id)
		//}
		//def getProbabilidad={Oportunidad,value->
			//return generalService.getValorParametro(Oportunidad.idEtapa)
		//}
		
		//Map formatters = [/*fechaCierreEstimada:date_solo_fecha,idEtapa:getProbabilidadregOportunidad:opFabricante*/:]
		/*
		println "params.titulo= "+params.titulo*/
		Map formatters = [idMarca:idMarcaTo_Total,'oportunidad.empleado.primerNombre':nombreCompleto,/*'oportunidad.numOportunidadFabricante':regOportunidad,*/'oportunidad.idEstadoOportunidad':estadoOppty]
		String filename=exportarService.setfilename(params.titulo)
		
		if(params.tipo_export=='1')//exportar todos
		{
			//resultadosfiltro_export=filterPaneService.filter(params, ElementoPorOportunidad)//lista con base en el filtro
			List idss=listaItems.id
			lista_export=exportarService.obtenerItemsSeleccionados(ElementoPorOportunidad,idss)
		}
		else //exportar seleccionados
		{
			println "hola cejejklasj"
			List ids=params.list('prodelegidos')//ids de items seleccionados
			lista_export=exportarService.obtenerItemsSeleccionados(ElementoPorOportunidad,ids)//lista de checkbox seleccionados
			
		}
		exportarService.exportar(ElementoPorOportunidad,lista_export,fields,labels,response,formatters,filename)
	}
	
	
	
	
	
	
	
	
	
	
}
