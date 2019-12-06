
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
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'estrategia.label', default: 'Estrategia')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <% def sw_crud=[1,1,1,1,0,1] %>
<g:form controller="estrategia"> 
        <div id="list-estrategia" class="content scaffold-list" role="main">

            <h2>Lista de Estrategias de Mercadeo</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">                                               

           
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
                   <%  def swacc=0 %>
                    <ul class="dropdown-menu">

                        


                        <g:if test="${'BORRAR' in session['operaciones']}">
                             <%  swacc=1 %>
                            <li><g:actionSubmit  
                                    onMouseOver="${mover}" 
                                    onMouseOut="${mout}" 
                                    style="${estilo}"  
                                    value="Eliminar" 
                                    onclick="return confirm('Seguro que desea eliminar?')"
                                    action="eliminarDatos" />
                            </li>
                            
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
                <a class="btn btn-mini" href="/crm/estrategia/index"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                <br><br>
                
               <g:set var="beanInstance"  value="${estrategiaInstance}" />                
               <g:render template="/general/mensajes" />
            
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <td style="width:18px"> </td>
                            <g:sortableColumn property="descripcion" title="${message(code: 'estrategia.descripcion.label', default: 'Descripción')}" />

                            <g:sortableColumn property="idEstadoEstrategia" title="${message(code: 'estrategia.idEstadoEstrategia.label', default: 'Estado')}" />


                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${estrategiaInstanceList}" status="i" var="estrategiaInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                               <td><g:checkBox name="estrategias" value="${estrategiaInstance.id}" checked="false" /></td>
                                <td><g:link action="show" style="text-decoration:underline"
                                    id="${estrategiaInstance.id}">${fieldValue(bean: estrategiaInstance, field: "descripcion")}</g:link></td>

                               <td>${generalService.getValorParametro(estrategiaInstance?.idEstadoEstrategia)}</td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <div class="pagination_crm">
                    <g:paginate total="${estrategiaInstanceCount ?: 0}" />
                </div>
            </div>
        </div>
	</g:form>	
    </body>
</html>
