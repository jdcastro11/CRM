<%@ page import="crm.Oportunidad" 
import="crm.Empresa"
import="crm.Persona"
%>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="oportunidadService" bean="oportunidadService" />
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'Oportunidad')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    
        <g:javascript src="funcionesRequerimientos.js"/>
</head>

<body >
     <g:set var="seguridadService" bean="seguridadService" />
    <% def sw_crud=[1,1,1,1,0,0]  %>

    <div id="detalleconten">           

        <h2>${xtitulo}</h2>

        <hr style="margin-top:10px;margin-bottom:10px;">   
  

   
        <a  class="btn btn-mini" href="/crm/oportunidad/index?sort=fechaApertura&order=desc"><i class="icon-remove"></i>&nbsp;Cancelar</a>

        <g:set var="beanInstance"  value="${oportunidadInstance}" />                
        <g:render template="/general/mensajes" />
        <a  href="#" class="req" > Listado Requerimiento</a>  
        
         <g:render template="listadoReq"/>
       
    </div>                     

<script>
 
</script>
</body>
</html>
