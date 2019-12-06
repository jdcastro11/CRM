
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />

<div class="control-group ${hasErrors(bean: vencimientoInstance, field: 'motivoNoRenovacion', 'error')} ">
    <label  class="control-label" for="observCambioVendedor">
        <g:message code="vencimiento.noRenovacion.label" default="Observaciones No renovación"  required="" />
    </label>    
    <div class="controls">
        <g:textArea style="width:400px;"  name="motivoNoRenovacion"  rows="6"  value="${vencimientoInstance?.motivoNoRenovacion}" disabled="${xronly}"  />
    </div>
</div>

<g:hiddenField name="idEnc" value="${params.idenc}"/>