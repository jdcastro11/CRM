<%@ page import="crm.Oportunidad" 
import="crm.Empresa"
import="crm.Persona"
%>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="oportunidadService" bean="oportunidadService" />
<dd>
   
    <div id="div-tbl-1" >
        <table id="tbl-1-${id}" class="table table-condensed table-striped">
            <thead>
                <tr>
                    <th></th>
                    <th>Nro. Pedido</th>
                    <th>Empresa</th>
                    <th>Valor COP</th>
                    <th>Valor USD</th>
                    <th>Fecha Entrega</th>
                    <th>Estado</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                 <g:each in="${listaRegistro}" status="i" var="items">
                <tr>
                    <td><input type="checkbox" name="oportunidades" value="${items.id}" id="oportunidades"></td>
                   
                     <td> <g:link action="show" style="text-decoration:underline;" id="${items.id}" params="[sw:0]">
                         ${items.numPedido}
                        </g:link>
                     </td>
                    
                    <td>${items.nombreCliente}</td>
                    
                            <% 
                             BigDecimal valorendolares=0g
                             if (xtrm !=0) valorendolares=(items?.valorPedido?:0)/xtrm                                  
                            %>
                                <g:if test="${items.idTipoPrecio=='pedtprec02'}" >
                                <td style="text-align:right">                                   
                                        <g:formatNumber name="subtotal" number="${valorendolares}" format="###,###,###.##" locale="co"/>                    
                                </td> 
                                </g:if>
                                <g:else>
                                 <td></td>
                                </g:else>
                                <g:if test="${items.idTipoPrecio=='pedtprec01'}" >
                                    <td style="text-align:right">
                                            <g:formatNumber name="subtotal" number="${items?.valorPedido}" format="###,###,##0" locale="co"/>                    
                                    </td>
                                </g:if>
                                <g:else>
                                   <td></td>
                                </g:else>
                                
                       <td>${g.formatDate(format:'dd-MM-yyyy',date:items?.fechaApertura)}</td>
                       
                       <td>${generalService.getValorParametro(items?.idEstadoPedido)}</td>  
                    <td><g:link action="show" style="text-decoration:underline;" id="${items.id}" params="[sw:0]">
                      <i class="icon-file"></i>
                     </g:link>  
                     </td>
                </tr>
                 </g:each>
            </tbody>
        </table> 
    </div>
</dd>