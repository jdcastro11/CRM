-<%@ page import="crm.Pedido" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'detPedido.label', default: 'DetPedido')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>     

    </head>

    <body>

        <h2>Asignar Pedido a otra Oportunidad </h2>
        <hr style="margin-top:10px;margin-bottom:10px;">    
       
        <g:form id="frmCambiar" class="form-horizontal" url="[resource:pedidoInstance, action:'moverPedidoDef']" method="PUT" >

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
                        ${pedidoInstance?.numPedido}
                    </div>
                </div>
                <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'idOportunidad', 'error')} ">
                    <label class="control-label">
                        <g:message code="Pedido.oportunidad.id.label" default="Nueva Oportunidad" />
                    </label>
                    <div class="controls">
                        <g:select class="input-large" name="idOportunidad" from="${crm.Oportunidad.findAll('from Oportunidad where idEstadoOportunidad in (\'oporactiva\',\'opocotizad\',\'xganada\') and eliminado=0')}" 
                            optionKey="id" 
                        value=""
                            noSelection="['': 'Seleccione Oportunidad']"   />
                    </div>
                </div> 
                <g:hiddenField name="prodList"  value="${prodList}"/>                                

            </g:form>

    </body>
</html>
