<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="detalle">
		<g:set var="entityName" value="${message(code: 'actividad.label', default: 'Actividad')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>

	</head>
	<body>

		<div id="create-anexo" class="content scaffold-create" role="main">
            
                <h2>Nueva Actividad</h2>
                <hr style="margin-top:10px;margin-bottom:10px;">
            
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${actividadInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${actividadInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form class="form-horizontal" url="[resource:actividadInstance, action:'save']" >
				<fieldset class="form">
                    <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</button>
                      <a  class="btn btn-mini" href="/crm/actividad/index/${params.identidad}?entidad=${params.entidad}">
                 <i class="icon-remove"></i>&nbsp;Cancelar</a>
                    <br>
                    <br>
                    <g:set var="xoportuinidad" value="${params.id}" scope="request"/>
                    <g:set var="xentidad" value="${params.entidad}" scope="request"/>
                    <g:set var="xronly" value="false" scope="request"/>
					<g:render template="form"/>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
