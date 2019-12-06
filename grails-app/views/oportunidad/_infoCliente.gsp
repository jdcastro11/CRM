%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />

<div class="control-group">
	<label class="control-label" for="nit">Nit
     <span class="required-indicator">*</span>
    </label>
	<div class="controls" > 
          ${clienteInstance.nit}
	</div>
</div>
<div class="control-group">
	<label class="control-label" for="sector">Sector</label>
	<div class="controls" > 
          ${generalService.getValorParametro(clienteInstance.idSector)}
	</div>
</div>
<div class="control-group">
	<label class="control-label" for="telefonos">Teléfono</label>
	<div class="controls" > 
          ${clienteInstance.telefonos}
	</div>
</div>
<div class="control-group">
	<label class="control-label" for="direccion">Dirección</label>
	<div class="controls" > 
          ${clienteInstance.direccion}
	</div>
</div>
<div class="control-group">
	<label class="control-label" for="email">E-mail</label>
	<div class="controls" > 
          ${clienteInstance.email}
	</div>
</div>