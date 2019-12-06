<%@ page import="crm.Actividad" %>
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
        <g:set var="entityName" value="${message(code: 'actividad.label', default: 'Actividad')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-anexo" class="content scaffold-edit" role="main">
            <h2>Editar Actividad </h2>
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
            <g:form class="form-horizontal" url="[resource:actividadInstance, action:'update']" method="PUT" >

                <fieldset class="form">
                    <g:render template="acciones" />
                    <br><br>
                    <g:set var="xoportunidad" value="${params.idopor}" scope="request"/>
                    <g:set var="xentidad" value="${params.entidad}" scope="request"/>
                    <g:set var="xidempresa" value="${params.idemp}" scope="request"/>

                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
