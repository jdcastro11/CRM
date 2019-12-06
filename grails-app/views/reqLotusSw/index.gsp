<%@ page import="crm.Oportunidad" 
import="crm.Empresa"
import="crm.Persona"
%>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="seguridadService" bean="seguridadService" />
<%
   def mover=generalService.getMenuV(1)
   def mout=generalService.getMenuV(2)
   def estilo=generalService.getMenuV(3)
%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'Oportunidad')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
 
</head>
    
<body >
    
     <g:set var="seguridadService" bean="seguridadService" />
    <% def sw_crud=[1,1,1,1,0,0] 
     def userActual=generalService.getNombreEmpleado(session['idUsuario'].toLong()).toString() %>

    <div id="detalleReq">          
        <h2>${xtitulo}</h2>

        <hr style="margin-top:10px;margin-bottom:10px;">   
  
        <div class="pull-left">
            <div class="pull-left">
                <g:if test="${'CREAR' in seguridadService.operacionesPorOpcion(session['idUsuario'],'/reqLotusSw/index')}">
                   <g:if test="${pedido=='Si'}">
                     <g:if test="${userActual=='Katerine Delgado' || userActual=='Jose Maury'|| userActual=='Danna Zarate'|| userActual=='Diana Heredia'}">
                     	<a class="btn btn-mini btn-primary" href="/crm/reqLotusSw/create/?pedido=S&numOportunidad=${numOportunidad}">
	                        <i class="icon-plus icon-white"></i>
	                        <strong><g:message code="default.nuevo.req"/></strong>
	                    </a>
                     </g:if>    
                   </g:if> 
                    <g:if test="${pedido=='No'}"  >    
                    <a class="btn btn-mini btn-primary" href="/crm/reqLotusSw/create/?pedido=N&numOportunidad=${numOportunidad}">
                        <i class="icon-plus icon-white"></i>
                        <strong><g:message code="default.nuevo.req"/></strong>
                    </a>
                   </g:if> 
                </g:if>
            </div>
        </div>
        &nbsp;
        <g:set var="beanInstance"  value="${oportunidadInstance}" />                
        <g:render template="/general/mensajes" />
        
         <g:render template="listadoReq"/>
       
    </div>                     

<script>
  var contenido= $("#detalleReq");
  if (parent.IFRAME_REQUERIMIENTO !=null) parent.IFRAME_REQUERIMIENTO.height(contenido.height()+60);      
</script>
</body>
</html>
