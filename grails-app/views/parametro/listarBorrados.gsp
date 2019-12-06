<%@ page import="crm.Parametro"
         import="crm.ValorParametro"    
%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'parametro.label', default: 'Parametro')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>              
	</head>
	<body>
             <% def sw_crud=[0,1,1,0,0,1]  %>
              <div class="box-header" data-original-title>
		<h2><i class="icon-trash"></i><span class="break"></span>Parámetros Borrados</h2>               
	      </div>             
		            
	
                       <p>&nbsp; </p>   
                        <form class="form-inline ng-pristine ng-valid"><!-- busqueda --> 
                            <fieldset>
                                    <div class="input-append pull-right">
                                            <input class="input-xlarge ng-pristine ng-valid" type="text" placeholder="Parametro" ng-model="query">
                                                                    <span class="add-on">
                                                                            <i class="icon-search"></i>
                                                                    </span>
                                    </div>
                            </fieldset>
                        </form>
                   
                  <g:form name="frmParametros"  >
                        <div class="row-fluid sortable">

                                <div class="pull-left">
                                        <div class="pull-left">
                                          <button  type="reset" class="btn btn-mini" onclick="history.go(-1)"><i class="icon-remove"></i>&nbsp;Cancelar</button>                           

                                        </div>
                                </div>
                        </div>
                        <!-- Fin operaciones de la Opcion) -->
                        
			<table class="table table-bordered">
			<thead>
					<tr>
					
			                        <td style="width:18px"> </td>				
                                                <g:sortableColumn property="idParametro" title="${message(code: 'parametro.idParametro.label', default: 'Código')}" />
					
						<g:sortableColumn property="descripcion" title="${message(code: 'parametro.descripcion.label', default: 'Descripción')}" />
					
						<g:sortableColumn property="tipoParametro" title="${message(code: 'parametro.tipoParametro.label', default: 'Tipo')}"  style="text-align:center" />
					
						<g:sortableColumn property="estadoParametro" title="${message(code: 'parametro.estadoParametro.label', default: 'Estado')}" style="text-align:center" />
						<td style="width:100px"> </td>				
					</tr>
				</thead>
				<tbody>
                                 
				<g:each in="${parametroInstanceList}" status="i" var="parametroInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
					     <td><g:checkBox name="parametros" value="${parametroInstance.id}" checked="false" /></td>	
                                             <g:if test="${sw_crud[2]==1}">
                                                  <td><g:link action="edit" style="text-decoration:underline" id="${parametroInstance.id}" >${fieldValue(bean: parametroInstance, field: "idParametro")}</g:link></td>
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
                                                <td class="center">
                                                    
                                                             <g:set var="xurl" value="/crm/valorParametro/index/${parametroInstance.idParametro}" />                                                                      
                                                   <g:if test="${sw_crud[1]==1}">
                                                      <g:link  class="btn btn-success  btn-mini" action="show" id="${parametroInstance.id}"><i class="icon-zoom-in icon-white"  ></i></g:link>
                                                   </g:if>
                                                     <g:if test="${sw_crud[5]==1}">
                                                      <a href="#" class="btn btn-info  btn-mini"   onclick="crm_cargardetalle('ifvalp','${xurl}');"><i class="icon-list icon-white"></i></a>
                                                   </g:if>
                                                  <g:if test="${sw_crud[3]==1}">
                                                    <g:set var="xreg" value="${parametroInstance.id}" />
                                                    <g:set var="xaccion" value="${createLink(action:'borrar')}" />
                                                    <a href="#" class="btn btn-danger btn-mini" 
                                                        onclick='return confirm("Está seguro de borrar este registro?",function(){window.location.href="${xaccion}/${xreg}"})'>                                                     
                                                        <i class="icon-trash icon-white"></i></a>
                                                   </g:if>         
                                                </td>										
                           		</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${parametroInstanceCount ?: 0}" />
			</div>
                        </g:form>
      
         <script language="javascript">
                       IFRAME_DETALLE = null;
                 </script>
                 
                <iframe id="ifvalp" src="${xurl}" style="border:0;" width="100%" height=0 scrolling="no" ></iframe>                
 
 	</body>
</html>
