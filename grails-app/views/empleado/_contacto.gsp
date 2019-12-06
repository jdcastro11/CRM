<%@ page import="crm.Persona" %>

%{--Use generalService--}%
<g:set var="generalService" bean="generalService"/>

<div class="box-content" id="box_pers">
      <g:if test="${personaInstance?.eliminado==1}" >
    <div id="men_eliminado" class="pull-right label label-important">
       Eliminado
    </div>
  </g:if>
<g:hiddenField name="idTipoPersona"  value="percontact" />

<div class="control-group  ${hasErrors(bean: personaInstance, field: 'primerNombre', 'error')} required ">
	<label class="control-label" for="primerNombre">
		<g:message code="persona.primerNombre.label" default="Primer Nombre" />
        <span class="required-indicator">*</span>
	</label>
	<div class="controls">
	   <g:textField name="primerNombre"  required="" maxlength="30" value="${personaInstance?.primerNombre}"    disabled="${xronly}" />
	</div>
</div>

<div class="control-group  ${hasErrors(bean: personaInstance, field: 'segundoNombre', 'error')} ">
	<label class="control-label" for="segundoNombre">
		<g:message code="persona.segundoNombre.label" default="Segundo Nombre" />
		
	</label>
	<div class="controls">
	   <g:textField name="segundoNombre" maxlength="30" value="${personaInstance?.segundoNombre}"    disabled="${xronly}" />
	</div>
</div>


<div class="control-group  ${hasErrors(bean: personaInstance, field: 'primerApellido', 'error')} required ">
	<label class="control-label" for="primerApellido">
		<g:message code="persona.primerApellido.label" default="Primer Apellido" />
        <span class="required-indicator">*</span>
	</label>
	<div class="controls">
	   <g:textField name="primerApellido"  required="" maxlength="30" value="${personaInstance?.primerApellido}"  disabled="${xronly}" />
	</div>
</div>

<div class="control-group  ${hasErrors(bean: personaInstance, field: 'segundoApellido', 'error')} ">
	<label class="control-label" for="segundoApellido">
		<g:message code="persona.segundoApellido.label" default="Segundo Apellido" />
		
	</label>
	<div class="controls">
	   <g:textField name="segundoApellido" maxlength="30" value="${personaInstance?.segundoApellido}"  disabled="${xronly}" />
	</div>
</div>

<div class="control-group  ${hasErrors(bean: personaInstance, field: 'email', 'error')} ">
	<label class="control-label" for="email">
		<g:message code="persona.email.label" default="Email" />
		
	</label>
	<div class="controls">
	  <g:field type="email" name="email" maxlength="100" value="${personaInstance?.email}"/>
	</div>
</div>

<div class="control-group  ${hasErrors(bean: personaInstance, field: 'celularPrincipal', 'error')} required ">
	<label class="control-label" for="celularPrincipal">
		<g:message code="persona.celularPrincipal.label" default="Celular Principal" />
        <span class="required-indicator">*</span>
	</label>
	<div class="controls">
	   <g:textField name="celularPrincipal" required="" maxlength="15" value="${personaInstance?.celularPrincipal}"  disabled="${xronly}" />
	</div>
</div>

<div class="control-group  ${hasErrors(bean: personaInstance, field: 'celularAdicional', 'error')} ">
	<label class="control-label" for="celularAdicional">
		<g:message code="persona.celularAdicional.label" default="Celular Adicional" />
		
	</label>
	<div class="controls">
	   <g:textField name="celularAdicional" maxlength="15" value="${personaInstance?.celularAdicional}"  disabled="${xronly}" />
	</div>
</div>

<div class="control-group  ${hasErrors(bean: personaInstance, field: 'telefonoFijo', 'error')} ">
	<label class="control-label" for="telefonoFijo">
		<g:message code="persona.telefonoFijo.label" default="Teléfono Fijo" />
		
	</label>
      <div class="controls">
	<g:textField name="telefonoFijo" maxlength="15" value="${personaInstance?.telefonoFijo}"  disabled="${xronly}"/>
    </div> 
</div>
<div class="control-group  ${hasErrors(bean: personaInstance, field: 'cargo', 'error')} ">
	<label class="control-label" for="cargo">
		<g:message code="persona.cargo.label" default="Cargo" />		
	</label>
     <div class="controls">
	   <g:textField name="cargo" maxlength="50" value="${personaInstance?.cargo}" disabled="${xronly}" />
	</div>
</div>   

 <g:hiddenField name="IdEstadoPersona" value="${personaInstance?.idEstadoPersona?:'peractivo'}" />

 <g:hiddenField name="eliminado" type="number" value="${personaInstance?.eliminado?:0}" />

<g:javascript>                    
<!-- calcula el alto del bloque htm del detalle de encaberzado respectivo --> 
 contenido=$("#"box_pers");

  if (parent.IFRAME_DETALLE !=null) parent.IFRAME_DETALLE.height(contenido.height()+150);

</g:javascript>

