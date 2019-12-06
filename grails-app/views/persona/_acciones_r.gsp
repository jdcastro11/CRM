<div class="pull-left">
    <g:if test="${'MODIFICAR' in session['operaciones']}"> 
<g:link class="btn btn-mini btn-primary"  controller="Persona" action='edit'
       params="[pw:1,layout:'main',swmodal:'']" id="${personaInstance.id}">Editar...</g:link>  
</g:if>
 <g:if test="${'BORRAR' in session['operaciones']}">
   <a href="#" class="btn btn-danger btn-mini" 
      onclick='return BootstrapDialog.confirm("Está seguro de borrar este registro?",
      function(result) { if(result)window.location.href="${createLink(url:[controller:'Persona', action:'borrar',id:personaInstance.id])}"})'>                                                     
      <i class="icon-trash icon-white"></i>&nbsp;<g:message code="default.button.delete.label"/></a>
 </g:if>
 <div class="btn-group">
    <a href="#" class="btn btn-mini" ><g:message code="acciones.label"/></a>
   <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
   <span class="caret"></span></button>
    <ul class="dropdown-menu">
        <li align="center">Ninguna </li>
   </ul>										
 </div>
   &nbsp;<a  class="btn btn-mini" href="/crm/persona/index/"> <i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a> 
</div>