<%@ page import="crm.Empleado" %>
<g:set var="generalService" bean="generalService" />

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'empleado.label', default: 'Empleado')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
</head>
<body >
    <div id="detalleconten">
        <% def sw_crud=[1,1,1,1,0,1] %>


        <h2>${xtitulo}</h2>
        <hr style="margin-top:10px;margin-bottom: 10px;" />					
        <filterpane:filterPane domain="Empleado" 
        formName="frmFiltro"
        action="index"
        showTitle="no"
        dialog="true"
        filterProperties="${['identificacion','primerNombre','primerApellido','segundoApellido','cargo']}"                                    
        showSortPanel="false"
        fullAssociationPathFieldNames="false"
        />
        <div class="row-fluid sortable">

            <div class="pull-left">
                <div class="pull-left">
                    <g:if test="${sw_crud[0]==1}">

                        <a href="/crm/empleado/create/" class="btn btn-mini btn-primary">
                            <i class="icon-plus icon-white"></i>
                            <strong>Nuevo</strong>
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
                   <!-- inicio filter  buttons -->                           
            <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>
            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
            <!-- fin filter  buttons  -->
            <button type="reset" class="btn btn-mini" onclick="history.go(-1)"><i class="icon-remove"></i>&nbsp;Cancelar</button>


            <table class="table table-bordered">
                <thead>
                    <tr>
                        <td style="width:18px"> </td>

                        <g:sortableColumn property="identificacion" title="${message(code: 'empleado.identificacion.label', default: 'Identificación')}" params="${filterParams}" />					

                        <g:sortableColumn property="primerNombre" title="${message(code: 'empleado.primerNombre.label', default: 'Nombre')}" params="${filterParams}" />					
                        
                        <g:sortableColumn property="cargo" title="${message(code: 'empleado.cargo.label', default: 'Cargo')}" params="${filterParams}" />

                        <g:sortableColumn property="celularPrincipal" title="${message(code: 'empleado.celularPrincipal.label', default: 'Celular Principal')}" params="${filterParams}" />

                        <g:sortableColumn property="telefonoFijo" title="${message(code: 'empleado.segundoApellido.label', default: 'Teléfono Fijo')}" params="${filterParams}" />

                    </tr>
                </thead>
                <tbody>
                    <g:each in="${empleadoInstanceList}" status="i" var="empleadoInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td><g:checkBox name="empleados" value="${empleadoInstance.id}" checked="false" /></td>

                            <td><a style="text-decoration:underline" href="/crm/empleado/show/${empleadoInstance.id}">${fieldValue(bean: empleadoInstance, field: "identificacion")}</a></td>
                            <td>${empleadoInstance?.nombreCompleto()}</td>		                          											
                            <td>${fieldValue(bean: empleadoInstance, field: "cargo")}</td>                                                
                            <td>${fieldValue(bean: empleadoInstance, field: "celularPrincipal")}</td>
                            <td>${fieldValue(bean: empleadoInstance, field: "telefonoFijo")}</td>                                            

                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination_crm">            
                <filterpane:paginate total="${empleadoInstanceCount ?: 0}" domainBean="Empleado"/>

            </div>
        </div>                   
    </div>                   
</body>
</html>
