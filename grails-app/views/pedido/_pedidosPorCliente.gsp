<div class="control-group ">
	<label class="control-label" for="pedido">
		<g:message code="pedido.label" default="Pedido" />
		<span class="required-indicator">*</span>
	</label>
	<div class="controls">
    	<g:select id="pedido" name="idPedido" from="${pedidoList}" optionKey="id" required=''
                 value="${xidpedido}" noSelection="['': 'Seleccione Pedido']"  disabled="${xronly}" />
	</div>
</div>