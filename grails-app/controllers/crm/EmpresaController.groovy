package crm

import org.springframework.jca.cci.CciOperationNotSupportedException
import groovy.transform.CompileDynamic
import groovy.transform.CompileStatic
import wslite.soap.SOAPClient
import wslite.soap.SOAPResponse
import javax.xml.ws.Endpoint

import static org.springframework.http.HttpStatus.*

import org.codehaus.groovy.grails.web.json.JSONArray;
import org.codehaus.groovy.grails.web.json.JSONObject;

import grails.transaction.Transactional
import grails.converters.*

//@Transactional(readOnly = true)
class EmpresaController extends BaseController{

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def generalService
    def filterPaneService

    def indexc(){ //lista de empresas cliente

        int itemxview=generalService.getItemsxView(0)
        params.max =itemxview
        String  xoffset=params.offset?:0
        String xidtitulo
        
               
        if(!params.filter) params.filter = [op:[:]]
        
        params.filter.op.idTipoEmpresa = "Equal"
        params.filter.idTipoEmpresa='empcliente'
        params.filter.op.eliminado = "Equal"
        params.filter.eliminado = '0' 
        params.filter.op.idTipoSede = "Equal"
        params.filter.idTipoSede ='empprincip'
        
        
        render view: 'index',  model:[ empresaInstanceList: filterPaneService.filter( params, Empresa ),
            empresaInstanceCount: filterPaneService.count( params, Empresa ),
            filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
            xtitulo:generalService.getValorParametro('empresat05')]
    } 
    
    def indexp(){ // lista empresas Prospecto

        int itemxview=generalService.getItemsxView(0)
        params.max =itemxview         
        String  xoffset=params.offset?:0
        String xidtitulo
        
               
        if(!params.filter) params.filter = [op:[:]]
        
        params.filter.op.idTipoEmpresa = "Equal"
        params.filter.idTipoEmpresa='empprospec'
        params.filter.op.eliminado = "Equal"     
        params.filter.eliminado = '0' 
        params.filter.op.idTipoSede = "Equal"
        params.filter.idTipoSede ='empprincip'                       
        
       
        render view: 'index',  model:[ empresaInstanceList: filterPaneService.filter( params, Empresa ),
            empresaInstanceCount: filterPaneService.count( params, Empresa ),
            filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
            xtitulo:generalService.getValorParametro('empresat00')]
    }
    
    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max =itemxview
        String  xoffset=params.offset?:0
        String xtipoEmpresa
        String xidtitulo


        xidtitulo="empresat05"
        if (params.id){
           session['tipoF']=params.id            
        }else
           params.id=session['tipoF']
        
        String tipoF=params.id      // permite controlar el formulario para empresas prospecto, clientes y base
		println "TIPO F ES ........."+tipoF

        if ( tipoF=='0') {
            xtipoEmpresa="empbase"
            xidtitulo="empresat13"
        }else if ( tipoF=='1') {
            xtipoEmpresa="empprospec"
            xidtitulo="empresat00"
        } else if ( tipoF=='2') {
			xtipoEmpresa="empcliente"
            xidtitulo="empresat05"            
        }else if ( tipoF=='5') {
             xidtitulo="provtitu00"
            xtipoEmpresa="empproveed"
        }
        
        if(!params.filter) params.filter = [op:[:]]    
        
     
        params.filter.op.idTipoEmpresa="Equal"
        params.filter.idTipoEmpresa=xtipoEmpresa
        params.filter.op.eliminado = "Equal"     
        params.filter.eliminado = '0'
        params.filter.op.idTipoSede = "Equal"
        if (tipoF !='0')   // para obtener todas las sedes de la empresa base
          params.filter.idTipoSede ='empprincip'
       
        
        def empresaInstanceList= filterPaneService.filter( params, Empresa )
        def empresaInstanceCount=filterPaneService.count( params, Empresa )
       
