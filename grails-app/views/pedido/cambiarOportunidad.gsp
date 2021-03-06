-<%@ page import="crm.Pedido" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'pedido.label', default: 'Pedido')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>    
        <g:javascript library="jquery-ui"/>
        <g:javascript library="jquery"/>
        
	</head>
      
	<body>
			
		        <h2>Cambiar  Oportunidad  Asociada al Pedido </h2>
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
                           
			<g:form id="frmCambiar" class="form-horizontal" url="[resource:pedidoInstance, action:'cambiarOportunidadDef']" method="PUT" >
                            
                              <button type="submit" class="btn btn-mini btn-primary">
                                  <i class="icon-download-alt icon-white "></i>&nbsp;Guardar
                              </button>
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
                                 <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'numOportunidad', 'error')} ">
                                    <label class="control-label" for="numOportunidad">
                                        <g:message code="pedido.numOportunidad.label" default="Nueva Oportunidad" />
                                    </label>
                                    <div class="controls">
                                     <g:select class="input-xxlarge" name="oportunidad.id" from="${crm.Oportunidad.findAllByEliminado(0)}" 
                                            optionKey="id" 
                                             value="${pedidoInstance?.oportunidad?.id}"
                                            noSelection="['': 'Seleccione Oportunidad']"   />
                                    </div>
                                </div> 

               
                                 <g:hiddenField name="pedList"  value="${pedList}"/>                                
                                 
			</g:form>
	    
	</body>
</html>
