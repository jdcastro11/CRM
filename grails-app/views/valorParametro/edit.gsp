<%@ page import="crm.ValorParametro" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'valorParametro.label', default: 'ValorParametro')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <h2>Edición de Valor Parámetro</h2>               
        <hr style="margin-top:10px;margin-bottom:10px;">

        <form class="form-horizontal" action="/crm/ValorParametro/update/${valorParametroInstance?.id}" method="POST" >
            <g:render template="acciones" /> 
            <br><br>				
            <fieldset class="form">

                <g:render template="form"/>
            </fieldset>

        </form>

    </body>
</html>
