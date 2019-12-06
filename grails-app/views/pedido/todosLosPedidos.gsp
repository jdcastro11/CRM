<%@ page import="crm.Pedido" %>
<%@ page import="crm.Nota" %>
<%@ page import="crm.Empresa" %>
<g:set var="generalService" bean="generalService" />

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'pedido.label', default: 'Pedido')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
</head>
<body>
    <g:set var="generalService" bean="generalService" />
    <%
   def mover=generalService.getMenuV(1)
   def mout=generalService.getMenuV(2)
   def estilo=generalService.getMenuV(3)
    %>
    <g:set var="pedidoService" bean="pedidoService" />
    <% def sw_crud=[1,1,1,1,0,0] 
	   def listaSucursales=Empresa.findAllByIdTipoEmpresaAndEliminado('empbase',0)
	   def siNO=['Si','No']
	   def procesarPara=['Cableado','Mayorista']
    %>
     <g:set var="seguridadService" bean="seguridadService" />
    <h2>${xtitulo}</h2>
    <div>
    	<ul style="display:inline-block;">
    		<li>En elaboración</li>
			<li>En revisión</li>								
		</ul>		
		<ul style="display:inline-block;">
			<li>Pendiente por facturar parcial</li>
			<li>Pendiente por compra</li>
						
		</ul>
		<ul style="display:inline-block;">
			<li>Pendiente por facturar</li>			
			<li>Facturado parcialmente</li>		
		</ul>
		<ul style="display:inline-block;">
			<li>Facturado</li>			
			<li>Anulado</li>
		</ul>
		
    </div>
	
    <hr style="margin-top:10px;margin-bottom:10px;">
    <filterpane:filterPane domain="Pedido" 
    formName="frmFiltro"
    action="todosLosPedidos"
    showTitle="no"
    dialog="true"
    filterProperties="${['numPedido', 'nombreCliente','nombrecontacto','nombreVendedor','idEstadoPedido', 'factura','idSucursal','detpedido']}"   
    filterPropertyValues="${['idEstadoPedido':[values:crm.ValorParametro.executeQuery("select valor from ValorParametro where idParametro='estapedido' and valor NOT IN ('Anulado')")],'idSucursal':[values:listaSucursales],'detpedido.idProcesarPara':[values:procesarPara]]}"
    associatedProperties="factura.numFactura"
    listDistinct="true"
    distinctColumnName="nombreCliente"
    showSortPanel="false"
    fullAssociationPathFieldNames="false"
    />                                               
    <%
             def derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/pedido/index') 
     %>
    <div class="row-fluid sortable">
        <g:form controller="Pedido" params="[titulo:xtitulo]" >

            <div class="btn-group">

                <a href="#" class="btn btn-mini" >Acciones</a>
                <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
              <%  def swacc=0 %>
                <ul class="dropdown-menu">

                    <g:if test="${'CAMBIAR_DESTINATARIO_FACTURA' in derechos}">
                          <%  swacc=1 %>
                        <li><g:actionSubmit 
                              onMouseOver="${mover}" 
                              onMouseOut="${mout}" 
                              style="${estilo}" 
                                value="Cambiar Dest. Factura" action="cambiarDestinatarioFactura" />
                        </li>
                    </g:if>
                   
                    <g:if test="${'CAMBIAR_ESTADO_PEDIDO' in derechos}">
                          <%  swacc=1
                                 def xswc=0
                               if(generalService.getRolUsuario(session['idUsuario'].toLong()) =='ASISTENTE_FINANCIERO' )  xswc=1
                           %>
                        <li><g:actionSubmit 
                              onMouseOver="${mover}" 
                              onMouseOut="${mout}" 
                              style="${estilo}" 
                              value="Cambiar Estado Pedido "
                              action="cambiarEstadoPedido" />
                              <g:hiddenField name="swc" value="${xswc}" />
                        </li>
                    </g:if>

                    <g:if test="${'CAMBIAR_OPORTUNIDAD' in derechos}">
                          <%  swacc=1 %>
                        <li><g:actionSubmit 
                                onMouseOver="${mover}" 
                                onMouseOut="${mout}" 
                                style="${estilo}" 
                                value="Cambiar Oportunidad" 
                                action="cambiarOportunidad" />
                        </li>
                    </g:if>
                    <g:if test="${'CAMBIAR_VENDEDOR' in derechos}">
                          <%  swacc=1 %>
                        <li><g:actionSubmit 
                                onMouseOver="${mover}" 
                                onMouseOut="${mout}" 
                                style="${estilo}" 
                                value="Cambiar Vendedor" 
                                action="cambiarVendedor" />
                        </li>
                    </g:if>
                    <g:if test="${'APLICAR_DESCUENTO' in derechos}">
                          <%  swacc=1 %>
                        <li><g:actionSubmit 
                                onMouseOver="${mover}" 
                                onMouseOut="${mout}" 
                                style="${estilo}" 
                                value="Aplicar Descuento" 
                                action="aplicarDescuento" />
                        </li>
                    </g:if>
                     <g:if test="${'MOVER_PEDIDO' in derechos}">
                           <%  swacc=1 %>
                        <li><g:actionSubmit 
                              onMouseOver="${mover}" 
                              onMouseOut="${mout}" 
                              style="${estilo}" 
                              value="Mover Pedido" 
                              action="moverPedido" />
                        </li>
                    </g:if>
                    
                    
                    
                    
                    
                    
		             <!-- JOSE DANIEL 26/07/2016 -->
		             
			        <g:if test="${'ENVIAR_A_REVISION' in derechos}">
		                 <li><g:actionSubmit 
                              onMouseOver="${mover}" 
                              onMouseOut="${mout}" 
                              style="${estilo}" 
                              value="Enviar a revisión" 
                              action="enviarARevision" />
                        </li>              
		            </g:if>
		             
		             <!-- JOSE DANIEL 28/10/2016 -->
                 	<g:if test="${'EXPORTAR' in derechos}"> 
                            <%  swacc=1 %>
                            <li class="dropdown-submenu">
                                <a  class="gris" href="#">Exportar</a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <g:link action="exportarDatos" params="[tipo_export:'1',xaccionx:xaccion,titulo:xtitulo]">Todos</g:link>
                                    </li>                                    
                                    <li><g:actionSubmit  
                                    onMouseOver="${mover}" 
                                    onMouseOut="${mout}" 
                                    style="${estilo}"  
                                    value="Seleccionados" 
                                    action="exportarDatos" /></li>
                                </ul>
                            </li> 
                            
                            <li class="dropdown-submenu">
                                <a  class="gris" href="#">Informe de pedidos</a>
                                <ul class="dropdown-menu">                               
                                    <li>
                                    	<a href="/crm/pedido/generarReporteFinanciera" >Pendientes</a>
                                    </li>                                                                        
                                    <li>
                                        <g:link action="exportarDatos" params="[tipo_export:'2',xaccionx:xaccion,titulo:xtitulo]">Por arquitecto</g:link>
                                    </li>                          
                                                               
                                </ul>
                              </li>
                       </g:if>
                 
                 
                    <g:if test="${sw_crud[4]==1}">
                        <li><a href="${createLink(action:'eliminar')}" >Eliminar</a></li>
                        </g:if>
                        <g:if test="${'BORRAR' in derechos}">
                          <%  swacc=1 %>
                        <li><a href="${createLink(action:'index',params:[id:'pedidosbor'])}" >Ver Borrados</a></li>
                        </g:if>
                     <g:if test="${swacc==0}" >
                        <li align="center">Ninguna </li>
                    </g:if>                    
                </ul>
            </div>
          <!-- inicio filter  buttons  -->                         
            <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>
            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered> 
            <!-- fin filter  buttons  -->
            &nbsp; <a  class="btn btn-mini" href="/crm/pedido/todosLosPedidos"><i class="icon-remove"></i>&nbsp;Cancelar</a> &nbsp;
			<g:render template="/general/mensajes" />
            <div id="list-pedido" class="content scaffold-list" role="main">
                <g:set var="beanInstance"  value="${pedidoInstance}" />     
                <table  class="table table-bordered">
                    <thead>
                        <tr>
                            <td style="width:10px"> </td>
                            <g:sortableColumn property="numPedido" title="${message(code: 'pedido.numPedido.label', default: 'Código')}"  params="${filterParams}"/>

                            <g:sortableColumn property="nombreCliente" title="${message(code: 'pedido.nombreCliente.label', default: 'Empresa')}" params="${filterParams}" />

                            <g:sortableColumn property="valorPedido" title="${message(code: 'pedido.costo1.label', default: 'Valor en Dólares')}" params="${filterParams}" />

                            <g:sortableColumn property="valorPedido" title="${message(code: 'pedido.costo2.label', default: 'Valor en Pesos')}" params="${filterParams}" />

                            <g:sortableColumn property="fechaApertura" title="${message(code: 'pedido.fechaApertura.label', default: 'Fecha')}" params="${filterParams}" />

                            <g:sortableColumn property="idEstadoPedido" title="${message(code: 'pedido.idEstadoPedido.label', default: 'Estado')}" params="${filterParams}" />

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${pedidoInstanceList}" status="i" var="pedidoInstance">

                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td><g:checkBox name="pedidos" value="${pedidoInstance.id}" checked="false" /></td>

                                <td>
                                	<a style="text-decoration:underline;" href="/crm/pedido/show/${pedidoInstance?.id}?estado=${params.id}">
                                        ${fieldValue(bean: pedidoInstance, field: "numPedido")}
                                	</a>
                                	<g:if test="${generalService.esPedidoDetenido(pedidoInstance)==true}">&nbsp;
                                            <i class="fa-icon-ban-circle" title="Detenido en compras" style="font-size:1.4em;color:red"></i>
                                    </g:if>
                                </td>

                                <td style="overflow: hidden;text-overflow: ellipsis; white-space: nowrap;max-width: 350px;">${pedidoInstance.nombreCliente}</td>
                             
                                <g:if test="${pedidoInstance.idTipoPrecio=='pedtprec02'}" >
                                  <% 
                                   BigDecimal valorendolares=0   
                                   BigDecimal  xvalor=pedidoInstance?.valorPedido?:0
                                   BigDecimal ztrm=pedidoInstance?.trm?:xtrm
                                   if (ztrm !=0) valorendolares=xvalor/ztrm                             
                                  %>
                                <td style="text-align:right;">                                   
                                        <g:formatNumber name="subtotal" number="${valorendolares}" format="###,###,###.00" locale="co"/>                    
                                </td> 
                                </g:if>
                                <g:else>
                                 <td></td>
                                </g:else>
                                <g:if test="${pedidoInstance.idTipoPrecio=='pedtprec01'}" >
                                    <td style="text-align:right">
                                            <g:formatNumber name="subtotal" number="${pedidoInstance?.valorPedido}" format="###,###,###.00" locale="co"/>                    
                                    </td>
                                </g:if>
                                <g:else>
                                   <td></td>
                                </g:else>
                                
                                <td>${g.formatDate(format:'dd-MM-yyyy',date:pedidoInstance?.fechaApertura)}</td>
                               
                                <td>${generalService.getValorParametro(pedidoInstance?.idEstadoPedido)}</td>                       
                            </tr>
                        </g:each>
                    </tbody>
 					<tfoot>
                     <%  def  estilo1="style=text-align:right;" %>


                    <tr>
                       <td colspan="3" style="text-align:right"><b>TOTAL</b></td> 
                      <td bgcolor="#EEE" ${estilo1}><b>USD$</b> ${totalDolares}</td>
                      <td bgcolor="#EEE" ${estilo1}><b>COP$</b> ${totalPesos}</td>                                            
                      <td></td>
                      <td></td>
                    </tr>
                      
                    </tfoot>
                    
                </table>
                </div>
                <div class="pagination_crm">
                    <filterpane:paginate total="${pedidoInstanceCount?: 0}" domainBean="Pedido" id="${params.id}" />
        </div>
        </g:form>
   </div>    
</body>
</html>
