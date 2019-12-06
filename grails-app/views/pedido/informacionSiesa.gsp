<%@ page import="crm.Pedido" %>
<%@ page import="crm.Empresa" %>

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'Pedido.label', default: 'Pedido')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>     

    </head>

    <body>
       <g:set var="generalService" bean="generalService" />
        <h2>Información Siesa </h2>
        <hr style="margin-top:10px;margin-bottom:10px;">    
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>

        <g:form class="form-horizontal" url="[resource:pedidoInstance, action:'informacionSiesaDef']" method="PUT">

            <button type="submit" class="btn btn-mini btn-primary">
                <i class="icon-download-alt icon-white "></i>&nbsp;Guardar
            </button>
             <a  class="btn btn-mini" href="/crm/pedido/index/?sort=fechaApertura&order=desc&estado=${params.estado}">
             <i class="icon-remove"></i>&nbsp;Cancelar</a>
            <br>
            <br>

            <fieldset class="form">
            
            
                <div class="control-group" >
                    <label class="control-label"> Num. Pedido</label>
                    <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:300px;min-height:21px;background-color:#EEE;">
                        ${pedidoInstance?.numPedido}
                    </div>
                </div>
                
                
                
                
                
				<div class="control-group" >
                    <label class="control-label"> Nombre del cliente</label>
                    <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:300px;min-height:21px;background-color:#EEE;">
                        ${pedidoInstance?.nombreCliente}
                    </div>
                </div>                


                
                <% def nitEmpresa=Empresa.get(pedidoInstance.empresa.id).nit 
                
				def mtrm=pedidoInstance.trm			
                %>
                
                <div class="control-group" >
                    <label class="control-label"> NIT</label>
                    <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:300px;min-height:21px;background-color:#EEE;">
                        ${nitEmpresa}
                    </div>
                </div>
                
			     
			    <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'trm', 'error')} ">
			        <label class="control-label" for="trm">TRM  </label>      
			        <div class="controls">  				        
					         <g:field type="number"  name="trmd"  value="${mtrm}" style="text-align: right"  
					         required=""  min="0" step="0.01" />					                      
			        </div>               
			    </div>   
			    
	
			    
			    
    <div class="control-group ">
        <label class="control-label" >
            Valor Pedido
        </label>
        <% 
            def xvalorpedido
          	if (pedidoInstance?.idTipoPrecio=='pedtprec01' && pedidoInstance.valorPedido!=null)
				xvalorpedido=pedidoInstance.valorPedido
			else
			{
				if (pedidoInstance?.idTipoPrecio=='pedtprec02' && pedidoInstance.valorPedido!=null)
				{
					if(pedidoInstance.trm!=0)		
						xvalorpedido=pedidoInstance.valorPedido/pedidoInstance.trm
					else
						xvalorpedido=pedidoInstance.valorPedido
				}
				else
				xvalorpedido=0

			}
			
          
        %>
    <div class="controls" >           
            <!--<g:formatNumber name="subtotal"  number="${xvalorpedido}"   format="###,###,###.00" locale="co"  />-->
            <g:field type="number" name="valorpedido" required="" style="text-align:right" step="0.01" min="0" value="${xvalorpedido}"/>                              
        </div>
    </div>
            
            
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
			<div class="control-group ${hasErrors(bean: pedidoInstance, field: 'idFormaPago', 'error')} ">
                <label class="control-label" for="idFormaPago">
                    <g:message code="pedido.idFormaPago.label" default="Forma de Pago" />
                </label>
                <div class="controls">
                    <g:select name="idFormaPago" id="idFormaPago"  from="${generalService.getValoresParametro('formadpago')}"
                        optionKey="idValorParametro"
                    value="${pedidoInstance?.idFormaPago}"
                    noSelection="['': '']" disabled="${xronly}" required="" name="formadepago" />
                </div>
            </div>
            
            
            
            
            
            
            
            
            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'idTipoPrecio', 'error')} ">
                <label class="control-label" for="idTipoPrecio">
                    <g:message code="pedido.idTipoPrecio.label" default="Precios en " />

                </label>
                <div class="controls">
                    <g:select name="idTipoPrecio"  from="${generalService.getValoresParametro('tipoprecio')}"
                        optionKey="idValorParametro"
                    value="${pedidoInstance?.idTipoPrecio}"
                    noSelection="['': 'Seleccione Tipo Moneda']" disabled="${xronly}"  required="" 
                    onchange='return controlTipoPrecio(${params.swtp})' name="tipoprecio" />
                </div>
            </div>
            
            
            
    
            
                
         </fieldset>
                
                
                
                
                
                
                
            </g:form>
    </body>
</html>