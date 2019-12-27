package crm
import java.math.BigDecimal
import org.springframework.web.context.request.RequestContextHolder
import grails.transaction.Transactional
import grails.converters.JSON
//import java.math.MathContext
@Transactional
class PedidoService {
    def generalService
    def oportunidadService 
    
    def crearAnexos(lista,id) {              
    
        lista.each{
            def num=Anexo.executeQuery("""select count(a)from Anexo a where 
                                      idEntidad=${id} and 
                                      nombreEntidad='pedido' and
                                      idTipoAnexo='${it}' and
                                      eliminado=0""")
           
            if (num[0]==0){
                def anexoInstance=new Anexo()
                anexoInstance.idEntidad=id
                anexoInstance.nombreEntidad="pedido"
                anexoInstance.idTipoAnexo="${it}"
                anexoInstance.idEstadoAnexo="genactivo"
                anexoInstance.eliminado=0
                anexoInstance.save()            
            }
        }
        return true
    }
    
    def getPedidosPorCliente(Long id){
        def query="from Pedido p where p.empresa.id='${id}' and  p.eliminado=0 and datediff(current_date(),p.fechaApertura)<9100"
        def pedidoList=Pedido.findAll(query)    
        return  pedidoList
    }
	
	
	def totalFacturaPedidos(def lista)//Recibo una lista de pedidos y a esa lista le busco todas las facturas correspondientes
	{
		def totalFacturaPesos=0
		def totalFacturaDolares=0
		
		lista.each{pedido->
			if(pedido.idTipoPrecio.equals("pedtprec01") && pedido.valorPedido!=null)
			{
				def subTotalFactura=valorFacturado(pedido.id.toString())['subtotal']
				totalFacturaPesos+=subTotalFactura
				
			}
			else
				{
					if(pedido.idTipoPrecio.equals("pedtprec02") && pedido.valorPedido!=null)
					{
						def subTotalFactura=valorFacturado(pedido.id.toString())['subtotal']
						totalFacturaDolares+=subTotalFactura
					}
				}
		}
		return [facturaDolares:totalFacturaDolares,facturaPesos:totalFacturaPesos]
		
		
		
		
	}
 
    def valorFacturado (String id){//todo: revisar bien el iva que si se edita no permite ver los informes por arquitecto.
        //println("Calculando el valor facturado")

        def query = Factura.executeQuery("select sum(f.valorFactura) from Factura f where f.pedido.id = ${id} and f.eliminado=0")
              
        def query1 =Pedido.executeQuery("select descuentoPedido from Pedido where id = ${id}")

        /*def query2= Pedido.executeQuery("select numPedido from Pedido where id = ${id}")
        println("Numero pedido "+query2)*/

        // Calculos

        def descuento = (query1[0] == null)?0:query1[0].toDouble()

        def subtotal = (query[0] == null)?0:query[0].toDouble()

        def subtotal1=subtotal-descuento

        /*def anioPedido=query2.toString().split("-")[2].substring(0,2)
        println("año "+anioPedido)

        def iva=0
        if (anioPedido == "16"){
            println("El iva a facturar es del 16%")
            iva = subtotal1 * 0.16
        }
        if (anioPedido != "16"){
            println("El iva a facturar es del 19%")
            iva = subtotal1 * 0.19
        }


        */
        def iva = subtotal * 0.16
        def total = subtotal1 + iva
        /*println("Subtotal1= "+subtotal1)
        println("IVA= "+iva)
        println("Total="+total)*/
        return [subtotal:subtotal,descuento:descuento, iva:iva, total:total,subtotalSinIva:subtotal1]
    }
    
    def valorPedido(String  id){
        def query="""select sum(d.cantidad*d.valor) 
                    from DetPedido d where d.pedido.id = ${id} and 
                    idEstadoDetPedido !='peddetpd06' and 
                    d.eliminado=0"""
        
        def valor = DetPedido.executeQuery(query)                            
        if (valor[0]!=null) return valor[0] else  return 0   
    }
    
