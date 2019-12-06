<%@ page import="crm.EncVencimiento" %>
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>
<g:set var="generalService" bean="generalService" />

   <g:set var="xlabelEmpresa"  value="Empresa"  scope="request" /> 
   <g:set var="xlabelContacto"  value="Contacto"  scope="request" /> 
   <g:set var="xidempresa"  value="${encVencimientoInstance?.empresa?.id}"  scope="request" /> 
   <g:set var="zidcontacto"  value="idContacto"  scope="request" />
   <g:set var="xidcontacto"  value="${encVencimientoInstance?.persona?.id}"  scope="request" /> 
   <g:set var="autoSw"  value="2"  scope="request" /> <!-- para filtrar  solo clientes -->
   <g:render template="/general/empresaContacto1" />
   
   <div class="control-group ${hasErrors(bean: encVencimientoInstance, field: 'idVendedor', 'error')} ">
    <label class="control-label" for="idVendedor">
        Vendedor
    </label>
    <div class="controls" >
         <g:render template="/empleado/vendedorPorDefecto" />  
        <g:select id="idVendedor" style="width:284px;" name="idVendedor"
        from="${generalService.getVendedores()}"
            optionKey="id"
        value="${encVencimientoInstance?.empleado?.id?:xidVendedor}"
        noSelection="['': 'Seleccione Vendedor']"  disabled="${xronly}" required="" />
    </div>
</div>
  <div class="control-group">
	<label class="control-label" for="idEstadoEncVencimiento">
 	 Estado		
	</label>
	<div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:273px;min-height:21px;background-color:#EEE;">
            ${generalService.getValorParametro(encVencimientoInstance?.idEstadoEncVencimiento?:'genactivo')}                  
        </div>
</div>
<g:hiddenField   name="idEstadoEncVencimiento" value="${encVencimientoInstance?.idEstadoEncVencimiento?:'genactivo'}" />
<g:hiddenField  id ="eliminado" name="eliminado" value="${encVencimientoInstance?.eliminado?:0}" />
 <g:if test="${encVencimientoInstance?.id!=null}" >                
  <iframe id="ifvenc" src="/crm/vencimiento/index/?idenc=${encVencimientoInstance.id}&sw=${sw}" style="border:0;overflow:hidden;width:100%"  scrolling="no" ></iframe>
</g:if>


  <script language="javascript">
               IFRAME_DETALLE = $("#ifvenc");                       
    </script>