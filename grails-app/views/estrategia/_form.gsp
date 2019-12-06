<%@ page import="crm.Estrategia" %>

%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script> 
<script>redimIFRAME();</script>
<div>
	<g:if test="${estrategiaInstance?.eliminado==1}" >
	    <div id="men_eliminado" class="pull-right label label-important">
	       Eliminado
	    </div>
  	</g:if>
	<div class="control-group ${hasErrors(bean: estrategiaInstance, field: 'descripcion', 'error')} required">
		<label class="control-label" for="descripcion">
			<g:message code="estrategia.descripcion.label" default="Descripción" />
			<span class="required-indicator">*</span>
		</label>
		<div class="controls">
		  <g:textField name="descripcion" maxlength="200" required="" value="${estrategiaInstance?.descripcion}"  disabled="${xronly}" />
		</div>
	</div>

	
	<div class="control-group ${hasErrors(bean: estrategiaInstance, field: 'idEstadoEstrategia', 'error')} ">
		<label class="control-label" for="idEstadoEstrategia">
			<g:message code="estrategia.idEstadoEstrategia.label" default="Estado" />
			
		</label>
		<div class="controls">
		  <g:select name="idEstadoEstrategia" from="${generalService.getValoresParametro('estadogene')}" 
                              optionKey="idValorParametro" 
                              value="${estrategiaInstance?.idEstadoEstrategia?:'genactivo'}"
                              noSelection="['': '']" disabled="${xronly}"  />
		</div>
	</div>	
      <g:hiddenField id="eliminado" name="eliminado" value="${estrategiaInstance?.eliminado?:0}"/>
</div>


<g:if test="${estrategiaInstance.id !=null}">
  <!--<iframe id="iftactica" height="700" src="/crm/tactica/index/${estrategiaInstance.id}?sw=${sw}" style="overflow: hidden;border:0;width:100%;"></iframe> -->
  <object type="text/html" width="100%" height="1000px" data="/crm/tactica/index/${estrategiaInstance.id}?sw=${sw}"></object>  
</g:if> 
<%--  <script>
    IFRAME_DETALLE=$("#ifsubl");
   </script> --%>
 
  