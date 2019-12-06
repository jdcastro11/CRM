
<%@ page import="crm.Sublinea" %>
<%@ page import="crm.Linea" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'sublinea.label', default: 'Sublinea')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    
    <body>
        <% def sw_crud=[1,1,1,1,0,0]
		def estilo=generalService.getMenuV(3)
		def mover=generalService.getMenuV(1)
   		def mout=generalService.getMenuV(2) %>
        
        <div id="boxSublin">
            <div id="list-sublinea" class="content scaffold-list" role="main">
			
                <h2>${xtitulo}</h2>                
                <hr style="margin-top:10px;margin-bottom:10px;"> 

 <!-- <div class="row-fluid sortable"> -->
 
			<g:form controller="sublinea" >
				<g:hiddenField name="idLinea" value="${params.id}" />			
                <div class="pull-left">
                    <div class="pull-left">

                        <g:if test="${'CREAR' in session['operaciones']}">

                            <a class="btn btn-mini btn-primary" href="/crm/sublinea/create/${params.id}">
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
                    <ul class="dropdown-menu">
                        <%  def swacc=0 %>
                        <g:if test="${sw_crud[4]==1}">
                            <li><a href="${createLink(action:'eliminar')}" >Eliminar</a></li>
                            </g:if>
                            
                            
                            
                            
                            <g:if test="${'BORRAR' in session['operaciones']}">
                             <%  swacc=1 %>
	                            <!-- <li><a href="${createLink(action:'borrar')}" >Borrar</a></li> -->
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

                <a class="btn btn-mini" href="/crm/sublinea/index/${params.id}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                <g:render template="/general/mensajes" />                
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <td style="width:18px"> </td>

                            <g:sortableColumn property="descSublinea" title="${message(code: 'sublinea.descSublinea.label', default: 'Sub Linea')}" />                 

                            <g:sortableColumn property="observSublinea" title="${message(code: 'sublinea.observSublinea.label', default: 'Observaciones')}" />

                            <g:sortableColumn property="idEstadoSublinea" title="${message(code: 'sublinea.idEstadoSublinea.label', default: 'Estado')}" />

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${sublineaInstanceList}" status="i" var="sublineaInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td><g:checkBox name="sublineas" value="${sublineaInstance.id}" checked="false" /></td>
                                <td><g:link action="show" style="text-decoration:underline" 
                                    id="${sublineaInstance.id}">${fieldValue(bean: sublineaInstance, field: "descSublinea")}</g:link></td>

                                <td>${fieldValue(bean: sublineaInstance, field: "observSublinea")}</td>

                                <td>${generalService.getValorParametro(sublineaInstance?.idEstadoSublinea)}</td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <div class="pagination_crm">
                    <g:paginate id="${params.id}" total="${sublineaInstanceCount ?: 0}" />
                </div>
                </g:form>
            </div>
        </div>
        <script>
            var contenido= $("#boxSublin");

            if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+60);

        </script>

    </body>
</html>
