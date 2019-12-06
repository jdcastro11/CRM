<div class="pull-left">
 <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</button>
 <g:if test="${contactoInstance?.eliminado==1}" >
  <a href="#" onclick="crm_deseliminar()" class="btn btn-success  btn-mini">Borrar | Des-Borrar</a>
</g:if> 					
 <div class="btn-group">
    <a href="#" class="btn btn-mini" >Acciones</a>
   <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
   <span class="caret"></span></button>
    <ul class="dropdown-menu">
       <li align="center">Ninguna </li>   
   </ul>										
 </div>
   <g:if test="${params.layout=='main'}">
   <a  class="btn btn-mini" href="/crm/contacto/index?layout=main"><i class="icon-remove"></i>&nbsp;Cancelar</a>
</g:if>
<g:else>
   <a  class="btn btn-mini" href="/crm/contacto/listarContactos/${contactoInstance?.empresa?.id}?t=contactt00&layout=detail"><i class="icon-remove"></i>&nbsp;Cancelar</a>
</g:else>
</div>