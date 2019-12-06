<g:set var="oportunidadService" bean="oportunidadService" />
<div class="pull-left">
    <g:if test="${oportunidadService.oportunidadCerrada(params.idpos)=='N' && propuestaInstance.idEstadoPropuesta != 'propfinal'}" >
        <g:if test="${'MODIFICAR' in session['operaciones']}"> 
            <a  class="btn btn-success  btn-mini" href="/crm/propuesta/edit/${propuestaInstance.id}?idpos=${params.idpos}&idemp=${params.idemp}">
                <i class="icon-edit icon-white"  ></i>&nbsp;Editar</a> 
            </g:if>
            <g:if test="${'BORRAR' in session['operaciones']}">
                <a href="#" class="btn btn-danger btn-mini" 
                onclick='return BootstrapDialog.confirm("Está seguro de borrar este registro?",
            function(result) { if(result)window.location.href="${createLink(url:[controller:'Propuesta', action:'borrar',id:propuestaInstance.id])}"})'>
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
</g:if>

        
		<g:if test="${params.action=='showperfectum'}">
			<a  class="btn btn-mini" href="/crm/propuesta/indexPropuesta"><i class="icon-remove"></i>&nbsp;Cancelar</a>
		</g:if>
		<g:else>
			<a  class="btn btn-mini" href="/crm/propuesta/index/${propuestaInstance?.oportunidad?.id}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
			
		</g:else>
</div>