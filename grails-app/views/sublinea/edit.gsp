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

            <h2>Edición Sub Línea de Producto </h2>
            <hr style="margin-top:10px;margin-bottom:10px;"> 
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>        
            <g:form class="form-horizontal" url="[resource:sublineaInstance, action:'update']" method="PUT" >               
                <fieldset class="form">
                    <g:render template="acciones" />  
                    <br><br>
                    <g:set var="beanInstance"  value="${sublineaInstance}" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>

            </g:form>
        </div>
    </body>
</html>
