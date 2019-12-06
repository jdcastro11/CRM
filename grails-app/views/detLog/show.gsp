
<%@ page import="crm.DetLog" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'detLog.label', default: 'DetLog')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-detLog" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-detLog" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list detLog">
			
				<g:if test="${detLogInstance?.campo}">
				<li class="fieldcontain">
					<span id="campo-label" class="property-label"><g:message code="detLog.campo.label" default="Campo" /></span>
					
						<span class="property-value" aria-labelledby="campo-label"><g:fieldValue bean="${detLogInstance}" field="campo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${detLogInstance?.valorAnterior}">
				<li class="fieldcontain">
					<span id="valorAnterior-label" class="property-label"><g:message code="detLog.valorAnterior.label" default="Valor Anterior" /></span>
					
						<span class="property-value" aria-labelledby="valorAnterior-label"><g:fieldValue bean="${detLogInstance}" field="valorAnterior"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${detLogInstance?.valorActual}">
				<li class="fieldcontain">
					<span id="valorActual-label" class="property-label"><g:message code="detLog.valorActual.label" default="Valor Actual" /></span>
					
						<span class="property-value" aria-labelledby="valorActual-label"><g:fieldValue bean="${detLogInstance}" field="valorActual"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${detLogInstance?.idEstadoDetLog}">
				<li class="fieldcontain">
					<span id="idEstadoDetLog-label" class="property-label"><g:message code="detLog.idEstadoDetLog.label" default="Id Estado Det Log" /></span>
					
						<span class="property-value" aria-labelledby="idEstadoDetLog-label"><g:fieldValue bean="${detLogInstance}" field="idEstadoDetLog"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${detLogInstance?.eliminado}">
				<li class="fieldcontain">
					<span id="eliminado-label" class="property-label"><g:message code="detLog.eliminado.label" default="Eliminado" /></span>
					
						<span class="property-value" aria-labelledby="eliminado-label"><g:fieldValue bean="${detLogInstance}" field="eliminado"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${detLogInstance?.enclog}">
				<li class="fieldcontain">
					<span id="enclog-label" class="property-label"><g:message code="detLog.enclog.label" default="Enclog" /></span>
					
						<span class="property-value" aria-labelledby="enclog-label"><g:link controller="encLog" action="show" id="${detLogInstance?.enclog?.id}">${detLogInstance?.enclog?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:detLogInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${detLogInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
