<div class="pull-left">
  <g:if test="${'MODIFICAR' in session['operaciones']}">
   <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar oportunidad
   </button>
</g:if> 					
 <g:if test="${'BORRAR' in session['operaciones']}">
   <g:if test="${oportunidadInstance?.eliminado==1}" >
    <a href="#" onclick="crm_deseliminar()" class="btn btn-success  btn-mini">Borrar | Des-Borrar</a>
  </g:if>
</g:if>
 <div class="btn-group">
     <%  def swacc=0 %>
     <a href="#" class="btn btn-mini" >Acciones</a>
   <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
   <span class="caret"></span></button>
    <ul class="dropdown-menu">
       <%  swacc=1 %>
      <li><a href="/crm/oportunidad/generarPedido/${oportunidadInstance.id}" >Generar Pedido </a></li>      
        <g:if test="${swacc==0}" >
        <li align="center">Ninguna </li>
       </g:if>
   </ul>										
 </div>
  <%

   def xurl ="/crm/oportunidad/index?sort=fechaApertura&order=desc"
    if (params?.sm=='1')
      xurl="/crm/oportunidad/indexg"  
   %>
  <a  class="btn btn-mini" href="${xurl}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
</div>