<%@ page import="crm.Linea" %>

%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script> 
<script>redimIFRAME();</script>
<div>
	<g:if test="${lineaInstance?.eliminado==1}" >
	    <div id="men_eliminado" class="pull-right label label-important">
	       Eliminado
	    </div>
  	</g:if>
	<div class="control-group ${hasErrors(bean: lineaInstance, field: 'descLinea', 'error')} required">
		<label class="control-label" for="descLinea">
			<g:message code="linea.descLinea.label" default="Descripción" />
			<span class="required-indicator">*</span>
		</label>
		<div class="controls">
		  <g:textField name="descLinea" maxlength="200" required="" value="${lineaInstance?.descLinea}"  disabled="${xronly}" />
		</div>
	</div>

	<div class="control-group ${hasErrors(bean: lineaInstance, field: 'observLinea', 'error')} ">
		<label class="control-label" for="observLinea">
			<g:message code="linea.observLinea.label" default="Observaciones" />
			
		</label>
		<div class="controls">
		  <g:textArea name="observLinea" rows="3" maxlength="200" value="${lineaInstance?.observLinea}"  disabled="${xronly}" />
		</div>
	</div>

	<div class="control-group ${hasErrors(bean: lineaInstance, field: 'idEstadoLinea', 'error')} ">
		<label class="control-label" for="idEstadoLinea">
			<g:message code="linea.idEstadoLinea.label" default="Estado" />
			
		</label>
		<div class="controls">
		  <g:select name="idEstadoLinea" from="${generalService.getValoresParametro('estadogene')}" 
                              optionKey="idValorParametro" 
                              value="${lineaInstance?.idEstadoLinea?:'genactivo'}"
                              noSelection="['': '']" disabled="${xronly}"  />
		</div>
	</div>
	
      <g:hiddenField  id ="eliminado" name="eliminado" value="${lineaInstance?.eliminado?:0}" />
</div>

<g:if test="${lineaInstance.id !=null}">
  <iframe id="ifsubl" src="/crm/sublinea/index/${lineaInstance.id}?sw=${sw}" style="border:0;overflow:hidden;width:100%;" ></iframe> 
</g:if> 
<%--  <script>
    IFRAME_DETALLE=$("#ifsubl");
   </script> --%>
 
  