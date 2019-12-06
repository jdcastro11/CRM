<g:set var="oportunidadService" bean="oportunidadService" />
<g:set var="seguridadService" bean="seguridadService" />
<%
def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/prospecto/index')

%>

<div class="pull-left">
    <g:if test="${!(prospectoInstance.idEstadoProspecto in ['propasopox','prodescalx'])}" >
        <g:if test="${'MODIFICAR' in session['operaciones']}">                 
                <a class="btn btn-mini btn-success"  href="/crm/prospecto/edit/${prospectoInstance?.id}">
                  <i class="icon-edit icon-white"  ></i>&nbsp;<g:message code="edit.prospecto.label" default="Editar"/></a>
         </g:if> 
            
        <g:if test="${'BORRAR' in session['operaciones']}">
            <a href="#" class="btn btn-danger btn-mini" 
                     onclick='return BootstrapDialog.confirm("Está seguro de borrar este registro?",function(result){
                     if(result)
                       window.location.href="${createLink(url:[controller:'Prospecto', action:'borrar',id:prospectoInstance.id])}"})'>
                        <i class="icon-trash icon-white"></i>&nbsp;<g:message code="delete.prospecto.label" default="Borrar"/>
                   </a> 			

         </g:if> 
     </g:if>
    <%  def swacc=0 %> 
 <div class="btn-group">
     <a href="#" class="btn btn-mini" ><g:message code="acciones.label" default="Acciones"/></a>
   <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
   <span class="caret"></span></button>
    <ul class="dropdown-menu">
         <g:if test="${'MODIFICAR' in session['operaciones']}"> 
              <%  swacc=1 %>
        <li><a href="#" 
            onClick="var xidempresa = document.getElementById('idempresa').value;if(xidempresa=='')return;cargar_modal('crm_modal','modal_body','/crm/empresa/edit/'+xidempresa+'?layout=detail&tipo=1&swnit=1&swmodal=1&t=empresat12','refresh_combo')"><g:message code="nit.empresa.label" default="Definir Nit"/></a> 
        </li> 
         </g:if>
         
         <g:if test="${'ASIGNAR_VENDEDOR' in derechos}">
         	<li><a href="${createLink(action:'asignarVendedor',params:[idProsp:prospectoInstance.id])}" ><g:message code="asignarVendedor.prospecto.label" default="Asignar Vendedor"/></a></li>
         </g:if>
         
         
         <g:if test="${'DESCALIFICAR' in derechos}">
         	<li><a href="${createLink(action:'descalificar',params:[idProsp:prospectoInstance.id])}" ><g:message code="descalificar.prospecto.label" default="Descalificar"/></a></li>
         </g:if>
         
         <g:if test="${'CONVERTIR_OPORTUNIDAD' in derechos}">
         	<li><a href="${createLink(action:'convertir',params:[idProsp:prospectoInstance.id])}" ><g:message code="convertir.prospecto.label" default="Convertir a Oportunidad"/></a></li>
         </g:if>
         
          
	     <g:if test="${swacc==0}">
	       <li align="center">Ninguna</li>
	     </g:if>
   </ul>										
 </div>
   <a  class="btn btn-mini" href="/crm/Prospecto/index?sort=fechaApertura&order=desc"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label" default="Cancelar"/></a>
</div>