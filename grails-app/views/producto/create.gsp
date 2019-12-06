<!DOCTYPE html>
<html>
	<head>
              <g:if test="${params.layout=='main'}" >
                  <g:set var="xlayout" value="perfectum"  />
              </g:if>
              <g:else>
                  <g:set var="xlayout" value="detalle"  />
              </g:else>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'producto.label', default: 'Producto')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
      
                <h2>Nuevo Producto </h2>		   
                <hr style="margin-top:10px;margin-bottom:10px;">                           

		
		<div id="create-producto" class="content scaffold-create" role="main">
			
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${productoInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${productoInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form  class="form-horizontal" onsubmit="desactivar('btn_save_prod1')"  url="[resource:productoInstance, action:'save']" >
				<fieldset class="form">
                                <button type="submit" id='btn_save_prod1' class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</button>

                                
                      <button type="reset" class="btn btn-mini" onclick="history.go(-1)"> <i class="icon-remove"></i>&nbsp;Cancelar</button>
                      <br>
                      <br>
                       <g:set var="xronly" value="false" scope="request"/>
                        <g:render template="form"/>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
