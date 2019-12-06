<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'parametro.label', default: 'Parametro')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
	
		<div id="create-parametro" class="content scaffold-create" role="main">
			 <div class="box-header" data-original-title>
		        <h2><i class="icon-plus-sign"></i><span class="break"></span>Nuevo Parámetro</h2>
		       </div>
                       <br>
			<g:if test="${flash.message}">
                <br><br>
			<div class="alert alert-error" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${parametroInstance}">
			<ul class="alert alert-error" role="alert">
				<g:eachError bean="${parametroInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form class="form-horizontal" onsubmit="desactivar('btn_save_para')" url="[resource:parametroInstance, action:'save']" >
				<fieldset class="form">
                                 <g:submitButton id='btn_save_para'  class="btn btn-mini btn-primary" name="create"  value="Guardar" />
                                  <a  class="btn btn-mini" href="/crm/parametro/index"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                                 <br>
                                 <br>
                                 <g:render template="form"/>
				</fieldset>
				
			</g:form>
		</div>
	</body>
</html>
