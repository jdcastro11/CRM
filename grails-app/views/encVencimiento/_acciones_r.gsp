<div class="pull-left">
<g:if test="${'MODIFICAR' in session['operaciones']}"> 
  <a class="btn btn-mini btn-success"  href="/crm/EncVencimiento/edit/${encVencimientoInstance.id}">
   <i class="icon-edit icon-white"  ></i>&nbsp;Editar</a>
</g:if>
 <g:if test="${'BORRAR' in session['operaciones']}">
  <a href="#" class="btn btn-danger btn-mini" 
      onclick='return BootstrapDialog.confirm("Está seguro de borrar este registro?",function(result){
      if(result)
        window.location.href="${createLink(url:[controller:'EncVencimiento', action:'borrar',id:encVencimientoInstance.id])}"})'>
         <i class="icon-trash icon-white"></i>&nbsp;Borrar
    </a> 			
</g:if>
   <a  class="btn btn-mini" href="/crm/EncVencimiento/index?sort=encVencimiento&max=10&order=asc"><i class="icon-remove"></i>&nbsp;Cancelar</a>
</div>