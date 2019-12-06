<%@ page import="crm.Tactica" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'tactica.label', default: 'Tactica')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
      
    <body>
         <g:set var="seguridadService" bean="seguridadService" />
             <%
                def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/tactica/index') 
               
              %>
        <g:set var="generalService" bean="generalService" />
         <h3>Lista de Tácticas de Mercadeo archivadas</h3>                  
         <hr style="margin-top:10px;margin-bottom:10px;">
          <div class="row-fluid sortable">
             <div class="pull-left">
                    <div class="pull-left">
                        <g:if test="${'CREAR' in derechos}">
                            <a class="btn btn-mini btn-primary" href="/crm/tactica/create/${params.id}">
                                <i class="icon-plus icon-white"></i>
                                <strong>&nbsp;Nuevo</strong>
                            </a>
                        </g:if>
                    </div>
                </div>
                &nbsp;
                <div class="btn-group">

                     <a href="#" class="btn btn-mini">Acciones</a>
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                   <%  def swacc=0 %>
                    <ul class="dropdown-menu">                       
                            <g:if test="${'BORRAR' in derechos}">
                                  <%  swacc=1 %>
                            <li><a href="${createLink(action:'listarBorrados')}" >Ver Borrados</a></li>
                            </g:if>
                         <g:if test="${swacc==0}" >
                         <li align="center">Ninguna </li>
                       </g:if>
                    </ul>
                </div>
                &nbsp;
                <a class="btn btn-mini" href="/crm/tactica/index/${session.estrategia_id}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                <br><br>
                
               <g:set var="beanInstance"  value="${lineaInstance}" />                
               <g:render template="/general/mensajes" />
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <td style="width:18px"></td>
                        <g:sortableColumn property="idEstrategia" title="${message(code: 'tactica.idEstrategia.label', default: 'Id.')}" style="width:5%" />
                        <g:sortableColumn property="tactica" title="${message(code: 'tactica.tactica.label', default: 'Táctica')}" />

                    </tr>
                </thead>
                <tbody>
                    <g:each in="${tacticaInstanceList}" status="i" var="tacticaInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td><g:checkBox name="tacticas" value="${tacticaInstance.id}" checked="false" /></td>
                            <td>${tacticaInstance.id}</td>
                            
                            <td><g:link action="show" style="text-decoration:underline" id="${tacticaInstance.id}"> 
                                ${fieldValue(bean: tacticaInstance, field: "tactica")}</g:link></td>                          

                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination_crm">
                <g:paginate total="${tacticaInstanceCount?: 0}" id="${params.id}" />
            </div>
        </div>
       
    </body>
</html>
