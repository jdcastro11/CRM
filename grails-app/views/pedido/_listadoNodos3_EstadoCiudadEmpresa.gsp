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
                        <a  class="nodo3" id="${cId}-${nodo2?.id}" data-url="${createLink(controller: 'pedido', action: 'traerNodo', params:[orden:'numPedido',campoFiltro1:'idEstadoPedido', campoFiltro2:'idSucursal', campoFiltro3:'empresa', campoFiltro4:'', categoria:'numPedido', idGuardar:'numPedido', plantilla:'EstCiuEmp4',ultimoNodo:'Si'])}" nodo="5" href="#${cId}-${nodo2?.id}_container" data-toggle="collapse" >
                            <i class="fa-icon-caret-right margin-right"></i>${nodo2.label}
                        </a>
                        <div id="${cId}-${nodo2?.id}_container">
                        </div>

                    </dl>
                </div>

            </g:each>
          
   
</dd>