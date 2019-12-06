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
                    <th>Referencia.</th>
                    <th>Descripción</th>
                    <th>Cantidad</th>
                    <th>Valor</th>
                    <th>Total</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                 <g:each in="${listaRegistro}" status="i" var="items">
                <tr>
                    <td><input type="checkbox" name="oportunidades" value="${items.id}" id="oportunidades"></td>
                    <td>
                        ${items.refProducto}
                    </td>
                    <td>${items.descProducto}</td>
                    <td>${formatNumber(number:items?.cantidad,format:'###,###,###', locale:'co')}</td>
                    <td>${formatNumber(number:items?.valor,format:'###,###,###', locale:'co')}</td>
                    <g:set var="xtotal" value="${items?.cantidad*items?.valor}" />
                    <td>${xtotal} </td>
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