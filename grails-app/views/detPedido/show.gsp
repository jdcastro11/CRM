<%@ page import="crm.DetPedido" %>
<!DOCTYPE html>
<html>
    <head>
        <g:if test="${params.layout=='main'}" >
            <g:set var="xlayout" value="perfectum"  />
        </g:if>
        <g:else>
            <g:set var="xlayout" value="detalle"  />
        </g:else>
        <meta name="layout" content="${xlayout}">
        <g:set var="entityName" value="${message(code: 'detPedido.label', default: 'DetPedido')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-detPedido" class="content scaffold-edit" role="main">

            <h2>Vista de Producto </h2>
            <hr style="margin-top:10px;margin-bottom:10px;">                                               

           
            <g:form class="form-horizontal" url="[resource:detPedidoInstance, action:'update']" method="PUT" >

                <fieldset class="form">
                    <g:set var="sw" value="${params?.sw}" scope="request"/>
                    <g:render template="acciones_r" />
                     <g:render template="/general/mensajes" />
                    <br><br>
                    <g:set var="xpedido" value="${params.pedido}" scope="request"/>
                    <g:set var="xronly" value="true" scope="request"/>
                    <g:set var="xronlycontrato" value="true" scope="request"/>                    
                    <g:render template="form"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
