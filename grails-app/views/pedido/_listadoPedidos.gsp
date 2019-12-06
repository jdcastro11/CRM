<%@ page import="crm.Pedido" 
import="crm.Empresa"
import="crm.Persona"
%>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="pedidoService" bean="pedidoService" />
<dd>
   
    <div id="div-tbl-1" >
        <table id="tbl-1-${cId}" class="table table-condensed table-striped">
            <thead>
                <tr>
                    <th></th>
                    <th>Código</th>
                    <th>Orden de Compra</th>
                    <th>Valor en Dólares</th>
                    <th>Valor en Pesos</th>
                    <th>Fecha</th>
                    <th>Estado</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                 <g:each in="${nodo}" status="i" var="pedidoInstance">
                <tr>
                    <td><g:checkBox name="pedidos" value="${pedidoInstance.id}" checked="false" /></td>
                    <td>
                        <g:link action="show" style="text-decoration:underline;" id="${pedidoInstance.id}" params="[sw:0]">
                        ${fieldValue(bean: pedidoInstance, field: "numPedido")}
                        </g:link>
                    </td>
                    
                     <td>
                        ${fieldValue(bean: pedidoInstance, field: "ordenCompra")}
                    </td>
                 
                    
                        <% 
                         BigDecimal valorendolares=0
						 BigDecimal ztrm=pedidoInstance?.trm?:xtrm
                           if (ztrm !=0) valorendolares=(pedidoInstance?.valorPedido?:0)/ztrm                                  
                        %>
                     <g:if test="${pedidoInstance.idTipoPrecio=='pedtprec02'}" >
                                <td>                                   
                                        <g:formatNumber name="subtotal" number="${valorendolares}" format="###,###,###.##" locale="co"/>                    
                                </td> 
                                </g:if>
                                <g:else>
                                 <td></td>
                                </g:else>
                                <g:if test="${pedidoInstance.idTipoPrecio=='pedtprec01'}" >
                                    <td>
                                       <g:formatNumber name="subtotal" number="${pedidoInstance?.valorPedido}" format="###,###,##0" locale="co"/>                    
                                    </td>
                                </g:if>
                                <g:else>
                                   <td></td>
                                </g:else>
                                
                                <td>${g.formatDate(format:'dd-MM-yyyy',date:pedidoInstance?.fechaApertura)}</td>
                               
                                <td>${generalService.getValorParametro(pedidoInstance?.idEstadoPedido)}</td>
                    <td><g:link action="show" style="text-decoration:underline;" id="${pedidoInstance.id}" params="[sw:0]">
                      <i class="icon-file"></i>
                     </g:link>  
                     </td>
                </tr>
                 </g:each>
            </tbody>
        </table> 
    </div>
</dd>