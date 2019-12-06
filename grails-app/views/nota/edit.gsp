<%@ page import="crm.Nota" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'nota.label', default: 'Nota')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-nota" class="content scaffold-edit" role="main">

            <h2>Editar Nota </h2>
            <hr style="margin-top:10px;margin-bottom:10px;">  
            <g:form class="form-horizontal" controller="Nota" action="update" id="${params.id}" method="POST" >

                <fieldset class="form">                
                     <g:set var="xtiponota" value="${xtiponota}" scope="request"/> 
                    <g:render template="acciones" />
                    <br><br>              
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
