<%@ page import="crm.Empresa" %>

%{--Use generalService--}%
<g:set var="generalService" bean="generalService"/>
<!-- la linea siguiente es para los metodos async -->
<g:hiddenField id="id" name="id" value="${empresaInstance?.id}"/> 

<div>
     <g:if test="${empresaInstance?.eliminado==1}" >
    <div id="men_eliminado" class="pull-right label label-important">
       Eliminado
    </div>
  </g:if>
<g:hiddenField name="tipoF"  value="${params.tipo}"/> 
<g:hiddenField name="idTipoEmpresa"  value="empbase"/>
<g:hiddenField name="idTipoSede"  value="empprincip"/>
<g:hiddenField name="idEstadoEmpresa"  value="empactivo"/>
<g:hiddenField  id ="eliminado" name="eliminado" value="${empresaInstance?.eliminado?:0}" />

<div class="control-group ${hasErrors(bean: empresaInstance, field: 'razonSocial', 'error')}  required ">
	<label class="control-label" for="Empresa">
		<g:message code="empresa.razonSocial.label" default="Empresa" />
        <span class="required-indicator">*</span>
	</label>
        <div class="controls">
        <g:textField name="razonSocial" id="razonSocial" required=""   maxlength="200"  style="width:400px"
        value="${empresaInstance?.razonSocial}" disabled="${xronly}" onblur="document.getElementById('mierror').innerHTML=''" />
        </div>
</div>
    
         <div class="control-group ${hasErrors(bean: empresaInstance, field: 'nit', 'error')} ">
            <label  class="control-label" for="nit">
                 <g:message code="empresa.nit.label" default="Nit" />
                <span class="required-indicator">*</span>
             </label>
        <div class="controls" >
            <g:textField name="nit" id="nit" maxlength="15" value="${empresaInstance?.nit?:''}" 
                onblur="document.getElementById('mierror').innerHTML=''" />
         </div>
        </div>

<div class="control-group  ${hasErrors(bean: empresaInstance, field: 'email', 'error')} ">
	<label  class="control-label"  for="email">
		<g:message code="empresa.email.label" default="E-mail" />
		
	</label>
         <div class="controls">
	 <g:textField name="email" maxlength="200" value="${empresaInstance?.email}" disabled="${xronly}" />
        </div>
</div>


<div class="control-group ${hasErrors(bean: empresaInstance, field: 'telefonos', 'error')} required  ">
	<label class="control-label" for="telefonos">
		<g:message code="empresa.telefonos.label" default="Teléfonos" />
        
	</label>
         <div class="controls">
	  <g:textField name="telefonos" id="telefonos"  maxlength="20" 
            value="${empresaInstance?.telefonos}" disabled="${xronly}"
              onblur="document.getElementById('mierror').innerHTML=''"  />
        </div>
</div>

<div class="control-group ${hasErrors(bean: empresaInstance, field: 'direccion', 'error')} ">
	<label class="control-label" for="direccion">
		<g:message code="empresa.direccion.label" default="Dirección" />		
	</label>
         <div class="controls">
	  <g:textField name="direccion" maxlength="100" value="${empresaInstance?.direccion}" disabled="${xronly}" />
        </div>
</div>

</div>
