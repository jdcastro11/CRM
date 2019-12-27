<%@ page import="crm.Pedido" %>
<%@ page import="crm.Empresa" %>


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
    <% 
		def sw_crud=[1,1,1,1,0,0]  
		def listaSucursales=Empresa.findAllByIdTipoEmpresaAndEliminado('empbase',0)
		def siNO=['Si','No']
    %>
     <g:set var="seguridadService" bean="seguridadService" />
    <h2>${xtitulo}</h2>
    <hr style="margin-top:10px;margin-bottom:10px;">	
    <filterpane:filterPane domain="Pedido" 
    formName="frmFiltro"
    action="indexcompraeyc"
    showTitle="no"
    dialog="true"
	filterProperties="${['numPedido', 'nombreCliente','nombrecontacto','nombreVendedor','idEstadoPedido','idSucursal','detenidoEnCompra']}"   
    filterPropertyValues="${['idEstadoPedido':[values:crm.ValorParametro.executeQuery("select valor from ValorParametro where idParametro='estapedido'")],'idSucursal':[values:listaSucursales],'detenidoEnCompra':[values:siNO]]}"
    associatedProperties="factura.numFactura"
    listDistinct="true"
    distinctColumnName="nombreCliente"
    showSortPanel="false"
    fullAssociationPathFieldNames="false"
    />                                               
    <%
        def derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/pedido/indexcompraeyc')
     %>
    <div class="row-fluid sortable">
        <g:form controller="Pedido" params="[titulo:xtitulo]" >

            <div class="pull-left">
                <div class="pull-left">
                    <g:if test="${'CREAR' in derechos}">
                        <a class="btn btn-mini btn-primary" href="/crm/pedido/create">
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
              <%  def swacc=0 %>
                <ul class="dropdown-menu">

                    
                    <g:if test="${'VER' in derechos}">
                          <%  swacc=1 %>
                        <li><a  class="gris" href="/crm/pedido/index/pedfacturx?sort=fechaApertura&order=desc">Ver Facturados</a></li> 
                    </g:if>
                    
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
                                    action="exportarDatos"
                                    params="[tipo_export:'2']" /></li>
                                                               
                                </ul>
                            </li> 
                     </g:if>                    
                </ul>
            </div>
          <!-- inicio filter  buttons  -->                         
            <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>
            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered> 
            <!-- fin filter  buttons  -->
            &nbsp; <a  class="btn btn-mini" href="/crm/pedido/indexcompraeyc?sort=fechaApertura&order=desc"><i class="icon-remove"></i>&nbsp;Cancelar</a>

            <div id="list-pedido" class="content scaffold-list" role="main">

                <g:set var="beanInstance"  value="${pedidoInstance}" />                
                <g:render template="/general/mensajes" />
                <table  class="table table-bordered">
                    <thead>
                        <tr>
                            <td style="width:18px"> </td>
                            <g:sortableColumn property="numPedido" title="${message(code: 'pedido.numPedido.label', default: 'Código')}"  params="${filterParams}"/>

                            <g:sortableColumn property="nombreCliente" title="${message(code: 'pedido.nombreCliente.label', default: 'Empresa')}" params="${filterParams}" />

                            <g:sortableColumn property="valorPedido" title="${message(code: 'pedido.costo1.label', default: 'Valor en Dólares')}" params="${filterParams}" />

                            <g:sortableColumn property="valorPedido" title="${message(code: 'pedido.costo2.label', default: 'Valor en Pesos')}" params="${filterParams}" />

                            <g:sortableColumn property="fechaApertura" title="${message(code: 'pedido.fechaApertura.label', default: 'Fecha')}" params="${filterParams}" />

                            <g:sortableColumn property="idEstadoPedido" title="${message(code: 'pedido.idEstadoPedido.label', default: 'Estado')}" params="${filterParams}" />

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${listaFiltro}" status="i" var="pedidoInstance">

                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td><g:checkBox name="pedidos" value="${pedidoInstance.id}" checked="false" /></td>

                                <td><a style="text-decoration:underline;" href="/crm/pedido/show/${pedidoInstance?.id}?estado=${params.id}">
                                        ${fieldValue(bean: pedidoInstance, field: "numPedido")}
                                    </a>
                                    <g:if test="${generalService.esPedidoDetenido(pedidoInstance)==true}">&nbsp;
                                            <i class="fa-icon-ban-circle" title="Detenido en compras" style="font-size:1.4em;color:red"></i>
                                    </g:if>                             
                                 </td>

                                <td style="overflow: hidden;text-overflow: ellipsis; white-space: nowrap;max-width: 350px;">${pedidoInstance.nombreCliente}</td>
                             <% BigDecimal valorFacturado=pedidoService.valorFacturado(pedidoInstance?.id.toString())['subtotal'] %>
                                <g:if test="${pedidoInstance.idTipoPrecio=='pedtprec02'}" >
                                  <% 
                                   BigDecimal valorendolares=0
                                   BigDecimal  xvalor=pedidoInstance?.valorPedido?:0
                                   BigDecimal ztrm=pedidoInstance?.trm?:xtrm
								   
                                   if (ztrm !=0) valorendolares=xvalor/ztrm                             
                                  %>
                                <td style="text-align:right">                                   
                                        <g:formatNumber name="subtotal" number="${valorendolares}" format="###,###,###.00" locale="co"/>
                                        <g:if test="${valorFacturado>0}">                                         
                                         	<p style="color:red;font-size:10px;margin:0;">-<g:formatNumber name="facturado" number="${valorFacturado}" format="###,###,###.00" locale="co"/></p>
                                        </g:if>                    
                                </td> 
                                </g:if>
                                <g:else>
                                 <td></td>
                                </g:else>
                                <g:if test="${pedidoInstance.idTipoPrecio=='pedtprec01'}" >
                                    <td style="text-align:right">
                                            <g:formatNumber name="subtotal" number="${pedidoInstance?.valorPedido}" format="###,###,###.00" locale="co"/>
                                            <g:if test="${valorFacturado>0}">
                                         		<p style="color:red;font-size:10px;margin:0;">-<g:formatNumber name="facturado" number="${valorFacturado}" format="###,###,###.00" locale="co"/></p>
                                         	</g:if>                    
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
                      <td bgcolor="#EEE" ${estilo1}><b>USD$</b>
                       ${totalDolares}
                       <g:if test="${facturaDolares>0}">                                         
                                <p style="color:red;font-size:10px;margin:0;">-<g:formatNumber name="subtotal" number="${facturaDolares}" format="###,###,###.00" locale="co"/></p>
					   </g:if>                       
                      </td>
                      <td bgcolor="#EEE" ${estilo1}><b>COP$</b>
                       ${totalPesos}
                      	<g:if test="${facturaPesos>0}">                                         
                                <p style="color:red;font-size:10px;margin:0;">-<g:formatNumber name="subtotal" number="${facturaPesos}" format="###,###,###.00" locale="co"/></p>
					    </g:if>
                      </td>                                            
                      <td></td>
                      <td></td>
                    </tr>
                      
                    </tfoot>
                </table>
                
            </div>
            </g:form>
        </div>
        
    
</body>
</html>