<g:set var="oportunidadService" bean="oportunidadService" />
<g:set var="seguridadService" bean="seguridadService" />
<%
def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/prospecto/index')

%>

<div class="pull-left">
<g:if test="${'MODIFICAR' in session['operaciones']}">
<button type="submit" id="btn_convert_prospect"  class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar
</button> 
</g:if>
<g:if test="${'BORRAR' in session['operaciones']}">
 <g:if test="${prospectoInstance?.eliminado==1}" >
  <a href="#" onclick="crm_deseliminar()" class="btn btn-success  btn-mini">Borrar | Des-Borrar</a>
</g:if> 	
</g:if>
<div class="btn-group">
    <%  def swacc=0 %>
     <a href="#" class="btn btn-mini" >Acciones</a>
   <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
   <span class="caret"></span></button>
    <ul class="dropdown-menu">
         <g:if test="${'MODIFICAR' in session['operaciones']}"> 
              <%  swacc=1 %>
        <li><a href="#" 
            onClick="var xidempresa = document.getElementById('idempresa').value;if(xidempresa=='')return;cargar_modal('crm_modal','modal_body','/crm/empresa/edit/'+xidempresa+'?layout=detail&tipo=1&swnit=1&swmodal=1&t=empresat12','refresh_combo')">Definir Nit</a> 
        </li> 
         </g:if>
         
         <g:if test="${'ASIGNAR_VENDEDOR' in derechos}">
         	<li><a href="${createLink(action:'asignarVendedor',params:[idProsp:prospectoInstance?.id])}" >Asignar Vendedor</a></li>
         </g:if>
         
         
         <g:if test="${'DESCALIFICAR' in derechos}">
         	<li><a href="${createLink(action:'descalificar',params:[idProsp:prospectoInstance?.id])}" >Descalificar</a></li>
         </g:if>
         
         <g:if test="${'CONVERTIR_OPORTUNIDAD' in derechos}">
         	<li><a href="${createLink(action:'convertir',params:[idProsp:prospectoInstance?.id])}" >Convertir en Oportunidad</a></li>
         </g:if>
         
          
	     <g:if test="${swacc==0}">
	       <li align="center">Ninguna</li>
	     </g:if>
   </ul>										
 </div>
   <a  class="btn btn-mini" href="/crm/Prospecto/index?sort=fechaApertura&order=desc"><i class="icon-remove"></i>&nbsp;Cancelar</a>
</div>