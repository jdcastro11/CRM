<%@ page import="crm.Empresa" %>
<!DOCTYPE html>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />

<html>
	<head>
        <g:if test="${params.layout=='main'}" >
            <g:set var="xlayout" value="perfectum"  />
        </g:if>
        <g:else>
            <g:set var="xlayout" value="detalle"  />
        </g:else>
        <meta name="layout" content="${xlayout}">
		<g:set var="entityName" value="${message(code: 'prospecto.label', default: 'Prospecto')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
             
   
	</head>
	<body>
	
		<div id="edit-prospecto" class="content scaffold-edit" role="main">
			<div class="box-header" data-original-title>

                 <g:set var="xtitulo" value="${generalService.getValorParametro(params.t)}" />

		            <h2><i class="fa-icon-upload-alt"></i><span class="break"></span>${xtitulo}</h2>
		          </div>
                       <br>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${entidadInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${entidadInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors> 
                        <g:uploadForm url="[controller:'General',action:'subirArchivo']">
                        <input type="file"  name="nombreArchivo">
                            <g:hiddenField name="xregreso" value="${zregreso}" />
                            <g:submitButton class="btn btn-mini btn-success" name="upload" value="Cargar"/>
                        </g:uploadForm>
                      
	    </div>
	</body>
</html>
