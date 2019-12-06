<g:set var="oportunidadService" bean="oportunidadService" />
<g:set var="seguridadService" bean="seguridadService" />
<%
def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/oportunidad/index')
%>
<g:set var="oportunidadService" bean="oportunidadService" />
<div class="pull-left">
    <g:if test="${oportunidadService.oportunidadCerrada((String)oportunidadInstance.id)=='N' }" >
        <g:if test="${'MODIFICAR' in derechos}"> 
            <a class="btn btn-mini btn-success"  href="/crm/oportunidad/edit/${oportunidadInstance.id}?sm=${params.sm}"><i class="icon-edit icon-white"></i>&nbsp;<g:message code="default.edit.label"/>
            </a>
        </g:if>
        <g:if test="${'BORRAR' in derechos}">
            <a href="#" class="btn btn-danger btn-mini"
            onclick='return BootstrapDialog.confirm("Está seguro de borrar este registro?",function(result){
            if(result)
            window.location.href="${createLink(url:[controller:'Oportunidad', action:'borrar',id:oportunidadInstance.id])
}"})'><i class="icon-trash icon-white"></i>&nbsp;<g:message code="default.button.delete.label"/></a>				
        </g:if>
        </g:if>
    <div class="btn-group">
        <%  def swacc=0 %>
        <a href="#" class="btn btn-mini" ><g:message code="acciones.label"/></a>
        <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
            <span class="caret"></span></button>
        
        <ul class="dropdown-menu">
             <g:if test="${"GENERAR_PEDIDO" in derechos}">
              	<%  swacc=1 %>
             	<li><a href="/crm/oportunidad/generarPedido/${oportunidadInstance.id}" >Generar Pedido. </a></li>
             </g:if>
             	
             <g:if test="${'ABRIR_OPORTUNIDAD' in derechos && oportunidadInstance?.idEstadoOportunidad=='xperdida'}">
             	<%  swacc=1 %>
             	<li><a href="${createLink(action:'abrirOportunidad',params:[idOp:oportunidadInstance.id])}" >Abrir oportunidad </a></li>
             </g:if>
             <g:if test="${'CERRAR_OPORTUNIDAD' in derechos}">
             	<%  swacc=1 %>
             	<li><a href="${createLink(action:'cerrarOportunidad',params:[idOp:oportunidadInstance.id])}" ><g:message code="cerrarOportunidad.oppty.label"/></a></li>
             </g:if>
             <g:if test="${'ASIGNAR_VENDEDOR' in derechos}">
             	<%  swacc=1 %>
             	<li><a href="${createLink(action:'asignarVendedor',params:[idOp:oportunidadInstance.id])}" ><g:message code="cambiarVendedor.oppty.label"/></a></li>
             </g:if>	
             
             
            <g:if test="${swacc==0}" >
            <li align="center">Ninguna </li>
           </g:if>
        </ul>										
    </div>

<% 
   def xurl ="/crm/oportunidad/index?sort=fechaApertura&order=desc"
  if (params?.sm=='1')
      xurl="/crm/oportunidad/indexg"
%>
<a  class="btn btn-mini" href="${xurl}"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>
</div>