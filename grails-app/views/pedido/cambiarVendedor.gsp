<%@ page import="crm.Oportunidad" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'pedido.label', default: 'Oportunidad')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
             
   
	</head>
	<body>

		<div id="edit-pedido" class="content scaffold-edit" role="main">
			
		        <h2>Cambiar Vendedor </h2>
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
                           
			  <g:form id="frmCambiar" class="form-horizontal" url="[resource:pedidoInstance, action:'cambiarVendedorDef']" method="PUT" >
				 <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar
                                  </button>
                                 <a  class="btn btn-mini" href="/crm/pedido/index/?sort=fechaApertura&order=desc&estado=${params.estado}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                                 <br>
                                 <br>
                                 
			    	   <fieldset class="form">
                                  <div class="control-group">
                                    <label class="control-label" for="idVendedor">
                                            <g:message code="pedido.idVendedor.label" default="Ej- de Venta Actual" />
                                        
                                    </label>
                                    <div class="controls"  style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:220px;min-height:21px;background-color:#EEE;">
                                        ${pedidoInstance.empleado.nombreCompleto()}
                                    </div>
                                  </div>
				  <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'idVendedor', 'error')}">
                                    <label class="control-label" for="idVendedor">
                                            <g:message code="pedido.idVendedor.label" default="Nuevo Ej. de Venta" />
                                        <span class="required-indicator">*</span>
                                    </label>
                                    <div class="controls">
                                         <g:select name="idVendedor" from="${vendedoresList}"
                                                  optionKey="id"    required=""
                                                  value=""
                                                  noSelection="['': 'Seleccione Vendedor']"  />
                                    </div>
                              </div>
           
				   </fieldset>		
                                             
                            <g:hiddenField  name ="idVendedorAnterior" value="${pedidoInstance?.empleado?.id?:0}" />
                                 
			</g:form>
	    </div>
	</body>
</html>
