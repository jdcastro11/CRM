<%@ page import="crm.Pedido" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'pedido.label', default: 'Pedido')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-pedido" class="content scaffold-edit" role="main">

            <h2>Editar Pedido Convertido de Oportunidad... </h2>
            <hr style="margin-top:10px;margin-bottom:10px;">                                               

            <br>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <g:form class="form-horizontal" onsubmit="desactivar('botonPed')" url="[resource:pedidoInstance, action:'update']" method="PUT" >
                <g:hiddenField name="version" value="${pedidoInstance?.version}" />
                <fieldset class="form">
                    <g:render template="acciones" />
                    <br><br>
                    <g:set var="beanInstance"  value="${pedidoInstance}" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>

            </g:form>
        </div>
    </body>
</html>
