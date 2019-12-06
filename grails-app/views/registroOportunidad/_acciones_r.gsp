<g:set var="oportunidadService" bean="oportunidadService" />
<div class="pull-left">
    <g:if test="${oportunidadService.oportunidadCerrada(params.idop)=='N'}" >
        <g:if test="${'MODIFICAR' in session['operaciones']}"> 
            <a class="btn btn-success  btn-mini" href="/crm/registroOportunidad/edit/${registroOportunidadInstance.id}?idop=${params.idop}"><i class="icon-edit icon-white"  ></i>&nbsp;Editar</a>
        </g:if>
        <g:if test="${'BORRAR' in session['operaciones']}">
            <a href="#" class="btn btn-danger btn-mini" 
            onclick='return BootstrapDialog.confirm("Está seguro de borrar este registro?",
            function(){window.location.href="${createLink(url:[controller:'RegistroOportunidad', action:'borrar',id:registroOportunidadInstance.id])}"})'>
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
</g:if>
<a class="btn btn-mini" href="/crm/registroOportunidad/index/${params.idop}" ><i class="icon-remove"></i>&nbsp;Cancelar</a>
</div>