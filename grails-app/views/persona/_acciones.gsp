<div class="pull-left">
<g:if test="${params.swmodal==''}">
   <g:actionSubmit class="btn btn-mini btn-primary"  action="update" value="Guardar" />
    
</g:if>
 <g:else>
 <button type="button" class="btn btn-mini btn-primary" 
            onclick="if (validarPersona()) guardarEntidad('/crm/persona/updateAsync','formPersona','modal_body','idContacto','nombreContacto')">
            <i class="icon-download-alt icon-white"></i>&nbsp;<g:message code="default.button.create.label"/></button>
</g:else>
 			
 <div class="btn-group">
    <a href="#" class="btn btn-mini" ><g:message code="acciones.label"/></a>
   <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
   <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li align="center">Ninguna </li>     
   </ul>										
 </div>
  <g:if test="${params.swmodal==''}" >
     &nbsp;
     <a  class="btn btn-mini" href="/crm/persona/index/"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a> 
  </g:if> 
</div>