<%@ page import="crm.Pieza" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="detalle">
		<g:set var="entityName" value="${message(code: 'pieza.label', default: 'Pieza')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
	
	   <div id="edit-registroOportunidad" class="content scaffold-edit" role="main">

            <h2>Editar pieza</h2> 
            <hr style="margin-top:10px;margin-bottom:10px;">                                               

            <g:form class="form-horizontal" url="[resource:piezaInstance, action:'update']" method="PUT" >                
                <fieldset class="form">
                    <g:render template="acciones" />  
                    <br><br>
                    <g:set var="beanInstance"  value="${piezaInstance}" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>

            </g:form>
        </div>

	</body>
</html>