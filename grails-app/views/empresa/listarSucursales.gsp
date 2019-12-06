
<%@ page import="crm.Empresa" %>
<%@ page import="crm.Territorio" %>
<!DOCTYPE html>
<html>
    <head>     
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'empresa.label', default: 'Empresa')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
%{--Use generalService--}%
        <g:set var="generalService" bean="generalService"/>
        <% def sw_crud=[1,1,1,1,0,0] %>
        <div id="detalleconten1">
            <div id="list-empresa" class="content scaffold-list" role="main">

              <%--  <g:set var="xtitulo" value="${generalService.getValorParametro(params.t)}" /> --%>
                <h2>${xtitulo}</h2>
                <hr style="margin-top:10px; margin-bottom:10px;"/>


                <div class="row-fluid sortable">

                   
                        <div class="pull-left">
                            <div class="pull-left">
                                <g:if test="${'CREAR' in session['operaciones']}">

                                    <a class="btn btn-mini btn-primary" href="/crm/empresa/create/${xidPadre}?tipo=4&layout=${params.layout}&t=sedest01&swmodal=">
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
                                    <li><a href="${createLink(action:'eliminar')}" >Eliminar</a></li>
                                    </g:if>
                                  <g:if test="${'BORRAR' in session['operaciones']}">
                                     <%  swacc=1 %>
                                    <li><a href="${createLink(action:'listarBorrados')}" >Ver Borrados</a></li>
                                </g:if>
                                <g:if test="${swacc==0}" >
                                     <li align="center">Ninguna </li>
                               </g:if>
                            </ul>
                        </div>
                 
                    <button type="reset" class="btn btn-mini" onclick="history.go(-1)"><i class="icon-remove"></i>&nbsp;Cancelar</button>

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

                                    <td> <a style="text-decoration:underline" href="/crm/empresa/show/${empresaInstance.id}?layout=main&t=empresat08&tipo=4">
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
