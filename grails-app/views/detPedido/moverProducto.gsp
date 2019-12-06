-<%@ page import="crm.Pedido" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'detPedido.label', default: 'DetPedido')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>     

    </head>

    <body>

        <h2>Mover Producto a otro Pedido </h2>
        <hr style="margin-top:10px;margin-bottom:10px;">    
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${detPedidoInstance}">
            <ul class="errors" role="alert">
                <g:eachError bean="${detPedidoInstance}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
            </ul>
        </g:hasErrors> 

        <g:form id="frmCambiar" class="form-horizontal" url="[action:'moverProductoDef',controller:'DetPedido']" >

            <button type="submit" class="btn btn-mini btn-primary">
                <i class="icon-download-alt icon-white "></i>&nbsp;Guardar
            </button>
           <a  class="btn btn-mini" href="/crm/detPedido/index/${pedidoOld}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
            <br>
            <br>

            <fieldset class="form">
                <div class="control-group" >
                    <label class="control-label"> Num. Pedido</label>
                    <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:300px;min-height:21px;background-color:#EEE;">
                        ${xnumPedido}
                    </div>
                </div>
                <g:hiddenField name="pedidoOld"  value="${pedidoOld}" />                                

                <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'pedido.id', 'error')} ">
                    <label class="control-label" for="pedido.id">
                        <g:message code="detPedido.pedido.id.label" default="Nuevo Pedido" />
                    </label>
                    <div class="controls">
                        <g:select class="input-large" name="pedido.id" from="${crm.Pedido.executeQuery('from Pedido where idEstadoPedido not in (\'pedestad07\',\'pedestad06\') and eliminado=0  order by numPedido')}" 
                            optionKey="id" 
                        value="${detPedidoInstance?.pedido?.id}"
                            noSelection="['': 'Seleccione Pedido']"   />
                    </div>
                </div> 
                <% 
                 def listaProd=prodList.join(',')
                 %>
                <g:hiddenField name="prodList"  value="${listaProd}"/>                                
             
            </g:form>

    </body>
</html>
