<div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'refProducto', 'error')} ">
        <label class="control-label" for="refProducto">
            <g:message code="detPedido.refProducto.label" default="Referencia"  />

        </label>
        <div class="controls" >            
            <g:textField name="refProducto"  maxlength="50" value="${xrefProducto}" disabled="${xronly}"/>
        </div>
 </div>
