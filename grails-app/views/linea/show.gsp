<%@ page import="crm.Linea" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'linea.label', default: 'Linea')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-linea" class="content scaffold-edit" role="main">

            <h2>Ver Línea de Producto</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">    

            <g:form class="form-horizontal" url="[resource:lineaInstance, action:'update']" method="PUT" >
                <g:hiddenField name="version" value="${lineaInstance?.version}" />
                <fieldset class="form">
                    <g:render template="acciones_r" />  
                    <br><br>
                    <g:set var="beanInstance"  value="${lineaInstance}" />                
                    <g:render template="/general/mensajes" />
                      <g:set var="xronly" value="true" scope="request"/>
                    <g:render template="form"/>
                </fieldset>

            </g:form>
        </div>
    </body>
</html>
