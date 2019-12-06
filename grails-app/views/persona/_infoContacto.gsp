<%@ page import="crm.Persona" %>

<div  id="box_pers">


    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'primerNombre', 'error')} required ">
        <label class="control-label" for="primerNombre">
            <g:message code="persona.primerNombre.label" default="Primer Nombre" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            ${fieldValue(bean: personaInstance, field: "primerNombre")}
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'segundoNombre', 'error')} ">
        <label class="control-label" for="segundoNombre">
            <g:message code="persona.segundoNombre.label" default="Segundo Nombre" />

        </label>
        <div class="controls">
            ${fieldValue(bean: personaInstance, field: "segundoNombre")}
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'primerApellido', 'error')} required ">
        <label class="control-label" for="primerApellido">
            <g:message code="persona.primerApellido.label" default="Primer Apellido" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            ${fieldValue(bean: personaInstance, field: "primerApellido")}
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'segundoApellido', 'error')} ">
        <label class="control-label" for="segundoApellido">
            <g:message code="persona.segundoApellido.label" default="Segundo Apellido" />

        </label>
        <div class="controls">
            ${fieldValue(bean: personaInstance, field: "segundoApellido")}
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'email', 'error')} ">
        <label class="control-label" for="email">
            <g:message code="persona.email.label" default="Email" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            ${fieldValue(bean: personaInstance, field: "email")}
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'celularPrincipal', 'error')} required ">
        <label class="control-label" for="celularPrincipal">
            <g:message code="persona.celularPrincipal.label" default="Celular Principal" />
           
        </label>
        <div class="controls">
            ${fieldValue(bean: personaInstance, field: "celularPrincipal")}
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'celularAdicional', 'error')} ">
        <label class="control-label" for="celularAdicional">
            <g:message code="persona.celularAdicional.label" default="Celular Adicional" />

        </label>
        <div class="controls">
            ${fieldValue(bean: personaInstance, field: "celularAdicional")}
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'telefonoFijo', 'error')} ">
        <label class="control-label" for="telefonoFijo">
            <g:message code="persona.telefonoFijo.label" default="Teléfono Fijo" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            ${fieldValue(bean: personaInstance, field: "telefonoFijo")}
        </div> 
    </div>
    <div class="control-group  ${hasErrors(bean: personaInstance, field: 'cargo', 'error')} ">
        <label class="control-label" for="cargo">
            <g:message code="persona.cargo.label" default="Cargo" />		
        </label>
        <div class="controls">
            ${fieldValue(bean: personaInstance, field: "cargo")}
        </div>
    </div>   



