<%@ page import="crm.EncLog" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'encLog.label', default: 'EncLog')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-encLog" class="content scaffold-edit" role="main">

            
            <hr style="margin-top:10px;margin-bottom:10px;">
            <g:form class="form-horizontal" url="[resource:encLogInstance, action:'update']" method="PUT" >
                 <g:render template="acciones_r" />
                    <br><br>
                <fieldset class="form">                  
                    <g:set var="xronly" value="true" scope="request"/>                    
                    <g:set var="xidentidad" value="${params.ident}" scope="request"/>                    
                    <g:set var="xentidad" value="${params.entidad}" scope="request"/>                    
                    <g:render template="form"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