        respond empresaInstanceList, model:[empresaInstanceCount:empresaInstanceCount,tipoF:tipoF,
                   filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
                   xtitulo:generalService.getValorParametro(xidtitulo),params:params]
    }
    
    def listarSedes(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max = Math.min(max?: itemxview, 100)
        String  xoffset=params.offset?:0
        String xtipoEmpresa
        String xtitulo="empresat99"

        def query="from Empresa  where padreId='${params.id}' and eliminado=0 order by razonSocial"
        def queryc="select count(e) from Empresa e where padreId='${params.id}' and eliminado=0"
        
        def empresaInstanceList=Empresa.findAll(query,[max:params.max,offset:xoffset.toLong()])
        def xcount =Empresa.executeQuery(queryc)
        
        render view:"listarSedes", model:[empresaInstanceList: empresaInstanceList,
        empresaInstanceCount:xcount[0],
        xtitulo:generalService?.getValorParametro("${xtitulo}"),
        xidPadre:"${params.id}"]
    }
    
       
    def listarSucursales(){

        int itemxview=generalService.getItemsxView(0)
        params.max =itemxview
        String  xoffset=params.offset?:0
        String xidtitulo
        
               
        if(!params.filter) params.filter = [op:[:]]
        
        params.filter.op.idTipoEmpresa = "Equal"
        params.filter.idTipoEmpresa='empbase'
        params.filter.op.eliminado = "Equal"
        params.filter.eliminado = '0'
        //params.filter.op.idTipoSede = "Equal"
        // params.filter.idTipoSede ='empprincip'
        
      
        render view: 'listarSucursales',  model:[ empresaInstanceList: filterPaneService.filter( params, Empresa ),
            empresaInstanceCount: filterPaneService.count( params, Empresa ),
            filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
            xtitulo:generalService.getValorParametro('prinysucur')]
    } 
    
    def listarBorrados(Integer max) {

        int itemxview=generalService.getItemsxView(0)
        params.max = itemxview
        String  xoffset=params.offset?:0
        String xtipoEmpresa
        String xidtitulo
        
        String tipoF=params.id ?:session['tipoF']

        if ( tipoF=='1') {
            xtipoEmpresa="empprospec"
            xidtitulo="empresat04"
        } else if ( tipoF=='2') {
            xidtitulo="empresat09"
            xtipoEmpresa="empcliente"
        } else if ( tipoF=='5') {
             xidtitulo="provtitu01"
            xtipoEmpresa="empproveed"
        }
        if(!params.filter) params.filter = [op:[:]]
		//println "XTIPOEMPRESA "+xtipoEmpresa
        //params.filter.op.idTipoEmpresa = "Equal"
        //params.filter.idTipoEmpresa=xtipoEmpresa
        params.filter.op.eliminado = "Equal"
        params.filter.eliminado = '1'
        //params.filter.op.idTipoSede = "Equal"
        //params.filter.idTipoSede ='empprincip'
        def empresaInstanceList= filterPaneService.filter( params, Empresa )
        def empresaInstanceCount=filterPaneService.count( params, Empresa )
        
        println "ok valor tipoF=";params.id

        render view: "index" , model:[empresaInstanceList:empresaInstanceList,tipoF:tipoF,
                      filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
                       empresaInstanceCount:empresaInstanceCount,
                       itemxview:itemxview,xtitulo:generalService?.getValorParametro("${xidtitulo}"),xaccion:"listarBorrados",params:params]
    }
    
    def listarSedesBorradas(Integer max) {

        int itemxview=generalService.getItemsxView(0)
        params.max = itemxview
        String  xoffset=params.offset?:0
       
        
       String xtipoEmpresa="empcliente"
       String  xidtitulo="sedest04"
        
        def query="from Empresa  where idTipoEmpresa='${xtipoEmpresa}' and padreId=${params.id} and eliminado=1 order by razonSocial"
        def queryc="select count(e) from  Empresa e where padreId=${params.id} and eliminado=1"
        
        def empresaInstanceList=Empresa.findAll(query,[max:params.max,offset:xoffset.toLong()])
        def xcount= Empresa.executeQuery(queryc)
        def xidPadre=params.id
        render view: "listarSedes" , model:[empresaInstanceList:empresaInstanceList,
        empresaInstanceCount:xcount[0],
        itemxview:itemxview,xtitulo:generalService?.getValorParametro("${xidtitulo}"),xidPadre:xidPadre]
    }
    
    def show(Empresa empresaInstance) {
        respond empresaInstance
    }
    
    @Transactional // borrar
    def borrar(Empresa empresaInstance) {
      
        if (params.id == null) {
            notFound()
            return
        }
        
        if (generalService.hayInstancias('crm.Oportunidad', params.id,'e.idSucursal') ){
           flash.warning="Existe al menos una Oportunidad  asociado a esta empresa. Elimine primero las oportunidades, luego la empresa"
           if (params.tipo!=4)
                redirect url:"/empresa/index/"+params.tipo+"?layout=main"
            else
               redirect url:"/empresa/listarSedes/${empresaInstance?.id}?t=sedest00&layout=detail"
          
            return
       }
        if (generalService.hayInstancias('crm.Pedido', params.id,'e.idSucursal') ){
           flash.warning="Existe al menos un Pedido  asociado a esta empresa. Elimine primero los pedidos, luego la empresa"
           if (params.tipo!=4)
                redirect url:"/empresa/index/"+params.tipo+"?layout=main"
            else                
               redirect url:"/empresa/listarSedes/${empresaInstance?.id}?t=sedest00&layout=detail"
          
            return
       }
       empresaInstance= Empresa.get(params.id)

        
       empresaInstance.eliminado=1

        empresaInstance.save flush:true

        
       flash.message ="Registro ha sido borrado. Consulte ver Borrados"
       
        if (params.tipo!=4)
         redirect url:"/empresa/index/"+params.tipo+"?layout=main"
       else
        redirect url:"/empresa/listarSedes/${empresaInstance?.id}?t=sedest00&layout=detail"
        
    }

    def create() {
        respond new Empresa(params)
    }

    //save con transacciones manejadas Programaticamente
	
    def save(Empresa empresaInstance) {

         empresaInstance=new Empresa(params)
    
     
        if (empresaInstance == null) {
            notFound()
            return
        }
        
     Empresa.withTransaction{ status ->    
            def num
            def xtit
            if (params.tipoF =='1') xtit='empresat10'
            else if (params.tipoF =='2') xtit='empresat06'
            else if (params.tipoF =='5') xtitc='provtitu03'
             
             if (empresaInstance.idTipoEmpresa=='empcliente' && empresaInstance.idTipoSede=='empprincip')
			 {
                
				log.info("Nit antes de aplicar el formatNit "+params.nit)
				println "Entre aca para formatear el guion"+params
				String nitNoGuion=generalService.formatearNitPedido(params.nit.toString())
				empresaInstance.nit=nitNoGuion

				//println "\n ***** Se guardo el cliente ${empresaInstance.razonSocial} con el nit ${empresaInstance.nit} luego de format ***** \n"
				log.info("\n ***** Se guardo el cliente ${empresaInstance.razonSocial} con el nit ${empresaInstance.nit} luego de format ***** \n")
				 

				num=Empresa.executeQuery("select count(e) from Empresa e where e.nit = '${nitNoGuion}'")
				

              
               if (num[0]>0) {
				  status.setRollbackOnly()
                  flash.warning="Nit ya existe  para una sede principal. Click en CANCELAR para modificar datos"
				  redirect url:"/empresa/create/?"+params.tipoF+"&layout=main&swmodal=&t=${xtit}"
                  return            
               }

               num=Empresa.executeQuery("Select count(e) from Empresa e where razonSocial='${params.razonSocial}' and idTipoEmpresa='empcliente'")
             
               if (num[0] > 0) {
                  status.setRollbackOnly()
                  flash.warning="Razon Social  ya existe  para una sede principal. click en CANCELAR  para modificar datos"
                  redirect url:"/empresa/create/?"+params.tipoF+"&layout=main&swmodal=&t=${xtit}"
                  return            
               }
           }         


            if (empresaInstance.idTipoSede=='emprsucurs'){
                def queryc=Empresa.executeQuery("Select count(e) from Empresa e where padreId=${params.idPadre} and idTipoSede='emprsucurs'")
                def nsuc=queryc[0]+1
                empresaInstance.razonSocial=empresaInstance.razonSocial+" ("+nsuc.toString()+")"
                empresaInstance.padreId=params.long('idPadre')
            }

            if (params.idVendedor)
                empresaInstance.empleado=Empleado.get(params.idVendedor)

            empresaInstance.validate()

            if (empresaInstance.hasErrors()) {
               redirect url:"/empresa/create/?tipo="+params.tipoF+"&layout=main&t=empresat06&swmodal="          
                return
            }

            empresaInstance.save flush:true

            request.withFormat {
                form {
                    flash.message = message(code: 'default.created.message', args: [message(code: 'empresaInstance.label', default: 'Empresa'), empresaInstance.id])           //
                    if (empresaInstance.idTipoSede!='emprsucurs') {
                    redirect url:"/empresa/show/${empresaInstance?.id}?tipo=${params.tipoF}&layout=main&t=${xtit}"
                    }else {
                        redirect url:"/empresa/listarSedes/${empresaInstance?.padreId}?t=sedest00&layout=detail"
                    }
                }

                '*' { respond empresaInstance, [status: CREATED] }
            }
     }
    }

    def edit(Empresa empresaInstance) {
        respond empresaInstance
    }
    
    @Transactional  //save asinc
    def saveAsync() {
        
        Empresa empresaInstance = new Empresa(params)
        empresaInstance.validate()
        if (empresaInstance.hasErrors()) {
            def errors = empresaInstance.errors.allErrors.collect{
                ['message': message(error:it),
                 'field': it.getField(), 
                 'badValue': it.getRejectedValue()
                ]
            }
            render(contentType: "text/json") {
                ['success':  false, 'errors':errors]
            }
            return
        }
        
        def num
        if (empresaInstance.idTipoEmpresa=='empcliente' && empresaInstance.idTipoSede=='empprincip'){
           num=Empresa.executeQuery("select count(e) from Empresa e where e.nit='${params.nit}' and e.idTipoEmpresa='empcliente' and e.eliminado=0")
		   def lista="from Empresa e where e.nit='${params.nit}' and e.idTipoEmpresa='empcliente' and e.eliminado=0"
           println "=num[0] en nit =";println  num[0]
          if (num[0]>0) {
            render(status:"403",text:"Nit ya existe para una sede principal")
             return
          }		  
		  

          num=Empresa.executeQuery("Select count(e) from Empresa e where razonSocial='${params.razonSocial}' and idTipoEmpresa='empcliente' and eliminado=0")
          println "num en razon social=";println num[0]
          if (num[0] > 0) {
             render(status:"403",text:"Razon Social  ya existe para una sede principal")
             return
          }
      }     

        String nitNoGuion=generalService.formatearNitPedido(params.nit.toString())
        empresaInstance.nit=nitNoGuion
        //Modificación agregada el 20/04/2018 Por José Castro para eliminar error al momento de agregar prospectos nuevos
        if(empresaInstance.nit=="null"){
            empresaInstance.nit=null
        }
        empresaInstance.save flush:true

        render(contentType: "text/json") {
            ['success':  true, key:empresaInstance.id, value:empresaInstance.razonSocial]
        }
        
    }

    // update con transaccion manejada programaticamente
    def update(Empresa empresaInstance) {
         
    if (empresaInstance == null) 
    {
            notFound()
            return
        }  
        
       Empresa.withTransaction{ status ->
            def  num 
            def xtit
           
            if (params.tipoF =='1') xtit='empresat12'
            else if (params.tipoF =='2') xtit='empresat07'
            else if (params.tipoF =='5') xtit='provtitu05'
         
            if (empresaInstance.idTipoEmpresa=='empcliente' && empresaInstance.idTipoSede=='empprincip'){
                     num=Empresa.executeQuery("select count(e) from Empresa e where e.nit='${params.nit}' and id <> ${params.idempresa}  and e.idTipoEmpresa='empcliente' and e.eliminado=0")
                        println "El numero es "+num
                        if (num[0] > 0) {                          
                               status.setRollbackOnly()
                               flash.warning="Nit ya existe  para una sede principal"
                                redirect url:"/empresa/edit/"+empresaInstance?.id+"?tipo="+params.tipoF+"&layout=${params.layout}&swmodal=&t=${xtit}"
                               return
                        }                  
                      
                      num=Empresa.executeQuery("Select count(e) from Empresa e where razonSocial='${params.razonSocial}'  and id <> ${params.idempresa}  and idTipoEmpresa='empcliente' and e.eliminado=0")
                    
                     if (num[0] > 0) {
                        flash.message="Razon Social ya existe  para una sede principal"
                         status.setRollbackOnly()
                         redirect url:"/empresa/edit/"+empresaInstance?.id+"?tipo="+params.tipoF+"&layout=${params.layout}&swmodal=&t=${xtit}"
                         return   
                     }
           }         

                if (params.idVendedor)
                    empresaInstance.empleado=Empleado.get(params.idVendedor)


                empresaInstance.validate()
                if (empresaInstance.hasErrors()) {  
                   
                    redirect url:"/empresa/edit/"+empresaInstance?.id+"?tipo="+params.tipoF+"&t=empresat07&layout=${params.layout}&swmodal="
                    return
                }

                empresaInstance.save flush:true
				log.info("Se actualiz\u00f3 informaci\u00f3n del cliente ${empresaInstance}")


                request.withFormat {
                    form {              
                        flash.message = message(code: 'default.updated.message', args: [message(code: 'Empresa.label', default: 'Empresa'), empresaInstance.id])
                                              
                        if (empresaInstance.idTipoSede!='emprsucurs') {
                             redirect url:"/empresa/index/"+params.tipoF+"?layout=${params.layout}&t=${xtit}&sort=razonSocial"
                        }else {
                            redirect url:"/empresa/listarSedes/${empresaInstance?.padreId}?t=sedest00&layout=detail"
                        }
                        }
                
                    '*'{ respond empresaInstance, [status: OK] }
                }
       }

    } // Fin update
    
  //update Asinc   transaccionalidad manejada manualmente
  def updateAsync() {
    
     Empresa.withTransaction{ status ->
        Empresa empresaInstance = Empresa.get(params.id)
        empresaInstance.properties = params

        empresaInstance.validate()
        if (empresaInstance.hasErrors()) {
            def errors = empresaInstance.errors.allErrors.collect{
                ['message': message(error:it),
                 'field': it.getField(), 
                 'badValue': it.getRejectedValue()
                ]
            }
            render(contentType: "text/json") {
                ['success':  false, 'errors':errors]
            }
            return
        }
       
             def num
             if (empresaInstance.idTipoEmpresa=='empcliente' && empresaInstance.idTipoSede=='empprincip'){
                 
                    num=Empresa.executeQuery("select id from Empresa e where e.nit='${params.nit}' and id <> ${empresaInstance.id} and e.idTipoEmpresa='empcliente' and e.eliminado=0")
                   
                   if (num[0] > 0 ) {
                        status.setRollbackOnly()
                     render(status:"403",text:"Nit ya existe para una sede principal")               
                      return            
                   }      
              
                    num=Empresa.executeQuery("Select id from Empresa e where razonSocial='${params.razonSocial}' and id <> ${empresaInstance.id} and idTipoEmpresa='empcliente' and eliminado=0")
                   
                    if (num[0] > 0) {
                        status.setRollbackOnly()
                       render(status:"403",text:"Razon Social  ya existe para una sede principal")           
                       return            
                    }
               
      } 
	  
	  	log.info("************ Nit creado desde EmpresaController/Update Async ***************")
		log.info("Nit Antes de FORMAT "+empresaInstance.nit)



		String nitNoGuion=generalService.formatearNitPedido(params.nit.toString())
		empresaInstance.nit=nitNoGuion
		
		
		log.info("Nit Luego de FORMAT "+empresaInstance.nit)
	  	empresaInstance.save flush:true,failOnError:true   // ojo funciona asi con esto comentado
		  
		  

        render(contentType: "text/json") {
            ['success':  true, key:empresaInstance.id, value:empresaInstance.razonSocial]
        }
        }
    }
    
    @Transactional //delete
    def delete(Empresa empresaInstance) {

        if (empresaInstance == null) {
            notFound()
            return
        }

        empresaInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Empresa.label', default: 'Empresa'), empresaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.warning = message(code: 'default.not.found.message', args: [message(code: 'empresaInstance.label', default: 'Empresa'), params.id])
                redirect url:"/empresa/index/"+params.tipoF+"?layout=main&swmodal="
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def mostrarCboEmpresa(){
        render template:'comboEmpresa'
    }

    def datosCliente(){
        def clienteInstance=Empresa.get(params.id)
        render template :'infoCliente1', model:[clienteInstance:clienteInstance,xidEmpresa:params.id]
    }

    def autoCompletar(){
        render  generalService.autoCompletar(params.term,params.id) as JSON
    }

    def direccion(){
        def empresaInstance=Empresa.get(params.id)
       render view:"direccion", model:[empresaInstance:empresaInstance]
    }
    
    @Transactional
    def cambiarRazonSocial(){
        try{
           def  empresaInstance=Empresa.get(params.id)
            def query1="update Prospecto set nombreCliente='${empresaInstance.razonSocial}' where empresa.id=${params.id}"
            Prospecto.executeUpdate(query1)
            def query2="update Oportunidad set nombreCliente='${empresaInstance.razonSocial}' where empresa.id=${params.id}"
            Oportunidad.executeUpdate(query2)
            def query3="update Pedido set nombreCliente='${empresaInstance.razonSocial}' where empresa.id=${params.id}"
            Pedido.executeUpdate(query3)
           flash.message="Cambio de Razón Social Realizado"
       }catch(Exception  e){            
         flash.warning="Cambio de Razón Social Falló.Consulte con el administrador"
       }
       redirect url:"/empresa/index/2?layout=main&swmodal="
        
    }
    
    def convertirACliente()
	{			
			def empresaInstance		
			if(params.list('empresas'))
			{
				println "DFGDFG"+params.list('empresas')
				
				if(params.list('empresas').size()!=1)
				{
					flash.warning = message(code: 'default.select.one')
					redirect url:"/empresa/index/1?layout=main&sort=razonSocial"
					return
				}
				else 
				{
					empresaInstance=Empresa.get(params.list('empresas'))
					def idemp=empresaInstance.id
					//render(view:"convertirCliente",model:[empresaInstance:empresaInstance])
					redirect (url:"/empresa/convertirACliente/${idemp}",model:[empresaInstance:empresaInstance])
				}			
			}
			else //
			{
				if(params.id)//desde adentro
				{
					empresaInstance=Empresa.get(params.id)
					render(view:"convertirCliente",model:[empresaInstance:empresaInstance])
				}
				else
				{
					//empresaInstance=Empresa.get(params.list('empresas'))
					flash.warning = message(code: 'default.select.one')
					redirect url:"/empresa/index/1?layout=main&sort=razonSocial"
					return
				
				}			
			}	
    }



    def listarClientesWS()
	{
		def peticion=request.JSON
		def usuarioExiste=generalService.usuarioExiste(peticion.username, peticion.password)
		if(usuarioExiste)
		{
			def consulta="Select e from Empresa e where e.eliminado=0 and e.nit IS NOT NULL and e.empleado IS NOT NULL order by e.razonSocial"

			def lista=Empresa.executeQuery(consulta)
			JSONArray listaClientes=new JSONArray()
			lista.each {
				JSONObject cliente=new JSONObject()
				cliente.put("cliente_id",it.id)


				String nit9digitos=generalService.formatearNitPedido(it.nit.toString())
				//log.info("Nit9Digitos es... "+nit9digitos)
				//if(nit9digitos.length()>9)
				//nit9digitos=nit9digitos.substring(0,9)
				//cliente.put("nit",it.nit.toString().split("-")[0])
				cliente.put("nit",nit9digitos)


				cliente.put("razonSocial",it.razonSocial)
				cliente.put("direccion",it.direccion)
				cliente.put("ejecutivo",it.empleado?.nombreCompleto())
				cliente.put("ejecutivo_id",it.empleado?.id)
				listaClientes.add(cliente)
			}
			response.status=200
			render ([listaClientes:listaClientes,transaccion:1,mensaje:'Transaccion exitosa',tamano:lista.size()]as JSON)
		}
		else
		{
			response.status=401
			render([transaccion: 0,mensaje:'Usuario no autorizado. Verifique'] as JSON)

		}



	}



	def listarEjecutivosWS()//recibo el Id y devuelvo el ejecutivo de cuenta
	{
		def peticion=request.JSON
		def usuarioExiste=generalService.usuarioExiste(peticion.username, peticion.password)
		if(usuarioExiste)
		{
			def empleado=Empleado.find{eliminado==0;empresa.id==peticion.clienteId}
			def empresa=Empresa.find{id==peticion.clienteId}?.razonSocial
			println peticion
			if(empresa)
			{
				if(!empleado)
				{
					response.status=404
					render([transaccion: 0,cliente:empresa,mensaje:'Este cliente no tiene un ejecutivo de cuenta asociado'] as JSON)
				}
				else
				{
					JSONObject empleadoInfo=new JSONObject()

					empleadoInfo.put("crm_id",empleado.id)
					empleadoInfo.put("nombre",empleado.nombreCompleto())
					empleadoInfo.put("identificacion",empleado?.identificacion)
					empleadoInfo.put("sucursal_id",empleado?.idSucursal)
					empleadoInfo.put("email",empleado?.email)
					empleadoInfo.put("username",empleado.usuario.usuario[0])

					render ([empleadoInfo:empleadoInfo,transaccion:1,cliente:empresa]as JSON)
				}

			}
			else
			{
					response.status=404
					render([transaccion: 0,mensaje:'Cliente no encontrado con el ID especificado'] as JSON)
			}



		}
		else
		{
			response.status=401
			render([transaccion: 0,mensaje:'Usuario no autorizado. Verifique'] as JSON)
		}



	}

    //para liberar WS de empresas (27/04/2018)José Castro
    def servicelis(){
        println "Revisando serviceLis, Usuario: " //+  params.username.toString() + ", Contraseña: " + params.password
        def consul = "select nit, razonSocial from Empresa"
        def con = Empresa.executeQuery(consul)
        render con as JSON
    }


}