package crm
import java.util.Map
import java.util.Random 
/*import crm.ImportadorExcel*/
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class DetPedidoController extends BaseController{

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
    def exportService
    def generalService
    def filterPaneService
    def pedidoService 
    def auditoriaService
    
    def index(Integer max) {
        
         int itemxview
        if (params.p){
            session.p=params.int('p')
           if (params.int('p')>10)              
              itemxview=params.int('p')
           else
            itemxview=generalService.getItemsxView(0)  
        }else{
            if (session.p)
               itemxview=session.p
             else
               itemxview=generalService.getItemsxView(0)           
        }
       
        params.max = itemxview
        String  xoffset=params.offset?:0        
        String  xordenar
        
        def idpedido
        if (params.id)
           idpedido=params.id
        else
           idpedido= session.zpedido  

        
        if(!params.filter) params.filter = [op:[:],pedido:[:]]
            params.filter.op.eliminado = "Equal"    
            params.filter.eliminado = '0' 
            params['filter.op.pedido.id'] = "Equal"
            params['filter.pedido.id'] = idpedido
                    
        if (params.filter.idEstadoDetPedido != null)
         params.filter.idEstadoDetPedido=generalService.getIdValorParametro('estadetped',params.filter.idEstadoDetPedido)       
          
        def pedidoInstance=Pedido.get(idpedido.toLong())   
       
        def xdescuento=pedidoInstance?.descuentoPedido?:0       
          
        def xpiva=Double.parseDouble(generalService.getValorParametro('iva').toString())
		
		
		
		//-------------------------------------CORRECCION TOTAL-------------------------------
		def anioPedido=pedidoInstance.numPedido.toString().split("-")[2]
		
		if(anioPedido=="17"||anioPedido=="18"||anioPedido=="19")
			xpiva=Double.parseDouble(generalService.getValorParametro('iva2017').toString())
			
		def listaPed16Iva19=generalService.getValorParametro('ped16iva19').toString().split(",")
		def listaPed17Iva16=generalService.getValorParametro('ped17iva16').toString().split(",")
		def listaPed18Iva16=generalService.getValorParametro('ped18iva16').toString().split(",")
						
		if(listaPed17Iva16.contains(pedidoInstance.numPedido))//Si el pedido actual se encuentra en la lista de casos especiales de 2017 con iva 16%
			xpiva=Double.parseDouble(generalService.getValorParametro('iva').toString())

		if(listaPed18Iva16.contains(pedidoInstance.numPedido))//Si el pedido actual se encuentra en la lista de casos especiales de 2018 con iva 16%
			xpiva=Double.parseDouble(generalService.getValorParametro('iva').toString())
				
		if(listaPed16Iva19.contains(pedidoInstance.numPedido))//Si el pedido actual se encuentra en la lista de casos especiales de 2016 con iva 19%
			xpiva=Double.parseDouble(generalService.getValorParametro('iva2017').toString())		
		
		//-------------------------------------CORRECCION TOTAL-------------------------------
		
		
		
		/*if(pedidoInstance.numPedido.toString().split("-")[2]=="17") || pedidoInstance.numPedido=='BAQ-0557-16' ||
			pedidoInstance.numPedido=='BAQ-0488-16' || pedidoInstance.numPedido=='BAQ-0489-16' 
			|| pedidoInstance.numPedido=='BOG-0190-16' || pedidoInstance.numPedido=='BAQ-0554-16' || pedidoInstance.numPedido=='BAQ-0556-16'
			|| pedidoInstance.numPedido=='BUC-0033-16' || pedidoInstance.numPedido=='BAQ-0338-16' || pedidoInstance.numPedido=='BAQ-0553-16')
			xpiva=Double.parseDouble(generalService.getValorParametro('iva2017').toString())*/		

			
		//A continuacion un caso especial donde el pedido es del 2017 pero se realiz� con un iva del 16%
			/*if(pedidoInstance.numPedido=='BAQ-0156-17' || pedidoInstance.numPedido=='BAQ-0271-17' || pedidoInstance.numPedido=='BAQ-0270-17'
				||pedidoInstance.numPedido=='BAQ-0294-17'||pedidoInstance.numPedido=='BAQ-0293-17'||pedidoInstance.numPedido=='BAQ-0295-17'
				||pedidoInstance.numPedido=='BAQ-0296-17'||pedidoInstance.numPedido=='BAQ-0356-17'||pedidoInstance.numPedido=='BAQ-0358-17'
				||pedidoInstance.numPedido=='BAQ-0426-17'||pedidoInstance.numPedido=='BAQ-0458-17'||pedidoInstance.numPedido=='BAQ-0469-17'
				||pedidoInstance.numPedido=='BAQ-0473-17'||pedidoInstance.numPedido=='BAQ-0474-17'||pedidoInstance.numPedido=='BAQ-0495-17')				
				xpiva=Double.parseDouble(generalService.getValorParametro('iva').toString())*/
		//-----------------------------------------------------------------------------------
           
        def detPedidoInstanceList = filterPaneService.filter( params, DetPedido )
        
        // Total  valores sin filtros
        def  xsubtotal1=pedidoService.valorPedido(idpedido)
             
        def  xiva1=xpiva*(xsubtotal1-xdescuento)
        println "xiva1=";println xiva1
        def  xtotal1=xsubtotal1-xdescuento+xiva1
       
        def  xsubtotal=0       
        detPedidoInstanceList.each{
            if (it.idEstadoDetPedido!='peddetpd06')
                xsubtotal+=it.cantidad*it.valor            
        }
        
       def xiva=xpiva*(xsubtotal-xdescuento)
       def xtotal=xsubtotal-xdescuento+xiva
       
        respond detPedidoInstanceList,  model:[ 
            detPedidoInstanceCount: filterPaneService.count( params, DetPedido ),
            filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
            xtitulo:generalService?.getValorParametro('detPedit01'),
            xpedido:params.id,xdescuento:xdescuento,xiva:xiva,xsubtotal:xsubtotal,xtotal:xtotal,
            xsubtotal1:xsubtotal1,xiva1:xiva1,xtotal1:xtotal1, params:params]      
     
    }

    def listarBorrados(Integer max) {

        int itemxview=generalService.getItemsxView(0)
        params.max = Math.min(max ?: itemxview, 100)
        String  xoffset=params.offset?:0
       
        def query="from DetPedido  where pedido.id=${params.id} and eliminado=1"
        def detPedidoInstanceList=DetPedido.findAll(query,[max:params.max,offset:xoffset.toLong()])

        render view: "index" , model:[detPedidoInstanceList:detPedidoInstanceList,
            detPedidoInstanceCount: DetPedido.countByEliminado(1),
            itemxview:itemxview,xtitulo:generalService?.getValorParametro('detPedit05')]
    }

    @Transactional   //borrar
    def borrar(DetPedido detPedidoInstance) {

        if (params.id == null) {f
            notFound()
            return
        }

        detPedidoInstance= DetPedido.get(params.id)

        detPedidoInstance.eliminado=1

        detPedidoInstance.save flush:true
         if (detPedidoInstance)
              actualizarValorPedido(detPedidoInstance.pedido.id)
        
        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'detPedido.label', default: 'DetPedido'), detPedidoInstance.id])
                redirect url:"/detPedido/index/"+ detPedidoInstance.pedido.id            }
            '*'{ respond facturaInstance, [status: OK] }
        }
    }
    
    def show(DetPedido detPedidoInstance) {
        respond detPedidoInstance, model:[sw:0]
    }

    def create() {
        respond new DetPedido(params), model:[sw:1]
    }

    @Transactional  //save
    def save(DetPedido detPedidoInstance) {
        if (detPedidoInstance == null) {
            notFound()
            return
        }
        def productoInstance=Producto.findByRefProducto(params.refProducto)
        if (productoInstance !=null)  detPedidoInstance.producto=productoInstance
//-------------------DESDE ACÁ----------------------------------------------------
		generalService.crearOActualizarContrato(request,servletContext,params,detPedidoInstance,"0")
		
//-------------------HASTA ACÁ----------------------------------------------------
		
			//-------------TIENE QUE GUARDARSE PRIMERO EL DETPEDIDO, LUEGO EL CONTRATO PARA SUBIR EL ARCHIVO
		
          //Actualizar valor pedido
           actualizarValorPedido(detPedidoInstance?.pedido?.id)
              
            // hadoff obligatorio para pedidos de mas de 150,000 dolares            
            String ztrm=generalService.getValorParametro('trm')
            def ytrm=new BigDecimal(ztrm)
            String zvalhandoff=generalService.getValorParametro('venmaxhand') 
            BigDecimal xvalhandoff=new BigDecimal(zvalhandoff)
            BigDecimal xvalorpedido=detPedidoInstance?.pedido?.valorPedido
            BigDecimal xtrm=detPedidoInstance?.pedido?.trm?:ytrm
            if (detPedidoInstance?.pedido?.idTipoPrecio=='pedtprec01'){ // si el pedido esta en pesos hay que calcular en dolares para el handOff
               if (xtrm !=0 ){
                   xvalorpedido=xvalorpedido/(xtrm)
               } 
            }
           if (xvalorpedido >= xvalhandoff){            
             detPedidoInstance?.pedido?.handOff='S'
          }  
         // actualizar valor  oportunidad y prospecto si lo hay 
        if (detPedidoInstance?.pedido?.oportunidad){ 
              def xvalor=detPedidoInstance?.pedido?.valorPedido 
              def xidoportunidad=detPedidoInstance?.pedido?.oportunidad?.id
              pedidoService.actualizarValor(xvalor,xtrm,xidoportunidad)
          }
             
        auditoriaService.logIn('DetPedido',detPedidoInstance?.id)
        
        /*request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'detPedidoInstance.label', default: 'DetPedido'), detPedidoInstance.id])
                redirect  url:"/detPedido/index/"+ detPedidoInstance.pedidoId
            }
            '*' { respond detPedidoInstance, [status: CREATED] }
        }*/
		
		redirect url:"/detPedido/index/${params.idPedido}?sw=1"
		flash.message="Producto agregado exitosamente!"
    }
	
	
	def renovarContrato(DetPedido detPedidoInstance){		
		render view:"renovar", model:[detPedidoInstance:detPedidoInstance]
	}
	
	@Transactional
	def renovarContratoDef(){
		 
		println "PARAMETROS RENOVAR CONTRATO "+params
		//-----------------------------------------------------OBTENER CONTRATO
		Contrato contratoInstance=Contrato.get(params.idContrato)
		//-----------------------------------------------------OBTENER CONTRATO
		
		def tipoVen=generalService.getValorParametro(contratoInstance.idTipoVencimiento)
		def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong())).id
		def usuarioL=Empleado.findById(usuarioAccede)
		String urlbase=generalService.getValorParametro('urlaplic')
		


		String oldFechaVencimiento = contratoInstance.getPersistentValue('fechaVencimiento').toString()
		def newFechaVencimiento=params.fechaVencimiento
		String oldFechaInicio=contratoInstance.getPersistentValue('fechaInicio').toString()
		def newFechaInicio=params.fechaInicio
		String oldFechaVenci=generalService.stringDateWithTimeToDate(oldFechaVencimiento)
		String oldFechaIni=generalService.stringDateWithTimeToDate(oldFechaInicio)

		Date fechaInicio=generalService.stringToDate(params.fechaInicio)
		Date fechaVencimiento=generalService.stringToDate(params.fechaVencimiento)
		
		contratoInstance.observaciones=params?.observaciones?:''
		contratoInstance.fechaInicio=fechaInicio
		contratoInstance.fechaVencimiento=fechaVencimiento
		
		
		def idVendedor=contratoInstance.detpedido.pedido.empleado.id
		
		
		
		String empresaVenc=Empresa.get(params.empresaPedido).razonSocial
		String asunto="RENOVACION CONTRATO DE VENCIMIENTO - ${empresaVenc}"
		String cuerpo="Registro elaborado por: ${usuarioL}<br><br>Se ha efectuado la renovaci&oacute;n de un vencimiento tipo <b>${tipoVen}</b> para la empresa ${empresaVenc} y usted figura como responsable del mismo.<br><br><b>Descripci&oacute;n:</b><br>${contratoInstance.descripcion?:''}<br><br>Fecha de inicio anterior: <b>${oldFechaIni}</b><br>Nueva fecha de inicio: <b>${newFechaInicio}</b><br><br>Fecha vencimiento anterior: <b>${oldFechaVenci}</b><br>Nueva fecha vencimiento: <b>${newFechaVencimiento}</b><br><br> Para m&aacute;s detalles haga clic <a href='${urlbase}/detPedido/show/${params.id}?&layout=main'> AQUI </a>"
		generalService.notificarVencimiento(contratoInstance.idTipoVencimiento, idVendedor,asunto,cuerpo)
		
		
		contratoInstance.save flush: true,failOnError: true
		
	   redirect url:"/detPedido/show/${params.id}"
	   //redirect url:"/contrato/show/${params.vencimientoId}?layout=detalle&idenc=${idVenci}"
	   flash.message="Vencimiento  renovado exitosamente"
	}

    def edit(DetPedido detPedidoInstance) {
		println "Params son... "+params
        respond detPedidoInstance, model:[sw:1]
    }

    @Transactional //update
    def update(DetPedido detPedidoInstance) {
        if (detPedidoInstance == null) {
            notFound()
            return
        }
		
		//println "Parametros recibidos al editar producto... "+params
		
		generalService.crearOActualizarContrato(request,servletContext,params,detPedidoInstance,"1")
		
        def productoInstance=Producto.findByRefProducto(params.refProducto)
        
        if (productoInstance !=null)  detPedidoInstance.producto=productoInstance
        
        if (params.idPedido){
            detPedidoInstance.pedido=Pedido.get(params.long('idPedido'))
        }
        if (params.idProveedor) {
            detPedidoInstance.empresa=Empresa.get(params.long('idProveedor'))
        }
        detPedidoInstance.cantidad=params.long('cantidad')
        detPedidoInstance.valor=params.double('valor')
       
       
        detPedidoInstance.validate()
        
        if (detPedidoInstance.hasErrors()) {        
            respond detPedidoInstance.errors, view: 'edit'
            return
        }
        
        def swcambio=false
         if (detPedidoInstance.isDirty('cantidad') || detPedidoInstance.isDirty('valor')) swcambio=true

         detPedidoInstance.save flush: true 
        
       // Actualizando valor pedido si cambia cantidad  o valor
        actualizarValorPedido(detPedidoInstance.pedido.id)            
       if(swcambio){           
              
            // hadoff obligatorio para pedidos de mas de 150,000 dolares            
            String ztrm=generalService.getValorParametro('trm')
            def ytrm=new BigDecimal(ztrm) 
            String zvalhandoff=generalService.getValorParametro('venmaxhand') 
            BigDecimal xvalhandoff=new BigDecimal(zvalhandoff)           
            BigDecimal xvalorpedido=detPedidoInstance?.pedido?.valorPedido
            BigDecimal xtrm=detPedidoInstance?.pedido?.trm?:ytrm
            if (detPedidoInstance?.pedido?.idTipoPrecio=='pedtprec01'){
               if (xtrm !=0 ){
                   xvalorpedido=xvalorpedido/(xtrm)
               } 
            }
           if (xvalorpedido >= xvalhandoff){            
             detPedidoInstance?.pedido?.handOff='S'
          }   
          // actualizar valor  oportunidad y prospecto si lo hay 
          if (detPedidoInstance?.pedido?.oportunidad){ 
              def xvalor=detPedidoInstance?.pedido?.valorPedido 
              def xidoportunidad=detPedidoInstance?.pedido?.oportunidad?.id
              pedidoService.actualizarValor(xvalor,xtrm,xidoportunidad)
          }
        }      
               
       /* request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DetPedido.label', default: 'DetPedido'), detPedidoInstance.id])
                redirect  url:"/detPedido/index/"+ detPedidoInstance.pedido?.id
            }
            '*' { respond detPedidoInstance, [status: OK] }
        }*/
		
		redirect url:"/detPedido/index/${params.idPedido}?sw=1"
		flash.message="Producto modificado exitosamente!"
    }

    @Transactional  //delete
    def delete(DetPedido detPedidoInstance) {

        if (detPedidoInstance == null) {
            notFound()
            return
        }

        detPedidoInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DetPedido.label', default: 'DetPedido'), detPedidoInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.warning = message(code: 'default.not.found.message', args: [message(code: 'detPedidoInstance.label', default: 'DetPedido'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
    
    def moverProducto(){
    
        def prodList=[]
        
        if(params?.detpedidos){
            prodList.addAll(params?.detpedidos)
                def detPedidoInstance=DetPedido.get(prodList[0])
                def pedidoOld=detPedidoInstance.pedido.id
                def xnumPedido=detPedidoInstance.pedido.numPedido
                render view:"moverProducto",model:[prodList:prodList,pedidoOld:pedidoOld,xnumPedido:xnumPedido]  
        }else{          
            flash.warning = message(code: 'default.select.one')             
            redirect url:"/DetPedido/index/"+params.id
        }           
    }
    @Transactional
    def moverProductoDef(){
        
        def detPedidoInstance
        def prodLista=params.prodList.split(',').collect{it}     
        def sw=0    
        def pedidoInstance=Pedido.get(params.pedido.id)       
         prodLista.each{
           detPedidoInstance=DetPedido.get(it.toLong())
           if (detPedidoInstance.idEstadoDetPedido =='peddetpd00' || detPedidoInstance.idEstadoDetPedido=='peddetpd01'){               
                detPedidoInstance.pedido=pedidoInstance
                detPedidoInstance.save(flush:true,failOnSave:true)     
           }else sw=1
         }
           if (sw==0){  
                                
                 flash.message="Movimiento de productos realizado. Verifique en pedido destino: "+pedidoInstance?.numPedido                 
           }else
               flash.warning="Algunos productos no se movieron por su estado actual verifique en pedido destino: "+pedidoInstance?.numPedido      
          
        // actualizarValorPedido(params.pedido.id) 
        // actualizarValorPedido(params.pedidoOld) 
         redirect url:"/DetPedido/index/"+params.pedidoOld
        
        
    }
    
    def procesarProductoCompraSP(){ // desde el layout main sw=1 desde dentro Sw= 2 desde fuera
            if (params?.sw=='1'){
                render view :'compras', model: [xprod:params.id,xpedido:params.pedido,sw:11,xlayout:'main']
                return
             }
                 
            if (params?.detpedidos==null ) {             
                flash.warning = "Debe Seleccionar por lo menos un2 producto."
                redirect url:"/detPedido/indexn"  
                return
            }else 
                render view :'compras', model: [xprod:params.id,xpedido:params.pedido,sw:12,xlayout:'main']  
          
    }

    def procesarProductoCompra(){ // desde layout detalle
		println "hice clic desde aca dentro"
        if (params?.sw=='1'){
                render view :'compras', model: [xprod:params.id,xpedido:params.pedido,sw:21,xlayout:'detalle']
                return
        }
        if (params?.detpedidos==null ) {             
                flash.warning = "Debe Seleccionar por lo menos un producto."
                redirect url:"/detPedido/index/${params.id}"  
                return
            }else 
                render view :'compras', model: [xprod:params.id,xpedido:params.pedido,sw:22,xlayout:'detalle']  
          
    }
    
    @Transactional  //ProcesarProductoCompraDef
    def procesarProductoCompraDef(){   
                 println "Se proceso un producto."
				 println params
         if (params.detpedidos!=null){
            def detPedidoInstance
            
            def elegidos = params.detpedidos.split(',').collect{it}
            elegidos.each({
               detPedidoInstance=DetPedido.get(it)
               detPedidoInstance.ordenCompra=params.ordenCompra      
               detPedidoInstance.observaciones=params.observaciones
               detPedidoInstance.fechaPosibleLlegada=params.date('fechaPosibleLlegada','dd-MM-yyyy')
               detPedidoInstance.idEstadoDetPedido='peddetpd02'

			   println "DET PEDIDO INSTANCE ID ES..."+detPedidoInstance.id
			   			   
			   //AQUI DEBO COMPROBAR Y ACTUALIZAR EL ESTADO DEL PEDIDO A....PENDIENTE POR RECIBIR//---------
			   pedidoService.marcarPedidoPendientePorRecibir(params.pedido)
			   //AQUI DEBO COMPROBAR Y ACTUALIZAR EL ESTADO DEL PEDIDO A....PENDIENTE POR RECIBIR//---------
			   
			   
             if (params.idProveedor) {
              detPedidoInstance.empresa=Empresa.get(params.long('idProveedor'))
              } 
              detPedidoInstance.save(flush:true)
            })            
          }
        if (params.sw in ['11','12'])  
         redirect url:"/detPedido/indexn/"
        else
        redirect url:"/detPedido/index/${params.pedido}"
    }
    
    def procesarProductoAlmacen(){ // recibo mercancia almacen
        def detPedidoInstance=DetPedido.get(params.id) 
        println detPedidoInstance.properties
        render view :'almacen', model: [detPedidoInstance:detPedidoInstance,layout:params.layout]
    }
    
    @Transactional  //procesarProductoAlmacenDef
    def procesarProductoAlmacenDef(DetPedido detPedidoInstance){        

         def xcantRecibida=detPedidoInstance?.cantidadRecibida?:0
                     
        if ((xcantRecibida+params.long('cantidadARecibir')) < detPedidoInstance.cantidad  )       
            detPedidoInstance.idEstadoDetPedido='peddetpd05'
        else 
             detPedidoInstance.idEstadoDetPedido='peddetpd04'
        
        detPedidoInstance.cantidadRecibida=xcantRecibida + params.long('cantidadARecibir')
        detPedidoInstance.save()
        flash.message="Producto Actualizado en Cantidad Recibida"
        
        // Cada vez que se recibe se intenta cerrar el pedido por compras y notifica 
        pedidoService.cerrarPedidoPorCompras(detPedidoInstance?.pedido?.id)
        
        if(params.layout=='main')
          redirect url:"/detPedido/indexg?layout=main"
        else
        redirect url:"/detPedido/index/${detPedidoInstance?.pedido?.id}"
    }
    
    @Transactional  //anularProductoPedido()
    def anularProductoPedido(){
       
        int sw=0
        def prodList=new ArrayList()
        
        if(params.detpedidos !=null){
        
            prodList.addAll(params?.detpedidos)
           def detPedidoInstance
            prodList.each(){
                 detPedidoInstance=DetPedido.get(it)
                if (detPedidoInstance.idEstadoDetPedido in ['peddetpd00','peddetpd01']){
                    detPedidoInstance.idEstadoDetPedido='peddetpd06'
                    detPedidoInstance.save()
                } else sw=1
            }  
            if (sw==0) {
                flash.message="Productos elegidos han sido anulados"
                if(detPedidoInstance)
                    actualizarValorPedido(detPedidoInstance.pedido.id)            
            } 
            else flash.warning="Algunos productos no se anularon por su estado actual"
        
            redirect url:"/DetPedido/index/"+params.id
        }else{       
         
            flash.warning = message(code: 'default.select.one')              
            redirect url:"/DetPedido/index/"+params.id
            return
        } 
        
    }
    
    @Transactional  //eliminarProductoPedido()
    def eliminarProductoPedido(){
       
        int sw=0
        def prodList=new ArrayList()
         if(params.detpedidos !=null){
            prodList.addAll(params?.detpedidos)
            if (params.allRegs){             
              def idpedido =DetPedido.get(prodList[0]).pedido.id
              DetPedido.executeUpdate("delete DetPedido where pedido.id=${idpedido}")
               redirect url:"/DetPedido/index/"+params.id
                
            }else{
                def detPedidoInstance
                 prodList.each(){ 
                  detPedidoInstance=DetPedido.get(it)
                 if (detPedidoInstance.idEstadoDetPedido in ['peddetpd00','peddetpd01','peddetpd06']){
                     detPedidoInstance.delete()
                 } else sw=1
                }  
                if (sw==0){
                    flash.message="Productos elegidos han sido eliminados" 
                  
                   if (detPedidoInstance)
                       actualizarValorPedido(detPedidoInstance.pedido.id)
                }
                else flash.warning="Algunos productos no se eliminaron  por su estado actual"
        
                redirect url:"/DetPedido/index/"+params.id
           }
        }else{       
           
            flash.warning = message(code: 'default.select.one')              
            redirect url:"/DetPedido/index/"+params.id
            return
        } 
        
    }
    @Transactional  //deanularProductoPedido()
    def desanularProductoPedido(){
       
        int sw=0
        def prodList=new ArrayList()
        if(params.detpedidos !=null){
        
            prodList.addAll(params?.detpedidos)
            def detPedidoInstance
            prodList.each(){
                 detPedidoInstance=DetPedido.get(it)
                if (detPedidoInstance.idEstadoDetPedido=='peddetpd06'){
                    detPedidoInstance.idEstadoDetPedido='peddetpd00'
                    detPedidoInstance.save()
                } else sw=1
            }  
            if (sw==0){
                flash.message="Productos elegidos han sido desanulados"
                if (detPedidoInstance)
                  actualizarValorPedido(detPedidoInstance.pedido.id)            
            } 
            else flash.warning="Algunos productos no se desanularon por su estado actual"
        
            redirect url:"/DetPedido/index/"+params.id
        }else{       
         
            flash.warning = message(code: 'default.select.one')              
            redirect url:"/DetPedido/index/"+params.id
            return
        } 
        
    }
    
    def importarProductosPedido(){
        render view: "importar"        
    }
    
    @Transactional  //importarProductosPedidoDef
    def importarProductosPedidoDef(){
        Random rand = new Random()
		
        if (params.hayAnexo=='S'){     
           try {   
            def file = request.getFile('file')
            String zruta =generalService.getValorParametro('ruta02')
            def xruta = servletContext.getRealPath(zruta)
            String xnombre=rand.nextInt(1000000).toString()+".xls"
            def  rutayFile=new File( xruta,xnombre)
           
            if (!rutayFile.exists()){               
                file.transferTo( rutayFile)
            }
            
            RecordExcelImporter  importer=new RecordExcelImporter(rutayFile)
            importer.CONFIG_RECORD_COLUMN_MAP =[sheet:'Tabla_de_costos', startRow: 1, 
                columnMap:[ 'A':'Referencia', 
                            'B':'Descripcion',
                            'C':'Cant' ,
                            'D':'P_Venta_Unit',
                            'E':'Procesar_para']]
            def recordsMapList = importer.getRecords();
             if(recordsMapList){
                 int i=0
                 def detPedidoInstance
                recordsMapList.each(){
                    if (it.Referencia !=null){
                         detPedidoInstance=new DetPedido()
                        detPedidoInstance.pedido=Pedido.get(params.idPedido)
                        def productoInstance=Producto.findByRefProducto(it.Referencia)                      
                        detPedidoInstance.producto=productoInstance
                        detPedidoInstance.refProducto=it.Referencia
                        detPedidoInstance.descProducto=it.Descripcion
                        detPedidoInstance.cantidad=it.Cant
                        detPedidoInstance.valor=it.P_Venta_Unit 
                        //detPedidoInstance.idEstadoDetPedido='peddetpd00'
						detPedidoInstance.idEstadoDetPedido=generalService.estadoItemDetPedido(params.idPedido)
                        if (it.Procesar_para=='Mayorista')
                           detPedidoInstance.idProcesarPara='pedprosp01'
                        else
                           detPedidoInstance.idProcesarPara='pedprosp02'
                        
                        detPedidoInstance.eliminado=0
                        detPedidoInstance.save()                    
                       
                        i++
                     }
                  }
                  flash.message="("+i.toString()+") Productos importados !!!" 
                  if (detPedidoInstance)
                    actualizarValorPedido(detPedidoInstance.pedido.id)
                  
             }else{
                  flash.warning="Archivo no cumple estandar para carga exitosa.Verifique"
             }
            redirect url:"/DetPedido/index/${params.idPedido}"
            
            } catch(ex){
                 flash.warning="Archivo no cumple estandar catch para carga exitosa.Verifique"
                
                 redirect url:"/DetPedido/importarProductosPedido/${params.idPedido}"
            }
        }else{ 
            flash.warning="Debe cargar Hoja de costos primero.Verifique"
            redirect url:"/DetPedido/importarProductosPedido/${params.idPedido}"
        }
    }
    
    def infoLLegadas(){
        render view:"llegadaMercancia"        
    }
    
  
    def infoLLegadasDef(){
         
        def xmes =params.fecha[Calendar.MONTH]+1
        def xanio=params.fecha[Calendar.YEAR]
         
        response.contentType = grailsApplication.config.grails.mime.types[params.id]
        response.setHeader("Content-disposition", "attachment; filename=infoLLegadasMercancia.xls")
           
        Map formatters = [:]
        Map parameters = [:]
        Map reg
        List datos=[]
        def dias; def exito; def exitos=0;def n=0
        def query="""select fechaLlegada,fechaPosibleLlegada,descProducto,pedido.numPedido,pedido.nombreCliente,
                              refProducto,cantidad,idEstadoDetPedido 
                       from DetPedido 
                       where eliminado=0 and
                             idEstadoDetPedido='peddetpd04' and 
                             month(fechaLlegada)=${xmes} and 
                             year(fechaLlegada)=${xanio}  """        
       
        def entidadInstanceList=DetPedido.executeQuery(query)  
       
        if (entidadInstanceList==[]) {
            flash.warning="No hay datos para el mes y año elegido. Verifique"
            redirect url:"/detPedido/infoLLegadas"
            return
        }
         
        for (def entidadInstance in entidadInstanceList){   
            exito=0
            if (entidadInstance[0]!=null && entidadInstance[1] !=null){
                dias=entidadInstance[0]-entidadInstance[1]
                
            }else dias=0  
            if (dias<=0) exito=1 
            exitos=exitos+exito
            n=n+1
            reg=[:]           
            reg['0_Retraso']=dias
            reg['1_Exito']=exito 
            reg['2_Fecha_LLegada']=entidadInstance[0]
            reg['3_Fecha_Probable']=entidadInstance[1]
            reg['4_Descripcion']=entidadInstance[2]
            reg['5_Pedido']=entidadInstance[3]
            reg['6_Empresa']=entidadInstance[4]
            reg['7_Referencia']=entidadInstance[5]
            reg['8_Cantidad']=entidadInstance[6]
            reg['9_Estado']=generalService.getValorParametro(entidadInstance[7])
            datos.add(reg)
        } 
        reg=[:]
        reg['0_Retraso']=''
        if (n !=0)
        reg['1_Exito']=(exitos/n)*100 
        else 
        reg['1_Exito']=0
        datos.add(reg)            
        exportService.export('excel', response.outputStream,datos, formatters, parameters) 
    }
    
      // Listar productos perdientes por procesar almacen
    def indexg(Integer max){        
        int itemxview=generalService.getItemsxView(0)
        params.max = itemxview
        String  xoffset=params.offset?:0  
        if(!params.filter) params.filter = [op:[:],pedido:[:]]
        
        params.filter.op.eliminado = "Equal"     
        params.filter.eliminado = '0' 
        params.filter.op.idEstadoDetPedido="InList"
        params.filter.idEstadoDetPedido=['peddetpd02','peddetpd05']
        // Se excluyen productos de pedidos facturados o anulados
        params['filter.op.pedido.idEstadoPedido'] = "NotInList"
        params['filter.pedido.idEstadoPedido'] = ['pedanuladx']
		
             
        
        render view: "reciboMercancia",  model:[detPedidoInstanceList:filterPaneService.filter(params, DetPedido),
            detPedidoInstanceCount: filterPaneService.count( params, DetPedido ),
            filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),params:params,layout:'main']
        
    } 
    
    // Listar productos pendientes por comprar
    def indexn(Integer max){        
        int itemxview=generalService.getItemsxView(0)
        params.max = itemxview
        String  xoffset=params.offset?:0  
        if(!params.filter) params.filter =[op:[:],pedido:[:]]
        
        params.filter.op.eliminado = "Equal"     
        params.filter.eliminado = '0' //eliminados =0
        params.filter.op.idEstadoDetPedido="Equal" 
        params.filter.idEstadoDetPedido='peddetpd01'
        // Se excluyen peoductos de pedidos facturados o anulados
        params['filter.op.pedido.idEstadoPedido'] = "NotInList"
        params['filter.pedido.idEstadoPedido'] = ['pedanuladx']//los que no son anulados
		params.filter.op.idProcesarPara="NotEqual"
		params.filter.idProcesarPara="pedprosp02"//procesar para cableado
        
        render view: "compraMercancia",  model:[detPedidoInstanceList:filterPaneService.filter(params, DetPedido),
            detPedidoInstanceCount: filterPaneService.count( params, DetPedido ),
            filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),params:params,layout:'main']
        
    } 
    
    def reciboCompleto(){        
        println "ID_DEL PEDIDOJD->"+params.detpedidos
		println "Entre ac�aaaaaa.... "+params
        if(params.detpedidos)
          {
			  render (view:'almacenCompleto',model:[detpedidos:params.detpedidos])
			  return
		  }
         else {
         flash.warning="Debe elegir por lo menos un ítem.Verifique"        
        }
         if(params.layout=='main')
          redirect url:"/detPedidod/indexg?layout=main"
        else
          redirect url:"/detPedido/index/${params.idpedido}"
			//redirect url:"/crm/detPedido/index/1905?&sw=0"
			//crm/detPedido/index/${pedidoInstance?.id}?sw=${sw}
    }
    
     @Transactional  //reciboCompletoDef
    def reciboCompletoDef(){ 
        
         def elegidos = params.detpedidos.split(',').collect{it}
        
         def detPedidoInstance
        elegidos.each(){         
          detPedidoInstance=DetPedido?.get(it)
          detPedidoInstance.idEstadoDetPedido='peddetpd04'//procesado x almacen
          detPedidoInstance.fechaLlegada=params.date('fechaLlegada','dd-MM-yyyy')
          detPedidoInstance.cantidadRecibida=detPedidoInstance.cantidad
          detPedidoInstance.save()
         
        } 
         if (detPedidoInstance)   
           pedidoService.cerrarPedidoPorCompras(detPedidoInstance.pedido.id)
           
		   
		  println "PARAMETROS JEJEJE "+params 
        flash.message="Recibo Completo realizado para los ítem elegidos"
        if(params.layout=='main')
          redirect url:"/detPedido/indexg?layout=main"
        else
          //redirect url:"/detPedido/index/${detPedidoInstance?.pedido?.id}"
		//redirect url:"/detPedido/indexg?layout=main"
		redirect url:"/detPedido/index/${detPedidoInstance.pedido.id}?&sw=0"
    }  
    
     @Transactional
    def actualizarValorPedido(idpedido){
         def  pedidoInstance=Pedido.get(idpedido)
        
          BigDecimal xvalorpedido=pedidoService.valorPedido(idpedido.toString())
          if (pedidoInstance?.idTipoPrecio=='pedtprec02'){
            String ztrm=generalService.getValorParametro('trm')
            def ytrm=new BigDecimal(ztrm)
            BigDecimal xtrm=pedidoInstance?.trm?:ytrm
            pedidoInstance?.valorPedido=generalService.valorEnPesoTrm(xvalorpedido,xtrm)        
               
          }
          else          
             pedidoInstance?.valorPedido=xvalorpedido             
          pedidoInstance.save()
    }
	
	
	

  
}
