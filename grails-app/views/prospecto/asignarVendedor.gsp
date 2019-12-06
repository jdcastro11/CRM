<%@ page import="crm.Prospecto" %>
<%@ page import="crm.Empresa" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'prospecto.label', default: 'Prospecto')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
             
   
	</head>
	<body>	
		<div id="edit-prospecto" class="content scaffold-edit" role="main">			
		        <h2><g:message code="asignarVendedor.prospecto.label" default="Asignar Vendedor"/></h2>
		        <hr style="margin-top:10px;margin-bottom:10px;"> 
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${prospectoInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${prospectoInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors> 
                           
			<form  class="form-horizontal" action="/crm/prospecto/asignarVendedorDef">
				  <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white ">
                                    </i>&nbsp;<g:message code="default.button.create.label" default="Guardar"/></button>

                                 <button type="reset" class="btn btn-mini" onclick="history.go(-1)"> <i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label" default="Cancelar"/></button>
                                 <br>
                                 <br>
                   <div class="box-content" >
			           <fieldset class="form">
                      
                           <div class="control-group">
                                <label class="control-label" >
                                   Oportunidad SC
                               </label>
                               <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:400px;background-color:#EEE">
                                  ${Prospecto.get(posList)}
                               </div>
                           </div>
                            <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'idVendedor', 'error')}">
                                       <label class="control-label" for="idVendedor">
                                        <g:message code="prospecto.idVendedor.label" default="Ejecutivo de Venta" />
                                           <span class="required-indicator">*</span>
                                         </label>
                                              <div class="controls">
                                                     <g:select name="idVendedor" from="${vendedoresList}" 
                                                              optionKey="id"    required=""
                                                              value="${prospectoInstance?.empleado?.id}"
                                                              noSelection="['': 'Seleccione Vendedor']"  />
                                                </div>
                              </div>
				   </fieldset>		
                                </div>
                                 <g:hiddenField name="posList"  value="${posList}"/>                               
                                 
			</form>
	    </div>
	</body>
</html>
