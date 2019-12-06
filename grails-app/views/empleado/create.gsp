<!DOCTYPE html>
<html>
	<head>
		<g:if test="${params.layout=='detail'}" >
			<g:set var="xlayout" value="detalle"  />
		</g:if>
		<g:else>
			<g:set var="xlayout" value="perfectum"  />
		</g:else>
		<meta name="layout" content="${xlayout}">
		<g:set var="entityName" value="${message(code: 'empleado.label', default: 'Empleado')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>

	</head>
	<body>		
		<div id="create-empleado" class="content scaffold-create" role="main">
			
			<h2>Nuevo Empleado</h2>
			<hr style="margin-top:10px;margin-bottom: 10px;" />					

			<g:if test="${flash.message}">
				<div class="alert alert-info" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${empleadoInstance}">
				<ul class="errors" role="alert">
					<g:eachError bean="${empleadoInstance}" var="error">
						<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
						</g:eachError>
				</ul>
			</g:hasErrors>
			<form  class="form-horizontal" onsubmit="desactivar('btn_save_emple')"  action="${createLink(url:[controller:'Empleado',action:'save'])}" method="post">
				<fieldset class="form">
					<button type="submit" id='btn_save_emple' class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</button>					
					<button type="reset" class="btn btn-mini" onclick="history.go(-1)"><i class="icon-remove"></i>&nbsp;Cancelar</button>						
					<br><br>
						<g:set var="xronly" value="false" scope="request"/>
						<g:render template="form"/>
						
				</fieldset>
			</form>

		</div>
	</body>
</html>
