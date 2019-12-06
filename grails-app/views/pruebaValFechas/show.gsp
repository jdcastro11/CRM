
<%@ page import="crm.PruebaValFechas" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'pruebaValFechas.label', default: 'PruebaValFechas')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-pruebaValFechas" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-pruebaValFechas" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list pruebaValFechas">
			
				<g:if test="${pruebaValFechasInstance?.descripcionReq}">
				<li class="fieldcontain">
					<span id="descripcionReq-label" class="property-label"><g:message code="pruebaValFechas.descripcionReq.label" default="Descripcion Req" /></span>
					
						<span class="property-value" aria-labelledby="descripcionReq-label"><g:fieldValue bean="${pruebaValFechasInstance}" field="descripcionReq"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pruebaValFechasInstance?.fechaAperturaReq}">
				<li class="fieldcontain">
					<span id="fechaAperturaReq-label" class="property-label"><g:message code="pruebaValFechas.fechaAperturaReq.label" default="Fecha Apertura Req" /></span>
					
						<span class="property-value" aria-labelledby="fechaAperturaReq-label"><g:formatDate date="${pruebaValFechasInstance?.fechaAperturaReq}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${pruebaValFechasInstance?.fechaCierreEstimadaReq}">
				<li class="fieldcontain">
					<span id="fechaCierreEstimadaReq-label" class="property-label"><g:message code="pruebaValFechas.fechaCierreEstimadaReq.label" default="Fecha Cierre Estimada Req" /></span>
					
						<span class="property-value" aria-labelledby="fechaCierreEstimadaReq-label"><g:formatDate date="${pruebaValFechasInstance?.fechaCierreEstimadaReq}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${pruebaValFechasInstance?.numOptty}">
				<li class="fieldcontain">
					<span id="numOptty-label" class="property-label"><g:message code="pruebaValFechas.numOptty.label" default="Num Optty" /></span>
					
						<span class="property-value" aria-labelledby="numOptty-label"><g:fieldValue bean="${pruebaValFechasInstance}" field="numOptty"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pruebaValFechasInstance?.tema}">
				<li class="fieldcontain">
					<span id="tema-label" class="property-label"><g:message code="pruebaValFechas.tema.label" default="Tema" /></span>
					
						<span class="property-value" aria-labelledby="tema-label"><g:fieldValue bean="${pruebaValFechasInstance}" field="tema"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pruebaValFechasInstance?.tipoRequerimiento}">
				<li class="fieldcontain">
					<span id="tipoRequerimiento-label" class="property-label"><g:message code="pruebaValFechas.tipoRequerimiento.label" default="Tipo Requerimiento" /></span>
					
						<span class="property-value" aria-labelledby="tipoRequerimiento-label"><g:fieldValue bean="${pruebaValFechasInstance}" field="tipoRequerimiento"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:pruebaValFechasInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${pruebaValFechasInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
