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
                        <a  id="${empresa}-${nodo2?.id}" data-url="${createLink(controller: 'oportunidad', action: 'traerNodo1', params:[orden:'nombreCliente',campoFiltro1:'idSucursal', campoFiltro2:'nombreVendedor',campoFiltro3:'', categoria:'nombreCliente', idGuardar:'empresaId', plantilla:'7', ultimoNodo:'No'])}" nodo="3" class="nodo2" href="#${empresa}-${nodo2?.id}_container" data-toggle="collapse">
                            <i class="fa-icon-caret-right margin-right"></i>${nodo2.label}
                        </a>
                        <div id="${empresa}-${nodo2?.id}_container" >
                        </div>
                    </dl>
                </div>
            </g:each>
</dd>