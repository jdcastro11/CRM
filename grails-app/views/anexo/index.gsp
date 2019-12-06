<%@ page import="crm.Anexo" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="seguridadService" bean="seguridadService" />
<g:set var="pedidoService" bean="pedidoService" />
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'anexo.label', default: 'Anexo')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <% def sw_crud=[1,1,1,1,0,0] %>
        <div id="detalleconten">

            <h2>${xtitulo}</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">
            <div class="row-fluid sortable"> 
                <% 
                Long  xidpedido       
                if (xentidad=='pedido') xidpedido=xidentidad.toLong()           
                else xidpedido=0                            
                %>
             
                    <div class="pull-left">
                        <div class="pull-left">
                            <g:if test="${'CREAR' in seguridadService.operacionesPorOpcion(session['idUsuario'],'/anexo/index')}">
                                <g:if test="${params.pf !='1'}" >
                                    <a class="btn btn-mini btn-primary" href="/crm/anexo/create/?ident=${xidentidad}&entidad=${xentidad}&anex=${params.anex}">
                                        <i class="icon-plus icon-white"></i>
                                        <strong><g:message code="default.new.label"/></strong>
                                    </a>
                                </g:if>
                            </g:if>
                        </div>
                    </div>
                    &nbsp;
                <g:if test="${pedidoService.accesoPedido(xidpedido,session['idUsuario'],'anexo')}"> 
                    <%  def swacc=0 %>
                    <div class="btn-group">

                        <a href="#" class="btn btn-mini" ><g:message code="acciones.label"/></a>
                        <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                        <ul class="dropdown-menu">
                           
                                <g:if test="${'BORRAR' in session['operaciones']}">
                                  <%  swacc=1 %>
                                <li><a href="/crm/anexo/listarBorrados/${xidentidad}?entidad=${xentidad}" ><g:message code="borrados.template.label" default="Ver Borrados"/> </a></li>
                                </g:if>
                                <g:if test="${swacc==0}" >
                                <li align="center">Ninguna </li>
                               </g:if>
                        </ul>
                    </div>
                </g:if>
                &nbsp;  <a  class="btn btn-mini" href="/crm/anexo/index/${xidentidad}?entidad=${xentidad}">
                    <i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>&nbsp;
                    <g:set var="beanInstance"  value="${anexoInstance}" />                
                    <g:render template="/general/mensajes" />
                <div id="list-anexo" class="content scaffold-list" role="main">

                    <table class="table table-bordered">
                        <thead>
                            <tr>

                                <td style="width:14px"> </td>

                                <td><b><g:message code="anexo.idTipoAnexo.label" default="Tipo Anexo"/></b></td>

                                <td><b><g:message code="anexo.nombreArchivo.label" default="Nombre Archivo"/></b></td>

                                <td><b><g:message code="anexo.fechaCreacion.label" default="Fecha"/></b></td>

                                <td><b><g:message code="anexo.link.label" default="Enlace"/></b></td>
                                    
                                <td><b><g:message code="anexo.comentarios.label" default="Comentarios"/></b></td>

                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${anexoInstanceList}" status="i" var="anexoInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td><g:checkBox name="anexos" value="${anexoInstance?.id}" checked="false" /></td>


                                    <td><a action="show" style="text-decoration:underline" id="${anexoInstance.id}" href="/crm/anexo/show/${anexoInstance?.id}?ident=${xidentidad}&entidad=${xentidad}">
                                            ${generalService.getValorParametro(anexoInstance?.idTipoAnexo)}</a></td>                            
                                    <td>${fieldValue(bean: anexoInstance, field: "nombreArchivo")}</td>
                                    
                                    <td><g:formatDate format="dd-MM-yyyy" date="${anexoInstance?.fechaCreacion}" /></td>

                                    <g:set var="xruta" value="${generalService.getValorParametro('ruta00')}${anexoInstance.nombreArchivo}" />

                                    <td><g:if test="${anexoInstance?.nombreArchivo !=null}">
                                            <a class="btn btn-mini" href="${xruta}" target="_blank"><g:message code="verAnexo.label" default="Ver Archivo"/></a>
                                        </g:if>
                                    </td>

                                    <td>${fieldValue(bean: anexoInstance, field: "comentarios")}</td>

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
            /*if (parent.IFRAME_DETALLE1 !=null) parent.IFRAME_DETALLE1.height(contenido.height()+60);*/
            if (parent.IFRAME_ANEXO !=null) parent.IFRAME_ANEXO.height(contenido.height()+20); 
        </script>
    </body>
</html>