    def valorFacturadoOportunidad (String id){		
    
        def query = Oportunidad.executeQuery("""select sum(f.valorFactura) 
                                               from Factura f, Pedido p 
                                                where f.pedido.id = p.id and 
                                                p.oportunidad.id = ${id} and 
                                                p.oportunidad.id !=null and 
                                                f.eliminado=0""")

        def query1 = DetPedido.executeQuery("""select sum(dp.cantidad*dp.valor) 
                                               from  DetPedido dp,Oportunidad op,Pedido p
                                                where  dp.pedido.id=p.id and
                                                p.oportunidad.id=op.id and 
                                                p.oportunidad.id !=null and 
                                                op.id= ${id} and 
                                                dp.eliminado=0 and  
                                                dp.idEstadoDetPedido!='peddetpd06' """)
        
       
        def total = (query[0] == null)?0:query[0]       
       
        def totalOp=(query1[0] == null)?0:query1[0]
        
        def  porcFac=(totalOp!=0)? total / totalOp:0      
      
        return [total:total,porcFac:porcFac]
		
    }
   
    def accesoDetPedido(String xidusuario,String xcampo){       
 
        def xrol =generalService.getRolUsuario(Long.valueOf(xidusuario)) 
        if (xcampo=='ordenCompra')    
        if (xrol == 'COMPRADOR') return 'S' else return 'N'
        
        if (xcampo=='fechaPosibleLlegada')    
        if (xrol == 'COMPRADOR') return 'S' else return 'N'
        
        if (xcampo=='fechaLlegada')    
        if (xrol == 'ALMACENISTA') return 'S' else return 'N'
        
    }
    
    def validarPedido(String xidpedido){
        
        def pedidoInstance=Pedido.get(xidpedido.toLong())
        
        // Validar que almenos haya un producto en el pedido  
        def queryc=DetPedido.executeQuery("select count(d) from DetPedido d where pedido.id=${xidpedido} and eliminado=0")
        if (queryc[0]==0) return 1               
        
        // Validar  propuesta aprobada por el cliente        
        // if  (!hayAnexo(xidpedido,'pedido','anexo03')) return 8                      
        // Validar OC del cliente        
         
        if  (!hayAnexo(xidpedido,'pedido','anexo02'))		{
			if  (!hayAnexo(xidpedido,'pedido','anexoC'))		
				return 7		
		}			 
			                      
        
        // Validar inf cliente nuevo
        if (pedidoInstance.clienteNuevo=='S'){
            if  (!hayAnexo(xidpedido,'pedido','anexo09')) return 2                      
        }
        // Validar requisito Hand-Off
        /*if (pedidoInstance.handOff=='S'){
            if  (!hayAnexo(xidpedido,'pedido','anexo11')) return 3                      
        }*/
        // Validar aprobacion nexsys
        if (pedidoInstance.idBidNexsys=='S'){
            if  (!hayAnexo(xidpedido,'pedido','anexo05')) return 4                      
        }
        // Validar aprobacion Bid IBM
        if (pedidoInstance.bidIbm=='S'){
            if  (!hayAnexo(xidpedido,'pedido','anexo07')) return 5                      
        }
        
        // Validar aprobacion propuesta servicio IBM
        if (pedidoInstance.servicioIbm=='S'){
            if  (!hayAnexo(xidpedido,'pedido','anexo08')) return 6                      
        }

        //Validar si el pedido EyC es de mantenimiento
        if(pedidoInstance.eyc=='S'){
            if (pedidoInstance.mantenimiento=='N'){
                // Validar  propuesta aprobada por el cliente
                if  (!hayAnexo(xidpedido,'pedido','anexo03')) return 8
                //Validar que contenga los planos
                if  (!hayAnexo(xidpedido,'pedido','anexo26')) return 9
            }else if (pedidoInstance.mantenimiento=='S'){
                // Validar  propuesta aprobada por el cliente
                if  (!hayAnexo(xidpedido,'pedido','anexo03')) return 8
            }
        }
        
        return 0  //todo bien con el pedido 
    }
    
    def hayAnexo(String xidentidad, String xentidad, xtipoanexo){
      
        def xnum=Anexo.executeQuery(""" 
                                    select count(a) from Anexo a where 
                                    idEntidad=${xidentidad.toLong()} and
                                    nombreEntidad='${xentidad}'  and 
                                    idTipoAnexo='${xtipoanexo}' and 
                                    nombreArchivo !=null and 
                                    eliminado=0                                       
                                    """)
        if (xnum[0]>0) 
        return true else return false
        
    }
    
