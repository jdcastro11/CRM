<%@ page import="crm.Faq" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'faq.label', default: 'Faq')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
                <r:require module="filterpane" />
	</head>
	<body>
      <g:set var="generalService" bean="generalService" />
    <filterpane:filterPane domain="Faq" 
    formName="frmFiltro"
    action="indexn"
    showTitle="no"
    dialog="true"
    filterProperties="${['pregunta', 'idTipo']}"   
    filterPropertyValues="${['idTipo':[values:crm.ValorParametro.executeQuery('select valor from ValorParametro where idParametro=\'faqtipopre\'')]]}"
    showSortPanel="false"
    fullAssociationPathFieldNames="false"
    />     
        <div id="list-faq" class="content scaffold-list" role="main">
                <h1>Preguntas Frecuentes CRM </h1>
            <%-- inicio filter  buttons  --%>                         
            <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>
            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered> 
            <%-- fin filter  buttons  --%>    
        <a  class="btn btn-mini" href="/crm/faq/indexn"><i class="icon-remove"></i>&nbsp;Cancelar</a>
     <table class="table table-bordered">
                <thead>
                        <tr>
                              <td style="width:10px"></td>
                           <%--   <g:sortableColumn style="width:10px" property="orden" title="${message(code: 'faq.orden.label', default: '#')}" params="${filterParams}" />--%>
                               <g:sortableColumn style="width:5%" property="idTipo" title="${message(code: 'faq.idTipo.label', default: 'Tipo')}" params="${filterParams}" />
                                <td>Pregunta </td>
                            
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${faqInstanceList}" status="i" var="faqInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                           
                                    <td><a href="/crm/faq/help/${faqInstance.id}"><i class="icon-eye-open"></i></a></td>		
                                  <%--  <td>${faqInstance?.orden}</td>--%>
                                    <td>${generalService.getValorParametro(faqInstance?.idTipo)}</td>		
                                     <td>${fieldValue(bean: faqInstance, field: "pregunta")}</td>					
                                </tr>
                        </g:each>
                        </tbody>
                </table>
              <div class="pagination_crm">
                    <filterpane:paginate total="${faqInstanceCount ?: 0}" domainBean="Faq"/>
              </div>
        </div>
	</body>
</html>
