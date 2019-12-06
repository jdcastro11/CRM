<%@ page import="crm.Contacto" %>
<%@ page import="crm.Persona" %>
<%@ page import="crm.Empresa" %>
%{--Use generalService--}%
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>
<g:set var="generalService" bean="generalService"/>

<g:if test="${params.swmodal==''}">
    <g:set var="xdivModal" value="crm_modal" />
    <g:set var="xdivBody" value="modal_body" />
</g:if>
<g:else>
    <g:set var="xdivModal" value="crm_modal_det" />
    <g:set var="xdivBody" value="modal_body_det" />
</g:else>
<div id="boxcontac">
    <g:if test="${contactoInstance?.eliminado==1}" >
        <div id="men_eliminado" class="pull-right label label-important">
            Eliminado
        </div>
    </g:if>

    <g:if test="${params.layout!='detail'}">
        <g:set var="xlabelEmpresa"  value="${message(code: 'empresa.template.label', default: 'Empresa')}"  scope="request" /> 
        <g:set var="xlabelContacto"  value="${message(code: 'persona.template.label', default: 'Persona')}"  scope="request" /> 
        <g:set var="xidempresa"  value="${contactoInstance?.empresa?.id}"  scope="request" /> 
        <g:set var="zidcontacto"  value="idpersona"  scope="request" />
        <g:set var="xidcontacto"  value="${contactoInstance?.persona?.id}"  scope="request" /> 
        <g:set var="autoSw"  value="1"  scope="request" /> <!-- para filtrar  solo clientes /Prospectos -->
        <g:set var="swemp"  value="0"  scope="request" /> <!-- sw  control empresa solo lectura -->
        <g:render template="/general/empresaContacto" />
    </g:if>
    <g:else>

        <g:hiddenField id="idempresa" name="idempresa" value="${params.id}"  /> 
        <br>
        <div class="control-group ">
            <label class="control-label" >
                Empresa
            </label>
            <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:220px;min-height:21px;background-color:#EEE;"> 
                ${crm.Empresa.get(params.id)}
            </div>
        </div>
        <g:set var="xlabelContacto"  value="Persona"  scope="request" /> 
        <g:set var="zidcontacto"  value="idContacto"  scope="request" />
        <g:set var="xidcontacto"  value="${contactoInstance?.persona?.id}"  scope="request" /> 
        <g:render template="/general/contacto" />    
    </g:else> 
    <g:hiddenField  name ="idEstadoContacto"  value="${contactoInstance?.idEstadoContacto?:'genactivo'}" />

    <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'fechaRegistro', 'error')} ">
        <label class="control-label" for="fechaApertura">
            <g:message code="contacto.fechaRegistro.label" default="Fecha Registro" />
        </label>
        <div class="controls input-append date form_date" id="fechaRegistro" data-date-format="dd-mm-yyyy" style="margin-left:20px;">
            <input  type="text" name="fechaRegistro" id="fechar" 
            value="${g.formatDate(format:'dd-MM-yyyy',date:contactoInstance?.fechaRegistro)?:generalService.getHoy()}"  readonly >           
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: contactoInstance, field: 'idEstadoContacto', 'error')} ">
        <label class="control-label" for="IdEstadoContacto">
            <g:message code="contacto.idEstadoContacto.label" default="Estado" />
        </label>
        <div class="controls"> 
            <g:set var="xestadoContacto" value="${contactoInstance?.idEstadoContacto?:'genactivo'}" />
            <div style="padding-top:5px">${generalService.getValorParametro(xestadoContacto)} </div>
        </div>
    </div>
        <div style="height: 200px;"></div>
    <g:hiddenField  id ="eliminado" name="eliminado" value="${contactoInstance?.eliminado?:0}" />
    <g:hiddenField  id ="layout" name="layout" value="${params.layout}" />
</div> 
<script src="${resource(dir: 'js', file: 'crm_helper.js')}"></script>
<!--
<script>
    
    var contenido=$("#boxcontac");
    if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+150);
   
</script>
-->

