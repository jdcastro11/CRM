 <g:set var="seguridadService" bean="seguridadService" />
<div class="pull-left">
    <% def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/faq/indexn') %>
    <g:if test="${'MODIFICAR' in derechos }"> 
  <a class="btn btn-mini btn-success" href="/crm/faq/edit/${faqInstance.id}">
      <i class="icon-edit icon-white"></i>&nbsp;Editar</a> 
  </g:if>
     <g:if test="${'BORRAR' in derechos}">
   <a href="#" class="btn btn-danger btn-mini" 
      onclick='return BootstrapDialog.confirm("Está seguro de borrar este registro?",
      function(result){ if(result) window.location.href="${createLink(url:[controller:'faq', action:'borrar',id:faqInstance.id])}"})'>                                                     
      <i class="icon-trash icon-white"></i>&nbsp;Borrar</a>	
</g:if>
 <div class="btn-group">
    <a href="#" class="btn btn-mini" >Acciones</a>
   <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
   <span class="caret"></span></button>
    <ul class="dropdown-menu">
     <li align="center">Ninguna </li>
   </ul>										
 </div>
     <a  class="btn btn-mini" href="/crm/faq/index"><i class="icon-remove"></i>&nbsp;Cancelar</a>
</div>