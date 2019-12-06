<%@ page import="crm.Sublinea" %>
<%@ page import="crm.Linea" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />

<div  id="boxsublin">

    <g:if test="${sublineaInstance?.eliminado==1}" >
        <div id="men_eliminado" class="pull-right label label-important">
            Eliminado
        </div>
    </g:if>
    <g:hiddenField  id ="eliminado" name="eliminado" value="${sublineaInstance?.eliminado?:0}" />
    <g:hiddenField name="idlinea" value="${params.id}"/>
    <div class="control-group ${hasErrors(bean: sublineaInstance, field: 'descSublinea', 'error')} required">
        <label class="control-label" for="descSublinea">
            <g:message code="sublinea.descSublinea.label" default="Descripción" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:textField name="descSublinea" maxlength="200" required="" value="${sublineaInstance?.descSublinea}"  disabled="${xronly}" />
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: sublineaInstance, field: 'observSublinea', 'error')} ">
        <label class="control-label" for="observSublinea">
            <g:message code="sublinea.observSublinea.label" default="Observaciones" />

        </label>
        <div class="controls">
            <g:textField name="observSublinea" style="width:350px;" maxlength="200" value="${sublineaInstance?.observSublinea}"  disabled="${xronly}" />
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: sublineaInstance, field: 'idEstadoSublinea', 'error')} ">
        <label class="control-label" for="idEstadoSublinea">
            <g:message code="sublinea.idEstadoSublinea.label" default="Estado" />

        </label>
        <div class="controls">
            <g:select name="idEstadoSublinea" from="${generalService.getValoresParametro('estadogene')}" 
                optionKey="idValorParametro" 
            value="${sublineaInstance?.idEstadoSublinea?:'genactivo'}"
            noSelection="['': '']" disabled="${xronly}"  />
        </div>
    </div>


</div>
<script>
    <!-- calcula el alto del bloque htm del detalle de encaberzado respectivo -->
    var contenido= $("#boxsublin");

    if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+150);
</script>