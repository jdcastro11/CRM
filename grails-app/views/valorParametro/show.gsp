<%@ page import="crm.ValorParametro" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="detalle">
		<g:set var="entityName" value="${message(code: 'valorParametro.label', default: 'ValorParametro')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
	                
		<h2>Vista Valor Parámetro</h2>               
                <hr style="margin-top:10px;margin-bottom:10px;">
		                
			<g:form class="form-horizontal" url="[resource:valorParametroInstance, action:'update']" method="PUT" >
                                <g:render template="acciones_r" /> 
                                 <br><br>				
				<fieldset class="form">                                    
                                      <g:set var="xronly" value="true" scope="request"/>
					<g:render template="form"/>
				</fieldset>
			
			</g:form>
		
	</body>
</html>
