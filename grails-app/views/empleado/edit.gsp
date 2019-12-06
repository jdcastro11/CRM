<%@ page import="crm.Persona" %>
<!DOCTYPE html>
<html>
	<head>
		<g:if test="${params.layout=='main'}" >
			<g:set var="xlayout" value="perfectum"  />
		</g:if>
		<g:else>
			<g:set var="xlayout" value="detalle"  />
		</g:else>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'empleado.label', default: 'Empleado')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>

		<div id="edit-empleado" class="content scaffold-edit" role="main">

			<h2>Editar Empleado</h2>               
			<hr style="margin-top:10px;margin-bottom: 10px;" />					


			<g:if test="${flash.message}">
				<div class="alert alert-info" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${empleadoInstance}">
				<ul class="errors" role="alert">
					<g:eachError bean="${empleadoInstance}" var="error">
						<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
						</g:eachError>
				</ul>
			</g:hasErrors>
			<form  class="form-horizontal"  action="/crm/empleado/update/${params.id}" method="post">

				<fieldset class="form">
					<g:render template="acciones" />  
					<br>
					<br>				
						<g:set var="xronly" value="false" scope="request"/>
						<g:render template="form"/>					
				</fieldset>
			</form>
		</div>
	</body>
</html>
