
<%@ page import="crm.Contrato" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'contrato.label', default: 'Contrato')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-contrato" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-contrato" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list contrato">
			
				<g:if test="${contratoInstance?.idTipoVencimiento}">
				<li class="fieldcontain">
					<span id="idTipoVencimiento-label" class="property-label"><g:message code="contrato.idTipoVencimiento.label" default="Id Tipo Vencimiento" /></span>
					
						<span class="property-value" aria-labelledby="idTipoVencimiento-label"><g:fieldValue bean="${contratoInstance}" field="idTipoVencimiento"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.serial}">
				<li class="fieldcontain">
					<span id="serial-label" class="property-label"><g:message code="contrato.serial.label" default="Serial" /></span>
					
						<span class="property-value" aria-labelledby="serial-label"><g:fieldValue bean="${contratoInstance}" field="serial"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.descripcion}">
				<li class="fieldcontain">
					<span id="descripcion-label" class="property-label"><g:message code="contrato.descripcion.label" default="Descripcion" /></span>
					
						<span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${contratoInstance}" field="descripcion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.plataforma}">
				<li class="fieldcontain">
					<span id="plataforma-label" class="property-label"><g:message code="contrato.plataforma.label" default="Plataforma" /></span>
					
						<span class="property-value" aria-labelledby="plataforma-label"><g:fieldValue bean="${contratoInstance}" field="plataforma"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.idTipoCobertura}">
				<li class="fieldcontain">
					<span id="idTipoCobertura-label" class="property-label"><g:message code="contrato.idTipoCobertura.label" default="Id Tipo Cobertura" /></span>
					
						<span class="property-value" aria-labelledby="idTipoCobertura-label"><g:fieldValue bean="${contratoInstance}" field="idTipoCobertura"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.fechaInicio}">
				<li class="fieldcontain">
					<span id="fechaInicio-label" class="property-label"><g:message code="contrato.fechaInicio.label" default="Fecha Inicio" /></span>
					
						<span class="property-value" aria-labelledby="fechaInicio-label"><g:formatDate date="${contratoInstance?.fechaInicio}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.fechaVencimiento}">
				<li class="fieldcontain">
					<span id="fechaVencimiento-label" class="property-label"><g:message code="contrato.fechaVencimiento.label" default="Fecha Vencimiento" /></span>
					
						<span class="property-value" aria-labelledby="fechaVencimiento-label"><g:formatDate date="${contratoInstance?.fechaVencimiento}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.observaciones}">
				<li class="fieldcontain">
					<span id="observaciones-label" class="property-label"><g:message code="contrato.observaciones.label" default="Observaciones" /></span>
					
						<span class="property-value" aria-labelledby="observaciones-label"><g:fieldValue bean="${contratoInstance}" field="observaciones"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.idEstadoVencimiento}">
				<li class="fieldcontain">
					<span id="idEstadoVencimiento-label" class="property-label"><g:message code="contrato.idEstadoVencimiento.label" default="Id Estado Vencimiento" /></span>
					
						<span class="property-value" aria-labelledby="idEstadoVencimiento-label"><g:fieldValue bean="${contratoInstance}" field="idEstadoVencimiento"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.idTipoContrato}">
				<li class="fieldcontain">
					<span id="idTipoContrato-label" class="property-label"><g:message code="contrato.idTipoContrato.label" default="Id Tipo Contrato" /></span>
					
						<span class="property-value" aria-labelledby="idTipoContrato-label"><g:fieldValue bean="${contratoInstance}" field="idTipoContrato"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.eliminado}">
				<li class="fieldcontain">
					<span id="eliminado-label" class="property-label"><g:message code="contrato.eliminado.label" default="Eliminado" /></span>
					
						<span class="property-value" aria-labelledby="eliminado-label"><g:fieldValue bean="${contratoInstance}" field="eliminado"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.notificar}">
				<li class="fieldcontain">
					<span id="notificar-label" class="property-label"><g:message code="contrato.notificar.label" default="Notificar" /></span>
					
						<span class="property-value" aria-labelledby="notificar-label"><g:fieldValue bean="${contratoInstance}" field="notificar"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.idTipoConvenio}">
				<li class="fieldcontain">
					<span id="idTipoConvenio-label" class="property-label"><g:message code="contrato.idTipoConvenio.label" default="Id Tipo Convenio" /></span>
					
						<span class="property-value" aria-labelledby="idTipoConvenio-label"><g:fieldValue bean="${contratoInstance}" field="idTipoConvenio"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.refTipModNumContract}">
				<li class="fieldcontain">
					<span id="refTipModNumContract-label" class="property-label"><g:message code="contrato.refTipModNumContract.label" default="Ref Tip Mod Num Contract" /></span>
					
						<span class="property-value" aria-labelledby="refTipModNumContract-label"><g:fieldValue bean="${contratoInstance}" field="refTipModNumContract"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.serialManual}">
				<li class="fieldcontain">
					<span id="serialManual-label" class="property-label"><g:message code="contrato.serialManual.label" default="Serial Manual" /></span>
					
						<span class="property-value" aria-labelledby="serialManual-label"><g:fieldValue bean="${contratoInstance}" field="serialManual"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.archivoSeriales}">
				<li class="fieldcontain">
					<span id="archivoSeriales-label" class="property-label"><g:message code="contrato.archivoSeriales.label" default="Archivo Seriales" /></span>
					
						<span class="property-value" aria-labelledby="archivoSeriales-label"><g:fieldValue bean="${contratoInstance}" field="archivoSeriales"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.motivoNoRenovacion}">
				<li class="fieldcontain">
					<span id="motivoNoRenovacion-label" class="property-label"><g:message code="contrato.motivoNoRenovacion.label" default="Motivo No Renovacion" /></span>
					
						<span class="property-value" aria-labelledby="motivoNoRenovacion-label"><g:fieldValue bean="${contratoInstance}" field="motivoNoRenovacion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.detpedido}">
				<li class="fieldcontain">
					<span id="detpedido-label" class="property-label"><g:message code="contrato.detpedido.label" default="Detpedido" /></span>
					
						<span class="property-value" aria-labelledby="detpedido-label"><g:link controller="detPedido" action="show" id="${contratoInstance?.detpedido?.id}">${contratoInstance?.detpedido?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:contratoInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${contratoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
