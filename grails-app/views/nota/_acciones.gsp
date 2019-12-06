<div class="pull-left">
 <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</button>
 <g:if test="${notaInstance?.eliminado==1}" >
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
 &nbsp;<a  class="btn btn-mini" href="/crm/nota/index/${notaInstance?.idEntidad}?entidad=${notaInstance?.nombreEntidad}&tnota=${xtiponota}&zw=1">
                     <i class="icon-remove"></i>&nbsp;Cancelar</a>
</div>