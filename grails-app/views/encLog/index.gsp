<%@ page import="crm.EncLog" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'encLog.label', default: 'EncLog')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:set var="generalService" bean="generalService" />
        <div id="boxhisto">
            <h2>${xtitulo}</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <g:sortableColumn property="idTipoLog" title="${message(code: 'encLog.idTipoLog.label', default: 'Movimiento')}" />               

                        <g:sortableColumn property="fecha" title="${message(code: 'encLog.fecha.label', default: 'Fecha')}" />
                        <g:sortableColumn property="usuario.id" title="${message(code: 'encLog.usuario.id.label', default: 'Usuario')}" />
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${encLogInstanceList}" status="i" var="encLogInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><a  style="text-decoration:underline"  href="/crm/encLog/show/${encLogInstance?.id}?ident=${xidentidad}&entidad=${xentidad}">
                                    ${generalService.getValorParametro(encLogInstance?.idTipoLog)}</a></td> 
                            <td><g:formatDate format="dd-MM-yyyy HH:mm" date="${encLogInstance.fecha}" /></td>

                            <td>${encLogInstance?.usuario?.usuario}</td>

                        </tr>
                    </g:each>
                </tbody>
            </table>            
            <div class="pagination_crm">
                <% def xparam=[entidad:xentidad] %>
                <g:paginate id="${xidentidad}"  params="${xparam}" total="${encLogInstanceCount ?: 0}" />
            </div>
        </div>

        <script>
            var contenido= $("#boxhisto");
            if (parent.IFRAME_DETALLE9 !=null) {
                 parent.IFRAME_DETALLE9.height(contenido.height()+250);
              //var altura= parent.IFRAME_DETALLE9.height()+contenido.height()+100);
              //parent.IFRAME_DETALLE9.height(altura);
            }
        </script>
    </body>
</html>
