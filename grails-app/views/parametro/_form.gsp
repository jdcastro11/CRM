<%@ page import="crm.Parametro" %>
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script> 
 <script>redimIFRAME();</script>
<div >
  <g:if test="${parametroInstance?.eliminado==1}" >
    <div id="men_eliminado" class="pull-right label label-important">
       Eliminado
    </div>
  </g:if>
<div class="control-group ${hasErrors(bean: parametroInstance, field: 'idParametro', 'error')} ">
	<label class="control-label" for="idParametro">
		<g:message code="parametro.idParametro.label" default="Código" />		
	</label>
        <div class="controls">
	 <g:textField  maxlength="10" style="width:80px;" name="idParametro" value="${parametroInstance?.idParametro}"  disabled="${xronly}" />
        </div>
</div>

<div class="control-group ${hasErrors(bean: parametroInstance, field: 'atributo', 'error')} ">
	<label class="control-label" for="atributo">
		<g:message code="parametro.atributo.label" default="Atributo" />		
	</label>
        <div class="controls">
	<g:textField class="span5 typeahead" name="atributo" value="${parametroInstance?.atributo}" disabled="${xronly}" />
        </div>
</div>

<div class="control-group ${hasErrors(bean: parametroInstance, field: 'descripcion', 'error')} ">
	<label class="control-label"  for="descripcion">
		<g:message code="parametro.descripcion.label" default="Descripción" />		
	</label>
        <div class="controls">            
	<g:textField class="span5 typeahead" name="descripcion" value="${parametroInstance?.descripcion}" disabled="${xronly}" />
        </div>
</div>

<div class="control-group ${hasErrors(bean: parametroInstance, field: 'tipoParametro', 'error')} ">
	<label  class="control-label"  for="tipoParametro">
	  <g:message code="parametro.tipoParametro.label" default="Tipo" />		
	</label>   
    <div class="controls">  
	<g:select name="tipoParametro" from="['Usuario','Sistema']" 
                  value="${parametroInstance?.tipoParametro}" valueMessagePrefix="parametro.tipoParametro" 
                  keys="['U','S']"
                  noSelection="['': '']" disabled="${xronly}" />
    </div>
 </div>

<div class="control-group ${hasErrors(bean: parametroInstance, field: 'estadoParametro', 'error')} ">
	<label class="control-label" for="estadoParametro">
	  <g:message code="parametro.estadoParametro.label" default="Estado" />		
	</label>
       <div class="controls">   
	 <g:select name="estadoParametro" from="['Activo','Inactivo']" 
                   keys="['A','I']"
                   value="${parametroInstance?.estadoParametro}" valueMessagePrefix="parametro.estadoParametro" 
                   noSelection="['': '']" disabled="${xronly}"/>
    </div>
    <g:hiddenField  id ="eliminado" name="eliminado" value="${parametroInstance?.eliminado?:0}" />
</div>
</div>
<g:if test="${parametroInstance.id !=null}" >
<hr style="margin-top:10px;margin-bottom:10px;"> 
     <iframe id="ifvalp" src="/crm/valorParametro/index/${parametroInstance.idParametro}?idp=${parametroInstance.id}&sw=${params.sw}" style="border:0;width:100%;" scrolling="no"></iframe>  
    <!-- <script>
          IFRAME_DETALLE=$("#ifvalp");
     </script> -->
</g:if> 






