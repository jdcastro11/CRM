<%@ page import="crm.Pieza" %>
<!DOCTYPE html>
<html>
	<head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'pieza.label', default: 'Piezas')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
         <g:set var="seguridadService" bean="seguridadService" />
             <!-- <%
               def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/tactica/index') 
               
              %> -->
        <g:set var="generalService" bean="generalService" />
         <h3>Lista de piezas</h3>                  
         <hr style="margin-top:10px;margin-bottom:10px;">
          <div class="row-fluid sortable">
             <div class="pull-left">
                    <div class="pull-left">
                        <!--<g:if test="${'CREAR' in derechos}">-->
                            <a class="btn btn-mini btn-primary" href="/crm/pieza/create/${params.id}"><!-- ACÁ FALTA EL PARAMS ID -->
                                <i class="icon-plus icon-white"></i>
                                <strong>&nbsp;Nuevo</strong>
                            </a>
                        <!-- </g:if>-->
                    </div>
                </div>
                &nbsp;
                <div class="btn-group">

                     <a href="#" class="btn btn-mini">Acciones</a>
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                    
                   <%  def swacc=0 %>                   
                    <ul class="dropdown-menu">                       
                            <!--<g:if test="${'BORRAR' in derechos}">-->
                                  <%  swacc=1 %>
                            <li><a href="${createLink(action:'listarBorrados')}" >Ver Borrados</a></li>
                            <!--</g:if>-->
                         <g:if test="${swacc==0}" >
                         <li align="center">Ninguna </li>
                       </g:if>
                    </ul>
                </div>                
                <a class="btn btn-mini" href="/crm/pieza/index/${session.tactica_id}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                <br><br>                
                <g:render template="/general/mensajes" />
               <g:set var="beanInstance"  value="${lineaInstance}" />
            <table class="table table-bordered">
                <thead>
                    <tr>
						<g:sortableColumn property="url" title="${message(code: 'pieza.url.label', default: 'Url')}" />
					
						<g:sortableColumn property="textoParaMostrar" title="${message(code: 'pieza.textoParaMostrar.label', default: 'Texto Para Mostrar')}" />
						
						<g:sortableColumn property="tactica" title="${message(code: 'pieza.tactica.label', default: 'Tactica')}" />
					
						

                    </tr>
                </thead>
                <tbody>
				<g:each in="${piezaInstanceList}" status="i" var="piezaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${piezaInstance.id}">${fieldValue(bean: piezaInstance, field: "url")}</g:link></td>
					
						<td>${fieldValue(bean: piezaInstance, field: "textoParaMostrar")}</td>
					
						<td>${fieldValue(bean: piezaInstance, field: "tactica")}</td>
					
					</tr>
				</g:each>
                </tbody>
            </table>
			<div class="pagination_crm">
				<g:paginate total="${piezaInstanceCount ?: 0}"  id="${params.id}"/>
			</div>
        </div>
       
	</body>
</html>
