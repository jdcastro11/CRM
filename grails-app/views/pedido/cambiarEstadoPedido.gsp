-<%@ page import="crm.Pedido" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'pedido.label', default: 'Pedido')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>            
	</head>
      
	<body>
			
		        <h2>Cambiar Estado del Pedido </h2>
		        <hr style="margin-top:10px;margin-bottom:10px;">    
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${pedidoInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${pedidoInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors> 
                           
			<g:form id="frmCambiar" class="form-horizontal" url="[resource:pedidoInstance, action:'cambiarEstadoPedidoDef']" method="PUT" >
                            
                              <button type="submit" class="btn btn-mini btn-primary">
                                  <i class="icon-download-alt icon-white "></i>&nbsp;Guardar
                              </button>
                                <button type="reset" class="btn btn-mini" onclick="history.go(-1)"><i class="icon-remove"></i>&nbsp;Cancelar</button>
                                 <br>
                                 <br>
                                  
			    	 
                                        <div class="control-group" >
                                           <label class="control-label"> Num. Pedido</label>
                                             <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:300px;min-height:21px;background-color:#EEE;">
                                                  ${pedidoInstance.numPedido}
                                             </div>
                                        </div>
                                 <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'idEstadoPedido', 'error')} ">
                                    <label class="control-label" for="idEstadoPedido">
                                        <g:message code="pedido.idEstadoPedido.label" default="Estado del Pedido" />
                                    </label>
                                    <div class="controls">                                       
                                        <g:select name="idEstadoPedido" from="${estadosList}"
                                            optionKey="idValorParametro"
                                        value="${pedidoInstance?.idEstadoPedido}"
                                        noSelection="['': '']" disabled="${xronly}"  />
                                    </div>
                                </div> 
                          
                                 
			</g:form>
	    
	</body>
</html>
