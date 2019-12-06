
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'idMotivoPerdida', 'error')} ">
    <label class="control-label" for="idMotivoPerdida">
        <g:message code="oportunidad.idMotivoPerdida.label" default="Motivo Perdida" />

    </label>
    <div class="controls" >
        <g:select name="idMotivoPerdida" from="${generalService.getValoresParametro('tpoperdida')}"
                  optionKey="idValorParametro"
                  value="${oportunidadInstance?.idMotivoPerdida}"
                  noSelection="['': 'Seleccione Motivo']"  disabled="${xronly}"  required=""/>
    </div>
</div>

<div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'observCierrer', 'error')} ">
    <label  class="control-label" for="observCambioVendedor">
        <g:message code="oportunidad.observCierre.label" default="Observaciones"  required="" />
    </label>
    <div class="controls">
        <g:textArea style="width:400px;"  name="observCierre"  rows="4"  value="${oportunidadInstance?.observCierre}" disabled="${xronly}"  />
    </div>
</div>