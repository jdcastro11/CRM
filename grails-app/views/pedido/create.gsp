<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'pedido.label', default: 'Pedido')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
     
        <script>
            function validarPedido(){
            debugger;
                if (frmPedido.clienteNuevo.value.trim()==''){
                    alert("Defina el tipo de cliente");
                    $("#tab-princ").trigger("click"); 
                    $("#clienteNuevo").focus(); 
                    return false;
                   } 
                if (frmPedido.idFormaPago.value.trim()==''){
                  alert("Defina la forma de Pago")
                    $("#tab-princ").trigger("click");
                    frmPedido.idFormaPago.focus() ;            
                    return false;
                }
                if (frmPedido.idTipoPrecio.value.trim()==''){
                    alert("Defina tipo de precios")
                    $("#tab-princ").trigger("click");
                    frmPedido.idTipoPrecio.focus() ;            
                    return false;
                }
                if (frmPedido.dirDespacho.value.trim()==''){
                  alert("Defina la dirección de Despacho")
                    $("#tab-princ").trigger("click");
                    frmPedido.dirDespacho.focus() ;            
                    return false;
                }
                 if (frmPedido.dirEntregaFactura.value.trim()==''){
                  alert("Defina dirección para entregar factura ")
                    $("#tab-princ").trigger("click");
                    frmPedido.dirEntregaFactura.focus() ;            
                    return false;
                }
                 
                
                 if (frmPedido.idMondedaFactura.value.trim()==''){
                    alert("Defina tipo moneda")
                     $("#tab-princ").trigger("click");
                    frmPedido.idMondedaFactura.focus() ;            
                    return false;
                }
                
                 if (frmPedido.requierePolizas.value.trim()==''){
                    alert("Defina si hay polizas")
                    $("#tab-princ").trigger("click");
                    frmPedido.requierePolizas.focus() ;            
                    return false;
                }
                
                 if (frmPedido.campaniaRedsis.value.trim()==''){
                    alert("Defina si campaña Redsis")
                    $("#tab-princ").trigger("click");
                    frmPedido.campaniaRedsis.focus() ;            
                    return false;
                   } 
                 if (frmPedido.idBidNexsys.value.trim()==''){
                    alert("Defina si BID Nexsys")
                    $("#tab-princ").trigger("click");
                    frmPedido.idBidNexsys.focus() ;            
                    return false;
                   } 
                   
                 if (frmPedido.compraIbm.value.trim()==''){
                    alert("Defina si compra IBM")
                    $("#tab-princ").trigger("click");
                    frmPedido.compraIbm.focus() ;            
                    return false;
                 } 
                 if (frmPedido.servicioIbm.value.trim()==''){
                    alert("Defina si hay servicios Redsis")
                     $("#tab-princ").trigger("click");
                    frmPedido.servicioIbm.focus() ;            
                    return false;
                 } 
                 if (frmPedido.facturacionParcial.value.trim()==''){
                    alert("Defina si hay facturacion parcial")
                      $("#tab-princ").trigger("click");
                    frmPedido.facturacionParcial.focus() ;            
                    return false;
                 } 
                 if (frmPedido.arquitectoSol.value.trim()==''){
                    alert("Defina si hay arquitectos")
                      $("#tab-princ").trigger("click");
                    frmPedido.arquitectoSol.focus() ;            
                    return false;
                 } 
                 return true;
              }
        </script>
    </head>
    <body>

        <div id="create-pedido" class="content scaffold-create" role="main">

            <h2>Nuevo Pedido</h2>
            <hr style="margin-top:10px;margin-bottom:10px;"> 
            <g:form name="frmPedido" class="form-horizontal" onsubmit="desactivar('botonPed')"  url="[resource:pedidoInstance, action:'save']" >
                <fieldset class="form">
                    <button type="submit" id='btn_save_ped' onclick="if (validarPedido()){frmPedido.submit(); desactivar('btn_save_ped')}" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</button>
                     <a  class="btn btn-mini" href="/crm/pedido/index/?sort=fechaApertura&order=desc&estado=${params.estado}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                    <br><br>
                     <g:set var="beanInstance"  value="${pedidoInstance}" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
