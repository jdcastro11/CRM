
<%@ page import="crm.Faq" %>
<!DOCTYPE html>
<g:set var="generalService" bean="generalService" />
     <g:set var="seguridadService" bean="seguridadService" />
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'faq.label', default: 'Faq')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
         <% def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/faq/indexn') %>
	<body>
            
		  <div class="pull-left">
                    <div class="pull-left">
                        <g:if test="${'CREAR' in derechos}">

                            <a class="btn btn-mini btn-primary" href="${createLink(action:'create')}">
                                <i class="icon-plus icon-white"></i>
                                <strong>&nbsp;Nuevo</strong>
                            </a>
                        </g:if>
                    </div>
                </div>
                &nbsp;		
		<div id="list-faq" class="content scaffold-list" role="main">
			<h1>Lista de Preguntas Frecuentes</h1>			
			<table class="table table-bordered">
			<thead>
					<tr>
					       
						<g:sortableColumn property="id" style="width:4%" title="${message(code: 'faq.pregunta.label', default: 'Id.')}" />
					
						<g:sortableColumn property="idTipo" style="width:10%" title="${message(code: 'faq.idTipo.label', default: 'Tipo')}" />
                                                <g:sortableColumn property="orden" style="width:4%" title="${message(code: 'faq.orden.label', default: 'Orden')}" />
					
						<g:sortableColumn property="pregunta" title="${message(code: 'faq.pregunta.label', default: 'Pregunta')}" />
					
						<g:sortableColumn style="width:5%" property="estadoFaq" title="${message(code: 'faq.estadoFaq.label', default: 'Estado')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${faqInstanceList}" status="i" var="faqInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link style="text-decoration:underline" action="show" id="${faqInstance.id}">${fieldValue(bean: faqInstance, field: "id")}</g:link></td>					                                                
                                                <td>${generalService.getValorParametro(faqInstance?.idTipo)}</td>
                                                <td>${faqInstance?.orden}</td>
                                                <td>${fieldValue(bean: faqInstance, field: "pregunta")}</td>					
						<td>${fieldValue(bean: faqInstance, field: "estadoFaq")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${faqInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
