
<%@ page import="crm.Producto" %>
<%@ page import="crm.Linea" %>
<%@ page import="crm.Sublinea" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'producto.label', default: 'Producto')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <r:require module="filterpane" />
    </head>
    <body>
%{--Use generalService--}%
        <g:set var="generalService" bean="generalService" />
        <% def sw_crud=[1,1,1,1,0,0]  %>

        <h2>${xtitulo}</h2>
        <hr style="margin-top:10px;margin-bottom:10px;">  

        <filterpane:filterPane domain="Producto" 
        formName="frmFiltro"
        action="index"
        showTitle="no"
        dialog="true"
        filterProperties="${['descProducto','refProducto', 'linea','sublinea']}"                             
        associatedProperties="linea.descLinea,sublinea.descSublinea"       
        showSortPanel="true"
        fullAssociationPathFieldNames="false"
        />
        <div class="row-fluid sortable"> 


            <div class="pull-left">
                <div class="pull-left">
                    <g:if test="${'CREAR' in session['operaciones']}">
                        <a class="btn btn-mini btn-primary" href="${createLink(action:'create')}">
                            <i class="icon-plus icon-white"></i>
                            <strong> Nuevo</strong>
                        </a>
                    </g:if>
                </div>
            </div> &nbsp;
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
                        <li><a href="/crm/producto/listarBorrados" >Ver Borrados</a></li> 
                        </g:if>
                        <g:if test="${swacc==0}" >
                            <li align="center">Ninguna </li>
                       </g:if>
                </ul>
            </div>
            <!-- inicio filter  buttons -->                           
            <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>
            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
            <!-- fin filter  buttons  -->
            <button type="reset" class="btn btn-mini" style="margin-left:3px;height:21px;" onclick="history.go(-1)"><i class="icon-remove"></i>&nbsp;Cancelar</button>
            <!-- Fin botones -->
                    <!-- Inicio de la tabla -->
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <td style="width:18px"> </td>

                        <g:sortableColumn property="descProducto" title="${message(code: 'producto.descProducto.label', default: 'Descripción')}" params="${filterParams}" />

                        <g:sortableColumn property="linea.descLinea" title="${message(code: 'producto.idLinea.label', default: 'Linea')}"  params="${filterParams}" />

                        <g:sortableColumn property="sublinea.descSublinea" title="${message(code: 'producto.idSubLinea.label', default: 'Sub Linea')}" xparams="${filterParams}" />

                        <g:sortableColumn property="refProducto" title="${message(code: 'producto.refProducto.label', default: 'Referencia')}" params="${filterParams}" />

                     
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${productoInstanceList}" status="i" var="productoInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:checkBox name="prodelegidos" value="${productoInstance.id}" checked="false" /></td>

                            <td><a  style="text-decoration:underline" href="/crm/producto/show/${productoInstance?.id}?swb=${params.swb}">
                                    ${productoInstance.descProducto}
                                </a></td>

                            <td>${productoInstance?.linea?.descLinea}</td>

                            <td>${productoInstance?.sublinea?.descSublinea}</td>

                            <td>${fieldValue(bean: productoInstance, field: "refProducto")}</td>

                           
                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination_crm">
                <filterpane:paginate total="${productoInstanceCount ?: 0}" domainBean="Producto"/>
            </div>
        </div>    
    </body>
</html>
