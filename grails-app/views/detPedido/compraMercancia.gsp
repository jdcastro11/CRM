
<%@ page import="crm.DetPedido" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="seguridadService" bean="seguridadService" />
<g:set var="pedidoService" bean="pedidoService" />
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'detPedido.label', default: 'DetPedido')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title> 
    <r:require module="filterpane" />
    
</head>
<body>

    <div id="detalleconten">

        <h2>Compra de Mercancías</h2> 
        <hr style="margin-top: 10px; margin-bottom: 10px;"/>

        <div id="detalleconten">                            

            <filterpane:filterPane domain="DetPedido" 
            formName="frmFiltro"
            action="indexn"
            showTitle="no"
            dialog="true"
            filterProperties="${['refProducto','descProducto','empresa','pedido']}"  
            associatedProperties="empresa.razonSocial,pedido.numPedido"
            showSortPanel="false"
            fullAssociationPathFieldNames="false"
            />
            <div id="list-detPedido" class="content scaffold-list" role="main">

                <div class="row-fluid sortable">                 
                    <g:form controller="detPedido" id="${xpedido}" >                   

                        <div class="btn-group">

                            <a href="#" class="btn btn-mini" >Acciones</a>
                            <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>

                            <ul class="dropdown-menu">  
                            <g:if test="${'PROCESAR_PROD_COMPRA' in session['operaciones']}">     
                                      <%  swacc=1 
                                        def estilo=generalService.getMenuV(3)  
                                      %>
                                      <li> <g:actionSubmit 
                                        onMouseOver="${mover}" 
                                        onMouseOut="${mout}" 
                                        style="${estilo}" 
                                        value="Procesar x Compra" 
                                        action="procesarProductoCompraSP"  />
                                      </li>
                                     
                                    </g:if>
                                <g:if test="${'RECIBO_COMPLETO' in session['operaciones']}">
                                    <li><g:actionSubmit onMouseOut="this.style.backgroundColor='#fff'" 
                                            onMouseOver="this.style.backgroundColor='#eee'" 
                                            style="border:none;background-color:#fff;" 
                                            value="Recibo Varios Completo" action="reciboCompleto" />
                                    </li>
                                </g:if>
                            </ul>
                        </div>

   <!-- inicio filter  buttons -->                           
                        <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>
                        <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
                        <!-- fin filter  buttons  -->
                        <a  class="btn btn-mini" href="/crm/detPedido/indexn"><i class="icon-remove"></i>&nbsp;Cancelar</a>


                        <g:set var="beanInstance"  value="${detPedidoInstance}" />                
                        <g:render template="/general/mensajes" />

                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <td style="width:18px"> </td>

                                    <g:sortableColumn property="refProducto" title="${message(code: 'detPedido.refProducto.label', default: 'Referencia')}" />

                                      <g:sortableColumn style="width:12%" property="Pedido" title="${message(code: 'detPedido.numPedido.label', default: 'No.Pedido')}" />
                                    
                                    <g:sortableColumn style="width:4%" property="cantidad" title="${message(code: 'detPedido.cantidad.label', default: 'Cant.')}" />

                                    <g:sortableColumn property="descProducto" title="${message(code: 'detPedido.descProducto.label', default: 'Descripción')}" />

                                    <g:sortableColumn property="empresa" title="${message(code: 'detPedido.empresa.label', default: 'Proveedor')}" />                       

                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${detPedidoInstanceList}" status="i" var="detPedidoInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td><g:checkBox name="detpedidos" value="${detPedidoInstance?.id}" checked="false" /></td>
                                        
                                        <td><a href="/crm/detPedido/show/${detPedidoInstance.id}?layout=${layout}&pedido=${detPedidoInstance?.pedido?.id}&sw=1" style="text-decoration:underline">
                                              ${detPedidoInstance?.refProducto}</a>
                                        </td>
                                        <td>${detPedidoInstance?.pedido?.numPedido}</td>
                                        
                                        <td style="text-align:right;">${formatNumber(number:detPedidoInstance.cantidad,format:'###,###,###', locale:'co')}</td>

                                        <td>${detPedidoInstance?.descProducto}</td>

                                        <td>${detPedidoInstance?.empresa?.razonSocial}</td>
                                    </tr>
                                </g:each>
                            </tbody>                           
                        </table>
                        <div class="pagination_crm">
                            <filterpane:paginate total="${detPedidoInstanceCount ?: 0}" domainBean="DetPedido"/>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>
        <script>
            var contenido= $("#detalleconten");
            if (parent.IFRAME_DETALLE !=null) parent.IFRAME_DETALLE.height(contenido.height()+60);

        </script>
</body>
</html>
