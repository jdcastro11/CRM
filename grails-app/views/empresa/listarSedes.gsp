
<%@ page import="crm.Empresa" %>
<%@ page import="crm.Territorio" %>
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
        <g:set var="entityName" value="${message(code: 'empresa.label', default: 'Empresa')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
%{--Use generalService--}%
        <g:set var="generalService" bean="generalService"/>
        <% def sw_crud=[1,1,1,1,0,0] %>
        <div id="detalleconten1">
            <div id="list-empresa" class="content scaffold-list" role="main">

                <g:set var="xtitulo" value="${generalService.getValorParametro(params.t)}" />
                <h2>${xtitulo}</h2>
                <hr style="margin-top:10px; margin-bottom:10px;"/>


                <div class="row-fluid sortable">

                   
                        <div class="pull-left">
                            <div class="pull-left">
                                <g:if test="${'CREAR' in session['operaciones']}">

                                    <a class="btn btn-mini btn-primary" href="/crm/empresa/create/${xidPadre}?tipo=3&layout=${params.layout}&t=sedest01&swmodal=">
                                        <i class="icon-plus icon-white"></i>
                                        <strong><g:message code="default.new.label"/></strong>
                                    </a>

                                </g:if>
                            </div>
                        </div>
                        &nbsp;
                        <div class="btn-group">

                             <a href="#" class="btn btn-mini" ><g:message code="acciones.label"/></a>
                            <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                            <ul class="dropdown-menu">
                                <g:if test="${sw_crud[4]==1}">
                                    <li><a href="${createLink(action:'eliminar')}" ><g:message code="default.button.delete.label"/></a></li>
                                    </g:if>
                                  <g:if test="${'BORRAR' in session['operaciones']}">
                                    <li><a href="/crm/empresa/listarSedesBorradas/${xidPadre}?layout=detail" ><g:message code="borrados.label"/></a></li>
                                </g:if>
                            </ul>
                        </div>
                 
                 <%--   <button type="reset" class="btn btn-mini" onclick="history.go(-1)"><i class="icon-remove"></i>&nbsp;Cancelar</button> --%>
                      <a  class="btn btn-mini" href="/crm/empresa/listarSedes/${xidPadre}?t=sedest00&layout=detail&sw=${sw}"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>
                    <g:if test="${flash.message}">
                        <div class="alert alert-info" role="status">${flash.message}</div>
                    </g:if>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <td style="width:18px"> </td>

                                <g:sortableColumn property="razonSocial" title="${message(code: 'empresa.razonSocial.label', default: 'Sede')}" />
                                
                                <g:sortableColumn property="direccion" title="${message(code: 'empresa.direccion.label', default: 'Direccion')}" />
                                
                                <g:sortableColumn property="telefonos" title="${message(code: 'empresa.telefonos.label', default: 'Telefono')}" />                          

                                <g:sortableColumn property="idDpto" title="${message(code: 'empresa.idDpto.label', default: 'Dpto')}" />

                                <g:sortableColumn property="idCiudad" title="${message(code: 'empresa.Ciudad.label', default: 'Ciudad')}" />                        
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${empresaInstanceList}" status="i" var="empresaInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td><g:checkBox name="empresas" value="${empresaInstance.id}" checked="false" /></td>

                                    <td> <a style="text-decoration:underline" href="/crm/empresa/show/${empresaInstance.id}?layout=detail&t=empresat08&tipo=3">
                                       ${fieldValue(bean: empresaInstance, field: "razonSocial")} </a>
                                    </td>
                                    <td>${fieldValue(bean: empresaInstance, field: "direccion")}</td>
                                    <td>${fieldValue(bean: empresaInstance, field: "telefonos")}</td>


                                    <td>${Territorio.get(empresaInstance.idDpto)}</td>

                                    <td>${Territorio.get(empresaInstance.idCiudad)}</td>
    
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                    <div class="pagination_crm">
                        <g:paginate total="${empresaInstanceCount ?: 0}" />
                    </div>
                </div>
            </div>
        </div>
        <script>
            <!-- resize el padre del iframe -->
            var contenido= $("#detalleconten1");
            if (parent.IFRAME_DETALLE2 !=null)parent.IFRAME_DETALLE2.height(contenido.height()+60);

        </script>
    </body>
</html>
