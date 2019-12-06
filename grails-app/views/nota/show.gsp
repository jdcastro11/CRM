<%@ page import="crm.Nota" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="detalle">
		<g:set var="entityName" value="${message(code: 'nota.label', default: 'Nota')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>

		<div id="edit-nota" class="content scaffold-edit" role="main">
            
                <h2>Ver Nota</h2>
                <hr style="margin-top:10px;margin-bottom:10px;">
            
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${notaInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${notaInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form class="form-horizontal" url="[resource:notaInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${notaInstance?.version}" />
				<fieldset class="form">
                    <g:set var="xtiponota" value="${params.tnota}" scope="request"/>    
                    <g:render template="acciones_r" />
                    <br><br>
                    <g:set var="xronly" value="true" scope="request"/>                    
                    <g:set var="xident" value="${params.ident}" scope="request"/>                    
                    <g:set var="xent" value="${params.entidad}" scope="request"/>                    
					<g:render template="form"/>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
