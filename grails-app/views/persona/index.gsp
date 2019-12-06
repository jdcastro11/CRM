<%@ page import="crm.Persona" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'persona.label', default: 'Persona')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <r:require module="filterpane" />
    </head>
    <body >
        <div id="detalleconten">
            <% def sw_crud=[1,1,1,1,0,1] %>
           <h2>${xtitulo}</h2>
            <hr style="width:80%; margin-top:10px;margin-bottom:10px;">  
     
          <% 
            if (!xaccion)  xaccion="index"
          %>  
        
        <filterpane:filterPane domain="Persona" 
        formName="frmFiltro"
        action="${xaccion}"
        showTitle="no"
        dialog="true"
        filterProperties="${['primerApellido','segundoApellido','primerNombre','segundoNombre','cargo']}"      
        showSortPanel="false"
        fullAssociationPathFieldNames="false"
        />
            <div class="pull-left">
                <div class="pull-left">
                    <g:if test="${'CREAR' in session['operaciones']}">

                         <a class="btn btn-mini btn-primary" href="/crm/persona/create/?pw=1">
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
                        <li><a href="${createLink(action:'listarBorrados')}" ><g:message code="borrados.label"/></a></li> 
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
       <a  class="btn btn-mini" href="/crm/persona/index/?sort=primerNombre"><i class="icon-remove"></i>&nbsp;Cancelar</a>
             <g:set var="beanInstance"  value="${personanstance}" />                
             <g:render template="/general/mensajes" />
             
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <td style="width:18px"> </td>

                        <g:sortableColumn property="primerNombre" title="${message(code: 'persona.primerNombre.label', default: 'Primer Nombre')}" params="${filterParams}" />					

                        <g:sortableColumn property="primerApellido" title="${message(code: 'persona.primerApellido.label', default: 'Primer Apellido')}"  params="${filterParams}"  />

                        <g:sortableColumn property="segundoApellido" title="${message(code: 'persona.segundoApellido.label', default: 'Segundo Apellido')}"  params="${filterParams}"  />

                        <td>Celular Principal </td>

                        <td>Telefono Fijo</td>
                       
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${personaInstanceList}" status="i" var="personaInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td><g:checkBox name="personas" value="${personaInstance.id}" checked="false" /></td>

                            <td><g:link style="text-decoration:underline"  action="show"  params="[pw:1,layout:'main']"  id="${personaInstance.id}">${fieldValue(bean: personaInstance, field: "primerNombre")}</g:link></td>

                            <td>${fieldValue(bean: personaInstance, field: "primerApellido")}</td>					
                            <td>${fieldValue(bean: personaInstance, field: "segundoApellido")}</td>
                            <td>${fieldValue(bean: personaInstance, field: "celularPrincipal")}</td>
                            <td>${fieldValue(bean: personaInstance, field: "telefonoFijo")}</td>                                                
                        

                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination_crm">
                <filterpane:paginate total="${personaInstanceCount ?: 0}" domainBean="Persona"/>
            </div>
        </div>                   
    </body>
</html>
