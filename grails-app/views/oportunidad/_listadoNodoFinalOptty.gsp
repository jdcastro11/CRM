<%@ page import="crm.Oportunidad" 
import="crm.Empresa"
import="crm.Persona"
%>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="oportunidadService" bean="oportunidadService" />
<dd>
   
    <div id="div-tbl-1" >
        <table id="tbl-1-${cId}" class="table table-condensed table-striped">
            <thead>
                <tr>
                    <th></th>
                    <th><g:message code="oportunidad.numOportunidad.label" default="Nro."/></th>
                    <th><g:message code="nombreOportunidad.label" default="Proyecto"/></th>
                    <th><g:message code="oportunidad.valorOportunidad.label" default="Valor"/></th>
                    <th>Prob.</th>
                    <th><g:message code="oportunidad.numOportunidadFabricante.label" default="Op. Fabricante"/></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                 <g:each in="${nodo}" status="i" var="nodo2">
                <tr>
                    <td><input type="checkbox" name="oportunidades" value="${nodo2.id}" id="oportunidades"></td>
                    <td> <g:link action="show" style="text-decoration:underline;" id="${nodo2.id}" params="[sw:0]">
                        ${nodo2?.numOportunidad}
                        </g:link>
                    </td>
                    <td>${fieldValue(bean:nodo2,field:"nombreOportunidad")}</td>
                    <td>${fieldValue(bean:nodo2,field:"valorOportunidad")}</td>
                    <td>${generalService.getValorParametro(nodo2?.idEtapa)}</td>
                    <td><% println "${oportunidadService.getNumRegistros(nodo2.id)}"%></td>
                    <td><g:link action="show" style="text-decoration:underline;" id="${nodo2.id}" params="[sw:0]">
                      <i class="icon-file"> </i>
                     </g:link>  
                     </td>
                </tr>
                 </g:each>
            </tbody>
        </table> 
    </div>
</dd>