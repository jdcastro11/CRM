
<%@ page import="crm.PruebaValFechas" %>
<!DOCTYPE html>
<html>
	<head>
                <meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'pruebaValFechas.label', default: 'PruebaValFechas')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-pruebaValFechas" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-pruebaValFechas" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="descripcionReq" title="${message(code: 'pruebaValFechas.descripcionReq.label', default: 'Descripcion Req')}" />
					
						<g:sortableColumn property="fechaAperturaReq" title="${message(code: 'pruebaValFechas.fechaAperturaReq.label', default: 'Fecha Apertura Req')}" />
					
						<g:sortableColumn property="fechaCierreEstimadaReq" title="${message(code: 'pruebaValFechas.fechaCierreEstimadaReq.label', default: 'Fecha Cierre Estimada Req')}" />
					
						<g:sortableColumn property="numOptty" title="${message(code: 'pruebaValFechas.numOptty.label', default: 'Num Optty')}" />
					
						<g:sortableColumn property="tema" title="${message(code: 'pruebaValFechas.tema.label', default: 'Tema')}" />
					
						<g:sortableColumn property="tipoRequerimiento" title="${message(code: 'pruebaValFechas.tipoRequerimiento.label', default: 'Tipo Requerimiento')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${pruebaValFechasInstanceList}" status="i" var="pruebaValFechasInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${pruebaValFechasInstance.id}">${fieldValue(bean: pruebaValFechasInstance, field: "descripcionReq")}</g:link></td>
					
						<td><g:formatDate date="${pruebaValFechasInstance.fechaAperturaReq}" /></td>
					
						<td><g:formatDate date="${pruebaValFechasInstance.fechaCierreEstimadaReq}" /></td>
					
						<td>${fieldValue(bean: pruebaValFechasInstance, field: "numOptty")}</td>
					
						<td>${fieldValue(bean: pruebaValFechasInstance, field: "tema")}</td>
					
						<td>${fieldValue(bean: pruebaValFechasInstance, field: "tipoRequerimiento")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${pruebaValFechasInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
