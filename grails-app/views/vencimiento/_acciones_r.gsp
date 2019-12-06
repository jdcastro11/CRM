<div class="pull-left">
      
<g:if test="${'MODIFICAR' in session['operaciones'] && vencimientoInstance.idEstadoVencimiento!='vennorenov'}"> 
  <a class="btn btn-mini btn-success"  href="/crm/vencimiento/edit/${vencimientoInstance.id}?layout=${params.layout}">
   <i class="icon-edit icon-white"  ></i>&nbsp;Modificar contrato</a>
</g:if>
 <g:if test="${'BORRAR' in session['operaciones']}">
  <a href="#" class="btn btn-danger btn-mini" 
      onclick='return BootstrapDialog.confirm("Está seguro de borrar este registro?",function(result){
      if(result)
        window.location.href="${createLink(url:[controller:'Vencimiento', action:'borrar',id:vencimientoInstance.id])}"})'>
         <i class="icon-trash icon-white"></i>&nbsp;Borrar
    </a> 			
</g:if>
 <div class="btn-group">
    <a href="#" class="btn btn-mini" >Acciones</a>
   <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
   <span class="caret"></span></button>
    <%  swacc=0 %>
  
    <ul class="dropdown-menu">
         <g:if test="${'RENOVAR_VENCIMIENTO' in session['operaciones'] && vencimientoInstance.idEstadoVencimiento!='vennorenov'}">
              <%  swacc=1 %>
             <li><a href="/crm/vencimiento/renovarVencimiento/${vencimientoInstance.id}" >Renovar Vencimiento</a></li>
         </g:if>
         <g:if test="${'CLIENTE_NO_RENOVO' in session['operaciones'] && vencimientoInstance.idEstadoVencimiento=='venvencido'}">
  	
             	<li><a href="${createLink(action:'clienteNoRenovo',params:[idVencimiento:vencimientoInstance?.id,idenc:params?.idenc])}" >Cliente no renovó</a></li>			         
         	
         	<%--<li><a href="#" onclick='return BootstrapDialog.confirm("Está seguro de marcar este registro como No renovado?",function(result){
                    if(result)
                window.location.href="${createLink(action:'clienteNoRenovo',params:[id:vencimientoInstance?.id,idEnc:params.idenc]) }"})' >Cliente no renovó</a></li>
                 --%>
         </g:if>
        <g:if test="${swacc==0}">
            <li align="center">Ninguna</li>
        </g:if> 

   </ul>										
 </div> 
  <g:if test="${params.layout=='main'}" >
    <a  class="btn btn-mini" href="/crm/vencimiento/listarSeriales?sort=fechaVencimiento&max=10&order=asc"><i class="icon-remove"></i>&nbsp;Cancelar</a>
  </g:if>
  <g:else>
   <a  class="btn btn-mini" href="/crm/vencimiento/index?idenc=${params.idenc}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
   </g:else>
</div>