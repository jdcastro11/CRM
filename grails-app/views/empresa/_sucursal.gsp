<%@ page import="crm.Empresa" %>
<%@ page import="crm.Territorio" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService"/>

<g:if test="${empresaInstance?.eliminado==1}" >
    <div id="men_eliminado" class="pull-right label label-important">
        Eliminado
    </div>
</g:if>

<g:hiddenField name="tipoF"  value="${params.tipo}"/>
<g:hiddenField name="idTipoEmpresa"  value="empbase"/>
<g:hiddenField  id ="eliminado" name="eliminado" value="${empresaInstance?.eliminado?:0}" />

<div class="control-group ${hasErrors(bean: empresaInstance, field: 'razonSocial', 'error')} ">
    <label class="control-label" for="Empresa">
        <g:message code="empresa.razonSocial.label" default="Razón Social" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="razonSocial"     maxlength="50"  style="width:300px" 
        value="${empresaInstance?.razonSocial}" disabled="${xronly}" required="" />
    </div>
</div>

<div class="control-group ${hasErrors(bean: empresaInstance, field: 'nit', 'error')} ">
    <label  class="control-label" for="nit">
        <g:message code="empresa.nit.label" default="Nit" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls" >
        <g:textField name="nit" maxlength="15" value="${empresaInstance?.nit}" disabled="${xronly}" required=""/>
    </div>
</div>

<div class="control-group ${hasErrors(bean: empresaInstance, field: 'direccion', 'error')} ">
    <label class="control-label" for="direccion">
        <g:message code="empresa.direccion.label" default="Dirección" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="direccion" maxlength="100" value="${empresaInstance?.direccion}" disabled="${xronly}" required="" />
    </div>
</div>

<div class="control-group ${hasErrors(bean: empresaInstance, field: 'telefonos', 'error')} ">
    <label class="control-label" for="telefonos">
        <g:message code="empresa.telefonos.label" default="Teléfonos" />

    </label>
    <div class="controls">
        <g:textField name="telefonos" maxlength="20" value="${empresaInstance?.telefonos}" disabled="${xronly}"/>
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


<div class="control-group ${hasErrors(bean: empresaInstance, field: 'idDpto', 'error')} ">
    <label class="control-label" for="idDpto">
        <g:message code="empresa.idDpto.label" default="Departamento" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls" >
        <g:select name="idDpto" from="${Territorio.findAll('from Territorio where idTipoTerritorio=\'terdpto\' and eliminado=0  order by nombreTerritorio')}"
            optionKey="id"
        value="${empresaInstance?.idDpto}"
        onchange="${remoteFunction(controller:'Territorio',
                    action:'traerMunicipios', params:'\'id=\'+this.value',
                    update: [success: 'divmuni'])}"
            noSelection="['': 'Seleccione Dpto']"  
        disabled="${xronly}"  required="" />
    </div>
</div>
<div id="divmuni">
    <g:set var="municipioList" value="${generalService.getMunicipios(empresaInstance?.idDpto)}" scope="request"/>
    <g:set var="xidciudad" value="${empresaInstance?.idCiudad}" scope="request"/>
    <g:render template="/territorio/municipios"/>
</div>