    def accesoPedido(Long xidpedido, Long xidusuario,String xtipo){
      
        String xestado=''
        String xrol=generalService.getRolUsuario(xidusuario)
       
           
        if (xidpedido !=0){
            def pedidoInstance=Pedido.get(xidpedido)   
       
            if (pedidoInstance?.idAutorizado==generalService.getIdEmpleado(xidusuario)) return true
            if (pedidoInstance?.idVendedorAnterior==generalService.getIdEmpleado(xidusuario)) return true
            xestado=pedidoInstance?.idEstadoPedido
        } else return true

        // Pedido en elaboracion 
        if (xestado in ['pedfacturx','pedanuladx']) return false
        
        if (xestado=='pedenelab1' && xtipo in ['pedido'] && xrol!='VENDEDOR' && xrol!="GERENTE" && xrol!='ASISTENTE_VENTAS') return false
        
        if (xestado=='pedenelab1' && xtipo in ['factura'] && xrol!='VENDEDOR' && xrol!="GERENTE" && xrol!='ASISTENTE_VENTAS') return false
        
        if (xestado=='pedenelab1' && xtipo in ['anexo'] && xrol!='VENDEDOR' &&  xrol!="GERENTE" && xrol!='ASISTENTE_VENTAS') return false
         
        // Pedido en revision 
        if (xestado=='pedenrevi2' && xtipo in ['pedido']) return false
               
        if (xestado=='pedenrevi2' && xtipo in ['anexo'] && xrol!='ASISTENTE_FINANCIERO') return false
        
        if (xestado=='pedenrevi2' && xtipo in ['producto','factura']) return false

        // Pedido Compras y almacen

        //if (xtipo in ['pedido'] && xrol!='COMPRADOR') return true//para que compras visualice opciones

        //if ((xestado=='pedpencom3' || xestado=='pedpenrec4') && (xtipo in ['pedido'] && xrol!='COMPRADOR')) return true//para que compras visualice opciones

        if ((xestado=='pedpencom3' || xestado=='pedpenrec4') && (xtipo in ['pedido'] && xrol!='COMPRADOR' && xrol!='ALMACENISTA')) return false
        
        if ((xestado=='pedpencom3' || xestado=='pedpenrec4') && (xtipo in ['producto','anexo'] && xrol!='COMPRADOR' && xrol!='ALMACENISTA')) return false
        
        // Pedido en  Facturacion
        if (xestado=='pedpenfac2' && xtipo in ['pedido']) return false
        
        if (xestado=='pedpenfac2' && xtipo in ['anexo'] && xrol!='ASISTENTE_FINANCIERO') return false
        
       // Pedido Facturado Parcialmente
        if (xestado=='pedfacpar2' && xtipo in ['pedido'] ) return false
        
        return true 
        
    }
    
    def setEstadoProductos(Long xid, String xestado){
        def query ="update DetPedido d  set d.idEstadoDetPedido='${xestado}' where pedido.id=${xid}"
        DetPedido.executeUpdate(query)    
        
    }    
    
    def indicadorVentasQ(xid){  //Trimestral
       
        def hoy = new Date()
        def xmes =hoy[Calendar.MONTH]+1        
        def xanio=hoy[Calendar.YEAR] 
        Integer Qactual=(xmes+2)/3

        def xventasQ=Indicador.executeQuery("""select valor from Indicador where 
                                              idEntidad=${xid} and  
                                              idTipoIndicador='pedfacxven' and 
                                              periodo like 'Q%' and 
                                              anio = ${xanio} and
                                              nomEntidad='pedido' and Eliminado=0 and
                                              estado='A'""") 
        
        def xvacumQ=[];  def acum=0.0
        xventasQ.each(){
            acum+=it
            xvacumQ.add(acum)            
        }
              
        String  zmeta1=generalService.getValorParametro('porcenmeta')
        def metaQ=zmeta1.split(',').collect{it as int }        
                
        def xcuota        
        def empleadoInstance=Empleado.get(xid)
        if(empleadoInstance.cuota !=null)
        xcuota=empleadoInstance.cuota
        else  xcuota=0
        
        def xmeta=[];  def xcuotaQ=0.00
        
        for (int i=0; i<Qactual;i++){
            
            //xcuotames+=-1*metaQ[j]*xcuota/300   
            xcuotaQ+=metaQ[i]*xcuota/100   
            xcuotaQ=xcuotaQ.setScale(2, BigDecimal.ROUND_HALF_UP);
            xmeta.add(xcuotaQ)            
        }
        
        //  def xdifmeta=[xvacum, xmeta].transpose()*.sum()
        
        def xres=[]; def item=[];int k
        for (int i=0;i<Qactual;i++){
            k=i+1 
            item=['Q'+k,xvacumQ[i],xmeta[i]]
            xres.add(item)
        }           
          
        return xres
    }
    
