<%@ page import="crm.Linea" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="detalle">
		<g:set var="entityName" value="${message(code: 'sublinea.label', default: 'Linea')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		
		<div id="edit-sublinea" class="content scaffold-edit" role="main">
			
		      <h2>Ver Sub Línea de Producto</h2>
		       <hr style="margin-top:10px;margin-bottom:10px;"> 
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${sublineaInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${sublineaInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form class="form-horizontal" url="[resource:sublineaInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${sublineaInstance?.version}" />
				<fieldset class="form">
				    <g:render template="acciones_r" />  
                    <br><br>
                    <g:set var="xronly" value="true" scope="request"/>
					<g:render template="form"/>
				</fieldset>
				
			</g:form>
		</div>
	</body>
</html>
