<%@ page import="crm.Propuesta" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'propuesta.label', default: 'Propuesta')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="edit-propuesta" class="content scaffold-edit" role="main">
            <% String xtit
                 if (params.sh=='1') xtit="(Archivada)" else xtit="" 
            %>
            <h2>Ver Propuesta ${xtit}</h2> 
            <hr style="margin-top:10px;margin-bottom:10px;">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${propuestaInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${propuestaInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form class="form-horizontal" url="[resource:propuestaInstance, action:'update']" method="PUT" >
                <g:hiddenField name="version" value="${propuestaInstance?.version}" />
                <fieldset class="form">
                    <g:if test="${params.sh=='1'}" >
                        <a  class="btn btn-mini" href="/crm/propuesta/indexh/${params.idpos}?sh=1">
                            <i class="icon-remove"></i>&nbsp;Cancelar</a>
                        </g:if>
                        <g:else>                             
                            <g:render template="acciones_r" />
                        </g:else> 
                    <g:set var="beanInstance"  value="${propuestaInstance}" />                
                    <g:render template="/general/mensajes" />
                    <br><br>
                    <g:set var="xpos" value="${params.idpos}" scope="request"/>
                    <g:set var="xemp" value="${params.idemp}" scope="request"/>
                    <g:set var="xsh" value="${params.sh}" scope="request"/>
                    <g:set var="xronly" value="true" scope="request"/>
                    <g:render template="form"/>
                    
                    
                </fieldset>

            </g:form>
        </div>
    </body>
</html>