    // MODIFICACIONES REALIZADAS POR MARIO PARA SACAR LA GRAFICA GERENCIA DE 
    // CUOTA VS FACTURADO POR Q
    def indicadorVentasQGerencia(xid){  //Trimestral
       
        def hoy = new Date()
        def xmes =hoy[Calendar.MONTH]+1        
        def xanio=hoy[Calendar.YEAR] 
        Integer Qactual=(xmes+2)/3

        def xventasQ=Indicador.executeQuery("""select sum(p.valor)from Indicador p where idTipoIndicador='pedfacxveq' and
               anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='pedido' and estado='A' and eliminado=0""") 
        
        def xvacumQ=[];  def acum=0.0
        xventasQ.each(){
            acum+=it
            xvacumQ.add(acum)            
        }
              
        String  zmeta1=generalService.getValorParametro('porcenmeta')
        def metaQ=zmeta1.split(',').collect{it as int }        
                
        def xcuota        
        def empleadoInstance=Empleado.get(xid)
        if(empleadoInstance.cuota !=null)
        xcuota=empleadoInstance.cuota
        else  xcuota=0
        
        def xmeta=[];  def xcuotaQ=0.00
        
        for (int i=0; i<Qactual;i++){
            
            //xcuotames+=-1*metaQ[j]*xcuota/300   
            xcuotaQ+=metaQ[i]*xcuota/100   
            xcuotaQ=xcuotaQ.setScale(2, BigDecimal.ROUND_HALF_UP);
            xmeta.add(xcuotaQ)            
        }
        
        //  def xdifmeta=[xvacum, xmeta].transpose()*.sum()
        
        def xres=[]; def item=[];int k
        for (int i=0;i<Qactual;i++){
            k=i+1 
            item=['Q'+k,xvacumQ[i],xmeta[i]]
            xres.add(item)
        }           
          
        return xres as JSON
    }
    
   // FINAL MODIFICACIONES 
   
    def indicadorVentasM(xid){  // mensual 
        def meses =['Ene','Feb','Mar','Abr','May','Jun',
                    'Jul','Ago','Sep','Oct','Nov','Dic']
        
        def hoy = new Date()
        def xmes =hoy[Calendar.MONTH]+1        
        def xanio=hoy[Calendar.YEAR]         
        
        def xventasM=Indicador.executeQuery("""select valor from Indicador where 
                                              idEntidad=${xid} and  
                                              idTipoIndicador='pedfacxven' and 
                                              periodo not like 'Q%' and 
                                              periodo <=${xmes} and  anio = ${xanio} and
                                              nomEntidad='pedido' and Eliminado=0 and
                                              estado='A'""") 
        
        def xvacumM=[]; def acum=0.0
        xventasM.each(){
            acum+=it
            xvacumM.add(acum)            
        }
        String  zmeta1=generalService.getValorParametro('porcenmeta')
        def metaQ=zmeta1.split(',').collect{it as int }        
                
        def xcuota        
        def empleadoInstance=Empleado.get(xid)
        if(empleadoInstance.cuota !=null)
        xcuota=empleadoInstance.cuota
        else  xcuota=0
        
        def xmeta=[];  def xcuotames=0.00;int j=0
        
        for (int i=1; i<=xmes;i++){
            j=(i+2)/3 -1            
            //xcuotames+=-1*metaQ[j]*xcuota/300   
            xcuotames+=metaQ[j]*xcuota/300   
            xcuotames=xcuotames.setScale(2, BigDecimal.ROUND_HALF_UP);
            xmeta.add(xcuotames)            
        }
        
        //  def xdifmeta=[xvacum, xmeta].transpose()*.sum()
        
        def xres=[]; def item=[];
       
        for (int i=0; i<xmes;i++){                   
            item=[meses[i],xvacumM[i],xmeta[i]] 
            xres.add(item)
        }           
    
        return xres
    }
  
