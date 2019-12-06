<%@ page import="crm.Pedido" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'pedido.label', default: 'Pedido')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
       
    <r:require module="filterpane" />
</head>
<body>
    <g:set var="generalService" bean="generalService" />
    <g:set var="pedidoService" bean="pedidoService" />                                            

    <div class="row-fluid sortable">
        <g:form controller="Pedido" >

            <div id="list-pedido" class="content scaffold-list" role="main">
                
                <table  style="font-size:0.9em" width="100%">
                    <thead>
                        <tr>
                            <g:sortableColumn property="numPedido" title="${message(code: 'pedido.numPedido.label', default: 'Código')}"  />

                            <g:sortableColumn property="nombreCliente" title="${message(code: 'pedido.nombreCliente.label', default: 'Empresa')}"  />

                            <g:sortableColumn property="valorPedido" title="${message(code: 'pedido.costo1.label', default: 'Valor')}"  />

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${pedidoInstanceList}" status="i" var="pedidoInstance">

                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                
                                <td><a style="text-decoration:underline;" target="_parent" href="/crm/pedido/show/${pedidoInstance?.id}?estado=${params.estado}">
                                        ${fieldValue(bean: pedidoInstance, field: "numPedido")}
                                    </a></td>
                                <td>${pedidoInstance.nombreCliente.toLowerCase()}</td>
                                <td style="text-align:right">
                                    <g:formatNumber name="subtotal" number="${pedidoService.valorPedido((String)pedidoInstance.id)}" format="###,###,##0" locale="co"/>                    
                                </td>                               
                                <td style="text-align:right"></td>
                            </tr>
                            <% if (i>10) pedidoInstanceList=[] %>
                        </g:each>
                    </tbody>
                </table>
                <div class="pagination_panel">
                    <g:paginate total="${pedidoInstanceCount ?: 0}" domainBean="Pedido"/>
                </div>
            </div>
        </div>
    </g:form>
</body>
</html>
