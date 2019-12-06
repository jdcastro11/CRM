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
                        <a id="${cId}-${nodo2.id}" data-url="${createLink(controller: 'oportunidad', action: 'traerNodo1', params:[orden:'numOportunidad',campoFiltro1:'trimestre', campoFiltro2:'idSucursal',campoFiltro3:'nombreVendedor',campoFiltro4:'empresa', categoria:'numOportunidad', idGuardar:'numOportunidad', plantilla:'5', ultimoNodo:'Si'])}" nodo="5" class="nodo4" href="#${cId}-${nodo2?.id}_container" data-toggle="collapse">
                            <i class="fa-icon-caret-right margin-right"></i>${nodo2.label}
                        </a>
                        <div id="${cId}-${nodo2.id}_container" >
                        </div>
                    </dl>
                </div>
            </g:each>    
</dd>
