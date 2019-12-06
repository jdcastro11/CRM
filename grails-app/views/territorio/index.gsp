<%@ page import="crm.Territorio" %>
<g:set var="generalService" bean="generalService" />

<!DOCTYPE html>
<html>
    <head>
        <g:if test="${params.layout=='detail'}" >
            <g:set var="xlayout" value="detalle"  />
        </g:if>
        <g:else>
            <g:set var="xlayout" value="perfectum"  />
        </g:else>
        <meta name="layout" content="${xlayout}">
        <g:set var="entityName" value="${message(code: 'territorio.label', default: 'Territorio')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <% def sw_crud=[1,1,1,1,0,0]  %>

        <h2>${xtitulo}</h2>
        <hr style="margin-top:10px;margin-bottom:10px" />
        <div id="list-territorio" class="content scaffold-list" role="main">


            <div class="pull-left">
                <g:if test="${'CREAR' in session['operaciones']}">

                    <a class="btn btn-mini btn-primary" href="/crm/territorio/create/?layout=main">
                        <i class="icon-plus icon-white"></i>
                        <strong>Nuevo</strong>
                    </a>

                </g:if>  
            </div>
            &nbsp;
            <div class="btn-group">
                 <a href="#" class="btn btn-mini" >Acciones</a>
                <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
               
                <%  def swacc=0 %>
                <ul class="dropdown-menu">
                 <g:if test="${'BORRAR' in session['operaciones']}">
                       <%  swacc=1 %>
                           <li><a href="/crm/territorio/listarBorrados/" >Ver Borrados</a></li>  
                  </g:if>
                  <g:if test="${swacc==0}" >
                    <li align="center">Ninguna </li>
                  </g:if>
                </ul>				
            </div>
             
            &nbsp;<a  class="btn btn-mini"  href="/crm/territorio/index/${territorioInstance?.padre?.id}?layout=${params.layout}" ><i class="icon-remove" ></i>&nbsp;Cancelar</a>

            <g:set var="beanInstance"  value="${territorioInstance}" />                
            <g:render template="/general/mensajes" />

            <div class="row-fluid sortable">
                <table class="table table-bordered">
                    <thead>
                        <tr>

                            <g:sortableColumn property="nombreTerritorio" title="${message(code: 'territorio.nombreTerritorio.label', default: 'Nombre Territorio')}" />

                            <g:sortableColumn property="codigoTerritorio" title="${message(code: 'territorio.codigoTerritorio.label', default: 'Codigo Territorio')}" />

                            <g:sortableColumn property="idTipoTerritorio" title="${message(code: 'territorio.idTipoTerritorio.label', default: 'Tipo Territorio')}" />

                            <g:sortableColumn property="estadoTerritorio" title="${message(code: 'territorio.estadoTerritorio.label', default: 'Estado Territorio')}" />							

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${territorioInstanceList}" status="i" var="territorioInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td><a style="text-decoration:underline" href="/crm/territorio/show/${territorioInstance.id}?layout=main">
                                        ${fieldValue(bean: territorioInstance, field: "nombreTerritorio")}</a></td>

                                <td>${fieldValue(bean: territorioInstance, field: "codigoTerritorio")}</td>

                                <td>${generalService.getValorParametro(territorioInstance?.idTipoTerritorio)}</td>

                                <td>${fieldValue(bean: territorioInstance, field: "estadoTerritorio")}</td>								

                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <div class="pagination_crm">
                    <g:paginate   total="${territorioInstanceCount ?: 0}" />
                </div>
            </div>
        </div>
    </body>
</html>
