<%@ page import="crm.Oportunidad" 
import="crm.Empresa"
import="crm.Persona"
%>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="oportunidadService" bean="oportunidadService" />
<dd>
   
    <div id="div-tbl-1" >
        <table id="tbl-1-${empresa}" class="table table-condensed table-striped">
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
                 <g:each in="${oportunidadInstanceList}" status="i" var="oportunidades">
                <tr>
                    <td><input type="checkbox" name="oportunidades" value="${oportunidades.id}" id="oportunidades"></td>
                    <td> <g:link action="show" style="text-decoration:underline;" id="${oportunidades.id}" params="[sw:0]">
                        ${oportunidades?.numOportunidad}
                        </g:link>
                    </td>
                    <td>${fieldValue(bean:oportunidades,field:"nombreOportunidad")}</td>
                    <td>${fieldValue(bean:oportunidades,field:"valorOportunidad")}</td>
                    <td>${generalService.getValorParametro(oportunidades?.idEtapa)}</td>
                    <td><% println "${oportunidadService.getNumRegistros(oportunidades.id)}"%></td>
                    <td><g:link action="show" style="text-decoration:underline;" id="${oportunidades.id}" params="[sw:0]">
                      <i class="icon-file"> </i>
                     </g:link>  
                     </td>
                </tr>
                 </g:each>
            </tbody>
        </table> 
    </div>
</dd>