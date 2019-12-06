<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'encvencimiento.label', default: 'EncVencimiento')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="create-vencimiento" class="content scaffold-create" role="main">
		 
		   <h2>Nuevo Vencimiento</h2>
		     <hr style="margin-top:10px;margin-bottom:10px;"> 
		
			<g:if test="${flash.message}">
			<div class="alert alert-error" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${vencimientoInstance}">
			<ul class="alert alert-error" role="alert">
				<g:eachError bean="${encVencimientoInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form class="form-horizontal" onsubmit="desactivar('btn_save_enven')" url="[resource:encVencimientoInstance, action:'save']" >
				<fieldset class="form">
				    <button type="submit" id='btn_save_enven' class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar
                                   </button> 
                               <a  class="btn btn-mini" href="/crm/EncVencimiento/index"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                      <br>
                      <br>
                       <g:set var="xronly" value="false" scope="request"/>
					<g:render template="form"/>
				</fieldset>				
			</g:form>
		</div>
	</body>
</html>
