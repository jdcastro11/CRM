<g:set var="generalService" bean="generalService" />
<%
   def mover=generalService.getMenuV(1)
   def mout=generalService.getMenuV(2)
   def estilo=generalService.getMenuV(3)
%>
<g:set var="pedidoService" bean="pedidoService" />
<div class="pull-left">   
    <g:if test="${pedidoService.accesoPedido(pedidoInstance.id,session['idUsuario'],'pedido') }"> 
        <g:if test="${'MODIFICAR' in session['operaciones']}">             
            <a class="btn btn-success  btn-mini" href="/crm/pedido/edit/${pedidoInstance.id}?estado=${xid}&swtp=true">
                <i class="icon-edit icon-white" ></i>&nbsp;Editar</a>                
            </g:if> 
            <g:if test="${'BORRAR' in session['operaciones']}">
                <g:if test="${params.swb==''}" >
                    <a  href="#" class="btn btn-danger btn-mini" 
                    onclick='return BootstrapDialog.confirm("Está seguro de borrar este registro?",function(result){
                    if(result)
                window.location.href="${createLink(url:[controller:'Pedido', action:'borrar',id:pedidoInstance.id])}"})'>
                <i class="icon-trash icon-white"></i>&nbsp;Borrar
            </a> 			
        </g:if> 	
    </g:if>
