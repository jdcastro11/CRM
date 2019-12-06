<%@ page import="crm.Anexo" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'anexo.label', default: 'Anexo')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-anexo" class="content scaffold-edit" role="main">

            <h2>Editar Anexo </h2>
            <hr style="margin-top:10px;margin-bottom:10px;">

            <g:uploadForm class="form-horizontal" controller="Anexo" action="update" id="${params.id}" method="POST" >

                <fieldset class="form">
                    <g:render template="acciones" />
                    <br><br>
                    <g:set var="beanInstance"  value="${anexoInstance}" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>
            </g:uploadForm>
        </div>
    </body>
</html>
