<%@ page import="crm.Parametro" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'parametro.label', default: 'Parametro')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>              
	</head>
	<body>
             <% def sw_crud=[0,1,1,0,0]  %>
              
		<!--<a href="#list-parametro" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-parametro" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if> -->
                        <!--Inicio Operaciones de la opcion   -->
                        <form class="form-inline ng-pristine ng-valid"><!-- busqueda --> 
                            <fieldset>
                                    <div class="input-append pull-right">
                                            <input class="input-xlarge ng-pristine ng-valid" type="text" placeholder="Parametro" ng-model="query">
                                                                    <span class="add-on">
                                                                            <i class="icon-search"></i>
                                                                    </span>
                                    </div>
                            </fieldset>
                        </form>

                        <div class="row-fluid sortable">

                                <div class="pull-left">
                                        <div class="pull-left">
                                              <g:if test="${sw_crud[0]==1}">
                                            
                                                <a class="btn btn-mini btn-primary" href="${createLink(action:'create')}">
                                                        <i class="icon-plus"></i>
                                                        <strong> Nuevo</strong>
                                                </a>
                                                
                                              </g:if>  
                                                <div class="btn-group">

                                                         <a href="#" class="btn btn-mini" >Acciones</a>
                                                        <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                                                        <ul class="dropdown-menu">
                                                              <g:if test="${sw_crud[4]==1}">
                                                                <li><a href="#" >Eliminar</a></li>  
                                                              </g:if> 
                                                               
                                                        </ul>

                                                </div>

                                        </div>
                                </div>
                        </div>
                        <!-- Fin operaciones de la Opcion) -->
			<table class="table table-bordered">
			<thead>
					<tr>
					
			                        <td style="width:18px"> </td>				
                                                <g:sortableColumn property="idParametro" title="${message(code: 'parametro.idParametro.label', default: 'Código')}" />
					
						<g:sortableColumn property="descripcion" title="${message(code: 'parametro.descripcion.label', default: 'Descripción')}" />
					
						<g:sortableColumn property="tipoParametro" title="${message(code: 'parametro.tipoParametro.label', default: 'Tipo')}"  style="text-align:center" />
					
						<g:sortableColumn property="estadoParametro" title="${message(code: 'parametro.estadoParametro.label', default: 'Estado')}" style="text-align:center" />
						<td style="width:100px"> </td>				
					</tr>
				</thead>
				<tbody>
                                 
				<g:each in="${parametroInstanceList}" status="i" var="parametroInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
					    <td><input type="checkbox"></td>	
                                             <g:if test="${sw_crud[2]==1}">
                                                  <td><g:link action="show" style="text-decoration:underline" id="${parametroInstance.id}" >${fieldValue(bean: parametroInstance, field: "idParametro")}</g:link></td>
					     </g:if>
                                             <g:else>
                                                  <td>${fieldValue(bean: parametroInstance, field: "idParametro")}</td>
                                             </g:else>
                                             
                                              
						<td>${fieldValue(bean: parametroInstance, field: "descripcion")}</td>
					
                                                <td><center>${fieldValue(bean: parametroInstance, field: "tipoParametro")}</center></td>
                                                <td><center>${fieldValue(bean: parametroInstance, field: "estadoParametro")}</center></td>			
						
                                                <td class="center">
                                                    
                                                                                                     
                                                   <g:if test="${sw_crud[1]==1}">
                                                      <g:link  class="btn btn-success  btn-mini" action="show" id="${parametroInstance.id}"><i class="icon-zoom-in icon-white"  ></i></g:link>
                                                      <g:link class="btn btn-info  btn-mini" action="details" resource="${parametroInstance}"><i class="icon-list icon-white"></i> </g:link>
                                                   </g:if>
                                                  <g:if test="${sw_crud[3]==1}">
                                                    <g:set var="xreg" value="${parametroInstance.id}" />
                                                    <g:set var="xaccion" value="${createLink(action:'borrar')}" />
                                                    <a href="#" class="btn btn-danger btn-mini" 
                                                        onclick='return confirm("Está seguro de borrar este registro?",function(){window.location.href="${xaccion}/${xreg}"})'>                                                     
                                                        <i class="icon-trash icon-white"></i></a>
                                                   </g:if>         
                                                </td>										
                           		</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${parametroInstanceCount ?: 0}" />
			</div>
		</div>
         
 
	</body>
</html>
