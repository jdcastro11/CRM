<%@ page import="crm.Oportunidad" 
import="crm.Empresa"
import="crm.Persona"
%>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="oportunidadService" bean="oportunidadService" />
<dd>
            <g:each in="${nodo}" status="i" var="nodo2">
                <div class="box-content-tabla">
                    <dl>                       
                        <a  id="${empresa}-${nodo2?.id}" data-url="${createLink(controller: 'pedido', action: 'traerNodo', params:[orden:'nombreCliente',campoFiltro1:'idEstadoPedido', campoFiltro2:'idSucursal',campoFiltro3:'', categoria:'nombreCliente', idGuardar:'empresaId', plantilla:'EstCiuEmp3', ultimoNodo:'No'])}" nodo="3" class="nodo2" href="#${empresa}-${nodo2?.id}_container" data-toggle="collapse">
                            <i class="fa-icon-caret-right margin-right"></i>${nodo2.label}
                        </a>
                        <div id="${empresa}-${nodo2?.id}_container" >
                        </div>
                    </dl>
                </div>
            </g:each>
</dd>