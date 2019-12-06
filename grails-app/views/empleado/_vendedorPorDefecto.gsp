<g:if test="${'VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())}" >
    <g:set var="xidVendedor" value="${generalService.getIdEmpleado(session['idUsuario'].toLong())}" scope="request" />     
</g:if> 
<g:else>
    <g:set var="xidVendedor" value="" scope="request" /> 
</g:else>
