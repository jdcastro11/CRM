<%@ page import="crm.ValorParametro" %>
<%@ page import="crm.Parametro" %>

<div id="boxvalp">
      <g:if test="${valorParametroInstance?.eliminado==1}" >
    <div id="men_eliminado" class="pull-right label label-important">
       Eliminado
    </div>
  </g:if>

   <g:hiddenField  name="idParametro"  value="${valorParametroInstance?.idParametro?:params.idparametro}"  />

    <g:hiddenField  name="parametroID"  value="${valorParametroInstance?.parametro?.id?:params.idp}"  /> 

    <div class="control-group ${hasErrors(bean: valorParametroInstance, field: 'idValorParametro', 'error')} required ">
        <label class="control-label" for="idValorParametro">
            <g:message code="valorParametro.idValorParametro.label" default="Valor Parametro" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:textField  maxlength="15" style="width:80px;" name="idValorParametro"  required=""
                          value="${valorParametroInstance?.idValorParametro}"  disabled="${xronly}" />
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: valorParametroInstance, field: 'valor', 'error')} ">
        <label class="control-label" for="valor">
            <g:message code="valorParametro.valor.label" default="Valor" />

        </label>
            <div class="controls">
         <g:textField name="valor" value="${valorParametroInstance?.valor}"  disabled="${xronly}" />
            </div>
    </div>
    
  <div class="control-group ${hasErrors(bean: valorParametroInstance, field: 'descValParametro', 'error')} ">
        <label class="control-label" for="valor">
            <g:message code="valorParametro.descValParametro.label" default="Descripción" />

        </label>
            <div class="controls">
         <g:textField name="descValParametro" value="${valorParametroInstance?.descValParametro}"  disabled="${xronly}" />
            </div>
    </div>
    
    <div class="control-group ${hasErrors(bean: valorParametroInstance, field: 'orden', 'error')} ">
        <label class="control-label" for="orden">
            <g:message code="valorParametro.orden.label" default="Orden" />

        </label>
            <div class="controls">
        <g:textField name="orden" value="${valorParametroInstance?.orden}"  disabled="${xronly}" /></div>
            </div>

    <div class="control-group ${hasErrors(bean: valorParametroInstance, field: 'estadoValorParametro', 'error')} ">
        <label class="control-label" for="estadoValorParametro">
            <g:message code="valorParametro.estadoValorParametro.label" default="Estado"  disabled="${xronly}" />

        </label>
             <div class="controls">
           <g:select name="estadoValorParametro" from="['Activo','Inactivo']"
                         keys="['A','I']"
                         value="${valorParametroInstance?.estadoValorParametro?:"A"}"
                         valueMessagePrefix="valorParametro.estadoValorParametro"
                         noSelection="['': 'Seleccione Estado']"  disabled="${xronly}" />
             </div>
     </div>

<g:hiddenField  id ="eliminado" name="eliminado" value="${valorParametroInstance?.eliminado?:0}" />


</div>
<div class="modal hide fade" id="crm_modal1" >	
	<div id="modal_body1" class="modal-body" ></div>
        <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Salir</button>        
        </div>
</div>

<script>                    
<!-- calcula el alto del bloque htm del detalle de encaberzado respectivo --> 
var contenido= $("#boxvalp"); 

if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+150);     

 </script>    
