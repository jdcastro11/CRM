<%@ page import="crm.ElementoPorOportunidad" %>
<%@ page import="crm.Linea" %>
<%@ page import="crm.Sublinea" %>
<%@ page import="crm.Oportunidad" %>
<head>	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js" type="text/javascript"></script>
	<script src="//cdn.jsdelivr.net/bootstrap/3.0.0/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="//cdn.jsdelivr.net/jquery.dirtyforms/2.0.0/jquery.dirtyforms.min.js" type="text/javascript"></script>
	<script src="//cdn.jsdelivr.net/jquery.dirtyforms/2.0.0/jquery.dirtyforms.dialogs.bootstrap.min.js" type="text/javascript"></script>
</head>
<g:set var="generalService" bean="generalService" />
<div id="detalleconten">

    <g:hiddenField name="idOportunidad" type="number" value="${elementoPorOportunidadInstance?.oportunidad?.id?:xoportunidad}" />  

    

    <div class="control-group ${hasErrors(bean: elementoPorOportunidadInstance, field: 'linea.id', 'error')} required">
        <label class="control-label" for="idLinea">
            <g:message code="elementoPorOportunidad.idLinea.label" default="Línea" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:select name="idLinea" from="${Linea.findAllByIdEstadoLineaAndEliminado('genactivo',0)}"
                optionKey="id"   required=""
            value="${elementoPorOportunidadInstance?.linea?.id}"
                noSelection="['': "${message(code: 'seleccionar.linea.label')}"]"
            onchange="${remoteFunction(controller:'ElementoPorOportunidad',
                        action:'infoSublineas', params:'\'id=\'+this.value',
                        update: [success: 'divsublineas'])}"   disabled="${xronly}" />
        </div>
    </div>

    <div id="divsublineas">
        <g:set var="sublineaList" value="${generalService.getSublinea(elementoPorOportunidadInstance?.linea?.id)}" scope="request"/>
        <g:set var="xidsublinea" value="${elementoPorOportunidadInstance?.sublinea?.id}" scope="request"/>
        <g:render template="/sublinea/sublineas"/>
    </div>


    <div class="control-group ${hasErrors(bean: elementoPorOportunidadInstance, field: 'cantidad', 'error')} ">
        <label class="control-label" for="cantidad">
            <g:message code="elementoPorOportunidad.cantidad.label" default="Cantidad" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:if test="${xronly=='false'}" >
                <g:field  type="number"  name="cantidad"   required="" min="0"
                value="${elementoPorOportunidadInstance?.cantidad}"                       
                disabled="${xronly}" 
                style="text-align:right"  />
            </g:if>
            <g:else>
                <g:textField name="cantidad_s"  
                value="${formatNumber(number:elementoPorOportunidadInstance?.cantidad,format:'###,###,###', locale:'co')}"                       
                disabled="${xronly}" 
                    style="text-align: right" />
            </g:else>           
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: elementoPorOportunidadInstance, field: 'valor', 'error')} ">
        <label class="control-label" for="valor">
            <g:message code="elementoPorOportunidad.valor.label" default="Valor" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:if test="${xronly=='false'}" >
                
                <g:field type="number"  name="valor"   required="" min="0" step="any" maxlength="15"
                value="${elementoPorOportunidadInstance?.valor}"                       
                disabled="${xronly}" 
                style="text-align:right"  class="decimal" />
            </g:if>
            <g:else>
                <g:textField name="valor_s" 
                value="${formatNumber(number:elementoPorOportunidadInstance?.valor,format:'###,###,###.00', locale:'co')}"                       
                disabled="${xronly}" 
                    style="text-align: right" />
            </g:else>  

        </div>
    </div>

    <div class="control-group ${hasErrors(bean: elementoPorOportunidadInstance, field: 'total', 'error')} ">
        <label class="control-label" for="total">
            <g:message code="elementoPorOportunidad.total.label" default="Total" />

        </label>
        <div class="controls"  style="text-align:right;width:215px;">         
            <g:if test="${elementoPorOportunidadInstance?.cantidad==null || elementoPorOportunidadInstance?.valor==null}" >
                <g:set var="xtotal" value="" />
            </g:if>
            <g:else>
                <g:set var="xtotal" value="${elementoPorOportunidadInstance?.cantidad*elementoPorOportunidadInstance?.valor}" />
                <g:textField name="total" id="idtotal"  
                value="${formatNumber(number:xtotal,format:'###,###,###.00', locale:'co')}"
                    readonly=""  style="text-align: right" /> 
            </g:else>
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: elementoPorOportunidadInstance, field: 'idEstadoElementoPorOportunidad', 'error')} ">
        <label class="control-label" for="idEstadoElementoPorOportunidad">
            <g:message code="elementoPorOportunidad.idEstadoElementoPorOportunidad.label" default="Estado" />

        </label>
        <div class="controls">
            <g:select name="idEstadoElementoPorOportunidad" from="${generalService.getValoresParametro('estadogene')}"
                optionKey="idValorParametro"
            value="${elementoPorOportunidadInstance?.idEstadoElementoPorOportunidad?:'genactivo'}"
            noSelection="['': '']"    disabled="${xronly}" />
        </div>
        
    </div>
</div>
<g:hiddenField name="eliminado" type="number" value="${elementoPorOportunidadInstance?.eliminado?:0}" />

    

    

<script type="text/javascript">    
    var contenido= $("#detalleconten");
    if (parent.IFRAME_DETALLE !=null) parent.IFRAME_DETALLE.height(contenido.height()+120);

    $('form').dirtyForms({
        // Message will be shown both in the Bootstrap Modal dialog 
        // and in most browsers when attempting to navigate away 
        // using browser actions.
        message: 'Los cambios que realizó no se guardarán',
        dialog: {
            title: 'Advertencia',
            dialogID: 'custom-dialog', 
            titleID: 'custom-title', 
            messageClass: 'custom-message', 
            proceedButtonText: 'Abandonar', 
            stayButtonText: 'Permanecer'
                 
        }
    });

    // If .dirtyForms() has already been called, you can override
    // the values after the fact like this.
    $.DirtyForms.dialog.title = 'Advertencia';
    $.DirtyForms.dialog.proceedButtonText = 'Abandonar';
    $.DirtyForms.dialog.stayButtonText = 'Permanecer aquí';



    	
</script>