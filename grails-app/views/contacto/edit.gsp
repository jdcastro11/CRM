<%@ page import="crm.Contacto" %>
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
        <g:set var="entityName" value="${message(code: 'contacto.label', default: 'Contacto')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-empresa" class="content scaffold-edit" role="main">

            <h2>Edición de Contacto </h2>
            <hr style="margin-top:10px;margin-bottom:10px;">                                               


            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${contactoInstance}">
                <ul class="alert alert-error" role="alert">
                    <g:eachError bean="${contactoInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                </ul>
            </g:hasErrors> 

            <g:form class="form-horizontal" url="[resource:contactoInstance,action:'update', controller:'Contacto']" method="PUT" >
                <g:render template="acciones" />  
                <br><br>
                <fieldset class="form">
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>

            </g:form>
        </div>
    </body>
</html>
