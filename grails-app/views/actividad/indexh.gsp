<%@ page import="crm.Persona" %>
<%@ page import="crm.ActividadH" %>
<g:set var="seguridadService" bean="seguridadService" />
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'actividad.label', default: 'ActividadH')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <% def sw_crud=[1,1,1,1,0,0]  %>
        <div id="detalleconten" class="content scaffold-list" role="main">

            <h2>${xtitulo}</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">

            &nbsp;<a  class="btn btn-mini" href="/crm/actividad/indexh/${xidentidad}?entidad=${xentidad}">
                     <i class="icon-remove"></i>&nbsp;Cancelar</a>

                <g:set var="beanInstance"  value="${actividadInstance}" />                
                <g:render template="/general/mensajes" />

            <table   class="table table-bordered">
                <thead>
                    <tr>
                        <td style="width:18px"> </td>

                        <g:sortableColumn property="nombreEntidad" title="${message(code: 'actividad.descActividad.label', default: 'Actividad')}" />

                        <g:sortableColumn property="nombreEntidad" title="${message(code: 'actividad.Responsable.label', default: 'Responsable')}" />

                        <g:sortableColumn property="idContacto" title="${message(code: 'actividad.idContacto.label', default: 'Contacto')}" />

                        <g:sortableColumn property="fechaFinal" title="${message(code: 'actividad.fechaFinal.label', default: 'Finaliza')}" />                 
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${actividadInstanceList}" status="i" var="actividadInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td><g:checkBox name="actividades" value="${actividadInstance.id}" checked="false" /></td>

                            <td><a action="show" style="text-decoration: underline;" href="/crm/actividad/show/${actividadInstance.id}?identidad=${xidentidad}&entidad=${xentidad}&idcon=${xidcontacto}&idemp=${xidempresa}&sh=1">
                                    ${fieldValue(bean: actividadInstance, field: "descActividad")}
                                </a></td>

                            <td>${crm.Empleado.get(actividadInstance?.idResponsable)} </td>

                            <td>${Persona.get(actividadInstance?.idContacto)}</td>

                            <td>${fieldValue(bean: actividadInstance, field: "fechaFinal")}</td>

                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination_crm">
                <%  def xparam=[entidad:"${xentidad}"] %>
                <g:paginate id="${xidentidad}"  params="${xparam}" total="${actividadInstanceCount ?: 0}" />
            </div>
        </div>
        <script>
            var contenido= $("#detalleconten");
            if (parent.IFRAME_DETALLE2 !=null)parent.IFRAME_DETALLE2.height(contenido.height()+250);

        </script>

    </body>
</html>
