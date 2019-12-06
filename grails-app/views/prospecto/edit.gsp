<%@ page import="crm.Empresa" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'prospecto.label', default: 'Prospecto')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
            </head>
            <body>

		<div id="edit-empresa" class="content scaffold-edit" role="main">		     
		   <h2>Edición de Prospecto</h2>
                   <hr style="margin-top:10px;margin-bottom:10px;">        
		   
		<form class="form-horizontal" action="/crm/prospecto/update/${params.id}"  method='POST' >
                    
                    <g:render template="acciones" />                
                    <br><br>
                   <g:set var="beanInstance"  value="${prospectoInstance}" />                
                     <g:render template="/general/mensajes" />
                    <fieldset class="form">
                    <g:set var="xronly" value="false" scope="request"/>
                        <g:render template="form"/>
                    </fieldset>				
		</form>
		</div>
	</body>
</html>
