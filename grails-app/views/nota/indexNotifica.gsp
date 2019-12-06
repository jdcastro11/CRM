<%@ page import="crm.Nota" %>
<g:set var="generalService" bean="generalService" />
<g:set var="seguridadService" bean="seguridadService" />
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'nota.label', default: 'Nota')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <% def sw_crud=[1,1,1,1,0,0] %>
        <div id="detalleconten">
            <h2>${xtitulo}</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">
            <div class="row-fluid sortable"> 
                <g:if test="${xsololec=='N'}" >
                    <div class="pull-left">
                        <div class="pull-left">
                            <g:if test="${'CREAR' in seguridadService.operacionesPorOpcion(session['idUsuario'],'/nota/index')}">

                                <a class="btn btn-mini btn-primary" href="/crm/nota/create/?ident=${xidentidad}&entidad=${xentidad}&tnota=${xtiponota}">
                                    <i class="icon-plus icon-white"></i>
                                    <strong> Nuevo</strong>
                                </a>

                            </g:if>
                        </div>
                    </div>
                    &nbsp;
                    <div class="btn-group">

                        <a href="#" class="btn btn-mini" >Acciones</a>
                        <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                       <%  def swacc=0 %>
                        <ul class="dropdown-menu">
                            <g:if test="${sw_crud[4]==1}">
                                <li><a href="" >Eliminar</a></li>
                                </g:if>
                                <g:if test="${'BORRAR' in session['operaciones']}">
                                 <%  swacc=1 %>
                                <li><a href="/crm/nota/listarBorrados/${xidentidad}?entidad=${xentidad}" >Ver Borrados</a></li>
                                </g:if>
                                <g:if test="${swacc==0}" >
                                  <li align="center">Ninguna </li>
                               </g:if>
                        </ul>
                    </div>
                    &nbsp;<a  class="btn btn-mini" href="/crm/nota/index/${xidentidad}?entidad=${xentidad}&tnota=${xtiponota}&zw=1">
                     <i class="icon-remove"></i>&nbsp;Cancelar</a>
                </g:if>   
                <div id="list-nota" class="content scaffold-list" role="main">

                    <g:if test="${flash.message}">
                        <div class="alert alert-info" role="status">${flash.message}</div>
                    </g:if>
                    <table class="table table-bordered">
                        <thead>
                            <tr>

                                <td style="width:18px"> </td>

                                <g:sortableColumn style="width:8%" class="span2" property="fecha" title="${message(code: 'nota.fechaCreacion.label', default: 'Fecha')}" />
                                
                                <g:sortableColumn style="width:10%"  class="span2" property="Autor" title="${message(code: 'nota.idAutor.label', default: 'Autor')}" />
                               
                                <g:sortableColumn style="width:12%" class="span2" property="idTipoNota" title="${message(code: 'nota.tipo.label', default: 'Tipo')}" />
                                
                                <g:sortableColumn class="span4" property="nota" title="${message(code: 'nota.nombreArchivo.label', default: 'Comentario')}" />

                                 <g:sortableColumn style="width:20%" class="span4" property="nota" title="${message(code: 'nota.funcionariosNotificados.label', default: 'Notificados')}" />
                          

                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${notaInstanceList}" status="i" var="notaInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td><g:checkBox name="notas" value="${notaInstance?.id}" checked="false" /></td>
                                 <g:if test="${xsololec=='N'}" >   
                                    <td><a action="show" style="text-decoration:underline" id="${notaInstance.id}" href="/crm/nota/show/${notaInstance?.id}?ident=${xidentidad}&entidad=${xentidad}&tnota=${xtiponota}">
                                            ${g.formatDate(format:'dd-MM-yyyy',date:notaInstance?.fecha)}
                                        </a></td>                            
                                  </g:if>
                                  <g:else>
                                      <td>${g.formatDate(format:'dd-MM-yyyy',date:notaInstance?.fecha)}</td>
                                  </g:else>  
                                    <td>${crm.Empleado.get(notaInstance?.idAutor)}</td>
                                    
                                    <td>${generalService.getValorParametro(notaInstance?.idTipoNota)}</td>
                                    <td>${fieldValue(bean: notaInstance, field: "nota")}</td>
                                    <% def xnotificados =notaInstance.funcionariosNotificados.replace('@redsis.com','') %>
                                    <td>${xnotificados}</td>                                

                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                     <% def xparam=[entidad:xentidad] %>
                    <div class="pagination_crm">
                        <g:paginate id="${xidentidad}" params="${xparam}" total="${notaInstanceCount ?: 0}" />
                    </div>
                </div>
            </div>
        </div>
        <script>
            var contenido= $("#detalleconten");
            if (parent.IFRAME_DETALLE !=null) parent.IFRAME_DETALLE.height(contenido.height()+60);
            if (parent.IFRAME_DETALLE2 !=null) parent.IFRAME_DETALLE2.height(contenido.height()+60);
        </script>
    </body>
</html>
