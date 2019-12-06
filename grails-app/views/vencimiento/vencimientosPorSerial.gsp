<%@ page import="crm.Seriales" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<!DOCTYPE html>
<html>
    <head> 
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'vencimiento.label', default: 'Vencimiento')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <r:require module="filterpane" />
    </head>
    <body>
    
    <%
		def listaVenci=generalService.getValoresParametro('tipovencim')
	    def tipoCobertura=generalService.getValoresParametro('tipocobert')
	 %>
    	
        <% def sw_crud=[1,1,1,1,0,0] %>
        <div id="boxVencimiento">	                
            <div id="list-vencimiento" class="content scaffold-list" role="main">
                <h2>Vencimientos</h2>
                
                
                
                
                    <hr style="margin-top:10px;margin-bottom:10px;">	
					    <filterpane:filterPane domain="Vencimiento" 
						    formName="frmFiltro"
						    action="listarSeriales"
						    showTitle="no"
						    filterProperties="${['descripcion', 'serial','idTipoVencimiento','idTipoCobertura']}"
						    filterPropertyValues="${['idTipoVencimiento':[values:listaVenci],'idTipoCobertura':[values:tipoCobertura]]}"						    
						    dialog="true"
						    listDistinct="true"						    						    
						    showSortPanel="false"						    
						    fullAssociationPathFieldName="false"
					    />
                
                
                
                
                         

                
                <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>
            	<filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>

                
                <a  class="btn btn-mini" href="/crm/vencimiento/listarSeriales"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>
                <br><br>
                

                 <g:set var="beanInstance"  value="${vencimientoInstance}" />                
                
                <table class="table table-bordered">
                    <thead>
                        <tr>
                        	<g:sortableColumn property="encvencimiento" title="${message(code: 'vencimiento.encvencimiento.label', default: 'Cliente')}"  params="${filterParams}"/>

                            <g:sortableColumn property="idTipoVencimiento" title="${message(code: 'vencimiento.idTipoVencimiento.label', default: 'Tipo Vencimiento')}" params="${filterParams}" />

                            <g:sortableColumn property="serial" title="${message(code: 'vencimiento.serial.label', default: 'Serial')}"  params="${filterParams}" />

                            <g:sortableColumn property="descripcion" title="${message(code: 'vencimiento.descripcion.label', default: 'Descripción')}" params="${filterParams}" />

                            <g:sortableColumn property="idTipoCobertura" title="${message(code: 'vencimiento.idTipoCobertura.label', default: 'Tipo Cobertura')}"  params="${filterParams}" />

                            <g:sortableColumn property="fechaInicio" title="${message(code: 'vencimiento.fechaInicio.label', default: 'Inicio')}" params="${filterParams}" />

                            <g:sortableColumn property="fechaVencimiento" title="${message(code: 'vencimiento.fechaVencimiento.label', default: 'Vence')}" params="${filterParams}" />

                            <g:sortableColumn property="idEstadoVencimiento" title="${message(code: 'vencimiento.idEstadoVencimientoaVencimiento.label', default: 'Estado')}" params="${filterParams}" />

                        </tr>
                    </thead>
                    <tbody  style="overflow:scroll">
                    <%def contador=0 %>
                      <g:each in="${vencimientoInstanceList}" status="i" var="vencimientoInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            
                            	<td>${crm.Empresa.get(vencimientoInstance?.encvencimiento?.empresa?.id)}</td>                                

                                <td><a href="/crm/vencimiento/show/${vencimientoInstance.id}?layout=main&idemp=${vencimientoInstance?.encvencimiento?.empresa?.id}"
                                       style="text-decoration:underline" >
                                       ${generalService.getValorParametro(vencimientoInstance?.idTipoVencimiento)}
                                </a>
                            </td>                                       

                            <g:if test="${vencimientoInstance?.serial}">
                            	<td>${fieldValue(bean: vencimientoInstance, field: "serial")}</td>
                            </g:if>                            
                            <g:else>
	                            <g:set var="xruta" value="${generalService.getValorParametro('ruta00')}${vencimientoInstance?.archivoSeriales}" />							
	                            <td><g:if test="${vencimientoInstance?.archivoSeriales !=null}">
	                                            <a class="btn btn-mini" href="${xruta}" target="_blank"><g:message code="verAnexo.label" default="Ver Archivo"/></a>
	                                </g:if>
	                            </td>
                            </g:else>

                            <td>${fieldValue(bean: vencimientoInstance, field: "descripcion")}</td>

                            <td>${generalService.getValorParametro(vencimientoInstance?.idTipoCobertura)}</td>

                            <td><g:formatDate format="dd-MM-yyyy" date="${vencimientoInstance?.fechaInicio}" /></td>
                           
                            <td><g:formatDate format="dd-MM-yyyy" date="${vencimientoInstance?.fechaVencimiento}" /></td>
                     
                            
                            <% def xres=generalService.getEstadoVencimiento(vencimientoInstance?.fechaInicio,vencimientoInstance?.fechaVencimiento) %>                            
                            <g:if test="${vencimientoInstance.idEstadoVencimiento=='vennorenov'}">                            
                            		<% xres[0]='vennorenov' //vencimiento no renovado empanada
									   xres[1]='background:#F15850 !important' %>                            		
                            </g:if>
                            	<td style="${xres[1]};font-weight:bold;text-align:center;color:#303030"><b>${generalService.getValorParametro(xres[0])}</b></td></tr>
                      
                    </g:each>                    
                </tbody>
            </table>            
            <div class="pagination_crm">
                <g:paginate total="${vencimientoInstanceCount ?: 0}" domainBean="Vencimiento"  params="${[tipoVenc:tipoVenc,idenc:params.idenc,clicHardw:1]}"/>
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