    def  ventasPorPeriodo(xidven,xperiodo,xtipo){        
        def periodo   
        def hoy = new Date()
        def xanio=hoy[Calendar.YEAR]       
        
        if (xtipo=='M') periodo="month(fechaApertura)"  else periodo="trimestre"            
          
        def query =""" select sum(p.valorPedido),${periodo} from Pedido p                        
                       where p.empleado.id=${xidven} and 
                       year(fechaApertura)=${xanio} and  
                       ${periodo}='${xperiodo}' and p.eliminado=0 
                       group by  2
                      """
       
        def resp=Pedido.executeQuery(query)
        def res
        if (resp[0]) res=resp[0] else res=[0]
       
        query="from Indicador  where idEntidad=${xidven} and idTipoIndicador='pedfacxven' and  anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='pedido' and estado='A' and eliminado=0"
        
        String ztrm=generalService.getValorParametro('trm')
        BigDecimal xtrm=new BigDecimal(ztrm)
        if (xtrm==0) xtrm=3150
        
        def lista =Indicador.findAll(query)
        
        if(lista.size()==0){
            def indicadorInstance=new Indicador()
            indicadorInstance.anio="${xanio}"
            indicadorInstance.eliminado=0
            indicadorInstance.estado='A'
            indicadorInstance.nomEntidad='pedido'
            indicadorInstance.idEntidad=xidven
            indicadorInstance.idTipoIndicador='pedfacxven' 
            indicadorInstance.periodo=xperiodo
            indicadorInstance.valor=res[0] / (xtrm*1000) 
            indicadorInstance.save()
        }else {
            lista[0].valor=res[0]/(xtrm*1000)
            lista[0].save()
        }    
    }

    
     // mofificaciones realizadas por MQ 09/03/2015
    
    def  totalPedidosFacturadosQ(xidven){          
        def hoy = new Date()
        def xanio=hoy[Calendar.YEAR]      
        //1 es para traer el Q actual --- 2 para el rango defechas del Q
        def xperiodo = generalService.getQoRangoFechasQ('1', hoy)
        
        println "el dato solicitado es: " + xperiodo
        println "el periodo es "+ xperiodo
        println "el vendedor es "+xidven
        
        def query =""" select sum(p.valorPedido),count(p) from Pedido p                        
                       where p.empleado.id=${xidven} and 
                       year(fechaApertura)=${xanio} and  
                       trimestre ='${xperiodo}' and p.eliminado=0 and
                       idEstadoPedido= 'pedfacturx' 
                      """
       
        def resp=Pedido.executeQuery(query)
        def res
        if (resp[0]) res=resp[0] else res=[0]
        
        println "la respuesta al query"+ resp
    
        query="from Indicador  where idEntidad=${xidven} and idTipoIndicador='pedfacxveq' and  anio='${xanio}' and periodo='${xperiodo}' and nomEntidad='pedido' and estado='A' and eliminado=0"
        
        String ztrm=generalService.getValorParametro('trm')
        BigDecimal xtrm=new BigDecimal(ztrm)
        if (xtrm==0) xtrm=2000
        
        def lista =Indicador.findAll(query)
        
        if(lista.size()==0){
            def indicadorInstance=new Indicador()
            indicadorInstance.anio="${xanio}"
            indicadorInstance.eliminado=0
            indicadorInstance.estado='A'
            indicadorInstance.nomEntidad='pedido'
            indicadorInstance.idEntidad=xidven
            indicadorInstance.idTipoIndicador='pedfacxveq' 
            indicadorInstance.periodo=xperiodo
            indicadorInstance.valor= res[0]?:0 / (xtrm*1000) 
            indicadorInstance.cant=resp[1]?:0
            indicadorInstance.save()
        }else {
            lista[0].valor= res[0]?:0/(xtrm*1000)
            lista[0].cant = resp[1]?:0
            lista[0].save()
        }    
    }
    
    
    // fin modificaciones realizadas MQ 09/06/2015
    def  totalesPorPeriodoAll(xidvendedor,xtipo,entidad){        
        def meses=['01','02','03','04','05','06','07','08','09','10','11','12']
        def trims=['Q1','Q2','Q3','Q4']
        def xbase;def limite
        def hoy = new Date()
        def xmes=hoy[Calendar.MONTH]+1 
        int trim=(xmes+2)/3 
        
        if (xtipo=='M'){
            xbase=meses 
            limite=xmes
        }else{
            xbase=trims
            limite=trim
        }     
        for (int i=0;i<limite;i++) { 
            if (entidad=='pedido') ventasPorPeriodo(xidvendedor,xbase[i],xtipo)
            else if (entidad=='prospecto')   oportunidadService.valorProspectosPorPeriodo(xidvendedor,xbase[i],xtipo)
            else if (entidad=='oportunidad') oportunidadService.valorOportunidadPorPeriodo(xidvendedor,xbase[i],xtipo)
        }
    }
    
