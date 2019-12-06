<%@ page import="crm.Producto" %>
<%@ page import="crm.Linea" %>
<%@ page import="crm.Sublinea" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />

<div id="boxprod"> 

<div class="control-group fieldcontain ${hasErrors(bean: productoInstance, field: 'descProducto', 'error')} required">
	<label class="control-label" for="descProducto">
		<g:message code="producto.descProducto.label" default="Descripción" />
		<span class="required-indicator">*</span>
	</label>
  <div class="controls">
	<g:textField name="descProducto" style="width:400px;" maxlength="200" required="" value="${productoInstance?.descProducto}"  disabled="${xronly}" />
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: productoInstance, field: 'refProducto', 'error')} ">
	<label class="control-label" for="refProducto">
		<g:message code="producto.refProducto.label" default="Referencia" />
		
	</label>
  <div class="controls">
	<g:textField name="refProducto" maxlength="50" value="${productoInstance?.refProducto}"  disabled="${xronly}" />
  </div>
</div>


<div class="control-group fieldcontain ${hasErrors(bean: productoInstance, field: 'linea.id', 'error')} ">
	<label class="control-label" for="idLinea">
		<g:message code="producto.idLinea.label" default="Línea" />
		
	</label>
  <div class="controls">
       <g:select name="idLinea" from="${Linea.findAllByIdEstadoLineaAndEliminado('genactivo',0)}"
                  optionKey="id"
                  value="${productoInstance?.linea?.id}"
                  noSelection="['': 'Seleccione Línea']"   
                  onchange="${remoteFunction(controller:'Sublinea',
                         action:'infoSublineas', params:'\'id=\'+this.value',
					 update: [success: 'divsublineas'])}"   disabled="${xronly}" />
</div>
</div>

 <div id="divsublineas">
      <g:set var="sublineaList" value="${generalService.getSublinea(productoInstance?.linea?.id)}" scope="request"/>
      <g:set var="xidsublinea" value="${productoInstance?.sublinea?.id}" scope="request"/>
      <g:render template="/sublinea/sublineas"/>
  </div>

<div class="control-group fieldcontain ${hasErrors(bean: productoInstance, field: 'idEstadoProducto', 'error')} ">
	<label class="control-label" for="idEstadoProducto">
		<g:message code="producto.idEstadoProducto.label" default="Estado" />
		
	</label>
  <div class="controls">
	
	   <g:select name="idEstadoProducto" from="${generalService.getValoresParametro('estadoprod')}"
                  optionKey="idValorParametro"
                  value="${productoInstance?.idEstadoProducto?:'prodactivo'}"
                  noSelection="['': '']"    disabled="${xronly}" />
  </div>
</div>

</div>
 <g:hiddenField name="eliminado" type="number" value="${productoInstance?.eliminado?:0}" />  
