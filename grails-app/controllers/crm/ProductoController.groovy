package crm
import grails.converters.*


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ProductoController extends BaseController{

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    
    def generalService
    def filterPaneService
    
    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0) 
        params.max =itemxview
        String  xoffset=params.offset?:0
        
        if(!params.filter) params.filter = [op:[:]]
        params.filter.op.eliminado = "Equal"     
        params.filter.eliminado = '0'        
   
        def productoIntanceList = filterPaneService.filter( params, Producto )
        respond productoIntanceList,  model:[
            productoInstanceCount: filterPaneService.count( params, Producto ),
            filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),          
            xtitulo:generalService?.getValorParametro('detPedit01')]       
       
    }

    def show(Producto productoInstance) {
        respond productoInstance
    }
    
    def listarBorrados(Integer max) {

       int itemxview=generalService.getItemsxView(0) 
        params.max =  itemxview
        String  xoffset=params.offset?:0

       def query="from Producto  where eliminado=1 order by descProducto"
       def productoInstanceList=Producto.findAll(query,[max:params.max,offset:xoffset.toLong()])

       render view: "index" , model:[productoInstanceList:productoInstanceList,
                                     productoInstanceCount: Producto.countByEliminado(1),
                                     itemxview:itemxview,xtitulo:generalService?.getValorParametro('detPedit05')]
     }
     
    @Transactional
    def borrar(Producto productoInstance) {

        if (params.id == null) {
            notFound()
            return
        }

        productoInstance= Producto.get(params.id)

        productoInstance.eliminado=1

        productoInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Producto.label', default: 'Producto'), productoInstance.id])
                redirect url:"/producto/index/"
            }
            '*'{ respond lineaInstance, [status: OK] }
        }
    }

    def create() {
        respond new Producto(params)
    }

    @Transactional
    def save(Producto productoInstance) {
        if (productoInstance == null) {
            notFound()
            return
        }

        productoInstance.linea=Linea.get(params.idLinea)  
        productoInstance.sublinea=Sublinea.get(params.idSublinea)
         
         productoInstance.validate()
         
        if (productoInstance.hasErrors()) {
            respond productoInstance.errors, view:'create'
            return
        }

        productoInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'productoInstance.label', default: 'Producto'), productoInstance.id])
                redirect url:"/producto/index"
            }
            '*' { respond productoInstance, [status: CREATED] }
        }
    }

    def edit(Producto productoInstance) {
        respond productoInstance
    }

    @Transactional
    def update(Producto productoInstance) {
        if (productoInstance == null) {
            notFound()
            return
        }
        
        productoInstance.linea=Linea.get(params.idLinea)  
        productoInstance.sublinea=Sublinea.get(params.idSublinea)
         
         productoInstance.validate()
        if (productoInstance.hasErrors()) {
            respond productoInstance.errors, view:'edit'
            return
        }

        productoInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Producto.label', default: 'Producto'), productoInstance.id])
                redirect url:"/Producto/index"
            }
            '*'{ respond productoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Producto productoInstance) {

        if (productoInstance == null) {
            notFound()
            return
        }

        productoInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Producto.label', default: 'Producto'), productoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'productoInstance.label', default: 'Producto'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
     def autoCompletarProducto(){   
        render  generalService.autoCompletarProducto(params.term) as JSON  
    }
    
    def datosProducto(){  
        
        def productoInstance=Producto.executeQuery("from Producto where id='${params.id}'") 
        println productoInstance
        render template :'infoProducto', model:[productoInstance:productoInstance[0]]
    }
}
