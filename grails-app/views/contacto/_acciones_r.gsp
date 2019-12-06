<div class="pull-left">
<g:if test="${'MODIFICAR' in session['operaciones']}"> 
  <a class="btn btn-mini btn-success"  href="/crm/contacto/edit/${contactoInstance.id}?sw=1&swmodal=&layout=${params.layout}">
      <i class="icon-edit icon-white" ></i>&nbsp;<g:message code="default.edit.label" default="Editar"/></a>
 </g:if>
 <g:if test="${'BORRAR' in session['operaciones']}">
   <a href="#" class="btn btn-danger btn-mini" 
      onclick='return BootstrapDialog.confirm("Está seguro de borrar este registro?",
      function(result) { if(result) window.location.href="${createLink(url:[controller:'Contacto', action:'borrar',id:contactoInstance?.id])}"})'>
      <i class="icon-trash icon-white" ></i>&nbsp;<g:message code="default.button.delete.label"/></a>
</g:if>
 <div class="btn-group">
    <a href="#" class="btn btn-mini" ><g:message code="acciones.label"/></a>
   <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
   <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li align="center">Ninguna </li>
   </ul>										
 </div>
 <g:if test="${params.layout=='main'}">
   <a  class="btn btn-mini" href="/crm/contacto/index?layout=main"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>
</g:if>
<g:else>
   <a  class="btn btn-mini" href="/crm/contacto/listarContactos/${contactoInstance?.empresa?.id}?t=contactt00&layout=detail"><i class="icon-remove"></i>&nbsp;Cancelar</a>
</g:else>
</div>