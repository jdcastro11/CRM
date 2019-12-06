<%@ page import="crm.DetLog" %>

<div id="boxlog">

<div class="fieldcontain ${hasErrors(bean: detLogInstance, field: 'campo', 'error')} ">
	<label for="campo">
		<g:message code="detLog.campo.label" default="Campo" />
		
	</label>
	<g:textField name="campo" value="${detLogInstance?.campo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: detLogInstance, field: 'valorAnterior', 'error')} ">
	<label for="valorAnterior">
		<g:message code="detLog.valorAnterior.label" default="Valor Anterior" />
		
	</label>
	<g:textArea name="valorAnterior" cols="40" rows="5" maxlength="500" value="${detLogInstance?.valorAnterior}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: detLogInstance, field: 'valorActual', 'error')} ">
	<label for="valorActual">
		<g:message code="detLog.valorActual.label" default="Valor Actual" />
		
	</label>
	<g:textArea name="valorActual" cols="40" rows="5" maxlength="500" value="${detLogInstance?.valorActual}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: detLogInstance, field: 'idEstadoDetLog', 'error')} ">
	<label for="idEstadoDetLog">
		<g:message code="detLog.idEstadoDetLog.label" default="Id Estado Det Log" />
		
	</label>
	<g:textField name="idEstadoDetLog" maxlength="10" value="${detLogInstance?.idEstadoDetLog}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: detLogInstance, field: 'eliminado', 'error')} required">
	<label for="eliminado">
		<g:message code="detLog.eliminado.label" default="Eliminado" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="eliminado" type="number" value="${detLogInstance.eliminado}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: detLogInstance, field: 'enclog', 'error')} required">
	<label for="enclog">
		<g:message code="detLog.enclog.label" default="Enclog" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="enclog" name="enclog.id" from="${crm.EncLog.list()}" optionKey="id" required="" value="${detLogInstance?.enclog?.id}" class="many-to-one"/>
</div>
</div>
