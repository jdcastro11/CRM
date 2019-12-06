<%@ page import="crm.Oportunidad" 
import="crm.Empresa"
import="crm.Persona"
%>
%{--Use generalindeService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="oportunidadService" bean="oportunidadService" />





<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>
        <g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'Oportunidad')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
    <style TYPE="text/css"> 
        a.gris:link{font-size:13px !important;}
        a.gris:hover{background:#eee !important;color:#000 !important}
    </style>
    <export:resource />
    
     <g:javascript src="funcionesVistasCategorizadas.js"/>
</head>

<body >
    <g:set var="seguridadService" bean="seguridadService" />
    <% def sw_crud=[1,1,1,1,0,0] 
	
	 %>
	 


    <div id="detalleconten">           
		<h2>INICIO CRM - INDICADORES DE GESTIÓN</h2>
        <h2>${usuarioLogueado}</h2>
          	
        <hr style="margin-top:10px;margin-bottom:10px;">	
        <g:set var="usuarioLogueado" value="${usuarioLogueado}" scope="request" />		
	        <g:render template="../general/infoEmpleadoQMaury"  />               
   </div>
   


   
</body>
</html>




   



