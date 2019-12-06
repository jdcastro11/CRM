
<%@ page import="crm.DetPedido" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="seguridadService" bean="seguridadService" />
<g:set var="pedidoService" bean="pedidoService" />
 <%
   def mover=generalService.getMenuV(1)
   def mout=generalService.getMenuV(2)
   def estilo=generalService.getMenuV(3)
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'detPedido.label', default: 'DetPedido')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>   
        <r:require module="filterpane" />
    </head>
    <body >      
        
        <div id="detalleconten">

            <h2>${xtitulo}</h2> 
            <hr style="margin-top: 10px; margin-bottom: 10px;"/>
            
             <%
             def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/detPedido/index')   
              if (!xpedido)
                  xpedido=session['zpedido']
               else
                  session['zpedido']=xpedido                  
               
             %>
             
                <filterpane:filterPane domain="DetPedido" 
                formName="frmFiltro"
                action="index"
                showTitle="no"
                dialog="true"
                filterProperties="${['refProducto','descProducto', 'idEstadoDetPedido']}" 
                filterPropertyValues="${['idEstadoDetPedido':[values:crm.ValorParametro.executeQuery('select valor from ValorParametro where idParametro=\'estadetped\'')],]}"
                showSortPanel="true"
                fullAssociationPathFieldNames="false"
             />
            <div id="list-detPedido" class="content scaffold-list" role="main">

                <div class="row-fluid sortable">       
                    <g:form controller="detPedido" id="${xpedido}" >
                        <% def pedidoInstance= crm.Pedido.get(xpedido) %>
                        <g:if test="${pedidoService.accesoPedido(pedidoInstance?.id,session['idUsuario'],'pedido')}"> 
                            <div class="pull-left">
                                <div class="pull-left">
                                    <g:if test="${'CREAR' in derechos}">
                                        <a class="btn btn-mini btn-primary" href="/crm/detPedido/create/?pedido=${xpedido}">
                                            <i class="icon-plus icon-white"></i> <strong> Nuevo</strong>  </a>
                                        </g:if>
                                </div>
                            </div>
                            &nbsp;

                            <div class="btn-group">

                                <a href="#" class="btn btn-mini" >Acciones</a>
                                <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>

                                <ul class="dropdown-menu">
                                     <%  def swacc=0 %>
                                    <g:if test="${'PROCESAR_PROD_COMPRA' in derechos}">     
                                      <%  swacc=1 %>
                                      <li> <g:actionSubmit 
                                        onMouseOver="${mover}" 
                                        onMouseOut="${mout}" 
                                        style="${estilo}" 
                                        value="Procesar x Compra" 
                                        action="procesarProductoCompra"  />
                                      </li>
                                     <g:hiddenField    name="pedido" value="${xpedido}" />                                   
                                    </g:if>
                                    <g:if test="${'MOVER_PRODUCTO' in derechos}">
                                        <%  swacc=1 %>
                                        <li><g:actionSubmit 
                                              onMouseOver="${mover}" 
                                              onMouseOut="${mout}" 
                                              style="${estilo}" 
                                              value="Mover Producto" 
                                              action="moverProducto"
                                             />
                                        </li>
                                    </g:if>
                                    <g:if test="${'RECIBO_COMPLETO' in derechos}">
                                        <%  swacc=1 %>
                                            <li><g:actionSubmit 
                                                    onMouseOver="${mover}"
                                                    onMouseOut="${mout}"   
                                                    style="${estilo}" 
                                                    value="Recibo Varios Completo" action="reciboCompleto" />
                                            </li>
                                          <g:hiddenField  name ="layout"  value="detail" />                                          
                                     </g:if>
                                    <g:if test="${'IMPORTAR_PRODUCTOS_PEDIDO' in derechos }">    
                                        <%  swacc=1 %>
                                        <li><a href="/crm/detPedido/importarProductosPedido/${xpedido}" >Importar Productos</a></li>
                                    </g:if>
                                    <g:if test="${'ANULAR_PRODUCTO_PEDIDO' in derechos}">
                                        <%  swacc=1 %>
                                    <li><g:actionSubmit 
                                            onMouseOver="${mover}" 
                                            onMouseOut="${mout}" 
                                            style="${estilo}" 
                                            value="Anular Producto" 
                                            action="anularProductoPedido" /></li>
                                    </g:if>
                                     <g:if test="${'DESANULAR_PRODUCTO_PEDIDO' in derechos}">
                                         <%  swacc=1 %>
                                    <li><g:actionSubmit 
                                            onMouseOver="${mover}" 
                                            onMouseOut="${mout}" 
                                            style="${estilo}" 
                                            value="Desanular Producto" 
                                            action="desanularProductoPedido" /></li>
                                    </g:if>
                                    <g:if test="${'ELIMINAR_PROD_PEDIDO' in derechos}">
                                        <%  swacc=1 %>
                                    <li><g:actionSubmit 
                                            onMouseOver="${mover}" 
                                            onMouseOut="${mout}" 
                                            style="${estilo}" 
                                            value="Eliminar Producto" 
                                            action="eliminarProductoPedido"                                            
                                            onclick="return confirm('Está seguro de eliminar registro(s)?')"
                                            /></li>
                                    </g:if>  
                                      <g:if test="${'BORRAR' in derechos}">
                                        <%  swacc=1 %>
                                      <li><a href="/crm/detPedido/listarBorrados/${params.id}" >Ver Borrados</a></li>
                                      </g:if>
                                    <g:if test="${swacc==0}" >
                                   <li align="center">Ninguna </li>
                                    </g:if>
                                </ul>
                            </div>
                        </g:if>
                           <!-- inicio filter  buttons -->                           
                            <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>
                            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
                            <!-- fin filter  buttons  -->
                        <a  class="btn btn-mini" href="/crm/detPedido/index/${xpedido}"><i class="icon-remove"></i>&nbsp;Cancelar</a>


                        <g:set var="beanInstance"  value="${detPedidoInstance}" />                
                        <g:render template="/general/mensajes" />

                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <td style="width:18px"><input name ="allRegs" type="checkbox" onClick="toggle(this,'detpedidos')" /> </td>

                                    <g:sortableColumn property="refProducto" title="${message(code: 'detPedido.refProducto.label', default: 'Referencia')}" />

                                    <g:sortableColumn property="descProducto" title="${message(code: 'detPedido.descProducto.label', default: 'Descripción')}" />

                                    <g:sortableColumn property="cantidad" title="${message(code: 'detPedido.cantidad.label', default: 'Cantidad')}" />

                                    <g:sortableColumn property="valor" title="${message(code: 'detPedido.valor.label', default: 'Valor')}" />

                                    <g:sortableColumn property="observaciones" title="${message(code: 'detPedido.total.label', default: 'Total')}" />

                                    <g:sortableColumn property="idProcesarPara" title="${message(code: 'detPedido.idProcesarPara.label', default: 'Procesar Para')}" />

                                    <g:sortableColumn property="idEstadoDetPedido" title="${message(code: 'detPedido.idEstadoDetPedido.label', default: 'Estado')}" />
                                    
                                    <g:sortableColumn property="ordenCompra" title="${message(code: 'detPedido.ordenCompra.label', default: 'Orden de compra')}" />
                                </tr>
                            </thead>
                            <tbody>
                               
                                <g:each in="${detPedidoInstanceList}" status="i" var="detPedidoInstance">
                                  
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td><g:checkBox name="detpedidos" value="${detPedidoInstance?.id}" checked="false" /></td>

                                        <td><a href="/crm/detPedido/show/${detPedidoInstance.id}?pedido=${xpedido}" style="text-decoration:underline">
                                                ${detPedidoInstance?.refProducto}</a>
                                        </td>

                                        <td>${detPedidoInstance?.descProducto}</td>

                                        <td style="text-align:right;">${formatNumber(number:detPedidoInstance?.cantidad,format:'###,###,###', locale:'co')}</td>


                                        <td style="text-align:right;">${formatNumber(number:detPedidoInstance?.valor,format:'###,###,###.00', locale:'co')}</td>
                                        

                                        <td style="text-align:right;">${formatNumber(number:detPedidoInstance.cantidad*detPedidoInstance.valor,format:'###,###,###.00', locale:'co')}</td> 

                                        <td>${generalService.getValorParametro(detPedidoInstance?.idProcesarPara)}</td>     

                                        <td style="text-align:center;">${generalService.getValorParametro(detPedidoInstance?.idEstadoDetPedido)}</td>
                                        
                                        <td style="text-align:center;">${detPedidoInstance?.ordenCompra}</td>
                                    </tr>
                                </g:each>
                            </tbody>
                              <% def estilo0="Style=text-align:right;font-weight:bold;" 
                                def  estilo1="style=text-align:right;"                               
                               %>
                                   <tr>
                                <td colspan="5" ${estilo0}>Subtotal</td>                                
                                <td bgcolor="#EEE" ${estilo1}>${formatNumber(number:xsubtotal,format:'###,###,###.00', locale:'co')}</td>
                                <td colspan="3">de ${formatNumber(number:xsubtotal1,format:'###,###,###.00', locale:'co')}</td>
                            </tr>
                            <tr>
                                <td colspan="5" ${estilo0}>Descuento</td>                               
                                <td bgcolor="#EEE" ${estilo1}>${formatNumber(number:xdescuento,format:'###,###,###.00', locale:'co')}</td>
                                <td colspan="3">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="5" ${estilo0}>IVA</td>                                
                                <td bgcolor="#EEE" ${estilo1}>${formatNumber(number:xiva,format:'###,###,###.00', locale:'co')}</td>
                                <td colspan="3">de ${formatNumber(number:xiva1,format:'###,###,###.00', locale:'co')}</td>
                            </tr>
                            <tr>
                                <td colspan="5" ${estilo0}>Total</td>                                
                                <td bgcolor="#EEE" ${estilo1}>${formatNumber(number:xtotal,format:'###,###,###.00', locale:'co')}</td>
                                <td colspan="3">de ${formatNumber(number:xtotal1,format:'###,###,###.00', locale:'co')}</td>
                            </tr>
                        </table>
                        <div class="pagination_crm">
                           <%-- <g:paginate id="${xpedido}" total="${detPedidoInstanceCount?:0}" /> --%>
                             <filterpane:paginate total="${detPedidoInstanceCount ?: 0}" domainBean="DetPedido"  id="${xpedido}"/>
                        </div>
                
                    </g:form>
                          
                           
                </div>
            </div>
        </div>
        <script>
            var contenido= $("#detalleconten");
            if (parent.IFRAME_DETALLE !=null) parent.IFRAME_DETALLE.height(contenido.height());

        </script>
    </body>
</html>
