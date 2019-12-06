<%@ page import="crm.DefLog" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'defLog.label', default: 'DefLog')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>   
        <g:set var="generalService" bean="generalService" />
        <g:set var="seguridadService" bean="seguridadService" />
        <div id="boxdetlog" >
            <h2>${xtitulo}</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">
            <div class="pull-left">
                <div class="pull-left">
                    <g:if test="${'CREAR' in seguridadService.operacionesPorOpcion(session['idUsuario'],'/defLog/create')}">
                        <g:set var="xcampos" values="${xcampos}" scope="request" />
                        <a class="btn btn-mini btn-primary" href="/crm/defLog/create/${xentidad}">
                            <i class="icon-plus icon-white"></i>
                            <strong> Nuevo</strong>
                        </a>

                    </g:if>
                </div>
            </div>
            &nbsp;
            <%  def swacc=0 %>
            <div class="btn-group">

                <a href="#" class="btn btn-mini" >Acciones</a>
                <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                <ul class="dropdown-menu">
                    <g:if test="${'DESTRUIR' in session['operaciones']}">
                         <%  swacc=1 %>
                        <li><a href="" >Eliminar</a></li>
                        </g:if>
                        <g:if test="${'BORRAR' in session['operaciones']}">
                          <%  swacc=1 %>
                        <li><a href="/crm/defLog/listarBorrados/${xentidad}" >Ver Borrados</a></li>
                        </g:if>
                         <g:if test="${swacc==0}" >
                         <li align="center">Ninguna </li>
                        </g:if>
                </ul>
            </div>
            &nbsp;  <a  class="btn btn-mini" href="/crm/defLog/index/${xentidad}">
                <i class="icon-remove"></i>&nbsp;Cancelar</a>
                <g:set var="beanInstance"  value="${defLogInstance}" /> 
                <g:render template="/general/mensajes" />
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <td style="width:18px"> </td>
                        <g:sortableColumn property="nombreCampo" title="${message(code: 'defLog.nomEntidad.label', default: 'Nombre Campo')}" />

                        <g:sortableColumn property="campo" title="${message(code: 'defLog.campo.label', default: 'Campo')}" />

                        <g:sortableColumn property="idTipoContenido" title="${message(code: 'defLog.idTipoContenido.label', default: 'Tipo')}" />                   
                        
                        <g:sortableColumn property="idEstadoDefLog" title="${message(code: 'defLog.idEstadoDefLog.label', default: 'Estado')}" />                   

                    </tr>
                </thead>
                <tbody>
                    <g:each in="${defLogInstanceList}" status="i" var="defLogInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td><g:checkBox name="deflogs" value="${defLogInstance.id}" checked="false" /></td>

                            <td><a style="text-decoration:underline" href="/crm/defLog/show/${defLogInstance.id}">
                                ${fieldValue(bean: defLogInstance, field: "nombreCampo")}
                             </a></td>

                            <td>${fieldValue(bean: defLogInstance, field: "campo")}</td>

                            <td>${generalService.getValorParametro(defLogInstance?.idTipoContenido)}</td>
                            
                            <td>${generalService.getValorParametro(defLogInstance?.idEstadoDefLog)}</td>

                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination_crm">
                <g:paginate total="${defLogInstanceCount ?: 0}" />
            </div>
        </div>
        <script>
            var contenido= $("#boxdetlog");
            if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+100);

        </script>
    </body>
</html>
