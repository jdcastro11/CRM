<%@ page import="crm.RegistroOportunidad" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="detalle">
		<g:set var="entityName" value="${message(code: 'registroOportunidad.label', default: 'RegistroOportunidad')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="edit-registroOportunidad" class="content scaffold-edit" role="main">
			
                    <h2>Editar Registro Oportunidad </h2> 
		     
                    <hr style="margin-top:10px;margin-bottom:10px;">
		     
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${registroOportunidadInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${registroOportunidadInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			
			<form class="form-horizontal" action="/crm/registroOportunidad/update/${registroOportunidadInstance.id}" method="POST" >

                        <fieldset class="form">
				    <g:render template="acciones" />  
                        <br><br>
                        <g:set var="xronly" value="false" scope="request"/>

					<g:render template="form"/>
				</fieldset>
				
			</form>
		</div>
	</body>
</html>
