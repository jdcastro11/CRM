<%@ page import="crm.Parametro" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'parametro.label', default: 'Parametro')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>


        <h2>Edición de Parámetro</h2>               
        <hr style="margin-top:10px;margin-bottom:10px;">
        
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
        <g:form class="form-horizontal" url="[resource:parametroInstance, action:'update']" method="PUT" >                        
            <g:render template="acciones" />  
            <br>
            <br>
            <g:hiddenField name="version" value="${parametroInstance?.version}" />
            <fieldset class="form">
                <g:set var="xronly" value="false" scope="request"/>
                <g:render template="form"/>
            </fieldset>

        </g:form>
<!--	</div>-->
    </body>
</html>
