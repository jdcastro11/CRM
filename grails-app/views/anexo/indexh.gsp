<%@ page import="crm.AnexoH" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="seguridadService" bean="seguridadService" />
<g:set var="pedidoService" bean="pedidoService" />
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'anexo.label', default: 'AnexoH')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <% def sw_crud=[1,1,1,1,0,0] %>
        <div id="detalleconten">

            <h2>${xtitulo}</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">
            <div class="row-fluid sortable">  
                
                &nbsp;  <a  class="btn btn-mini" href="/crm/anexo/indexh/${xidentidad}?entidad=${xentidad}">
                    <i class="icon-remove"></i>&nbsp;Cancelar</a>
                    <g:set var="beanInstance"  value="${anexoInstance}" />                
                    <g:render template="/general/mensajes" />
                <div id="list-anexo" class="content scaffold-list" role="main">

                    <table class="table table-bordered">
                        <thead>
                            <tr>

                                <td style="width:18px"> </td>

                                <g:sortableColumn property="idTipoAnexo" title="${message(code: 'anexo.idTipoAnexo.label', default: 'Tipo Anexo')}" />

                                <g:sortableColumn property="nombreArchivo" title="${message(code: 'anexo.nombreArchivo.label', default: 'Nombre Archivo')}" />

                                <g:sortableColumn property="fechaCreacion" title="${message(code: 'anexo.fechaCreacion.label', default: 'Fecha')}" />

                                <g:sortableColumn property="comentarios" title="${message(code: 'anexo.link.label', default: 'Enlaces')}" />

                                <g:sortableColumn property="comentarios" title="${message(code: 'anexo.comentarios.label', default: 'Comentarios')}" />

                                <g:sortableColumn property="idEstadoAnexo" title="${message(code: 'anexo.idEstadoAnexo.label', default: 'Estado')}" />

                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${anexoInstanceList}" status="i" var="anexoInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td><g:checkBox name="anexos" value="${anexoInstance?.id}" checked="false" /></td>


                                    <td><a action="show" style="text-decoration:underline" id="${anexoInstance.id}" href="/crm/anexo/show/${anexoInstance?.id}?ident=${xidentidad}&entidad=${xentidad}&sh=1">
                                            ${generalService.getValorParametro(anexoInstance?.idTipoAnexo)}</a></td>                            
                                    <td>${fieldValue(bean: anexoInstance, field: "nombreArchivo")}</td>
                                    <td>${fieldValue(bean: anexoInstance, field: "fechaCreacion")}</td>

                                    <g:set var="xruta" value="${generalService.getValorParametro('ruta00')}${anexoInstance.nombreArchivo}" />

                                    <td><g:if test="${anexoInstance?.nombreArchivo !=null}">
                                            <a class="btn btn-mini" href="${xruta}" target="_blank">Ver Archivo</a>
                                        </g:if>
                                    </td>

                                    <td>${fieldValue(bean: anexoInstance, field: "comentarios")}</td>

                                    <td>${generalService.getValorParametro(anexoInstance?.idEstadoAnexo)}</td>

                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                    <% def xparam=[entidad:xentidad] %>
                    <div class="pagination_crm">
                        <g:paginate id="${xidentidad}"  params="${xparam}" total="${anexoInstanceCount?:0}" />
                    </div>
                </div>
            </div>
        </div>
        <script>
            var contenido= $("#detalleconten");
            if (parent.IFRAME_DETALLE1 !=null) parent.IFRAME_DETALLE1.height(contenido.height()+60);

        </script>
    </body>
</html>
