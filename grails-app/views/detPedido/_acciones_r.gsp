<g:set var="pedidoService" bean="pedidoService" />
<div class="pull-left">

  <%-- <g:if test="${pedidoService.accesoPedido(detPedidoInstance?.pedido.id,session['idUsuario'],'producto')}" > --%>
        <g:if test="${'MODIFICAR' in session['operaciones']}">        
            <a class="btn btn-mini btn-success" href="/crm/detPedido/edit/${detPedidoInstance.id}?pedido=${params.pedido}">
                <i class="icon-edit icon-white"></i>&nbsp;Editar</a>            
            </g:if>
            <g:if test="${'BORRAR' in session['operaciones']}">
                <a href="#" class="btn btn-danger btn-mini" 
                onclick='return BootstrapDialog.confirm("Está seguro de borrar este registro?",
            function(result){ if(result) window.location.href="${createLink(url:[controller:'detPedido', action:'borrar',id:detPedidoInstance.id])}"})'>
            <i class="icon-trash icon-white"></i>&nbsp;Borrar</a>
        </g:if>

    <div class="btn-group">
        <%  def swacc=0 %>
        <a href="#" class="btn btn-mini" >Acciones</a>
        <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
            <span class="caret"></span></button>
        <ul class="dropdown-menu">
           <g:if test="${'PROCESAR_PROD_COMPRA' in session['operaciones']}">    
            <g:if test="${(detPedidoInstance?.idEstadoDetPedido=='peddetpd01')}" > <%-- Pendiente x Comprar --%>
               <%  swacc=1   
                   def xurl="/crm/detPedido/procesarProductoCompra/${detPedidoInstance?.id}?pedido=${params.pedido}&sw=1"
                  if (params.sw)
                    if (params.sw == '1')
                       xurl = "/crm/detPedido/procesarProductoCompraSP/${detPedidoInstance?.id}?pedido=${params.pedido}&sw=1"               
                   
                %>
                <li> <a href="${xurl}" >Procesar x Compra</a> </li>
                </g:if>
            </g:if>
                
            <g:if test="${'PROCESAR_PROD_ALMACEN' in session['operaciones']}">   
             
                <g:if test="${detPedidoInstance?.idEstadoDetPedido in ['peddetpd02','peddetpd05']}" > <%-- Pendiente x recibir total o parcial--%>
                   <%  swacc=1 %>
                    <li> <a href="/crm/detPedido/procesarProductoAlmacen/${detPedidoInstance.id}?layout=${params.layout}&sw=0" >Procesar x Recibo</a> </li>
                 </g:if>  
            </g:if>
            
            
            <%--<g:if test="${detPedidoInstance.contrato}">
            	<li><a href="/crm/detPedido/renovarContrato/${detPedidoInstance.id}">Renovar Contrato</a></li>
            </g:if>
            <g:if test="${detPedidoInstance?.contrato?.idEstadoVencimiento=='venvencido'}">
                <li><a href="${createLink(action:'clienteNoRenovo',params:[idVencimiento:detPedidoInstance?.contrato?.id,idenc:params?.idenc])}" >Cliente no renovó</a></li>
            </g:if>--%>
            
            
            
            
            
            <g:if test="${swacc==0}" >
             <li align="center">Ninguna </li>
            </g:if>   
        </ul>										
    </div>


    <% 
     def  xurl
      if (params.sw){
          if (params.sw == "0")
               xurl="/crm/detPedido/indexg"  
          if (params.sw == "1")
                xurl="/crm/detPedido/indexn?layout=main"  
      }else
         xurl="/crm/detPedido/index/${detPedidoInstance?.pedido?.id}?layout=datalle"                
              
     %>

<a  class="btn btn-mini" href="${xurl}"><i class="icon-remove"></i>&nbsp;Cancelar </a>

</div>