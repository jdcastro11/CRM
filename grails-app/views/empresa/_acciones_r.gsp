<g:set var="oportunidadService" bean="oportunidadService" />
<g:set var="seguridadService" bean="seguridadService" />
<%
def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/empresa/index')
%>
<%  // parametrizacion de titulos edit=xtite 
              def xtite; 
               if (params.tipo =='0') xtite='empresat15'
              if (params.tipo =='1') xtite='empresat12'
              else if (params.tipo =='2') xtite='empresat07'
              else if (params.tipo =='5') xtite='provtitu05'
  %>
<g:set var="seguridadService" bean="seguridadService" />
<div class="pull-left">
<g:if test="${'MODIFICAR' in seguridadService.operacionesPorOpcion(session['idUsuario'],'/empresa/update')}"> 
   <a class="btn btn-success  btn-mini" href="/crm/empresa/edit/${empresaInstance?.id}?tipo=${params.tipo}&t=${xtite}&layout=${(params.tipo=='3')?'detail':'main'}&swmodal=">
     <i class="icon-edit icon-white" ></i>&nbsp;<g:message code="default.edit.label"/></a>
   </g:if>
<g:if test="${empresaInstance?.eliminado==0}" >    
    <g:if test="${'BORRAR' in seguridadService.operacionesPorOpcion(session['idUsuario'],'/empresa/borrar')}">
      <a href="#" class="btn btn-danger btn-mini" 
      onclick='return BootstrapDialog.confirm("Está seguro de borrar este registro?",
      function(result) { if(result)window.location.href="/crm/empresa/borrar/${empresaInstance?.id}?tipo=${params.tipo}"})'>                                                     
          <i class="icon-trash icon-white"></i> Borrar</a>	
    </g:if>
</g:if>
 <div class="btn-group">
      <%  def swacc=0 %>
    <a href="#" class="btn btn-mini" ><g:message code="acciones.label"/></a>
   <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
   <span class="caret"></span></button>
    <ul class="dropdown-menu">
        <g:if test="${params.tipo=='1'}">
             <%  swacc=1 %>
            <li align="center"><a href="/crm/empresa/convertirACliente/${empresaInstance?.id}">Convertir a Cliente</a> </li>
        </g:if>      
           
        <g:if test="${swacc==0}" >
            <li align="center">Ninguna </li>
        </g:if>
   </ul>										
 </div>
    <%
     def xurl="/crm/empresa/index/${params.tipo}?layout=${params.layout}&sort=razonSocial"
     if (params.layout=="detail")
       xurl="/crm/empresa/listarSedes/${empresaInstance?.padreId}?t=sedest00&layout=detail&sw=${sw}"
     
     %>
   <a  class="btn btn-mini" href="${xurl}"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>
</div>