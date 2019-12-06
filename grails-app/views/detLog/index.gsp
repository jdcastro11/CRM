
<%@ page import="crm.DetLog" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'detLog.label', default: 'DetLog')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:set var="auditoriaService" bean="auditoriaService" />
        <div id="boxdetlog">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <g:sortableColumn property="campo" title="${message(code: 'detLog.campo.label', default: 'Campo')}" />

                        <g:sortableColumn property="valorAnterior" title="${message(code: 'detLog.valorAnterior.label', default: 'Valor Anterior')}" />

                        <g:sortableColumn property="valorActual" title="${message(code: 'detLog.valorActual.label', default: 'Valor Actual')}" />
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${detLogInstanceList}" status="i" var="detLogInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td>${auditoriaService.nombreCampo(detLogInstance?.campo,detLogInstance?.enclog?.nomEntidad)}</td>

                            <td>${auditoriaService.valorCampo(detLogInstance?.campo,detLogInstance?.valorAnterior,detLogInstance?.idTipoContenido)}</td>

                            <td>${auditoriaService.valorCampo(detLogInstance?.campo,detLogInstance?.valorActual,detLogInstance?.idTipoContenido)}</td>

                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination_crm">
                <g:paginate id="${xidenclog}" total="${detLogInstanceCount ?: 0}" />
            </div>
        </div>

        <script>
            alert('entre aqui')
            var contenido= $("#boxdetlog");            
            }
        </script>
         
    </body>
</html>