    def actualizarValor(valor,trm,id){
       
        def xidprospecto
        Oportunidad.withNewSession {s2 ->            
            def oportunidadInstance=Oportunidad.get(id.toLong())
            oportunidadInstance?.valorOportunidad=generalService.valorEnDolarTrm(valor,trm)
            xidprospecto=oportunidadInstance.prospecto?.id
            oportunidadInstance.save()              
            s2.flush()
            s2.close()
        }               
             
        if (xidprospecto){
           Prospecto.withNewSession {s2 ->
           def prospectoInstance=Prospecto.get(xidprospecto)
           prospectoInstance?.valorProspecto=generalService.valorEnDolarTrm(valor,trm)
           prospectoInstance.save()              
           s2.flush()
           s2.close()
           }
        }
        
    }
    
    def sacarNotificadosPorDefectoPedidos(params, tipoFuncionarios){
        def xiddestinatarios = []
        if(tipoFuncionarios ==3){
            // sacamos vendedor, area financiera y compradores
            def  pedidoInstance = Pedido.get(params.ident.toLong())
            xiddestinatarios.add(Empleado.get(pedidoInstance.empleadoId).email)
            xiddestinatarios.add(generalService.getValorParametro('compradore'))
            xiddestinatarios.add(generalService.getValorParametro('enccompras'))
            //xiddestinatarios.add(generalService.getValorParametro('regoportun'))--VALMORE BLANCO
           
        } else if(tipoFuncionarios ==1){
            // sacamos solo el vendedor
            def  pedidoInstance = Pedido.get(params.ident.toLong())
            xiddestinatarios.add(Empleado.get(pedidoInstance.empleadoId).email)

        } else if(tipoFuncionarios ==2){
            // sacamos vendedor y el area financiera
            def  pedidoInstance = Pedido.get(params.ident.toLong())
            xiddestinatarios.add(Empleado.get(pedidoInstance.empleadoId).email)
            xiddestinatarios.add(generalService.getValorParametro('noEstRev'))

        } else if(tipoFuncionarios ==4){
            // sacamos vendedor y el area financiera compradores y bodega
            def  pedidoInstance = Pedido.get(params.ident.toLong())
            xiddestinatarios.add(Empleado.get(pedidoInstance.empleadoId).email)
              xiddestinatarios.add(generalService.getValorParametro('compradore'))
              //xiddestinatarios.add(generalService.getValorParametro('noEstRev'))MJIMENEZ
              xiddestinatarios.add(generalService.getValorParametro('enccompras'))
              //xiddestinatarios.add(generalService.getValorParametro('regoportun'))

        } 
         println "XDESTINATARIOS"+xiddestinatarios
         return xiddestinatarios
    }
    
    def getArquitectosPedido(Long id ){
        
      def arqui = crm.Pedido.executeQuery("select listaArquitectos from Pedido  where id=${id}") 
     if (arqui[0]){ 
        def lista =arqui[0].split(',').collect{it}    
        def listaDef=[]
        lista.each(){
            listaDef.add(it)  
        }
      return listaDef
     }else 
         return null
    }          
	
	
	def marcarPedidoPendientePorRecibir(def idpedido)//Actualizar el pedido cuando todos los productos han sido marcados como comprados
	{
		def pedidoInstance=Pedido.get(idpedido)
		println "ID PEDIDO RECIBIDO ES..."+idpedido
		String query
		/* Numero de productos totales del pedido y diferentes a ProcesarPara=Interno Redsis*/
		query="select count(d) from DetPedido d  where pedido.id=${idpedido} and eliminado=0 and idProcesarPara is not 'pedprosp03'"
		def numTotal=DetPedido.executeQuery(query)[0]
	  
		/* Numero de productos procesados x compra, es decir los que se encuentran pendientes x recibir */
		query="select count(d) from DetPedido d  where pedido.id=${idpedido} and idEstadoDetPedido='peddetpd02' and eliminado=0"
		def numProductosProcesados=DetPedido.executeQuery(query)[0]

		if(numTotal==numProductosProcesados && numTotal > 0)
		{
            if(pedidoInstance.idEstadoPedido != 'pedfacpar2' || pedidoInstance.idEstadoPedido != 'pedfacturx'){
                println "Pedido diferente a facturado parcial o facturado"

                pedidoInstance.idEstadoPedido='pedpenrec4' // pedido marcado como pendiente x recibir
                pedidoInstance.save(flush:true)
                println "Todos los productos de este pedido han sido marcados como pendientes x recibir...estado pedido actualizado"
            }
		}
		else			
			println "Aun faltan ${numTotal}-${numProductosProcesados} productos pendientes por marcar..."

	}
    
