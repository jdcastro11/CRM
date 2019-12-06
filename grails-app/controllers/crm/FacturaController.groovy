package crm

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FacturaController extends BaseController{

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def generalService
    def consecutivoService
    
    def index(Integer max) {
        int itemxview = generalService.getItemsxView(0);
        params.max = itemxview 
        String xoffset = params.offset?:0
        
        def query = "from Factura where pedido.id = '${params.id}' and eliminado=0"
        def queryc = "select count(f) from Factura f  where pedido.id = '${params.id}' and eliminado=0"
        
        def facturaInstanceList = Factura.findAll(query, [max:params.max,offset:xoffset.toLong()])
        
        def num=Factura.executeQuery(queryc)
        
        render view: "index", model: [facturaInstanceCount:num[0],
                                      facturaInstanceList: facturaInstanceList,
                                      itemxview:itemxview,
                                      xtitulo:generalService.getValorParametro('facturat01'),
                                      xidped:params.id]
    }

    def listarBorrados(Integer max) {
        int itemxview = generalService.getItemsxView(0);
        params.max = Math.min(max ?: 10, 100)
        String xoffset = params.offset?:0
        
        def query = "from Factura where pedido.id = '${params.id}' and eliminado=1 "
        def facturaInstanceList = Factura.findAll(query, [max:params.max,offset:xoffset.toLong()])
        render view: "index", model: [facturaInstanceCount: Factura.countByEliminado(1),
                                      facturaInstanceList: facturaInstanceList,
                                      itemxview: itemxview,
                                      xtitulo: generalService?.getValorParametro('facturat05'),
                                      xidped: params.id]
    }    
    
    def show(Factura facturaInstance) {
        respond facturaInstance
    }

    def create() {        
        respond new Factura(params)
    }
    
    @Transactional // borrar
    def borrar(Factura facturaInstance) {
     
        if (params.id == null) {
            notFound()
            return
        }
       
        facturaInstance= Factura.get(params.id)

        facturaInstance.eliminado=1

        facturaInstance.save flush:true

        request.withFormat {
            form {
                flash.message ="Registro borrado exitosamente" 
                redirect url:"/factura/index/"+ facturaInstance.pedidoId+"?sw=1"
            }
            '*'{ respond facturaInstance, [status: OK] }
        }
    }

    @Transactional //save
    def save(Factura facturaInstance) {
        if (facturaInstance == null) {
            notFound()
            return
        }
		
		println "parametros de la factura "+params
        facturaInstance.valorFactura=params.double('valorFactura')
        
        facturaInstance.trimestre=generalService.getTrim(facturaInstance.fechaFactura)
        
        facturaInstance.validate()
        if (facturaInstance.hasErrors()) {
            respond facturaInstance.errors, view: 'create'
            return
        }
        facturaInstance.pedido.idEstadoPedido=params.idEstadoPedido
		println "pedidoID"+facturaInstance.pedido.id
		def creadorPedidoLogId=EncLog.executeQuery("Select el.usuario.empleado.id from EncLog as el where el.idEntidad=${facturaInstance.pedido.id} and el.idTipoLog='enclogcrea' and el.nomEntidad='Pedido'")
		def correoCreador=Empleado.get(creadorPedidoLogId[0])//.email
		def correoVendedor=Empleado.get(facturaInstance.pedido.empleado.id).email
		
		println "lista correo "+correoCreador.email
		println "lista correod "+correoVendedor
		
		List listacorreos=[]
		
		String notifactura=generalService.getValorParametro('notifactura')
		listacorreos=generalService.convertirEnLista(notifactura)
		
		
		
		if(correoCreador)//en caso de que el pedido tenga un creador(encLog)
		listacorreos.add(correoCreador.email)
		listacorreos.add(correoVendedor)
		
		
			
		
		def numpedido=facturaInstance.pedido
		def cliente=facturaInstance.pedido.empresa.razonSocial
		def estadopedido=generalService.getValorParametro(params.idEstadoPedido)
		
		String urlbase=generalService.getValorParametro('urlaplic')
		def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
		String asunto="PEDIDO NO. ${numpedido} - ${cliente} Ha sido ${estadopedido}"
		String mensaje="<b>Elaborado por: </b> "+usuarioAccede+"<br> Al pedido No. : ${numpedido} se le ha adicionado un registro de factura.<br><br><b>No. de factura:</b> ${params.numFactura}<br><br><b>Fecha factura:</b> ${params.fechaFactura}<br><br><b>Por valor de:</b> ${params.valorFactura} <br><br>Para mas detalles haga clic <a href='${urlbase}/pedido/show/${facturaInstance.pedido.id}'> AQUI </a>"
		
		generalService.enviarCorreo(1, listacorreos, asunto,mensaje)
		
		
		if(params.idEstadoPedido=='pedfacturx')//SI DESPUES DE ESA FACTURA EL ESTADO DEL PEDIDO ES FACTURADO..
			facturaInstance.pedido.oportunidad.idEtapa='posvent100'
		
        facturaInstance.save flush: true
        
        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'facturaInstance.label', default: 'Factura'), facturaInstance.id])
                redirect url:"/factura/index/"+facturaInstance.pedidoId+"?sw=1"
            }
            '*' { respond facturaInstance, [status: CREATED] }
        }
    }

    def edit(Factura facturaInstance) {
        respond facturaInstance
    }

    @Transactional //update
    def update(Factura facturaInstance) {
        if (facturaInstance == null) {
            notFound()
            return
        }
        facturaInstance.valorFactura=params.double('valorFactura')
        
        facturaInstance.trimestre=generalService.getTrim(facturaInstance.fechaFactura)
        
        facturaInstance.validate()

        if (facturaInstance.hasErrors()) {
            respond facturaInstance.errors, view: 'edit'
            return
        }
              
        facturaInstance.pedido.idEstadoPedido=params.idEstadoPedido
    
        facturaInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Factura.label', default: 'Factura'), facturaInstance.id])
                redirect url:"/factura/index/"+facturaInstance.pedidoId+"?sw=1"
            }
            '*' { respond facturaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Factura facturaInstance) {

        if (facturaInstance == null) {
            notFound()
            return
        }

        facturaInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Factura.label', default: 'Factura'), facturaInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.warning = message(code: 'default.not.found.message', args: [message(code: 'facturaInstance.label', default: 'Factura'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
