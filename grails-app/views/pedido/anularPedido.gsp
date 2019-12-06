-<%@ page import="crm.Oportunidad" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'pedido.label', default: 'Oportunidad')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
             
   
	</head>
	<body>

              %{--Use generalService--}%
              <g:set var="generalService" bean="generalService" />		
			
		        <h2>Anular Pedido </h2>
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
                           
			<g:form id="frmAnular" class="form-horizontal" url="[resource:pedidoInstance, action:'anularPedidoDef']" method="PUT" >
                            
				 <a href="#" class="btn btn-mini btn-primary"
                                 onclick='return BootstrapDialog.confirm("Está seguro de Anular este Pedido?",
                                 function(result){ if(result) document.getElementById("frmAnular").submit();
                               })'><i class="icon-download-alt icon-white "></i>&nbsp;Aceptar</a>

                                 <a  class="btn btn-mini" href="/crm/pedido/index/?sort=fechaApertura&order=desc&estado=${params.estado}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                                 <br>
                                 <br>
                                  
			    	 <fieldset class="form">
                                        <div class="control-group" >
                                           <label class="control-label"> Num. Pedido</label>
                                             <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:300px;min-height:21px;background-color:#EEE;">
                                                  ${pedidoInstance.numPedido}
                                             </div>
                                        </div>
                                    <div class="control-group" >
                                           <label class="control-label"> Cliente</label>
                                             <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:300px;min-height:21px;background-color:#EEE;">
                                                  ${pedidoInstance?.empresa.razonSocial}
                                             </div>
                                        </div>
				   </fieldset>		
               
                                 <g:hiddenField name="pedList"  value="${pedList}"/>                                
                                 
			</g:form>
	    
	</body>
</html>
