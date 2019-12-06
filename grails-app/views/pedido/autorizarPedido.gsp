<%@ page import="crm.Pedido" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'Pedido.label', default: 'Pedido')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>     

    </head>

    <body>
       <g:set var="generalService" bean="generalService" />
        <h2>Autorizar Cambiar Pedido </h2>
        <hr style="margin-top:10px;margin-bottom:10px;">    
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>

        <g:form id="frmCambiar" class="form-horizontal" url="[resource:pedidoInstance, action:'autorizarCambioPedidoDef']" method="PUT" >

            <button type="submit" class="btn btn-mini btn-primary">
                <i class="icon-download-alt icon-white "></i>&nbsp;Guardar
            </button>
             <a  class="btn btn-mini" href="/crm/pedido/index/?sort=fechaApertura&order=desc&estado=${params.estado}">
             <i class="icon-remove"></i>&nbsp;Cancelar</a>
            <br>
            <br>

            <fieldset class="form">
                <div class="control-group" >
                    <label class="control-label"> Num. Pedido</label>
                    <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:300px;min-height:21px;background-color:#EEE;">
                        ${pedidoInstance?.numPedido}
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" >
                        Funcionario
                        <span class="required-indicator">*</span>
                    </label>
                    <div class="controls">
                        <g:select class="input-large" name="idEmpleado" from="${generalService.getAdministrativos()}" 
                            optionKey="id" 
                            value="${pedidoInstance?.idAutorizado}"
                            noSelection="['': 'Seleccione Funcionario']"   />
                    </div>
                </div>                        

            </g:form>
    </body>
</html>
