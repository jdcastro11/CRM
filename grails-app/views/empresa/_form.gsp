<%@ page import="crm.Empresa" %>


<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'padre', 'error')} ">
	<label for="padre">
		<g:message code="empresa.padre.label" default="Padre" />
		
	</label>
	<g:select id="padre" name="padreId" from="${crm.Empresa.list()}" optionKey="id"  value="${empresaInstance?.padreId}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'nit', 'error')} ">
	<label for="nit">
		<g:message code="empresa.nit.label" default="Nit" />
		
	</label>
	<g:textField name="nit" maxlength="15" value="${empresaInstance?.nit}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'idTipoEmpresa', 'error')} ">
	<label for="idTipoEmpresa">
		<g:message code="empresa.idTipoEmpresa.label" default="Id Tipo Empresa" />
		
	</label>
	<g:textField name="idTipoEmpresa" maxlength="20" value="${empresaInstance?.idTipoEmpresa}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'razonSocial', 'error')} ">
	<label for="razonSocial">
		<g:message code="empresa.razonSocial.label" default="Razon Social" />
		
	</label>
	<g:textField name="razonSocial" maxlength="100" value="${empresaInstance?.razonSocial}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'idTipoSede', 'error')} ">
	<label for="idTipoSede">
		<g:message code="empresa.idTipoSede.label" default="Id Tipo Sede" />
		
	</label>
	<g:textField name="idTipoSede" maxlength="10" value="${empresaInstance?.idTipoSede}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'idSector', 'error')} ">
	<label for="idSector">
		<g:message code="empresa.idSector.label" default="Id Sector" />
		
	</label>
	<g:textField name="idSector" maxlength="10" value="${empresaInstance?.idSector}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'idRegion', 'error')} ">
	<label for="idRegion">
		<g:message code="empresa.idRegion.label" default="Id Region" />
		
	</label>
	<g:field name="idRegion" type="number" value="${empresaInstance.idRegion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'direccion', 'error')} ">
	<label for="direccion">
		<g:message code="empresa.direccion.label" default="Direccion" />
		
	</label>
	<g:textField name="direccion" maxlength="100" value="${empresaInstance?.direccion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'idPais', 'error')} ">
	<label for="idPais">
		<g:message code="empresa.idPais.label" default="Id Pais" />
		
	</label>
	<g:field name="idPais" type="number" value="${empresaInstance.idPais}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'idDpto', 'error')} ">
	<label for="idDpto">
		<g:message code="empresa.idDpto.label" default="Id Dpto" />
		
	</label>
	<g:field name="idDpto" type="number" value="${empresaInstance.idDpto}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'idCiudad', 'error')} ">
	<label for="idCiudad">
		<g:message code="empresa.idCiudad.label" default="Id Ciudad" />
		
	</label>
	<g:field name="idCiudad" type="number" value="${empresaInstance.idCiudad}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'telefonos', 'error')} ">
	<label for="telefonos">
		<g:message code="empresa.telefonos.label" default="Telefonos" />
		
	</label>
	<g:textField name="telefonos" maxlength="20" value="${empresaInstance?.telefonos}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'fax', 'error')} ">
	<label for="fax">
		<g:message code="empresa.fax.label" default="Fax" />
		
	</label>
	<g:textField name="fax" maxlength="15" value="${empresaInstance?.fax}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'email', 'error')} ">
	<label for="email">
		<g:message code="empresa.email.label" default="Email" />
		
	</label>
	<g:textField name="email" maxlength="100" value="${empresaInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'celular', 'error')} ">
	<label for="celular">
		<g:message code="empresa.celular.label" default="Celular" />
		
	</label>
	<g:textField name="celular" maxlength="20" value="${empresaInstance?.celular}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'observaciones', 'error')} ">
	<label for="observaciones">
		<g:message code="empresa.observaciones.label" default="Observaciones" />
		
	</label>
	<g:textArea name="observaciones" cols="40" rows="5" maxlength="300" value="${empresaInstance?.observaciones}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'idEstadoEmpresa', 'error')} ">
	<label for="idEstadoEmpresa">
		<g:message code="empresa.idEstadoEmpresa.label" default="Id Estado Empresa" />
		
	</label>
	<g:textField name="idEstadoEmpresa" maxlength="10" value="${empresaInstance?.idEstadoEmpresa}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'eliminado', 'error')} ">
	<label for="eliminado">
		<g:message code="empresa.eliminado.label" default="Eliminado" />
		
	</label>
	<g:field name="eliminado" type="number" value="${empresaInstance.eliminado}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'empresa', 'error')} ">
	<label for="empresa">
		<g:message code="empresa.empresa.label" default="Empresa" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${empresaInstance?.empresa}" var="e">
    <li><g:link controller="empresa" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="empresa" action="create" params="['empresa.id': empresaInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'empresa.label', default: 'Empresa')])}</g:link>
</li>
</ul>

</div>




