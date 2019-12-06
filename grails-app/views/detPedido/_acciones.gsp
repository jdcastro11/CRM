<div class="pull-left">
    <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</button>
    <g:if test="${detPedidoInstance?.eliminado==1}" >
        <a href="#" onclick="crm_deseliminar()" class="btn btn-success  btn-mini">Borrar | Des-Borrar</a>
    </g:if> 					
    <div class="btn-group">
        <%  def swacc=0 %>
         <a href="#" class="btn btn-mini" >Acciones</a>
        <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
            <span class="caret"></span></button>
        <ul class="dropdown-menu">           
            <g:if test="${'PROCESAR_PROD_ALMACEN' in session['operaciones']}">    
            <g:if test="${detPedidoInstance?.idEstadoDetPedido in ['peddetpd02','peddetpd05']}" > <%-- Pendiente x recibir total o parcial--%>
              <%  swacc=1 %>
                 <l1> <a href="/crm/detPedido/procesarProductoAlmacen/${detPedidoInstance.id}?layout=${params.layout}" >Procesar x Recibo</a> </li>
               </g:if>
            </g:if>
            
            <g:if test="${swacc==0}" >
             <li align="center">Ninguna </li>
            </g:if>   
        </ul>										
    </div>
<g:if test="${params.layout=='main'}" >
    <a  class="btn btn-mini" href="/crm/detPedido/indexg?layout=main"><i class="icon-remove"></i>&nbsp;Cancelar</a>
</g:if>
<g:else>
 <a  class="btn btn-mini" href="/crm/detPedido/index/${detPedidoInstance?.pedido?.id}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
</g:else>
      
</div>