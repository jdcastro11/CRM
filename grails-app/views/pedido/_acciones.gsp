<g:set var="generalService" bean="generalService" />
<%
   def mover=generalService.getMenuV(1)
   def mout=generalService.getMenuV(2)
   def estilo=generalService.getMenuV(3)
%>
<div class="pull-left">
  <button type="submit" id="botonPed" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar pedido</button>
 <g:if test="${pedidoInstance?.eliminado==1}" >
  <a href="#" onclick="crm_deseliminar()" class="btn btn-success  btn-mini">Borrar | Des-Borrar</a>
</g:if> 

<g:if test="${pedidoInstance?.id}">
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
            <g:if test="${'DEVOLVER_A_VENDEDOR' in session['operaciones']}">     
               <g:if test="${pedidoInstance.idEstadoPedido in ['pedpencom3','pedenrevi2']}" ><%-- en revision o pendiente x compras --%> 
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
                     href="/crm/pedido/asignarACompras/${pedidoInstance.id}" >Enviar a Cómpras</a> </li>
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
</g:if>
   <a  class="btn btn-mini" href="/crm/pedido/index/${xid}?sort=fechaApertura&order=desc}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
</div>