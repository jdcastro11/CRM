package crm



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TerritorioController extends BaseController{
	  
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def generalService
    def consecutivoService
	
    def index(Integer max) {
        int itemxview = generalService.getItemsxView(0)
        params.max = itemxview
        String xoffset = params.offset?:0

        def query ="from Territorio where eliminado = 0 and padre.id = null"
        def queryc ="select count(t) from Territorio t where eliminado = 0 and padre.id = null"
        /*prospectoInstanceCount:Prospecto.countByEliminadoAndIdEstadoProspecto(0,'proenproce')*/
		
        def territorioInstanceList = Territorio.findAll(query, [max:params.max, offset:xoffset.toLong()])

        def territorioInstanceCount = Territorio.executeQuery(queryc)

        render view: "index", model: [territorioInstanceList: territorioInstanceList,		
            territorioInstanceCount: territorioInstanceCount[0],
            itemxview: itemxview,
            xtitulo: generalService?.getValorParametro('territot01')
        ]
    }
	
    def detTerritorio (Integer max){
        int itemxview = generalService.getItemsxView(0)
        params.max = itemxview
        String xoffset = params.offset?:0
		
		
        def query =" from Territorio where padre.id = ${params.id} and eliminado = 0"
        def queryc ="select count(t) from Territorio t where padre.id = ${params.id} and eliminado = 0"
		
        def detTerritorioInstanceList = Territorio.findAll(query, [max:params.max, offset:xoffset.toLong()])

        def detTerritorioInstanceCount = Territorio.executeQuery(queryc)
        println detTerritorioInstanceCount

        render view: "detTerritorio", model: [detTerritorioInstanceList: detTerritorioInstanceList,
            detTerritorioInstanceCount: detTerritorioInstanceCount[0],
            itemxview: itemxview,
            xtitulo: generalService?.getValorParametro('territot01'),
            padre: params.id
        ]		
    }
	
    def listarBorrados(Integer max) {
        int itemxview = generalService.getItemsxView(0)
        params.max = itemxview
        String xoffset = params.offset?:0

        def query ="from Territorio where padre.id = null and eliminado = 1"
        def queryc ="select count(t) from Territorio t where padre.id = null and eliminado = 1"
		
        def territorioInstanceList = Territorio.findAll(query, [max:params.max, offset:xoffset.toLong()])

        def territorioInstanceCount = Territorio.executeQuery(queryc)

        render view: "index", model: [territorioInstanceList: territorioInstanceList,
            territorioInstanceCount: territorioInstanceCount,
            itemxview: itemxview,
            xtitulo: generalService?.getValorParametro('territot02')
        ]

		
    }

    def show(Territorio territorioInstance) {
        respond territorioInstance
        //render view:"show", model:[territorioInstance:territorioInstance,generalService:generalService]
    }

    def create() {
        respond new Territorio(params)
    }

    @Transactional
    def borrar(Territorio territorioInstance){
        if (params.id == null) {
            notFound()
            return
        }

        territorioInstance = Territorio.get(params.id)

        territorioInstance.eliminado = 1

        territorioInstance.save 
        flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Territorio.label', default: 'Territorio'), territorioInstance.id])
                redirect url:"/territorio/index/"
            }
			'*'{ respond territorioInstance, [status: OK] }
        }
    }

    @Transactional //save
    def save(Territorio territorioInstance) {
        if (territorioInstance == null) {
            notFound()
            return
        }

        if (territorioInstance.hasErrors()) {
            respond territorioInstance.errors, view:'create'
            return
        }

        territorioInstance.save flush:true
        def xvista 
        if (params.layout=='main')
         xvista="index"
         else 
         xvista="detTerritorio"
        request.withFormat {
            form {
                flash.warning = message(code: 'default.created.message', args: [message(code: 'territorioInstance.label', default: 'Territorio'), territorioInstance.id])
                 redirect url:"/territorio/${xvista}/${territorioInstance?.padre?.id}?layout=${params.layout}"
            }
			'*' { respond territorioInstance, [status: CREATED] }
        }
    }

    def edit(Territorio territorioInstance) {
        respond territorioInstance
    }

    @Transactional  //update
    def update(Territorio territorioInstance) {
        if (territorioInstance == null) {
            notFound()
            return
        }
        
        territorioInstance.validate()

        if (territorioInstance.hasErrors()) {
            respond territorioInstance.errors, view:'edit'
            return
        }
					
        territorioInstance.save flush:true
         def xvista 
        if (params.layout=='main')
         xvista="index"
         else 
         xvista="detTerritorio"
        
        println "Padre"
        println territorioInstance?.padre?.id
        println "xvista"
        println xvista
        request.withFormat {
            form {
                flash.warning = message(code: 'default.updated.message', args: [message(code: 'Territorio.label', default: 'Territorio'), territorioInstance.id])
               redirect url:"/territorio/${xvista}/${territorioInstance?.padre?.id}?layout=${params.layout}"
            }
			'*'{ respond territorioInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Territorio territorioInstance) {

        if (territorioInstance == null) {
            notFound()
            return
        }

        territorioInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Territorio.label', default: 'Territorio'), territorioInstance.id])
                redirect action:"index", method:"GET"
            }
			'*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'territorioInstance.label', default: 'Territorio'), params.id])
                redirect action: "index", method: "GET"
            }
			'*'{ render status: NOT_FOUND }
        }
    }
    
    def traerDptos(){  
       println "id=";println params.id
        def dptoList=generalService.getDptos(params.long('id')) 
        render template:"/territorio/dptos",model:[dptoList:dptoList]      
    
    }
    
    def traerMunicipios(){    
       println "Dpto="
       println params.id
       def municipioList=generalService.getMunicipios(params.id.toLong())
       println municipioList
       render template:"/territorio/municipios", model:[municipioList:municipioList]        
    
    }
}