</g:if>
<div class="btn-group">  
      <%  def swacc=0 %>
    <a href="#" class="btn btn-mini" >Acciones</a>
    <button class="btn btn-mini dropdown-toggle col.md-8" data-toggle="dropdown">
        <span class="caret"></span></button>
    <ul class="dropdown-menu">
         <g:if test="${'APLICAR_DESCUENTO' in session['operaciones']}">
             <%  swacc=1 %>
           <l1> <a 
                onMouseOver="${mover}" 
                onMouseOut="${mout}" 
                style="${estilo}" 
               href="/crm/pedido/aplicarDescuento?pedidos=${pedidoInstance.id}" > Aplicar Descuento</a> </li>
         </g:if>
        <g:if test="${'ENVIAR_A_REVISION' in session['operaciones']}">    
         <g:if test="${(pedidoInstance.idEstadoPedido=='pedenelab1')}" > <%-- en elaboracion --%>
            <%  swacc=1 %>   
              <l1> <a 
                     onMouseOver="${mover}"
                     onMouseOut="${mout}"
                     style="${estilo}" 
                    href="/crm/pedido/enviarARevision/${pedidoInstance.id}" >Enviar a Revisión</a> </li>
                </g:if>
            </g:if>
        <g:if test="${'GERENTE_PROYECTO' in session['operaciones']}">
                <%  swacc=1 %>
                <l1> <a
                       onMouseOver="${mover}"
                     onMouseOut="${mout}"
                     style="${estilo}"
                    href="/crm/pedido/modificaGerenteProye/${pedidoInstance.id}" >Modificar Gerente de Proyecto</a> </li>
        </g:if>
            <g:if test="${'DEVOLVER_A_VENDEDOR' in session['operaciones']}">     
               <g:if test="${pedidoInstance.idEstadoPedido in ['pedenrevi2']}" ><%-- en revision o pendiente x compras --%>
                
                    <%  swacc=1 %>
                    <l1> <a 
                         onMouseOver="${mover}" 
                         onMouseOut="${mout}" 
                         style="${estilo}" 
                        href="/crm/pedido/devolverAVendedor/?ident=${pedidoInstance.id}&sw=2&layout=main" >Devolver a Vendedor</a> </li>
                    </g:if> 
                </g:if> 
            <g:if test="${'ASIGNAR_A_COMPRAS' in session['operaciones']}"> 
                <g:if test="${(pedidoInstance.idEstadoPedido=='pedenrevi2')}" >
                    <%  swacc=1 %>
                    <l1> <a  onMouseOver="${mover}" 
                     onMouseOut="${mout}" 
                     style="${estilo}" 
                     href="/crm/pedido/asignarACompras/${pedidoInstance.id}" >Enviar a Compras</a> </li>
                    </g:if> 
                </g:if> 
         
               <g:if test="${'CAMBIAR_ESTADO_PEDIDO' in session['operaciones']}">       
               
                  <%  swacc=1 %>
                <l1> <a  onMouseOver="${mover}" 
                     onMouseOut="${mout}" 
                     style="${estilo}" 
                     href="/crm/pedido/cambiarEstadoPedido/${pedidoInstance.id}?swv=1" >Cambiar Estado Pedido</a> </li>
              </g:if> 
                 <g:if test="${'FACTURACION_PARCIAL' in session['operaciones']}">                
                <g:if test="${(pedidoInstance.idEstadoPedido in ['pedpenfp23'])}" >
                  <%  swacc=1 %>
                <l1> <a 
                     onMouseOver="${mover}" 
                     onMouseOut="${mout}" 
                     style="${estilo}" 
                    href="/crm/pedido/facturacionParcial/${pedidoInstance.id}" >Facturación Parcial</a> </li>
               </g:if>
             </g:if> 
            <g:if test="${'CERRAR_PEDIDO' in session['operaciones']}">                
                <g:if test="${(pedidoInstance.idEstadoPedido in ['pedpenfac2','pedpenfp23'])}" >
                  <%  swacc=1 %>
                <li> <a href="/crm/pedido/cerrarPedido/${pedidoInstance.id}" >Cerrar Pedido</a> </li>
               </g:if>
             </g:if>
                 <g:if test="${'AUTORIZAR_CAMBIO_PEDIDO' in session['operaciones']}">
                 <%  swacc=1 %>
                <li> <a 
                     onMouseOver="${mover}" 
                     onMouseOut="${mout}" 
                     style="${estilo}" 
                    href="/crm/pedido/autorizarCambioPedido/${pedidoInstance.id}" >Autorizar Cambiar Pedido</a> </li>               
             </g:if>

             <!-- JOSE DANIEL 22/07/2016 -->
             
	        <g:if test="${'AGREGAR_INFORMACION_SIESA' in session['operaciones']}">             
                <li> <a 
                     onMouseOver="${mover}" 
                     onMouseOut="${mout}" 
                     style="${estilo}" 
                    href="/crm/pedido/informacionSiesa/${pedidoInstance.id}" >Información SIESA</a> </li>              
             </g:if>
             
             <!-- JOSE DANIEL 22/07/2016 -->

             <!-- JOSE DANIEL 26/07/2016 -->
             
	        <g:if test="${'ANULAR_PEDIDO' in session['operaciones']}">             
                <li><a href="${createLink(action:'anularPedido',params:[idPed:pedidoInstance.id])}" >Anular pedido </a></li>              
             </g:if>
             
             <!-- JOSE DANIEL 26/07/2016 -->
             
             <% def detenido= generalService.esPedidoDetenido(pedidoInstance)
			 	def texto
			 	if(detenido==false)
				 texto='Marcar detenido en compras'
			 	else
				 texto='Desmarcar detenido en compras'
			 
			  %>
             
             <g:if test="${'DETENIDO_EN_COMPRAS' in session['operaciones']}">
                 <li><a onMouseOver="${mover}" 
	                     onMouseOut="${mout}" 
	                     style="${estilo}" 
	                     href="/crm/pedido/detenidoEnCompras/${pedidoInstance.id}">${texto}
                     </a>
                 </li>             
             </g:if>
             
                   <g:if test="${'RESET_CAMBIO_PEDIDO' in session['operaciones']}">
                    <%  swacc=1 %>
                   <li> <a 
                        onMouseOver="${mover}" 
                        onMouseOut="${mout}" 
                        style="${estilo}" 
                       href="/crm/pedido/resetCambioPedido/${pedidoInstance.id}" >Reset Cambiar Pedido</a> </li>               
                 </g:if>
                   <%  swacc=1 %>
                <li ><a href="/crm/pedido/vistaPedido/${pedidoInstance.id}" target="_blank" >Vista Preliminar</a> </li>
             <g:if test="${swacc==0}" >
                <li align="center">Ninguna </li>
              </g:if>
                </ul>										
            </div>
          
          <a  class="btn btn-mini" style="margin-right:5px;" href="/crm/pedido/index/${xid}?sort=fechaApertura&order=desc"><i class="icon-remove"></i>&nbsp;Cancelar</a>
            </div>