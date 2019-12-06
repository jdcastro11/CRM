<%@ page import="crm.Persona" %>
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script> 
<script>redimIFRAME();</script>
<div  id="box_pers">


    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'primerNombre', 'error')} required ">
        <label class="control-label" for="primerNombre">
            <g:message code="persona.primerNombre.label" default="Primer Nombre" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:textField name="primerNombre" maxlength="100" value="${personaInstance?.primerNombre}"  disabled="${xronly}" required="" />           
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'segundoNombre', 'error')} ">
        <label class="control-label" for="segundoNombre">
            <g:message code="persona.segundoNombre.label" default="Segundo Nombre" />

        </label>
        <div class="controls">
           <g:textField name="segundoNombre" maxlength="100" value="${personaInstance?.segundoNombre}"  disabled="${xronly}"  />  
         
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'primerApellido', 'error')} required ">
        <label class="control-label" for="primerApellido">
            <g:message code="persona.primerApellido.label" default="Primer Apellido" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:textField name="primerApellido" maxlength="100" value="${personaInstance?.primerApellido}"  disabled="${xronly}" required=""  /> 
            
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'segundoApellido', 'error')} ">
        <label class="control-label" for="segundoApellido">
            <g:message code="persona.segundoApellido.label" default="Segundo Apellido" />

        </label>
        <div class="controls">
          <g:textField name="segundoApellido" maxlength="100" value="${personaInstance?.segundoApellido}"  disabled="${xronly}"  />          
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'email', 'error')} ">
        <label class="control-label" for="email">
            <g:message code="persona.email.label" default="Email" />

        </label>
        <div class="controls">
            <g:textField name="email" maxlength="100" value="${personaInstance?.email}"  disabled="${xronly}"  />      
           
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'celularPrincipal', 'error')} required ">
        <label class="control-label" for="celularPrincipal">
            <g:message code="persona.celularPrincipal.label" default="Celular Principal" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:textField name="celularPrincipal" maxlength="100" value="${personaInstance?.celularPrincipal}"  disabled="${xronly}" required=""  />   
            
        </div>
    </div>

   <!-- <div class="control-group  ${hasErrors(bean: personaInstance, field: 'celularAdicional', 'error')} ">
        <label class="control-label" for="celularAdicional">
            <g:message code="persona.celularAdicional.label" default="Celular Adicional" />

        </label>
        <div class="controls">
          <g:textField name="celularAdicional" maxlength="100" value="${personaInstance?.celularAdicional}"  disabled="${xronly}"  /> 
      
        </div>
    </div>-->

    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'telefonoFijo', 'error')} ">
        <label class="control-label" for="telefonoFijo">
            <g:message code="persona.telefonoFijo.label" default="Teléfono Fijo" />

        </label>
        <div class="controls">
          <g:textField name="telefonoFijo" maxlength="100" value="${personaInstance?.telefonoFijo}"  disabled="${xronly}"  />        
         
        </div> 
    </div>
    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'cargo', 'error')} ">
        <label class="control-label" for="cargo">
            <g:message code="persona.cargo.label" default="Cargo" />		
        </label>
        <div class="controls">
              <g:textField name="cargo" maxlength="100" value="${personaInstance?.cargo}"  disabled="${xronly}"  /> 
           
        </div>
    </div>   
<g:if test="${personaInstance?.id !=null}">
  <iframe id="ifpers" src="/crm/contacto/indexp/${personaInstance?.id}?sw=${sw}" style="border:0;overflow:hidden;width:100%;" ></iframe> 
</g:if> 

