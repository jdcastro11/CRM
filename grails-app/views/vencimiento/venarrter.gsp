<%@ page import="crm.Vencimiento" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<!DOCTYPE html>
<html>
    <head> 
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'vencimiento.label', default: 'Vencimiento')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
    	${estado}
        <% def sw_crud=[1,1,1,1,0,0] %>
        <div id="boxVencimiento">	                
            <div id="list-vencimiento" class="content scaffold-list" role="main">
                <h2>${xtitulo}</h2>         
                <hr style="margin-top:10px;margin-bottom:10px;">     		
		
            <!-- <div class="row-fluid sortable"> -->

                <div class="pull-left">
                    <div class="pull-left">
                        <g:if test="${'CREAR' in session['operaciones']}"><a class="btn btn-mini btn-primary" href="/crm/vencimiento/create/?idenc=${xidencven}&idemp=${xidemp}">
                                <i class="icon-plus icon-white"></i>
                                <strong> Nuevo</strong>
                            </a>
                        </g:if>
                    </div>
                </div>
                &nbsp;
                <div class="btn-group">

                    <a href="#" class="btn btn-mini" >Acciones</a>
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                       <%  def swacc=0 %>
                    <ul class="dropdown-menu">
                    
                       <g:if test="${'BORRAR' in session['operaciones']}">
                         <%  swacc=1 %>
                           <li><a href="/crm/vencimiento/listarBorrados?idenc=${xidencven}" >Ver Borrados</a></li>
                           <li><a href="/crm/vencimiento/importarVencimientos?idVenci=${xidencven}" >Importar vencimientos</a></li>
                       </g:if>
                       <g:if test="${swacc==0}" >
                            <li align="center">Ninguna </li>
                       </g:if>
                    </ul>
                </div>

                &nbsp;<a  class="btn btn-mini" href="/crm/vencimiento/index?idenc=${xidencven}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                <br><br>
                

                 <g:set var="beanInstance"  value="${vencimientoInstance}" />                
                
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <g:sortableColumn property="idTipoVencimiento" title="${message(code: 'vencimiento.idTipoVencimiento.label', default: 'Tipo Vencimiento')}" params="${filterParams}" />
                            
                            <g:sortableColumn property="idTipoContrato" title="${message(code: 'vencimiento.idTipoContrato.label', default: 'Tipo Contrato')}" params="${filterParams}" />

                            <g:sortableColumn property="descripcion" title="${message(code: 'vencimiento.descripcion.label', default: 'Descripción')}" params="${filterParams}" />                            

                            <g:sortableColumn property="fechaInicio" title="${message(code: 'vencimiento.fechaInicio.label', default: 'Inicio')}" params="${filterParams}" />

                            <g:sortableColumn property="fechaVencimiento" title="${message(code: 'vencimiento.fechaVencimiento.label', default: 'Vence')}" params="${filterParams}" />

                            <g:sortableColumn property="idEstadoVencimiento" title="${message(code: 'vencimiento.idEstadoVencimientoaVencimiento.label', default: 'Estado')}" params="${filterParams}" />

                        </tr>
                    </thead>
                    <tbody  style="overflow:scroll">
                    <%def contador=0 %>
                      <g:each in="${vencimientoInstanceList}" status="i" var="vencimientoInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td><a href="/crm/vencimiento/show/${vencimientoInstance.id}?idenc=${xidencven}&idemp=${xidemp}"
                                       style="text-decoration:underline" >
                                       ${generalService.getValorParametro(vencimientoInstance?.idTipoVencimiento)}
                                </a>
                            </td>                                      

							<td>${generalService.getValorParametro(vencimientoInstance?.idTipoContrato)}</td>

                            <td>${fieldValue(bean: vencimientoInstance, field: "descripcion")}</td>                            

                            <td><g:formatDate format="dd-MM-yyyy" date="${vencimientoInstance?.fechaInicio}" /></td>
                           
                            <td><g:formatDate format="dd-MM-yyyy" date="${vencimientoInstance?.fechaVencimiento}" /></td>
                     
                            
                            <% def xres=generalService.getEstadoVencimiento(vencimientoInstance?.fechaInicio,vencimientoInstance?.fechaVencimiento) %>
                            
                            <g:if test="${vencimientoInstance.idEstadoVencimiento=='vennorenov'}">                            
                            		<% xres[0]='vennorenov' //vencimiento no renovado empanada
									   xres[1]='background:#F15850 !important' %>                            		
                            </g:if>
                            	<td style="${xres[1]};font-weight:bold;text-align:center;color:#303030">${generalService.getValorParametro(xres[0])}</td>                        </tr>
                      
                    </g:each>                    
                </tbody>
            </table>            
            <div class="pagination_crm">
                <g:paginate total="${vencimientoInstanceCount ?: 0}" domainBean="Vencimiento"  params="${[tipoVenc:tipoVenc,idenc:params.idenc,clicVenArrTer:1]}"/>                    
            </div>            
        </div>
    </div>
<script>
		var contenido= $("#boxVencimiento");
		var contador=${contador} 
        if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(800);    //numero de elementos por tamaño de la fila(40pixeles)
		//alert("${vencimientoInstanceCount}")
</script>     
</body>
</html>
