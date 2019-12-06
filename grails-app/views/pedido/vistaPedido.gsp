<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <style TYPE="text/css">
        @page{
        margin-left:-35px;
        margin-right:30px;
        margin-top:30px;
        padding:0px;}
           .table {  
             margin-left:40px;
           border: 1px solid #dddddd;
           width:765px;
           }
         .table th, .table td {
            padding: 2px;
         }
         
        .divtext {
         padding: 5px;
         width: 97%;
         height:80px;
         min-height:60px;
         max-height:250px;
         overflow: auto; }

           
         .col1 {width:80px;background:#eee;}
         .col2{width:180px;}
         @media print{
         .col1 {width:80px;background:#eee}
         .col2{width:180px;}

        
         }
         
         
        </style>   
       
</head>
<body > 

<g:set var="generalService" bean="generalService" />

<h2 style=margin-left:45px;"> Pedido : ${pedidoInstance?.numPedido} (${pedidoInstance?.nombreCliente}) </h2>
<table class="table table-bordered " >
    <tr>
        <td class="col1">Sucursal</td>
        <td class="col2">${xsucursal}</td>
        <td class="col1">Estado del pedido</td>
        <td class="col2">${generalService.getValorParametro(pedidoInstance.idEstadoPedido)}</td>
    </tr>    
    <tr>
        <td class="col1">Fecha</td>
        <td class="col2">${g.formatDate(format:'dd-MM-yyyy',date:pedidoInstance?.fechaApertura)}</td>
        <td class="col1">Cliente Nuevo</td>
        <td class="col2">${pedidoInstance.clienteNuevo}</td>
        
    </tr>
    <tr>
        <td class="col1">No.Pedido</td>
        <td class="col2">${pedidoInstance?.numPedido}</td>
        <td class="col1">Forma de Pago</td>
        <td class="col2">${xformaPago}</td>
        
    </tr>
    <tr>
        <td class="col1">Valor Pedido</td>
        <td class="col2">${formatNumber(number:xvalorpedido,format:'###,###,###', locale:'co')}</td>
        <td class="col1">Precios</td>
        <td class="col2">${xpreciosEn}</td>
        
    </tr>
    <tr>
        <td class="col1">Facturación Parcial</td>
        <td class="col2">${pedidoInstance?.facturacionParcial}</td>
        <td class="col1">Dir.Despacho</td>
        <td class="col2">${pedidoInstance?.dirDespacho}</td>
        
    </tr>
    <tr>
        <td class="col1">Cliente</td>
        <td class="col2">${pedidoInstance?.nombreCliente}</td>
        <td class="col1">Dir.Factura</td>
        <td class="col2">${pedidoInstance?.dirEntregaFactura}</td>
        
    </tr>
    
    <tr>
        <td class="col1">Nit</td>
        <td class="col2">${xnitEmpresa}</td>
        <td class="col1">Facturar En:</td>
        <td class="col2">${xfacturarEn}</td>        
    </tr>
    
    <tr>
        <td class="col1">Vendedor</td>
        <td class="col2">${pedidoInstance?.nombreVendedor}</td>
        <td class="col1"> Polizas</td>
        <td class="col2">${xpoliza}</td>
    </tr>
   
    <tr>
        <td class="col1">Facturar A:</td>
        <td class="col2">
        	${xfacturarA}
        	<g:if test="${xnitEmpresaFacturar!=xnitEmpresa}">
        		<br> Nit: ${xnitEmpresaFacturar}
        	</g:if>        	
        </td>
        <td class="col1">Fecha Entrega</td>
        <td class="col2">${g.formatDate(format:'dd-MM-yyyy',date:pedidoInstance?.fechaEntrega)}</td>
    </tr>
      
     <tr>
        <td class="col1">Orden de Compra</td>
        <td class="col2">${pedidoInstance?.ordenCompra}</td>
        <td class="col1">Arquitectos</td>
        <td class="col2">
         <g:each in="${listaDef}" status="i" var="xarqui">
              ${xarqui}<br/>
         </g:each>    
        </td>
    </tr>
    <table class="table table-bordered">      
     <tr>
         <td class="col1">Observaciones</td> 
         <td>
             <g:textArea class="divtext" name="observacionesPedido" maxlength="2000" value="${pedidoInstance?.observacionesPedido}" />
         </td>  
     </tr>
     
    </table>
</table>
 <h2 style="margin-left:50px;"> Productos </h2>
 <table class="table table-bordered">
    <tr style="background:#eee">
        <th style="width:12px">#</th>
        <th>Referencia</th>
        <th>Descripción</th>
        <th>Cantidad</th>       
        <th>Valor</th>
        <th>Total</th>
        <th>Orden Compra</th>
        
                     
    </tr>
        
    <g:each in="${detPedidoInstanceList}" status="i" var="detPedidoInstance">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
        
            <td>${i+1}</td>
            <td>${detPedidoInstance?.refProducto}</td>
            <td style="width:380px;">${detPedidoInstance?.descProducto}</td>
            <td style="text-align:right;">${formatNumber(number:detPedidoInstance.cantidad,format:'###,###,###', locale:'co')}</td>
            <td style="text-align:right;">${formatNumber(number:detPedidoInstance.valor,format:'###,###,###.00', locale:'co')}</td>
            <td style="text-align:right;">${formatNumber(number:detPedidoInstance.cantidad*detPedidoInstance.valor,format:'###,###,###.00', locale:'co')}</td>
            <td style="width:90px;">&nbsp;${detPedidoInstance?.ordenCompra}</td>
            
             
          	
        </tr>
    </g:each>      

        <% def estilo0="Style=text-align:right;font-weight:bold;" 
            def  estilo1="style=text-align:right;" %>
        <tr>
            <td colspan="5" ${estilo0}>Subtotal</td>                                
            <td bgcolor="#EEE" ${estilo1}>${formatNumber(number:xsubtotal,format:'###,###,###.00', locale:'co')}</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
            <td colspan="5" ${estilo0}>Descuento</td>                               
            <td bgcolor="#EEE" ${estilo1}>${formatNumber(number:xdescuento,format:'###,###,###.00', locale:'co')}</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
            <td colspan="5" ${estilo0}>IVA</td>                                
            <td bgcolor="#EEE" ${estilo1}>${formatNumber(number:xiva,format:'###,###,###.00', locale:'co')}</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
            <td colspan="5" ${estilo0}>Total</td>                                
            <td bgcolor="#EEE" ${estilo1}>${formatNumber(number:xtotal,format:'###,###,###.00', locale:'co')}</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
    </table>

</body>
</html>
