<%@ page import="crm.ValorParametro"   import="crm.Parametro" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="detalle">
		<g:set var="entityName" value="${message(code: 'valorParametro.label', default: 'ValorParametro')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
                
               
	</head>
        
      
	<body id="valp" >
            <div id="detalleconten">
            <% def sw_crud=[0,1,1,0,1,0]  %>
            <hr/>    
            <div class="box-header" data-original-title>
		<h2><i class="icon-trash"></i><span class="break"></span>  Valor Parámetros Borrados</h2>               
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
                  <div class="pull-left">
                        <div class="pull-left">
                              <g:if test="${sw_crud[0]==1}">

                                <a class="btn btn-mini btn-primary" href="${createLink(action:'create')}">
                                        <i class="icon-plus"></i>
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
                                  <g:if test="${sw_crud[4]==1}">
                                    <li><a href="${createLink(action:'eliminar')}" >Eliminar</a></li>  
                                  </g:if> 
                                  <li><a href="${createLink(action:'listarBorrados')}" >Ver Borrados</a></li>  
                            </ul>
                           <button type="reset" class="btn btn-mini" onclick="history.go(-1)">Cancelar</button>
                      </div>
                
                     <table class="table table-bordered">
			<thead>
					<tr>
					      <td style="width:18px"> </td>
						<g:sortableColumn property="idValorParametro" title="${message(code: 'valorParametro.idValorParametro.label', default: 'Código')}" />
					
						<g:sortableColumn property="valor" title="${message(code: 'valorParametro.valor.label', default: 'Valor')}" />
					
						<g:sortableColumn property="orden" title="${message(code: 'valorParametro.orden.label', default: 'Orden')}" style="text-align:center" />
					
						<g:sortableColumn property="estadoValorParametro" title="${message(code: 'valorParametro.estadoValorParametro.label', default: 'Estado')}" style="text-align:center" />
					        <td style="width:100px"> </td>	
					</tr>
				</thead>
				<tbody>
				<g:each in="${valorParametroInstanceList}" status="i" var="valorParametroInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
					 <td><g:checkBox name="parametros" value="${valorParametroInstance.id}" checked="false" /></td>		
                                            <td><g:link action="edit" id="${valorParametroInstance.id}" style="text-decoration:underline;">${fieldValue(bean: valorParametroInstance, field: "idValorParametro")}</g:link></td>
					
						<td>${fieldValue(bean: valorParametroInstance, field: "valor")}</td>
					
						<td><center>${fieldValue(bean: valorParametroInstance, field: "orden")}</center></td>
										
                                                  <g:if test="${valorParametroInstance.estadoValorParametro=='A'}" >
                                                    <td><center>Activo</center></td>
                                                 </g:if>                                         
						 <g:else>
                                                      <td><center>Inactivo</center></td>
                                                 </g:else>
                                              <td class="center">
                                                    
                                                                                                     
                                                   <g:if test="${sw_crud[1]==1}">
                                                      <g:link  class="btn btn-success  btn-mini" action="show" id="${valorParametroInstance.id}"><i class="icon-zoom-in icon-white"  ></i></g:link>
                                                    </g:if>
                                                   <g:if test="${sw_crud[5]==1}">
                                                       <a href="#" class="btn btn-info  btn-mini"   onclick="cargardetalle();"><i class="icon-list icon-white"></i></a>
                                                   </g:if>
                                                  <g:if test="${sw_crud[3]==1}">
                                                    <g:set var="xreg" value="${ valorParametroInstance.id}" />
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
			<div class="dataTables_paginate paging_bootstrap pagination">
				<g:paginate total="${valorParametroInstanceCount ?: 0}" />
			</div>
		</div>
                  <script>                    
                       <!-- calcula el alto del bloque htm del detalle de encaberzado respectivo --> 
                        var contenido= $("#detalleconten");                       
                        if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+60);                                        
                   </script>
        </body>
       
</html>

