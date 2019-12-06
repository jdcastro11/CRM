%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />

<div class="control-group">
	<label class="control-label" for="nit">Nit</label>
	<div class="controls" > 
          ${clienteInstance.nit}
	</div>
</div>

<div class="control-group">
	<label class="control-label" for="telefonos"><g:message code="telefono.template.label" default="Teléfono"/> </label>
	<div class="controls" > 
          ${clienteInstance.telefonos}
	</div>
</div>
<div class="control-group">
	<label class="control-label" for="direccion"><g:message code="direccion.template.label" default="Dirección"/></label>
	<div class="controls" id="dir-empresa-cli1"> 
          ${clienteInstance.direccion}
	</div>
</div>
<div class="control-group">
	<label class="control-label" for="Ciudad"><g:message code="ciudad.template.label" default="Ciudad"/></label>
	<div class="controls" > 
            ${generalService.getNombreTerritorio(clienteInstance.idCiudad)}
	</div>
</div>