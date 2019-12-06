-<%@ page import="crm.Pedido" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'pedido.label', default: 'Pedido')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>            
    </head>

    <body>

        <h2>Cambiar Destinatario Factura </h2>
        <hr style="margin-top:10px;margin-bottom:10px;">    
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${pedidoInstance}">
            <ul class="errors" role="alert">
                <g:eachError bean="${pedidoInstance}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
            </ul>
        </g:hasErrors> 

        <g:form id="frmCambiar" class="form-horizontal" url="[resource:pedidoInstance, action:'cambiarDestinatarioFacturaDef']" method="PUT" >

            <button type="submit" class="btn btn-mini btn-primary">
                <i class="icon-download-alt icon-white "></i>&nbsp;Guardar
            </button>
             <a  class="btn btn-mini" href="/crm/pedido/index/?sort=fechaApertura&order=desc&estado=${params.estado}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
            <br>
            <br>

            <fieldset class="form">
                <div class="control-group" >
                    <label class="control-label"> Num. Pedido</label>
                    <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:300px;min-height:21px;background-color:#EEE;">
                        ${pedidoInstance.numPedido}
                    </div>
                </div>
                <g:set var="xlabelEmpresax"  value="Facturar A"  scope="request" />   
                <g:set var="xcampo"  value="idFacturarA"  scope="request" />   
                <g:set var="xidempresa"  value="${pedidoInstance?.idFacturarA}"  scope="request" />    
                <g:render template="/general/cliente" />	

                <g:hiddenField name="pedList"  value="${pedList}"/>                                

            </g:form>

    </body>
</html>
