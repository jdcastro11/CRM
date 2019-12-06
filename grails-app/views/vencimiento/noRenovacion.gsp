<%@ page import="crm.Vencimiento" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="detalle">
		<g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'Oportunidad')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
             
   
	</head>
	<body>

              %{--Use generalService--}%
              <g:set var="generalService" bean="generalService" />		
			
		        <h2>No renovación vencimiento</h2>
		        <hr style="margin-top:10px;margin-bottom:10px;">                      
			<%--<form id="frmCierre" class="form-horizontal" action="/crm/oportunidad/cerrarOportunidadDef" method="post" > --%>
                            <g:form  id="frmCierre" class="form-horizontal" url="[resource:vencimientoInstance, action:'clienteNoRenovoDef']" method="PUT" >
				 <a href="#" class="btn btn-mini btn-primary"
                                 onclick='return BootstrapDialog.confirm("Está seguro de marcar este vencimiento como vencido no renovado?",
                                 function(result){ if(result) document.getElementById("frmCierre").submit();
                               })'><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</a>

                              <a  class="btn btn-mini" href="/crm/vencimiento/index?idenc=${params.idenc}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                                 <br>
                                 <br>
                                  <g:set var="beanInstance"  value="${vencimientoInstance}" />                
                                <g:render template="/general/mensajes" />
			    	 <fieldset class="form">                                      
                                        <div id="divNoRenovacion">                                        
                                         <g:render template="infoNoRenovacion" />
                                       </div>
				   </fieldset>
                                 
			</g:form>
	    
	</body>
</html>