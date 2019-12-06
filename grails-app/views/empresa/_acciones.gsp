<g:set var="seguridadService" bean="seguridadService" />
<%
def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/empresa/index') 

%>
<div class="pull-left">
<g:if test="${params.swmodal==''}">
   <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;<g:message code="default.button.create.label"/></button>
</g:if>
 <g:else>
 <button type="button" class="btn btn-mini btn-primary" onclick="guardarEntidad('/crm/empresa/updateAsync','formEmpresa','modal_body','idempresa','nombreEmpresa')"><i class="icon-download-alt icon-white"></i>&nbsp;<g:message code="default.button.create.label" default="Guardar"/></button>
</g:else>
  <g:if test="${empresaInstance?.eliminado==1}" >
  <a href="#" onclick="crm_deseliminar()" class="btn btn-success  btn-mini"><g:message code="borrar.desborrar.label"/></a>
</g:if> 					
 <div class="btn-group">
     <%  def swacc=0 %>
    <a href="#" class="btn btn-mini" ><g:message code="acciones.label" default="Acciones"/></a>
   <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
   <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <g:if test="${'CAMBIAR_RAZON_SOCIAL' in derechos}"> 
        <% swacc=1 %>
        <li><a href="#" class="btn-mini" 
         onclick='return BootstrapDialog.confirm("Si no es una corrección ortográfica, no debe hacer el cambio\nConfirma el cambio?",
         function(result) { if(result)window.location.href="/crm/empresa/cambiarRazonSocial/${empresaInstance?.id}"})'>
        <g:message code="cambiarRazonSocial.empresa.label" default="Cambiar Razón Social"/></a></li>
        <g:if test="${swacc==0}" >
         <li align="center">Ninguna </li>
       </g:if>
      </g:if>
   </ul>										
 </div>
 <g:if test="${params.swmodal==''}">
    <a  class="btn btn-mini" href="/crm/empresa/index/2?layout=main&sort=razonSocial"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>
</g:if>
   </div>