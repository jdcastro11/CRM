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

            <h2>Ver Anexo</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">          
            <g:form class="form-horizontal" url="[resource:anexoInstance, action:'update']" method="PUT" >
                <g:hiddenField name="version" value="${anexoInstance?.version}" />
                <fieldset class="form">
                    <g:if test="${params.sh=='1'}" >
                        <a  class="btn btn-mini" href="/crm/anexo/indexh/${params.ident}?entidad=${params.entidad}&sh=1">
                            <i class="icon-remove"></i>&nbsp;Cancelar</a>
                        </g:if>
                        <g:else>
                            <g:render template="acciones_r" />
                        </g:else> 
                    <br><br>
                    <g:set var="xronly" value="true" scope="request"/>                    
                    <g:set var="xident" value="${params.ident}" scope="request"/>                    
                    <g:set var="xent" value="${params.entidad}" scope="request"/>   
                     <g:set var="anex" value="${params.anex}" scope="request"/>   
                    <g:render template="form"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
