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
        <g:if test="${params.swmodal==''}">
            <meta name="layout" content="${xlayout}">
        </g:if>
        <g:set var="entityName" value="${message(code: 'persona.label', default: 'Persona')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-persona" class="content scaffold-edit" role="main">

            <h2>Editar Contacto </h2>               
            <hr style="width:80%; margin-top:10px;margin-bottom:10px;"> 

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
            <ul id="erroraSync">

            </ul>
            <form  id="formPersona" class="form-horizontal"  action="/crm/persona/update/${params.id}" method="${params.swmodal==''?'PUT':POST}">

                <fieldset class="form">
                    <g:render template="acciones" />  
                    <br>
                    <br>
                    <g:if test="${params.tipo='1'}" >
                        <g:set var="xronly" value="false" scope="request"/>
                        <g:render template="contacto"/>
                    </g:if>
                </fieldset>
            </form>
        </div>
    </body>
</html>
