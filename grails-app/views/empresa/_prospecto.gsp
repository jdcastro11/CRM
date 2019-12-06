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
<g:hiddenField name="idTipoEmpresa"  value="empcliente"/>
<g:hiddenField name="idTipoSede"  value="empprincip"/>
<g:hiddenField name="idEstadoEmpresa"  value="empactivo"/>
<g:hiddenField  id ="eliminado" name="eliminado" value="${empresaInstance?.eliminado?:0}" />

<div class="control-group ${hasErrors(bean: empresaInstance, field: 'razonSocial', 'error')}  required ">
	<label class="control-label" for="Empresa">
		<g:message code="empresa.template.label" default="Empresa" />
        <span class="required-indicator">*</span>
	</label>
        <div class="controls">
        <g:textField name="razonSocial" id="razonSocial" required=""   maxlength="200"  style="width:400px;text-transform:uppercase;"
        value="${empresaInstance?.razonSocial}" disabled="${xronly}" onblur="document.getElementById('mierror').innerHTML=''" onkeyup="return upperCases();"/>
        </div>
        
        
         
        
        
        
</div>
    <g:if test="${swNit=='1'}" >
         <div class="control-group ${hasErrors(bean: empresaInstance, field: 'nit', 'error')} ">
            <label  class="control-label" for="nit">
                 <g:message code="empresa.nit.label" default="Nit" />
                  <span class="required-indicator">*</span>
             </label>
        <div class="controls" >
            <g:textField name="nit" id="nit" maxlength="15" value="${empresaInstance?.nit?:''}" 
                placeholder="${message(code: 'placeholder.nit.label')}" disabled="${xronly}"
                onkeypress="return isNit(event);" 
                onblur="document.getElementById('mierror').innerHTML=''" required="" />
                <img  class="iconoAyudaEtiqueta"  src="${resource(dir: 'images', file:'ayuda.png')}" title="Sólo números, un guión y un dígito después del guión. Ej: 802006024-8">
         </div>
         
         
         
         
         
         
         
         
        </div>
        <div class="control-group ${hasErrors(bean: empresaInstance, field: 'idSector', 'error')} ">
            <label class="control-label" for="idSector">
                <g:message code="empresa.idSector.label" default="Sector" />

            </label>
            <div class="controls" >
                <g:select name="idSector" from="${generalService.getValoresParametro('sectores')}"
                          optionKey="idValorParametro"
                          value="${empresaInstance?.idSector}"
                          noSelection="['': 'Seleccione Sector']"  disabled="${xronly}" />
            </div>
        </div>
    </g:if>
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
		<g:message code="telefono.template.label" default="Teléfono" />
        <span class="required-indicator">*</span>
	</label>
         <div class="controls">
	  <g:textField name="telefonos" id="telefonos" required="" maxlength="20" 
            value="${empresaInstance?.telefonos}" disabled="${xronly}"
              onblur="document.getElementById('mierror').innerHTML=''"  />
        </div>
</div>

<div class="control-group ${hasErrors(bean: empresaInstance, field: 'direccion', 'error')} ">
	<label class="control-label" for="direccion">
		<g:message code="direccion.template.label" default="Dirección"   />		
	</label>
         <div class="controls">
	  <g:textField name="direccion" id="direccion" maxlength="100" value="${empresaInstance?.direccion}"  style="width:400px;"
                       disabled="${xronly}" 
                       onblur="document.getElementById('mierror').innerHTML=''"
              />
        </div>
</div>

</div>
