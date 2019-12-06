<%@ page import="crm.Propuesta" %>
<g:set var="generalService" bean="generalService" />
<g:set var="pedidoService" bean="pedidoService" />
<div class="pull-left">
        <% 
         def swc_prop=0
         Long  xidpedido       
         if (params.entidad=='pedido') xidpedido=params.long('ident')           
          else xidpedido=0  
         Long xidpropuesta
         if (params.entidad=='propuesta'){  // Si la propuesta es la ganadora evita su edicion
              xidpropuesta=params.long('ident')
            def propuestaInstance=Propuesta.get(xidpropuesta)           
            if(propuestaInstance?.idEstadoPropuesta=='propfinal')  swc_prop=1
            }
         
        %>
    <g:if test="${pedidoService.accesoPedido(xidpedido,session['idUsuario'],params.entidad) && swc_prop==0}"> 
        <g:if test="${'MODIFICAR' in session['operaciones']}"> 
            <a class="btn btn-success  btn-mini" href="/crm/anexo/edit/${anexoInstance?.id}?ident=${params.ident}&entidad=${params.entidad}">
                <i class="icon-edit icon-white" ></i>&nbsp;<g:message code="default.button.edit.label" default="Editar"/></a>
            </g:if>
            <g:if test="${'BORRAR' in session['operaciones']}">
                <a href="#" class="btn btn-danger btn-mini" 
                onclick='return BootstrapDialog.confirm("Está seguro de borrar este registro?",
            function(result) { if(result)window.location.href="${createLink(url:[controller:'Anexo', action:'borrar',id:anexoInstance.id])}"})'>
            <i class="icon-trash icon-white"></i><g:message code="default.button.delete.label" default="Borrar"/></a>				
        </g:if>
    <div class="btn-group">
        <a href="#" class="btn btn-mini" ><g:message code="acciones.label" default="Acciones"/></a>
        <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
            <span class="caret"></span></button>
        <ul class="dropdown-menu"> 
         <li align="center">Ninguna </li>
        </ul>										
    </div>
</g:if>
<a  class="btn btn-mini" href="/crm/anexo/index/${params.ident}?entidad=${params.entidad}">
    <i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label" default="Cancelar"/> </a>
</div>