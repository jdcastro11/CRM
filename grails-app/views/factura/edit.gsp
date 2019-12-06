<%@ page import="crm.Factura" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'registroOportunidad.label', default: 'Factura')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="edit-registroOportunidad" class="content scaffold-edit" role="main">

            <h2>Editar Factura</h2> 
            <hr style="margin-top:10px;margin-bottom:10px;">                                               

            <g:form class="form-horizontal" url="[resource:facturaInstance, action:'update']" method="PUT" >
                <g:hiddenField name="version" value="${facturaInstance?.version}" />
                <fieldset class="form">
                    <g:render template="acciones" />  
                    <br><br>
                    <g:set var="beanInstance"  value="${facturaInstance}" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>

            </g:form>
        </div>
    </body>
</html>
