<%@ page import="crm.Pedido" %>
<%  def xlista=Pedido.executeQuery("select id,numPedido from Pedido where oportunidad.id=${xidop} and eliminado=0") %>
 <div class="control-group">
        <label class="control-label" >Pedidos</label>
        <div class="controls" >
         <g:each in="${xlista}" status="i" var="xped">   
            <a href="/crm/pedido/show/${xped[0]}" style="text-decoration:underline;"> ${xped[1]}</a>; 
         </g:each>   
        </div>
</div>