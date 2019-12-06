
<%@ page import="crm.ReqLotusSw" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="seguridadService" bean="seguridadService" />
<%
   def mover=generalService.getMenuV(1)
   def mout=generalService.getMenuV(2)
   def estilo=generalService.getMenuV(3)
%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'linea.label', default: 'Linea')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <% def sw_crud=[1,1,1,1,0,1] %>

        <div id="list-linea" class="content scaffold-list" role="main">

            <h2>${xtitulo}</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">                                               


            <div class="row-fluid sortable">
			<g:form controller="linea" >
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
                   <%  def swacc=0 %>
                    <ul class="dropdown-menu">
                        <g:if test="${sw_crud[4]==1}">
                            <li><a href="${createLink(action:'eliminar')}" >Eliminar</a></li>
                            </g:if>
                            <g:if test="${'BORRAR' in session['operaciones']}">
                                  <%  swacc=1 %>                            
                            <li> <g:actionSubmit      
	                                onMouseOver="${mover}" 
                                    onMouseOut="${mout}" 
                                    style="${estilo}"                                   
                                    value="Borrar" 
                                    action="borrar"  />
                            </li>
                            <li><a href="${createLink(action:'listarBorrados')}" >Ver Borrados</a></li>
                            </g:if>
                            <g:if test="${swacc==0}" >
                            <li align="center">Ninguna </li>
                           </g:if>
                    </ul>
                </div>
                <a class="btn btn-mini" href="/crm/linea/index"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                
                <br><br>
                <g:render template="/general/mensajes" />
               <g:set var="beanInstance"  value="${lineaInstance}" />                
               
            
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <td style="width:18px"> </td>
                            <g:sortableColumn property="descLinea" title="${message(code: 'linea.descLinea.label', default: 'Descripción')}" />

                            <g:sortableColumn property="observLinea" title="${message(code: 'linea.observLinea.label', default: 'Observaciones')}" />

                            <g:sortableColumn property="idEstadoLinea" title="${message(code: 'linea.idEstadoLinea.label', default: 'Estado')}" />


                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${lineaInstanceList}" status="i" var="lineaInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td><g:checkBox name="lineas" value="${lineaInstance.id}" checked="false" /></td>
                                <td><g:link action="show" style="text-decoration:underline"
                                    id="${lineaInstance.id}">${fieldValue(bean: lineaInstance, field: "descLinea")}</g:link></td>

                                <td>${fieldValue(bean: lineaInstance, field: "observLinea")}</td>

                                <td>${generalService.getValorParametro(lineaInstance?.idEstadoLinea)}</td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <div class="pagination_crm">
                    <g:paginate total="${lineaInstanceCount ?: 0}" />
                </div>
                </g:form>
            </div>
        </div>


    </body>
</html>
