<%@ page import="crm.OportunidadH" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'oportunidadH.label', default: 'OportunidadH')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>    
	</head>
	<body>
                 <h2>Vista de Oportunidad Archivada</h2>               
                <hr style="margin-top:10px;margin-bottom:10px;"> 		
     	 <g:form class="form-horizontal" > 
                <fieldset class="form">
                     <g:set var="xronly" value="true" scope="request"/>
                     <g:render template="formh"/>
                </fieldset>			
	</g:form>
	</body>
</html>
