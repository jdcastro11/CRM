<%@ page import="crm.Propuesta" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="detalle">
		<g:set var="entityName" value="${message(code: 'propuesta.label', default: 'Propuesta')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="edit-propuesta" class="content scaffold-edit" role="main">
					     
                    <h2>Editar Propuesta</h2> 
		    <hr style="margin-top:10px;margin-bottom:10px;"> 
		     
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${propuestaInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${propuestaInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form class="form-horizontal" url="[resource:propuestaInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${propuestaInstance?.version}" />
				<fieldset class="form">
				    <g:render template="acciones" />  
                        <br><br>
                        <g:set var="xronly" value="false" scope="request"/>
                        <g:set var="xpos" value="${params.idpos}" scope="request"/>
                        <g:set var="xemp" value="${params.idemp}" scope="request"/>
					<g:render template="form"/>
				</fieldset>
				
			</g:form>
		</div>
	</body>
</html>
