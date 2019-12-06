<%@ page import="crm.Territorio" %>
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>
<script>redimIFRAME();</script>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService"/>

<g:if test="${personaInstance?.eliminado==1}" >
    <div id="men_eliminado" class="pull-right label label-important">
		Eliminado
    </div>
</g:if>
<g:hiddenField  id ="eliminado" name="eliminado" value="${sublineaInstance?.eliminado?:0}" />
<g:hiddenField   name="layout" value="${params.layout}" />
<div id="detterr">
<div class="control-group ${hasErrors(bean: territorioInstance, field: 'idTipoTerritorio', 'error')} ">
	<label class="control-label" for="idTipoTerritorio">
		<g:message code="territorio.idTipoTerritorio.label" default="Tipo Territorio" />

	</label>
	<div class="controls">
		<!--<g:textField name="idTipoTerritorio" value="${territorioInstance?.idTipoTerritorio}"/>-->
		<g:select name="idTipoTerritorio" from="${generalService.getValoresParametro('tterritori')}" 
			optionKey="idValorParametro"                
		value="${territorioInstance?.idTipoTerritorio}"
		noSelection="['': '']"   disabled="${xronly}"/> 

	</div>
</div>

<div class="control-group ${hasErrors(bean: territorioInstance, field: 'nombreTerritorio', 'error')} ">
	<label class="control-label" for="nombreTerritorio">
		<g:message code="territorio.nombreTerritorio.label" default="Nombre Territorio" />

	</label>
	<div class="controls">
		<g:textField name="nombreTerritorio" value="${territorioInstance?.nombreTerritorio}"  disabled="${xronly}"/>
	</div>
</div>

<div class="control-group ${hasErrors(bean: territorioInstance, field: 'codigoTerritorio', 'error')} ">
	<label class="control-label" for="codigoTerritorio">
		<g:message code="territorio.codigoTerritorio.label" default="Codigo Territorio" />

	</label>
	<div class="controls">
		<g:textField name="codigoTerritorio" value="${territorioInstance?.codigoTerritorio}"  disabled="${xronly}"/>
	</div>
</div>

<div class="control-group ${hasErrors(bean: territorioInstance, field: 'estadoTerritorio', 'error')} ">
	<label class="control-label" for="estadoTerritorio">
		<g:message code="territorio.estadoTerritorio.label" default="Estado Territorio" />

	</label>
	<div class="controls">        
		<g:select name="estadoTerritorio" from="['Activo','Inactivo']"
			keys="['A','I']"
		value="${territorioInstance?.estadoTerritorio?:"A"}"
			valueMessagePrefix="territorio.estadoTerritorio"
		noSelection="['': 'Seleccione Estado']"  disabled="${xronly}" />
	</div>
</div>

<div class="control-group ${hasErrors(bean: territorioInstance, field: 'padre', 'error')} ">
	<label class="control-label" for="padre">
		<g:message code="territorio.padre.label" default="Padre" />
	</label>
	<div class="controls">
		<g:select  disabled="${xronly}" id="padre" name="padre.id" from="${crm.Territorio.list()}" 
			optionKey="id"  
		value="${territorioInstance?.padre?.id}" 
			noSelection="['': '']"    
			class="many-to-one"/>
	</div>
</div>
</div>
<hr style="margin-top:10px;margin-bottom:10px;" />
<g:if test="${territorioInstance.id !=null}">
	<iframe id="ifdetTer" src="/crm/territorio/detTerritorio/${territorioInstance.id}?layout=detail" style="border:0;width:100%;"  scrolling="no" ></iframe> 
</g:if> 
 <div style="height:150px;"></div>
<script>
    IFRAME_DETALLE=$("#ifdetTer");
    
</script>
