-<%@ page import="crm.Pedido" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'pedido.label', default: 'Pedido')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>            
	</head>
      
	<body>
			
		        <h2>Pasar pedido a Detenido en compras</h2>
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
                           
			<g:form id="frmCambiar" class="form-horizontal" url="[resource:pedidoInstance, action:'detenidoEnComprasDef']" method="PUT" >
                            
                              <button type="submit" class="btn btn-mini btn-primary">
                                  <i class="icon-download-alt icon-white "></i>&nbsp;Guardar
                              </button>
                                <button type="reset" class="btn btn-mini" onclick="history.go(-1)"><i class="icon-remove"></i>&nbsp;Cancelar</button>
                                 <br>
                                 <br>
                                  <!-- JOSE DANIEL MAURY 09/08/2016 -->
			    	 
                                <div class="control-group" >
                                      <label class="control-label"> Num. Pedido</label>
                                        <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:300px;min-height:21px;background-color:#EEE;">
                                             ${pedidoInstance.numPedido}
                                        </div>
                                </div>
                                
                                <div class="control-group">
                                    <label class="control-label" >
                                        Notificados
                                    </label>
                                    <div class="controls">                                       
                                    	<g:textField name="notificarA" value="${notificados}" required style="width:300px;"/>                                    	
                                    </div>
                                </div>
                                
                                
                                
                                
                                
                                <div class="control-group">
                                    <label class="control-label" >
                                        Observaciones
                                    </label>
                                    <div class="controls">                                       
                                    	<g:textArea name="observaciones" required style="width:300px"/>                                    	
                                    </div>
                                </div> 
                                
                                 
                     		
                                 
			</g:form>
	    
	</body>
</html>