     @Transactional //cerrarPedidoPorCompras automaticamente y notifica 
    def cerrarPedidoPorCompras(idpedido){//todo verificar el cambio de estado luego de modificar por compras req=67 JD
        println idpedido
        def pedidoInstance=Pedido.get(idpedido)
        String query
        /* Numero de productos totales del pedido */
        query="select count(d) from DetPedido d  where pedido.id=${idpedido} and eliminado=0 and idProcesarPara is not 'pedprosp03'"
        def numTotal=DetPedido.executeQuery(query)
      
        /* Numero de productos recibidos totalmente */
        query="select count(d) from DetPedido d  where pedido.id=${idpedido} and idEstadoDetPedido='peddetpd04' and eliminado=0"
        def numProcesados=DetPedido.executeQuery(query)
              
        /* Numero de productos recibidos parcialmente */
       // query="select count(d) from DetPedido d  where pedido.id=${idpedido} and idEstadoDetPedido='peddetpd05' and eliminado=0"
       // def numProcParcial=DetPedido.executeQuery(query)
       // println "Num proc. parciales"
       // println numProcParcial[0]
        def swnoti=0
        
        if (numProcesados[0]==numTotal[0] && numTotal[0] > 0){
            if(pedidoInstance?.idEstadoPedido == 'pedpencom3') {
                pedidoInstance.idEstadoPedido = 'pedpenfac2' // pedido cerrado por compras
                pedidoInstance.save()
                swnoti = 1
            }
        } else {
            if (pedidoInstance?.facturacionParcial=='S'){
                pedidoInstance.idEstadoPedido='pedpenfp23' // Pedido pendiente por facturar
                swnoti=1
            }
        }
        if (swnoti==1){ //
            // a financiera que facture
            String xparam=generalService.getValorParametro('financiera')
            def xdest=generalService.convertirEnLista(xparam)
			def session = RequestContextHolder.currentRequestAttributes().getSession()
			def usuarioAccede = Empleado.findById(generalService.getIdEmpleado(session['idUsuario'].toLong()))
            String urlbase=generalService.getValorParametro('urlaplic')
            String xasunto="Notificación: Iniciar facturacion al pedido  No."+pedidoInstance.numPedido 
            String xcuerpo="<b>Elaborado por:</b> ${usuarioAccede}<br><br>Los productos para este pedido han sido procesados por almacen. <br><br>Favor realizar facturacion parcial o total del pedido  de la referencia <a href='${urlbase}/pedido/show/${pedidoInstance.id}'> AQUI </a>"
            generalService.enviarCorreo(1,xdest,xasunto, xcuerpo) 
        }      

    }
    
    def convertirValorProductos(xcaso, xidpedido,xtrmPedido){
        String ztrm=generalService.getValorParametro('trm')
        def ytrm=new BigDecimal(ztrm)        
        BigDecimal xtrm=xtrmPedido?:ytrm
       def query 
       if (xtrm !=0){
           if (xcaso==1) // cambio a Dolar 
               query="update DetPedido   set valor=valor/${xtrm} where pedido.id=${xidpedido} and eliminado=0"
           if (xcaso==2 ) // cambio a Pesos 
               query="update DetPedido set valor=valor*${xtrm} where pedido.id=${xidpedido} and eliminado=0"
        
           DetPedido.executeUpdate(query)
       }
        
    }
	
	
	def actualizarEstadoDetPedido(def pedidoId)
	{
		def query="update DetPedido set idEstadoDetPedido='peddetpd00' where pedido.id=${pedidoId}"
		DetPedido.executeUpdate(query)
	}
    
}
