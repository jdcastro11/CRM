<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'detPedido.label', default: 'DetPedido')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="create-detPedido" class="content scaffold-create" role="main">

            <h2>Nuevo Producto</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">                                               

            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${detPedidoInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${detPedidoInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form class="form-horizontal" method="post" onsubmit="return validarDatos()"  enctype="multipart/form-data"  url="[resource:detPedidoInstance, action:'save']" >
                <fieldset class="form">
                    <button type="submit" id='btn_save_prod' class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar producto</button>
                  <a  class="btn btn-mini" href="/crm/detPedido/index/${params.pedido}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                    <br><br>
                    <g:set var="xpedido" value="${params.id}" scope="request"/>
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
