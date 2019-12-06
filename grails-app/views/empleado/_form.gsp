<%@ page import="crm.Empleado" %>
<%@ page import="crm.ValorParametro" %>

<g:set var="generalService" bean="generalService" />
 <script src="${resource(dir: 'js/jquery', file:'jquery.numeric.js')}"></script>
<g:if test="${empleadoInstance?.eliminado==1}" >
    <div id="men_eliminado" class="pull-right label label-important">
		Eliminado
    </div>
</g:if>

<div class="control-group ${hasErrors(bean: empleadoInstance, field: 'identificacion', 'error')} ">
	<label class="control-label" for="identificacion">
		<g:message code="empleado.identificacion.label" default="Identificacion" />
          <span class="required-indicator">*</span>
	</label>
	<div class="controls">
		<g:textField name="identificacion" required="" maxlength="15" value="${empleadoInstance?.identificacion}"  disabled="${xronly}"/>
	</div>
</div>

<div class="control-group ${hasErrors(bean: empleadoInstance, field: 'idTipoEmpleado', 'error')} ">
	<label class="control-label" for="idTipoEmpleado">
		<g:message code="empleado.idTipoEmpleado.label" default="Tipo Empleado" />
          <span class="required-indicator">*</span>
	</label>
	<div class="controls">
		<g:select id="cboTipoEmpleado"
			name="idTipoEmpleado"
		from="${ValorParametro.findAll("from ValorParametro where idValorParametro in ('pervendedo', 'peremplead') and eliminado=0")}"
			optionKey="idValorParametro" required=""
		value="${empleadoInstance?.idTipoEmpleado}" class="many-to-one"
		noSelection="['': 'Seleccione Tipo']"  disabled="${xronly}" required="" />
	</div>

</div>

<div class="control-group ${hasErrors(bean: empleadoInstance, field: 'primerNombre', 'error')} required">
	<label class="control-label" for="primerNombre">
		<g:message code="empleado.primerNombre.label" default="Primer Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<div class="controls">
		<g:textField name="primerNombre" maxlength="30" required="" value="${empleadoInstance?.primerNombre}" disabled="${xronly}"/>
	</div>
</div>

<div class="control-group ${hasErrors(bean: empleadoInstance, field: 'segundoNombre', 'error')} ">
	<label class="control-label" for="segundoNombre">
		<g:message code="empleado.segundoNombre.label" default="Segundo Nombre" />

	</label>
	<div class="controls">
		<g:textField name="segundoNombre" maxlength="50" value="${empleadoInstance?.segundoNombre}"  disabled="${xronly}"/>
	</div>
</div>

<div class="control-group ${hasErrors(bean: empleadoInstance, field: 'primerApellido', 'error')} required">
	<label class="control-label" for="primerApellido">
		<g:message code="empleado.primerApellido.label" default="Primer Apellido" />
		<span class="required-indicator">*</span>
	</label>
	<div class="controls">
		<g:textField name="primerApellido" maxlength="30" required="" value="${empleadoInstance?.primerApellido}" disabled="${xronly}"/>
	</div>
</div>

<div class="control-group ${hasErrors(bean: empleadoInstance, field: 'segundoApellido', 'error')} ">
	<label class="control-label" for="segundoApellido">
		<g:message code="empleado.segundoApellido.label" default="Segundo Apellido" />

	</label>
	<div class="controls">
		<g:textField name="segundoApellido" maxlength="30" value="${empleadoInstance?.segundoApellido}" disabled="${xronly}"/>
	</div>
</div>

<div class="control-group ${hasErrors(bean: empleadoInstance, field: 'email', 'error')} ">
	<label class="control-label" for="email">
		<g:message code="empleado.email.label" default="Email" />
                <span class="required-indicator">*</span>       
	</label>
	<div class="controls">
		<g:field type="email" name="email" maxlength="100" value="${empleadoInstance?.email}" required="" disabled="${xronly}"/>
	</div>
</div>

<div class="control-group ${hasErrors(bean: empleadoInstance, field: 'celularPrincipal', 'error')} ">
	<label class="control-label" for="celularPrincipal">
		<g:message code="empleado.celularPrincipal.label" default="Celular Principal" />

	</label>
	<div class="controls">
		<g:textField name="celularPrincipal" maxlength="15" value="${empleadoInstance?.celularPrincipal}" disabled="${xronly}"/>
	</div>
</div>

<div class="control-group ${hasErrors(bean: empleadoInstance, field: 'telefonoFijo', 'error')} ">
	<label class="control-label" for="telefonoFijo">
		<g:message code="empleado.telefonoFijo.label" default="Teléfono Fijo" />

	</label>
	<div class="controls">
		<g:textField name="telefonoFijo" maxlength="50" value="${empleadoInstance?.telefonoFijo}" disabled="${xronly}"/>
	</div>
</div>

<div class="control-group ${hasErrors(bean: prospectoInstance, field: 'idSucursal', 'error')}  required ">
    <label class="control-label" for="idSucursal">
        <g:message code="prospecto.idSucursal.label" default="Sucursal" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls" > 
        <g:select name="idSucursal" required="" from="${crm.Empresa.findAllByIdTipoEmpresaAndEliminado('empbase',0)}"
            optionKey="id" 
        value="${empleadoInstance?.idSucursal}"
        noSelection="['': 'Seleccione Sucursal']"  disabled="${xronly}" />
    </div>
</div>

<div class="control-group ${hasErrors(bean: empleadoInstance, field: 'cargo', 'error')} ">
	<label class="control-label" for="cargo">
		<g:message code="empleado.cargo.label" default="Cargo" />

	</label>
	<div class="controls">
		<g:textField name="cargo" maxlength="50" value="${empleadoInstance?.cargo}" disabled="${xronly}"/>
	</div>
</div>

<div class="control-group ${hasErrors(bean: empleadoInstance, field: 'cuota', 'error')} ">
	<label class="control-label" for="cuota">
		<g:message code="empleado.cuota.label" default="Cuota(en miles Us)" />

	</label>
	<div class="controls">
	      <g:if test="${xronly=='false'}" >
                <g:textField name="cuota"  maxlength="10" 
                value="${empleadoInstance?.cuota}"                    
                disabled="${xronly}" 
                    style="text-align: right" class="entero" />
            </g:if>
            <g:else>
                <g:textField name="cuota_s" 
                value="${formatNumber(number:empleadoInstance?.cuota,format:'###,###,###', locale:'co')}"                       
                disabled="${xronly}" 
                    style="text-align: right" />
            </g:else>    
	</div>
</div>
<div class="control-group ${hasErrors(bean: empleadoInstance, field: 'idEstadoEmpleado', 'error')} ">
	<label class="control-label" for="idEstadoEmpleado">
		<g:message code="empleado.idEstadoEmpleado.label" default="Estado"  />

	</label>
	<div class="controls">
		<g:select name="idEstadoEmpleado" from="${generalService.getValoresParametro('eempleado')}"
			optionKey="idValorParametro"
			disabled="${xronly}"
		value="${empleadoInstance?.idEstadoEmpleado?:'empleactiv'}"
		noSelection="['': '']" />

	</div>
</div>


<g:hiddenField name="eliminado" type="number" value="${empleadoInstance?.eliminado?:0}" required=""/>

</div>
 <script> 
  $(".decimal").numeric();    
  $(".entero").numeric("0");
</script>