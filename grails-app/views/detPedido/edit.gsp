<%@ page import="crm.DetPedido" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'detPedido.label', default: 'DetPedido')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-detPedido" class="content scaffold-edit" role="main">

            <h2>Editar Producto</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">                                               

            <g:form class="form-horizontal" url="[resource:detPedidoInstance, action:'update']" enctype="multipart/form-data" method="post" >

                <fieldset class="form">
                    <g:render template="acciones" />
                    <br><br>
                    <g:set var="beanInstance"  value="${detPedidoInstance}" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xpedido" value="${params.pedido}" scope="request"/>
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:set var="xronlycontrato" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
