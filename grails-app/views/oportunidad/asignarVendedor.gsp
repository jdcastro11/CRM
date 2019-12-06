<%@ page import="crm.Oportunidad" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'Oportunidad')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
             
   
	</head>
	<body>

		<div id="edit-oportunidad" class="content scaffold-edit" role="main">
			
		        <h2>Cambiar Vendedor </h2>
		        <hr style="margin-top:10px;margin-bottom:10px;"> 
                      
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${oportunidadInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${oportunidadInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors> 
                           
			<form  class="form-horizontal" action="/crm/oportunidad/asignarVendedorDef" method="post" >
				 <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar
                                  </button>
                                 <a  class="btn btn-mini" href="/crm/oportunidad/index?sort=fechaApertura&order=desc"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                                 <br>
                                 <br>
                                 <div class="box-content" > 
			    	   <fieldset class="form">
				            <div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'idVendedor', 'error')}">
                                    <label class="control-label" for="idVendedor">
                                            <g:message code="oportunidad.idVendedor.label" default="Ejecutivo de Venta" />
                                        <span class="required-indicator">*</span>
                                    </label>
                                    <div class="controls">
                                         <g:select name="idVendedor" from="${vendedoresList}"
                                                  optionKey="id"    required=""
                                                  value="${oportunidadInstance?.empleado?.id}"
                                                  noSelection="['': 'Seleccione Vendedor']"  />
                                    </div>
                              </div>

                           <div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'observCambioVendedor', 'error')} ">
                               <label  class="control-label" for="observCambioVendedor">
                                   <g:message code="oportunidad.observCambioVendedor.label" default="Observaciones" />
                               </label>
                               <div class="controls">
                                   <g:textArea style="width:400px;"  name="observCambioVendedor"  rows="4"  value="${oportunidadInstance?.observCambioVendedor}" disabled="${xronly}"  />
                               </div>
                           </div>
				   </fieldset>		
                                </div>
                                 <g:hiddenField name="posList"  value="${posList}"/> 
			</form>
	    </div>
	</body>
</html>
