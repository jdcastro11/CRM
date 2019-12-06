<%@ page import="crm.DefLog" %>
<g:set var="generalService" bean="generalService" />
<div id="boxdeflog">
    <g:hiddenField name="eliminado"  value="${defLogInstance?.eliminado?:0}" />   
<div class="control-group ${hasErrors(bean: defLogInstance, field: 'nomEntidad', 'error')} required">
	<label class="control-label" for="nomEntidad">
		<g:message code="defLog.nomEntidad.label" default="Entidad" />
		<span class="required-indicator">*</span>
	</label>
	<div class="controls">
	<g:textField name="nomEntidad" maxlength="100" required="" value="${defLogInstance?.nomEntidad?:params.id}" readonly="" />
	</div>
</div>

<div class="control-group ${hasErrors(bean: defLogInstance, field: 'campo', 'error')} required">
	<label class="control-label" for="campo">
		<g:message code="defLog.campo.label" default="Campo" />
		<span class="required-indicator">*</span>
	</label>
	<div class="controls">
          <%  String xclase
              if(defLogInstance?.nomEntidad) xclase='crm.'+defLogInstance?.nomEntidad 
              else xclase='crm.'+params.id %>
	<g:select name="campo" from="${generalService.getCampos(xclase)}" 
                              optionKey="" 
                              value="${defLogInstance?.campo}"
                              noSelection="['': 'Seleccione Campo']" disabled="${xronly}"  />
	</div>
</div>
<div class="control-group ${hasErrors(bean: defLogInstance, field: 'nombreCampo', 'error')} required">
	<label class="control-label" for="nombreCampo">
		<g:message code="defLog.nombreCampo.label" default="Nombre Campo" />
		<span class="required-indicator">*</span>
	</label>
	<div class="controls">
	<g:textField name="nombreCampo" maxlength="100" required="" value="${defLogInstance?.nombreCampo}" disabled="${xronly}" />
	</div>
</div>

<div class="control-group ${hasErrors(bean: defLogInstance, field: 'idTipoContenido', 'error')} ">
	<label class="control-label" for="idTipoContenido">
		<g:message code="defLog.idTipoContenido.label" default="Tipo Contenido" />
		
	</label>
	<div class="controls">
	<g:select name="idTipoContenido" from="${generalService.getValoresParametro('tipoconten')}"
                optionKey="idValorParametro"
            value="${defLogInstance?.idTipoContenido}"
            noSelection="['': 'Selecciones Tipo']"    disabled="${xronly}" />
	</div>
</div>
<div class="control-group ${hasErrors(bean: defLogInstance, field: 'idEstadoDefLog', 'error')} ">
	<label class="control-label" for="idEstadoDefLog">
		<g:message code="defLog.idEstadoDefLog.label" default="Estado" />
		
	</label>
	<div class="controls">
	<g:select name="idEstadoDefLog" from="${generalService.getValoresParametro('estadogene')}"
                optionKey="idValorParametro"
            value="${defLogInstance?.idEstadoDefLog?:'genactivo'}"
            noSelection="['': '']"    disabled="${xronly}" />
	</div>
</div>
</div>
<script> 
var contenido= $("#boxdeflog"); 
if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+150);     

 </script> 



