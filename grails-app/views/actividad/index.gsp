<%@ page import="crm.Persona" %>
<%@ page import="crm.Actividad" %>
<g:set var="seguridadService" bean="seguridadService" />
<!DOCTYPE html>
<html>
    <head>
        <g:if test="${params.layout=='main'}" >
            <g:set var="xlayout" value="perfectum"  />
        </g:if>
        <g:else>
            <g:set var="xlayout" value="detalle"  />
        </g:else>
        <meta name="layout" content="${xlayout}">
        <g:set var="entityName" value="${message(code: 'actividad.label', default: 'Actividad')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <% def sw_crud=[1,1,1,1,0,0]  %>
        <div id="detalleconten" class="content scaffold-list" role="main">

            <h2>${xtitulo}</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">
            <g:if test="${xcerrada=='N'}">
                <div class="pull-left">

                    <div class="pull-left">  

                        <g:if test="${'CREAR' in seguridadService.operacionesPorOpcion(session['idUsuario'],'/actividad/index')}">

                            <a class="btn btn-mini btn-primary" href="/crm/actividad/create/?identidad=${xidentidad}&entidad=${xentidad}&idcon=${xidcontacto}&idemp=${xidempresa}">
                                <i class="icon-plus icon-white"></i> 
                                <strong>Nuevo</strong>
                            </a>

                        </g:if>
                    </div>
                    &nbsp;
                    <div class="btn-group">

                        <a href="#" class="btn btn-mini" >Acciones</a>
                        <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                        <ul class="dropdown-menu">
                            <g:if test="${sw_crud[4]==1}">
                                <li><a href="${createLink(action:'eliminar')}" >Eliminar</a></li>
                                </g:if>
                            <li><a href="/crm/actividad/listarBorrados/${xidentidad}?entidad=${xentidad}" >Ver Borrados</a></li>
                        </ul>
                    </div>            
                </div>
            </g:if>
            &nbsp;<a  class="btn btn-mini" href="/crm/actividad/index/${xidentidad}?entidad=${xentidad}">
                     <i class="icon-remove"></i>&nbsp;Cancelar</a>

                <g:set var="beanInstance"  value="${actividadInstance}" />                
                <g:render template="/general/mensajes" />

            <table   class="table table-bordered">
                <thead>
                    <tr>
                        <td style="width:18px"> </td>

                        <g:sortableColumn property="descActividad" title="${message(code: 'actividad.descActividad.label', default: 'Actividad')}" />

                        <g:sortableColumn property="nombreEntidad" title="${message(code: 'actividad.Responsable.label', default: 'Responsable')}" />

                        <g:sortableColumn property="idContacto" title="${message(code: 'actividad.idContacto.label', default: 'Contacto')}" />

                        <g:sortableColumn property="fechaFinal" title="${message(code: 'actividad.fechaFinal.label', default: 'Finaliza')}" />                 
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${actividadInstanceList}" status="i" var="actividadInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td><g:checkBox name="actividades" value="${actividadInstance.id}" checked="false" /></td>

                            <td><a action="show" style="text-decoration: underline;" href="/crm/actividad/show/${actividadInstance.id}?identidad=${xidentidad}&entidad=${xentidad}&idcon=${xidcontacto}&idemp=${xidempresa}">
                                    ${fieldValue(bean: actividadInstance, field: "descActividad")}
                                </a></td>

                            <td>${crm.Empleado.get(actividadInstance?.idResponsable)} </td>

                            <td>${Persona.get(actividadInstance?.idContacto)}</td>

                            <td><g:formatDate format="dd-MM-yyyy hh:mm" date="${actividadInstance?.fechaFinal}" /></td>

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
