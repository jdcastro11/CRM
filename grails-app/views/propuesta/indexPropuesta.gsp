<%@ page import="crm.Propuesta" %>
<%@ page import="crm.Persona" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="seguridadService" bean="seguridadService" />
<%
   def mover=generalService.getMenuV(1)
   def mout=generalService.getMenuV(2)
   def estilo=generalService.getMenuV(3)
%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'propuesta.label', default: 'Propuesta')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    	<r:require module="filterpane" />
	</head>
    <body>
        <% def sw_crud=[1,1,1,1,0,0] %>
          <%
             def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/propuesta/indexPropuesta')

           %>
            <h2>${xtitulo}</h2>
		    <filterpane:filterPane domain="Propuesta" 
		    formName="frmFiltro"
		    action="indexPropuesta"
		    showTitle="no"
		    dialog="true"
		    filterProperties="${['numPropuesta','oportunidad','valor','persona']}"
		    associatedProperties="oportunidad.empresa.razonSocial,persona.primerNombre"
		    listDistinct="true"		    
		    showSortPanel="false"
		    fullAssociationPathFieldNames="false"
		    />
           
		           
        <div id="boxprop">
            <div id="list-propuesta" class="content scaffold-list" role="main">

                <hr style="margin-top:10px;margin-bottom:10px;">
                <div class="row-fluid sortable"> 
                    <g:form controller="Propuesta" params="[titulo:xtitulo]"  id="${params.id}" >
                    
                            <div class="pull-left">
                                <div class="pull-left">
                                    <!--<g:if test="${'CREAR' in seguridadService.operacionesPorOpcion(session['idUsuario'],'/propuesta/indexPropuesta')}">
-->
                                        <a class="btn btn-mini btn-primary" href="/crm/propuesta/create/?idpos=${params.id}&idemp=${xidempresa}">
                                            <i class="icon-plus icon-white"></i>
                                            <strong>Nuevo</strong>
                                        </a>

                                    <!--</g:if>-->
                                </div>
                            </div>
                            &nbsp;
                            <div class="btn-group">

                                <a href="#" class="btn btn-mini" >Acciones</a>
                                <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                                <%  def swacc=0 %>
                                <ul class="dropdown-menu">
                                  <!--<g:if test="${'PROPUESTA_FINAL' in derechos }">
                                        <%  swacc=1 %>
                                    <li><g:actionSubmit 
                                     onMouseOver="${mover}" 
                                    onMouseOut="${mout}" 
                                    style="${estilo}" 
                                    value=" Propuesta Final" 
                                    action="propuestaFinal" /></li>
                                   </g:if>
                                  <g:if test="${'PROPUESTA_NORMAL' in derechos }">
                                        <%  swacc=1 %>
                                     <li><g:actionSubmit 
                                          onMouseOver="${mover}" 
                                          onMouseOut="${mout}" 
                                          style="${estilo}" 
                                          value=" Propuesta Normal" 
                                          action="propuestaNormal" /></li>
                                   </g:if>--> 
                                    <g:if test="${'BORRAR' in derechos}">
                                          <%  swacc=1 %>
                                        <li><a href="/crm/propuesta/listarBorrados/${params.id}?idemp=${xidempresa}" >Ver Borrados</a></li>
                                        </g:if>
                                    <g:if test="${swacc==0}" >
                                            <li align="center">Ninguna </li>
                                     </g:if>
				                                                         
				                       
				                            <%  swacc=1 %>
				                            <li class="dropdown-submenu">
				                                <a  class="gris" href="#">Exportar</a>
				                                <ul class="dropdown-menu">
				                                    <li>
				                                        <g:link action="exportarDatos" params="[tipo_export:'1',xaccionx:xaccion,titulo:xtitulo]">Todos</g:link>
				                                    </li>
				                                    <li><g:actionSubmit  
				                                    onMouseOver="${mover}" 
				                                    onMouseOut="${mout}" 
				                                    style="${estilo}"  
				                                    value="Seleccionados" 
				                                    action="exportarDatos"
				                                    params="[tipo_export:'2']" /></li>
				                                                               
				                                </ul>
				                            </li> 
				                     
                                     
                                     
                                     
                                     
                                     
                                </ul>
                              
                            </div>

                        <!-- inicio filter  buttons  -->                         
            				<filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>
            				<filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered> 
            			<!-- fin filter  buttons  -->
                  
                        <a  class="btn btn-mini" href="/crm/propuesta/indexPropuesta"><i class="icon-remove"></i>&nbsp;Cancelar</a>

                        <g:set var="beanInstance"  value="${propuestaInstance}" />              
                        <g:render template="/general/mensajes" />

                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <td style="width:18px"> </td>

                                    <g:sortableColumn property="numPropuesta" title="${message(code: 'propuesta.numPropuesta.label', default: 'Código')}" />

                                    <g:sortableColumn property="idContacto" title="${message(code: 'propuesta.empresa.label', default: 'Empresa')}" />

                                    <g:sortableColumn property="idVendedor" title="${message(code: 'propuesta.idVendedor.label', default: 'Vendedor')}" />

                                    <g:sortableColumn property="idContacto" title="${message(code: 'propuesta.idContacto.label', default: 'Contacto')}" />
                                    

                                    <g:sortableColumn property="valor" title="${message(code: 'propuesta.valor.label', default: 'Valor')}" />
                                    <g:sortableColumn property="fecha" title="${message(code: 'propuesta.fecha.label', default: 'Fecha')}" />

                                </tr>
                            </thead>
                            <tbody>
                            
                                <g:each in="${propuestaInstanceListVista}" status="i" var="propuestaInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td><g:checkBox name="itempropuesta" value="${propuestaInstance.id}" checked="false" /></td>

                                        <td><a style="text-decoration: underline;"
                                            <% def oportunidadId=propuestaInstance.oportunidad.id;def empresaId=propuestaInstance.oportunidad.empresa.id %>
                                            href="/crm/propuesta/showperfectum/${propuestaInstance.id}?idpos=${oportunidadId}&idemp=${empresaId}&swc=0">
                                            
                                            ${fieldValue(bean: propuestaInstance, field: "numPropuesta")}
                                            </a>
                                            <g:if test="${propuestaInstance?.idEstadoPropuesta=='propfinal'}" >&nbsp;
                                            <i class="fa-icon-trophy" style="font-size:1.2em;"></i>
                                            </g:if>
                                        </td>

										<td style="overflow: hidden;text-overflow: ellipsis; white-space: nowrap;max-width: 350px;">${propuestaInstance?.oportunidad?.empresa?.razonSocial}</td>                                        

                                        <td>${propuestaInstance?.empleado?.nombreCompleto()}</td>
                                        
                                        <td style="overflow: hidden;text-overflow: ellipsis; white-space: nowrap;max-width: 150px;">${propuestaInstance?.persona?.nombreCompleto()}</td>
                                        
                                        <td style="text-align:right;">${formatNumber(number:fieldValue(bean: propuestaInstance, field: "valor"),format:'###,###,##0', locale:'co')}</td>
                                        <td><g:formatDate format="dd-MM-yyyy" date="${propuestaInstance?.fecha}" /></td>

                                        

                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                        <div class="pagination_crm">                            
                             <filterpane:paginate total="${propuestaInstanceCount ?: 0}" domainBean="Propuesta"/>
                        </div>
                    </g:form>
                </div>
            </div>  <!-- fin content-scaffold-list !-->
        </div>  <!-- fin boxprop !-->
    </body>
</html>
