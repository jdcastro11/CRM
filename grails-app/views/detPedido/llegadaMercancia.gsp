<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">		
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
             
   
	</head>
	<body>

		<div id="edit-oportunidad" class="content scaffold-edit" role="main">
			
		        <h2>Reporte LLegada de Mercancía </h2>
		        <hr style="margin-top:10px;margin-bottom:10px;">                 
			
                           
			<form  class="form-horizontal" action="/crm/detPedido/infoLLegadasDef" method="post" >
				 <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Generar
                                  </button>
                                 <a  class="btn btn-mini" href="/crm/detPedido/infoLLegadas"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                                 <br>
                                 <br>
                                  <g:set var="beanInstance"  value="${pedidoInstance}" />                
                                 <g:render template="/general/mensajes" />
                                 <div class="box-content" > 
			    	   <fieldset class="form">
				            <div class="control-group">
                                    <label class="control-label" > Mes   
                                        <span class="required-indicator">*</span>
                                    </label>
                                    <div class="controls">
                                    <g:datePicker name="fecha" value="" precision="month" 
                                        noSelection="['':'Selecione Mes']" />
                                    </div>
                              </div>
			   </fieldset>		
                                </div>
                                
			</form>
	    </div>
	</body>
</html>
