<%@ page import="crm.EncLog" %>
<g:set var="generalService" bean="generalService" />
<div id="boxenclog">
    <div class="control-group ${hasErrors(bean: encLogInstance, field: 'idEntidad', 'error')} required">
        <label class="control-label" for="idEntidad">
            <g:message code="encLog.idEntidad.label" default="Id Entidad"   />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:field name="idEntidad" type="number" value="${encLogInstance.idEntidad}" required="" disabled="${xronly}" />
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: encLogInstance, field: 'nomEntidad', 'error')} required">
        <label class="control-label" for="nomEntidad">
            <g:message code="encLog.nomEntidad.label" default="Entidad"   />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:textField name="nomEntidad" maxlength="100" required="" value="${encLogInstance?.nomEntidad}" disabled="${xronly}" />
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: encLogInstance, field: 'idTipoLog', 'error')} ">
        <label class="control-label" for="idTipoLog">
            <g:message code="encLog.idTipoLog.label" default="Movimiento"   />

        </label>
        <div class="controls">
            <g:textField name="idTipoLog" maxlength="10" value="${generalService.getValorParametro(encLogInstance?.idTipoLog)}" disabled="${xronly}" />
        </div>
    </div>


    <div class="control-group ${hasErrors(bean: encLogInstance, field: 'fecha', 'error')} required">
        <label class="control-label" for="fecha">
            <g:message code="encLog.fecha.label" default="Fecha"   />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:formatDate format="dd-MM-yyyy HH:mm" date="${encLogInstance?.fecha}" />
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: encLogInstance, field: 'usuario', 'error')} required">
        <label class="control-label"  for="usuario">
            <g:message code="encLog.usuario.label" default="Usuario"   />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            ${encLogInstance.usuario.usuario} 
        </div>
    </div>

<iframe id="ifdetlog" src="/crm/detLog/index/${encLogInstance?.id}" style="border:0;overflow:hidden;width:100%;" ></iframe>
</div>
<script language="javascript">
    IFRAME_DETALLE8 = $("#ifdetlog");
</script>
<script>
    var contenido= $("#boxenclog");
    if (parent.IFRAME_DETALLE9 !=null) parent.IFRAME_DETALLE9.height(contenido.height()+100);
</script>

