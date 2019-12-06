<%@ page import="crm.Indicador" %>
<g:set var="generalService" bean="generalService" />
<g:set var="pedidoService" bean="pedidoService" />
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'anexo.label', default: 'Indicador')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="detalleconten">

            <h2>Estadísticas Por Vendedor</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">
            <div class="row-fluid sortable">  

                <div id="list-anexo" class="content scaffold-list" role="main">

                    <table class="table table-bordered">
                        <thead>
                            <tr>

                                <td style="width:18px"> </td>

                                <g:sortableColumn property="idEntidad" title="${message(code: 'anexo.idEntidad.label', default: 'Entidad')}" />

                                <g:sortableColumn property="nomEntidad" title="${message(code: 'anexo.nomEntidad.label', default: 'Categoría')}" />

                                <g:sortableColumn property="idTipoIndicador" title="${message(code: 'anexo.idTipoIndicador.label', default: 'Indicador')}" />

                                <g:sortableColumn property="periodo" title="${message(code: 'anexo.idTipoIndicador.label', default: 'Período')}" />

                                <g:sortableColumn property="anio" title="${message(code: 'anexo.periodo.label', default: 'Año')}" />

                                <g:sortableColumn property="valor" title="${message(code: 'anexo.valor.label', default: 'Valor')}" />

                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${indicadorInstanceList}" status="i" var="indicadorInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td><g:checkBox name="indicadores" value="${indicadorInstance?.id}" checked="false" /></td>
                                    <td>${crm.Empleado.get(indicadorInstance?.idEntidad)}</td>
                                    <td>${fieldValue(bean: indicadorInstance, field: "nomEntidad")}</td>
                                    <td>${generalService.getValorParametro(indicadorInstance?.idTipoIndicador)}</td>
                                    <td>${fieldValue(bean: indicadorInstance, field: "periodo")}</td>
                                    <td>${fieldValue(bean: indicadorInstance, field: "anio")}</td>
                                    <td>${fieldValue(bean: indicadorInstance, field: "valor")}</td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                    <% def xparam=[entidad:xentidad] %>
                    <div class="pagination_crm">
                        <g:paginate id="${xidentidad}"  total="${indicadorInstanceCount?:0}" />
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
