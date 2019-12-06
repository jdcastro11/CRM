<%@ page import="crm.ElementoPorOportunidad" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'elementoPorOportunidad.label', default: 'elementoPorOportunidad')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-elementoPorOportunidad" class="content scaffold-edit" role="main">
             <% String xtit
                if (params.sh=='1') xtit="(Archivado)" else xtit="" %>
            <h2>Vista Producto ${xtit} </h2>
            <hr style="margin-top:10px;margin-bottom:10px;">                           

            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${elementoPorOportunidadInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${elementoPorOportunidadInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form  class="form-horizontal" url="[resource:elementoPorOportunidadInstance, action:'update']" method="PUT" >
                <g:if test="${params.sh=='1'}" >
                   <a  class="btn btn-mini" href="/crm/elementoPorOportunidad/indexh/${params.idop}">
                  <i class="icon-remove"></i>&nbsp;Cancelar</a>
                </g:if>
                <g:else>
                  <g:render template="acciones_r" />
                </g:else>
                <br>
                <br>
                <fieldset class="form">
                    <g:set var="xoportunidad" value="${params.id}" scope="request"/>
                    <g:set var="xronly" value="true" scope="request"/>
                    <g:render template="form"/>
                </fieldset>
                <fieldset class="buttons">
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
