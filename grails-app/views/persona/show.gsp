<%@ page import="crm.Persona" %>
<!DOCTYPE html>
<html>
   
	<head> 
              <g:if test="${params.layout=='main'}" >
                  <g:set var="xlayout" value="perfectum"  />
                </g:if>
                 <g:else>
                 <g:set var="xlayout" value="detalle"  />
                 </g:else>
                <meta name="layout" content="${xlayout}">
		<g:set var="entityName" value="${message(code: 'persona.label', default: 'Persona')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<!--<a href="#edit-persona" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>-->
		<div id="edit-persona" class="content scaffold-edit" role="main">
			<div class="box-header" data-original-title>
		          <h2><i class=" fa-icon-eye-open"></i><span class="break"></span>Información Contacto</h2>               
		        </div>
                        <br>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${personaInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${personaInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form class="form-horizontal" url="[resource:personaInstance, action:'update']" method="PUT" >
				  <g:render template="acciones_r" /> 
                                 <br><br>
				<fieldset class="form">
                                    <g:set var="xronly" value="true" scope="request"/>
					<g:render template="form"/>
				</fieldset>				
			</g:form>
		</div>
	</body>
</html>
