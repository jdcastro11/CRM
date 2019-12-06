<div class="pull-left">
     <g:set var="seguridadService" bean="seguridadService" />
   <% def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/tactica/index') %>
 <g:if test="${'MODIFICAR' in derechos}"> 
    <a class="btn btn-success  btn-mini" href="/crm/tactica/edit/${tacticaInstance?.id}">
     <i class="icon-edit icon-white" ></i>&nbsp;Editar</a>
 </g:if>
 <g:if test="${'BORRAR' in derechos}">
    <a href="#" class="btn btn-danger btn-mini" 
         onclick='return BootstrapDialog.confirm("Está seguro de borrar este registro?",
         function(result) { if(result)window.location.href="${createLink(url:[controller:'Tactica', action:'borrar',id:tacticaInstance.id])}"})'>
         <i class="icon-trash icon-white"></i> Borrar</a>				
</g:if>
 <div class="btn-group">
    <a href="#" class="btn btn-mini" >Acciones</a>
   <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
   <span class="caret"></span></button>
    <ul class="dropdown-menu">
         <li align="center">Ninguna </li>
   </ul>										
 </div>
    &nbsp;<a  class="btn btn-mini" href="/crm/tactica/index/${tacticaInstance?.estrategia?.id}"> <i class="icon-remove"></i>&nbsp;Cancelar</a>
</div>