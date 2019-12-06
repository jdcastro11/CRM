<%@ page import="crm.Empresa" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'prospecto.label', default: 'Prospecto')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>

		 <h2><g:message code="show.prospecto.label" default="Vista de Prospecto"/> </h2>
                <hr style="margin-top:10px;margin-bottom:10px;"> 
	
			<form class="form-horizontal" action="/crm/prospecto/update/${params.id}"  >
                                 <g:render template="acciones_r" />  
                                 <br><br>
                                 <g:render template="/general/mensajes" />
                                
				<fieldset class="form">
                                      <g:set var="xronly" value="true" scope="request"/>
					<g:render template="form"/>
				</fieldset>
				
			</form>
	   
	</body>
</html>
