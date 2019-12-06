<%@ page import="crm.Contrato" %>



<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'idTipoVencimiento', 'error')} ">
	<label for="idTipoVencimiento">
		<g:message code="contrato.idTipoVencimiento.label" default="Id Tipo Vencimiento" />
		
	</label>
	<g:textField name="idTipoVencimiento" maxlength="10" value="${contratoInstance?.idTipoVencimiento}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'serial', 'error')} ">
	<label for="serial">
		<g:message code="contrato.serial.label" default="Serial" />
		
	</label>
	<g:textField name="serial" maxlength="50" value="${contratoInstance?.serial}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'descripcion', 'error')} ">
	<label for="descripcion">
		<g:message code="contrato.descripcion.label" default="Descripcion" />
		
	</label>
	<g:textField name="descripcion" maxlength="200" value="${contratoInstance?.descripcion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'plataforma', 'error')} ">
	<label for="plataforma">
		<g:message code="contrato.plataforma.label" default="Plataforma" />
		
	</label>
	<g:textField name="plataforma" maxlength="50" value="${contratoInstance?.plataforma}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'idTipoCobertura', 'error')} ">
	<label for="idTipoCobertura">
		<g:message code="contrato.idTipoCobertura.label" default="Id Tipo Cobertura" />
		
	</label>
	<g:textField name="idTipoCobertura" maxlength="10" value="${contratoInstance?.idTipoCobertura}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'fechaInicio', 'error')} required">
	<label for="fechaInicio">
		<g:message code="contrato.fechaInicio.label" default="Fecha Inicio" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fechaInicio" precision="day"  value="${contratoInstance?.fechaInicio}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'fechaVencimiento', 'error')} required">
	<label for="fechaVencimiento">
		<g:message code="contrato.fechaVencimiento.label" default="Fecha Vencimiento" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fechaVencimiento" precision="day"  value="${contratoInstance?.fechaVencimiento}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'observaciones', 'error')} ">
	<label for="observaciones">
		<g:message code="contrato.observaciones.label" default="Observaciones" />
		
	</label>
	<g:textField name="observaciones" maxlength="100" value="${contratoInstance?.observaciones}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'idEstadoVencimiento', 'error')} ">
	<label for="idEstadoVencimiento">
		<g:message code="contrato.idEstadoVencimiento.label" default="Id Estado Vencimiento" />
		
	</label>
	<g:textField name="idEstadoVencimiento" maxlength="10" value="${contratoInstance?.idEstadoVencimiento}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'idTipoContrato', 'error')} ">
	<label for="idTipoContrato">
		<g:message code="contrato.idTipoContrato.label" default="Id Tipo Contrato" />
		
	</label>
	<g:textField name="idTipoContrato" value="${contratoInstance?.idTipoContrato}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'eliminado', 'error')} ">
	<label for="eliminado">
		<g:message code="contrato.eliminado.label" default="Eliminado" />
		
	</label>
	<g:field name="eliminado" type="number" value="${contratoInstance.eliminado}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'notificar', 'error')} ">
	<label for="notificar">
		<g:message code="contrato.notificar.label" default="Notificar" />
		
	</label>
	<g:field name="notificar" type="number" value="${contratoInstance.notificar}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'idTipoConvenio', 'error')} ">
	<label for="idTipoConvenio">
		<g:message code="contrato.idTipoConvenio.label" default="Id Tipo Convenio" />
		
	</label>
	<g:textField name="idTipoConvenio" maxlength="10" value="${contratoInstance?.idTipoConvenio}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'refTipModNumContract', 'error')} ">
	<label for="refTipModNumContract">
		<g:message code="contrato.refTipModNumContract.label" default="Ref Tip Mod Num Contract" />
		
	</label>
	<g:textField name="refTipModNumContract" maxlength="20" value="${contratoInstance?.refTipModNumContract}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'serialManual', 'error')} ">
	<label for="serialManual">
		<g:message code="contrato.serialManual.label" default="Serial Manual" />
		
	</label>
	<g:textField name="serialManual" value="${contratoInstance?.serialManual}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'archivoSeriales', 'error')} ">
	<label for="archivoSeriales">
		<g:message code="contrato.archivoSeriales.label" default="Archivo Seriales" />
		
	</label>
	<g:textField name="archivoSeriales" maxlength="60" value="${contratoInstance?.archivoSeriales}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'motivoNoRenovacion', 'error')} ">
	<label for="motivoNoRenovacion">
		<g:message code="contrato.motivoNoRenovacion.label" default="Motivo No Renovacion" />
		
	</label>
	<g:textField name="motivoNoRenovacion" maxlength="200" value="${contratoInstance?.motivoNoRenovacion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'detpedido', 'error')} required">
	<label for="detpedido">
		<g:message code="contrato.detpedido.label" default="Detpedido" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="detpedido" name="detpedido.id" from="${crm.DetPedido.list()}" optionKey="id" required="" value="${contratoInstance?.detpedido?.id}" class="many-to-one"/>
</div>

