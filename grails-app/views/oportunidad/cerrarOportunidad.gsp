<%@ page import="crm.Oportunidad" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'Oportunidad')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
             
   
	</head>
	<body>

              %{--Use generalService--}%
              <g:set var="generalService" bean="generalService" />		
			
		        <h2>Cerrar Oportunidad </h2>
		        <hr style="margin-top:10px;margin-bottom:10px;">    
		
                           
			<%--<form id="frmCierre" class="form-horizontal" action="/crm/oportunidad/cerrarOportunidadDef" method="post" > --%>
                            <g:form  id="frmCierre" class="form-horizontal" url="[resource:oportunidadInstance, action:'cerrarOportunidadDef']" method="PUT" >
				 <a href="#" class="btn btn-mini btn-primary"
                                 onclick='return BootstrapDialog.confirm("Está seguro de cerrar esta oportunidad?",
                                 function(result){ if(result) document.getElementById("frmCierre").submit();
                               })'><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</a>

                              <a  class="btn btn-mini" href="/crm/oportunidad/index?sort=fechaApertura&order=desc"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                                 <br>
                                 <br>
                                  <g:set var="beanInstance"  value="${oportunidadInstance}" />                
                                <g:render template="/general/mensajes" />
			    	 <fieldset class="form">                                      
                                        <div id="divperdida">
                                        <%  if (params?.sw=='xperdida') xronly="false" %>
                                         <g:render template="infoPerdida" />
                                       </div>
				   </fieldset>		
               
                                 <g:hiddenField name="posList"  value="${posList}"/>
                                 <g:hiddenField name="xempresa"  value="${xempresa}"/>
                                 
			</g:form>
	    
	</body>
</html>
