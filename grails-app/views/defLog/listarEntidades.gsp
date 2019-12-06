
<%@ page import="crm.DefLog" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'defLog.label', default: 'DefLog')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>      
            <div id="list-defLog" class="content scaffold-list" role="main">
             <h2>Lista de Entidades Auditables </h2>
            <hr style="margin-top:10px;margin-bottom:10px;">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <td style="width:18px"> </td>
                        <g:sortableColumn property="descValParametro" title="${message(code: 'defLog.nomEntidad.label', default: 'Nombre Entidad')}" />

                        <g:sortableColumn property="valor" title="${message(code: 'defLog.campo.label', default: 'Entidad')}" />                            

                    </tr>
                </thead>
                <tbody>
                    <g:each in="${auditableInstanceList}" status="i" var="auditableInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            
                            <td><g:checkBox name="auditables" value="${auditableInstance.id}" checked="false" /></td>
                            
                            <td><a style="text-decoration:underline" 
                                   href="/crm/defLog/mostrar/${auditableInstance?.valor}?nom=${auditableInstance?.descValParametro}">
                                   ${auditableInstance?.descValParametro}
                                </a>
                            </td>
                             
                            <td>${fieldValue(bean: auditableInstance, field: "valor")}</td>
                            
                          
                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination_crm">
                <g:paginate total="${auditableInstanceCount ?: 0}" />
            </div>
        </div>
    </body>
</html>
