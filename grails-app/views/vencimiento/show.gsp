<%@ page import="crm.Vencimiento" %>
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
        <g:set var="entityName" value="${message(code: 'vencimiento.label', default: 'Vencimiento')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="edit-vencimiento" class="content scaffold-edit" role="main">
            <h2>Edición Detalle  Vencimiento</h2>
            <g:render template="/general/mensajes" />
            <hr style="margin-top:10px;margin-bottom:10px;">                        
            <g:hasErrors bean="${vencimientoInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${vencimientoInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form class="form-horizontal" url="[resource:vencimientoInstance, action:'update']" method="PUT" >
                <g:set var="xidemp" value="${params.idemp}" scope="request"/>
                <g:render template="acciones_r" />
                <br><br>
                <fieldset class="form">
                    <g:set var="xronly" value="true" scope="request"/>
                     <g:set var="layout" value="${params.layout}" scope="request"/>
                      <g:set var="xidemp" value="${params.idemp}" scope="request"/>
                      <g:set var="disableSeriales" value="disabled" scope="request"/>
                    <g:render template="form"/>
                </fieldset>			
            </g:form>
        </div>
    </body>
</html>
