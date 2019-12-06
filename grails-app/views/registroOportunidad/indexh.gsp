<%@ page import="crm.RegistroOportunidadH" %>
<%@ page import="crm.Persona" %>
<g:set var="generalService" bean="generalService" />
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'registroOportunidad.label', default: 'RegistroOportunidad')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <% def sw_crud=[1,1,1,1,0,0] %>
        <div id="boxRegOp">
            <div id="list-registroOportunidad" class="content scaffold-list" role="main">

                <h2>${xtitulo}</h2>
                <hr style="margin-top:10px;margin-bottom:10px;">                                               

                <div class="row-fluid sortable">

                    <g:set var="beanInstance"  value="${registroOportunidadInstance}" />                
                    <g:render template="/general/mensajes" />

                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <td style="width:18px"> </td>

                                <g:sortableColumn property="fecha" title="${message(code: 'registroOportunidad.fecha.label', default: 'Fecha')}" />

                                <g:sortableColumn property="idAutor" title="${message(code: 'registroOportunidad.idAutor.label', default: 'Solicitante')}" />

                                <g:sortableColumn property="idRegistroEn" title="${message(code: 'registroOportunidad.idRegistroEn.label', default: 'Registro En ')}" />

                                <g:sortableColumn property="numRegistroOportunidad" title="${message(code: 'registroOportunidad.numRegistroOportunidad.label', default: 'Num Reg. Oportunidad')}" />

                                <g:sortableColumn property="idAsignadoA" title="${message(code: 'registroOportunidad.idAsignadoA.label', default: 'Asignado A')}" />

                                <g:sortableColumn property="idEstadoRegistroOportunidad" title="${message(code: 'registroOportunidad.idEstadoRegistroOportunidad.label', default: 'Estado')}" />


                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${registroOportunidadInstanceList}" status="i" var="registroOportunidadInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                    <td><g:checkBox name="regOpor" value="${registroOportunidadInstance.id}" checked="false" /></td>

                                    <td><a  style="text-decoration: underline;" href="/crm/registroOportunidad/show/${registroOportunidadInstance.id}?idpos=${xidopor}&sh=1" >
                                            ${fieldValue(bean: registroOportunidadInstance, field: "fecha")}<a></td>

                                                <td>${crm.Empleado.get(registroOportunidadInstance.idAutor)}</td>

                                                <td>${generalService.getValorParametro(registroOportunidadInstance?.idRegistroEn)}</td>

                                                <td>${fieldValue(bean: registroOportunidadInstance, field: "numRegistroOportunidad")}</td>

                                                <td>${crm.Empleado.get(registroOportunidadInstance.idAsignadoA)}</td>

                                                <td>${generalService.getValorParametro(registroOportunidadInstance?.idEstadoRegistroOportunidad)}</td>

                                                </tr>
                                            </g:each>
                                            </tbody>
                                            </table>                      

                                            <div class="pagination_crm">
                                                <g:paginate id="${xidopor}" total="${registroOportunidadInstanceCount ?: 0}" />
                                            </div>
                                            </div>
                                            </div>       
                                            </div>       
                                            <script language="javascript">
                                                var contenido= $("#boxRegOp");
                                                if (parent.IFRAME_DETALLE3 !=null) parent.IFRAME_DETALLE3.height(contenido.height()+150);

                                            </script>
                                            </body>
                                            </html>
