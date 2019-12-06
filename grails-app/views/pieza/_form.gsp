<%@ page import="crm.Pieza" %>
<g:hiddenField name="idTactica" value="${params.id}"/>
<g:hiddenField id="eliminado" name="eliminado" value="${piezaInstance?.eliminado?:0}"/>


<g:if test="${piezaInstance?.eliminado==1}" >
    <div id="men_eliminado" class="pull-right label label-important">
        Eliminado
    </div>
</g:if>

<div class="fieldcontain ${hasErrors(bean: piezaInstance, field: 'url', 'error')} ">
	<label class="control-label"  for="url">
		<g:message code="pieza.url.label" default="Url" />		
	</label>
	<div class="controls">
		<g:textField style="width:40%" name="url"  disabled="${xronly}"  maxlength="100" value="${piezaInstance?.url}"/>
	</div>
</div>
<br>
<div class="fieldcontain ${hasErrors(bean: piezaInstance, field: 'textoParaMostrar', 'error')} ">
	<label class="control-label"  for="textoParaMostrar">		
		<g:message code="pieza.textoParaMostrar.label" default="Texto Para Mostrar" />				
	</label>
		<div class="controls">
			<g:textField style="width:40%" name="textoParaMostrar"  disabled="${xronly}"  maxlength="200" value="${piezaInstance?.textoParaMostrar}"/>
		</div>
</div>

<!-- <div class="fieldcontain ${hasErrors(bean: piezaInstance, field: 'tactica', 'error')} required">
	<label for="tactica">
		<g:message code="pieza.tactica.label" default="Tactica" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="tactica" name="tactica.id" from="${crm.Tactica.list()}" optionKey="id" required="" value="${piezaInstance?.tactica?.id}" class="many-to-one"/>
</div> -->

