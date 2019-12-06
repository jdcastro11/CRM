<%@ page import="crm.Parametro"
import="crm.ValorParametro"     
%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'parametro.label', default: 'Parametro')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title> 
        <r:require module="filterpane" />
    </head>
    <body>
        <% def sw_crud=[1,1,1,1,0,1] %>


        <h2>Lista de Parámetros</h2>
        <hr style="margin-top:10px;margin-bottom:10px;">                                               
            <filterpane:filterPane domain="Parametro" 
            formName="frmFiltro"
            action="filter"
            showTitle="no"
            dialog="true"
            filterProperties="${['descripcion', 'idParametro']}"
            showSortPanel="true"
            fullAssociationPathFieldNames="false"
             />
        <div class="row-fluid sortable">


           
                <div class="pull-left">
                    <div class="pull-left">
                     <g:if test="${'CREAR' in session['operaciones']}">

                            <a class="btn btn-mini btn-primary" href="${createLink(action:'create')}">
                                <i class="icon-plus icon-white"></i>
                                <strong>&nbsp;Nuevo</strong>
                            </a>

                        </g:if>  
                    </div>
                </div>
                &nbsp;
                <div class="btn-group">

                     <a href="#" class="btn btn-mini" >Acciones</a>
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                     <%  swacc=0 %>
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
             
               <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro" />
              
               <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
               <!-- fin filter  buttons  -->
             <a  class="btn btn-mini" href="/crm/parametro/index"><i class="icon-remove"></i>&nbsp;Cancelar</a>

    <!-- Fin operaciones de la Opcion) -->
            <table class="table table-bordered">
                <thead>
                    <tr>

                        <td style="width:18px"> </td>
                        <g:sortableColumn property="idParametro" title="${message(code: 'parametro.idParametro.label', default: 'Código')}"  params="${filterParams}" />

                        <g:sortableColumn property="descripcion" title="${message(code: 'parametro.descripcion.label', default: 'Descripción')}"  params="${filterParams}"  params="${filterParams}" />

                        <g:sortableColumn property="tipoParametro" title="${message(code: 'parametro.tipoParametro.label', default: 'Tipo')}"  style="text-align:center"  params="${filterParams}" />

                        <g:sortableColumn property="estadoParametro" title="${message(code: 'parametro.estadoParametro.label', default: 'Estado')}" style="text-align:center"  params="${filterParams}"/>                        			
                    </tr>
                </thead>
                <tbody>

                    <g:each in="${parametroInstanceList}" status="i" var="parametroInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:checkBox name="parametros" value="${parametroInstance.id}" checked="false" /></td>	
                            <g:if test="${sw_crud[2]==1}">
                                <td><a href="/crm/parametro/show/${parametroInstance.id}?sw=0" style="text-decoration:underline">
                                        ${fieldValue(bean: parametroInstance, field: "idParametro")}</a></td>
                                    </g:if>
                                    <g:else>
                                <td>${fieldValue(bean: parametroInstance, field: "idParametro")}</td>
                            </g:else>

                            <td>${fieldValue(bean: parametroInstance, field: "descripcion")}</td>

                            <g:if test="${parametroInstance.tipoParametro=='U'}" >
                                <td><center>Usuario</center></td>
                            </g:if>
                            <g:else>
                        <td><center>Sistema</center></td>
                        </g:else>

                        <g:if test="${parametroInstance.estadoParametro=='A'}" >
                        <td><center>Activo</center></td>
                        </g:if>
                        <g:else>
                        <td><center>Inactivo</center></td>
                        </g:else>
          
                    </tr>
                </g:each>

                </tbody>
            </table>
            <g:if test="${parametroInstanceCount>itemxview}" >
                <div class="pagination_crm">                
                <filterpane:paginate total="${parametroInstanceCount ?: 0}" domainBean="Parametro"/>
                </div>
            </g:if>
        </div>

        <iframe id="ifvalp" src="${xurl}" style="border:0;overflow:hidden;width:100%;height:0px" ></iframe>

    </body>
</html>
