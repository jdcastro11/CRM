<%@ page import="crm.Empresa" %>
<%@ page import="crm.Territorio" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService"/>

     <g:if test="${empresaInstance?.eliminado==1}" >
    <div id="men_eliminado" class="pull-right label label-important">
       Eliminado
    </div>
  </g:if>
    
    <g:set var="padreInstance" value="${Empresa.get(xidPadre)}" />
     <g:hiddenField name="layout"  value="${layout}"/>
    <g:hiddenField name="idTipoSede"  value="emprsucurs"/>
    <g:hiddenField name="idTipoEmpresa"  value="empcliente"/>
    <g:hiddenField name="idPadre"  value="${xidPadre}" />    
    <g:hiddenField name="razonSocial"  value="${padreInstance.razonSocial}" />
    <g:hiddenField name="nit"  value="${padreInstance.nit}" />
<div id="boxsede">
    <br>
    <div class="control-group ${hasErrors(bean: empresaInstance, field: 'razonSocial', 'error')} ">
        <label class="control-label" for="razonSocial">
            <g:message code="empresa.razonSocial.label" default="Razón Social" />
        </label>
        <div class="controls" style="padding-top:3px;">             
              ${padreInstance.razonSocial}
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: empresaInstance, field: 'direccion', 'error')} ">
        <label class="control-label" for="direccion">
            <g:message code="empresa.direccion.label" default="Dirección" />
        </label>
        <div class="controls">
            <g:textField name="direccion" maxlength="200" value="${empresaInstance?.direccion}" disabled="${xronly}"  />
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: empresaInstance, field: 'telefonos', 'error')} ">
        <label class="control-label" for="telefonos">
            <g:message code="empresa.telefonos.label" default="Teléfonos" />

        </label>
        <div class="controls">
            <g:textField name="telefonos" maxlength="20" value="${empresaInstance?.telefonos}" disabled="${xronly}"/>
        </div>
    </div>

<div class="control-group  ${hasErrors(bean: empresaInstance, field: 'email', 'error')} ">
	<label  class="control-label"  for="email">
		<g:message code="empresa.email.label" default="E-mail" />
		
	</label>
         <div class="controls">
	 <g:textField name="email" maxlength="200" value="${empresaInstance?.email}" disabled="${xronly}" />
        </div>
</div>



    <div class="control-group ${hasErrors(bean: empresaInstance, field: 'idDpto', 'error')} ">
        <label class="control-label" for="idDpto">
            <g:message code="empresa.idDpto.label" default="Departamento" />
           <span class="required-indicator">*</span>
        </label>
        <div class="controls" >
            <g:select name="idDpto" from="${Territorio.findAll('from Territorio where idTipoTerritorio=\'terdpto\' and eliminado=0  order by nombreTerritorio')}"
                      optionKey="id"
                      value="${empresaInstance?.idDpto}"
                       onchange="${remoteFunction(controller:'Territorio',
                                  action:'traerMunicipios', params:'\'id=\'+this.value',
                                 update: [success: 'divmuni'])}"
                          noSelection="['': "${message(code: 'seleccionarDpto.label')}"]"  
                      disabled="${xronly}"  required="" />
        </div>
 </div>
 <div id="divmuni">
      <g:set var="municipioList" value="${generalService.getMunicipios(empresaInstance?.idDpto)}" scope="request"/>
      <g:set var="xidciudad" value="${empresaInstance?.idCiudad}" scope="request"/>
      <g:render template="/territorio/municipios"/>
  </div>
  
      <div class="control-group ${hasErrors(bean: empresaInstance, field: 'idEstadoEmpresa', 'error')} ">
        <label class="control-label" for="idEstadoEmpresa">
            <g:message code="empresa.idEstadoEmpresa.label" default="Estado" />

        </label>
        <div class="controls">
            <g:select name="idEstadoEmpresa" from="${generalService.getValoresParametro('eempresa')}"
                      optionKey="idValorParametro"
                      value="${empresaInstance?.idEstadoEmpresa?:'empactivo'}"
                      noSelection="['': '']" disabled="${xronly}"  />
        </div>
    </div>
 <g:hiddenField  id ="eliminado" name="eliminado" value="${empresaInstance?.eliminado?:0}" />

</div>

<script>                    
<!-- calcula el alto del bloque htm del detalle de encaberzado respectivo --> 
var contenido= $("#boxsede"); 

if (parent.IFRAME_DETALLE2 !=null)parent.IFRAME_DETALLE2.height(contenido.height()+150);     

 </script> 