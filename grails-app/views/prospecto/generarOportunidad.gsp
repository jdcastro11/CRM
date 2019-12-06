<%@ page import="crm.Oportunidad" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'Oportunidad')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-oportunidad" class="content scaffold-edit" role="main">

            <h2>Edición de  Oportunidad Convertida de Prospecto </h2>
            <hr style="margin-top:10px;margin-bottom:10px;">                                               

            <br>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <g:form class="form-horizontal" onsubmit="desactivar('btn_convert_prospect')" url="[resource:oportunidadInstance, controller:'oportunidad', action:'save']" method="POST" >
                
                <fieldset class="form">
                    <g:render template="acciones" />
                    <br><br>
                    <g:set var="beanInstance"  value="${oportunidadInstance}" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:set var="swconvertir" value="${swconvertir}" scope="request"/>                    
                    <g:render template="/oportunidad/form"/>
                </fieldset>

            </g:form>
        </div>
    </body>
</html>
