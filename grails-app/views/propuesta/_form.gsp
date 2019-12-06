<%@ page import="crm.Propuesta" %>
<%@ page import="crm.Persona" %>
<%-- <script src="${resource(dir: 'js', file: 'iframeResizer.min.js')}"></script> --%>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="oportunidadInstance" value="${crm.Oportunidad.get(params.idpos)}" />
<g:hiddenField  name="idOportunidad" value="${params.idpos}"/>
<g:hiddenField id="eliminado" name="eliminado" value="${propuestaInstance?.eliminado?:0}"/>
<g:hiddenField name="idEstadoPropuesta" value="${propuestaInstance?.idEstadoPropuesta?:'propnormal'}"/> 
<head>	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js" type="text/javascript"></script>
	<script src="//cdn.jsdelivr.net/bootstrap/3.0.0/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="//cdn.jsdelivr.net/jquery.dirtyforms/2.0.0/jquery.dirtyforms.min.js" type="text/javascript"></script>
	<script src="//cdn.jsdelivr.net/jquery.dirtyforms/2.0.0/jquery.dirtyforms.dialogs.bootstrap.min.js" type="text/javascript"></script>
</head>
<div id="boxprop">
<g:if test="${propuestaInstance?.eliminado==1}" >
		<div id="men_eliminado" class="pull-right label label-important">
		   Eliminado
		</div>
	</g:if>
<div class="control-group ${hasErrors(bean: propuestaInstance, field: 'numPropuesta', 'error')} ">
	<label class="control-label" for="numPropuesta">
		<g:message code="propuesta.numPropuesta.label" default="Num Propuesta" />		
	</label>
	<div class="controls">
	<g:textField readonly="true" name="numPropuesta" maxlength="50" value="${propuestaInstance?.numPropuesta}"/> 
            <g:if test="${propuestaInstance?.idEstadoPropuesta=='propfinal'}" >
             <i class="fa-icon-trophy"></i>
            </g:if>
	</div>
</div>



<div class="control-group">
        <label class="control-label">
            <g:message code="oportunidad.titulo.label"/>
        </label>
        <div class="controls" >
            <g:if test="${propuestaInstance?.oportunidad?.id!=null}">
                <a href="/crm/oportunidad/show/${propuestaInstance?.oportunidad?.id}" style="text-decoration:underline;display:inline">                		
                    ${propuestaInstance?.oportunidad.numOportunidad}</a>
             </g:if>
        </div>

</div>




<div class="control-group ${hasErrors(bean: propuestaInstance, field: 'fecha', 'error')} ">
	<label class="control-label" for="fecha">
		<g:message code="propuesta.fecha.label" default="Fecha" />	
            <span class="required-indicator">*</span>
	</label>
    <div class="controls input-append date form_date" id="fecha"
         data-date-format="dd-mm-yyyy" style="margin-left:20px;">
        <input  type="text" name="fecha" value="${g.formatDate(format:'dd-MM-yyyy',date:propuestaInstance?.fecha)?:generalService.getHoy()}"
                style="width:153px;" readonly="true"  >
        <g:if test="${xronly!='true'}"  >         
         <span class="add-on"><i class="icon-th"></i></span>
        </g:if>
        </div>
    </div>


<div class="control-group ${hasErrors(bean: propuestaInstance, field: 'idVendedor', 'error')} ">
	<label class="control-label" for="idVendedor">
		<g:message code="propuesta.idVendedor.label" default="Vendedor" />
		 <span class="required-indicator">*</span>
	</label>
	<div class="controls">
        <g:select id="idVendedor" style="width:250px;" name="idVendedor" 
           from="${generalService.getVendedores()}"
           optionKey="id"
           value="${propuestaInstance?.empleado?.id?:oportunidadInstance?.empleado?.id}"
           noSelection="['': "${message(code: 'seleccioneVendedor.propuesta.label', default: 'Seleccione Vendedor')}"]"  required="" disabled="${xronly}"  />
	</div>
</div>

<div class="control-group ${hasErrors(bean: propuestaInstance, field: 'idContacto', 'error')} ">
	<label class="control-label" for="idContacto">
		<g:message code="propuesta.idContacto.label" default="Contacto" />
		
	</label>
	<div class="controls">
        <g:set var="xidValue" value="${propuestaInstance?.persona?.id?:oportunidadInstance?.persona?.id}" scope="request" />
        <g:set var="xidEmpresa" value="${params.idemp}" scope="request" />
        <g:render template="/contacto/comboContacto" />
	</div>
</div>

<div class="control-group ${hasErrors(bean: propuestaInstance, field: 'valor', 'error')} ">
	<label class="control-label" for="valor">
		<g:message code="propuesta.valor.label" default="Valor" />
		 <span class="required-indicator">*</span>
	</label>
	<div classf="controls">
	<g:textField id="idvalorpro" disabled="${xronly}" 
          name="valor" maxlength="20" value="${propuestaInstance?.valor}" 
              required="" style="text-align:right;" style="margin-left:20px" />
	</div>
</div>

<%--AGREGAR CAMPO DE COMENTARIOS__PROPUESTA ..JOSE DANIEL MAURY --%>
    
    <div class="control-group ${hasErrors(bean: propuestaInstance, field: 'comentarioRegistroOportunidad', 'error')} ">
        <label class="control-label" for="comentarioPropuesta">
            <g:message code="propuesta.comentarioPropuesta.label" default="Comentarios"/>

        </label>

        <div class="controls">
            <g:textArea name="comentarioPropuesta" style="width:300px;height:125px" maxlength="500" disabled="${xronly}"
                         value="${propuestaInstance?.comentarioPropuesta}"/>
        </div>
    </div>


    <hr>
    <g:if test="${propuestaInstance?.id!=null}" >
        <% if (xsh=='1') xindex="indexh" else xindex="index"
            def pf=0
          if (propuestaInstance?.idEstadoPropuesta=='propfinal') pf=1
        %>
       <div class="pull-right" style="margin-top:-4px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifanexos')"><i class="icon-refresh"></i></a></div>
	   <iframe id="ifanexos" src="/crm/anexo/${xindex}/${propuestaInstance?.id}?entidad=propuesta&pf=${pf}" style="border:0;width:100%;"  scrolling="No"></iframe>
	   <script>       
	       IFRAME_ANEXO=$("#ifanexos")       
	   </script>
    </g:if>
</div>
<script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.js')}"></script>
<script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.es.js')}"></script>
<script type="text/javascript">
<g:if test="${xronly!='true'}"  >
    $('.form_date').datetimepicker({
        language:  'es',
        weekStart: 1,
        todayBtn:  1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });
    </g:if>
</script>
<script>
 $('#idvalorpro').keyup(function () {
  this.value = this.value.replace(/[^0-9]/g,''); 
});
     var contenido= $("#boxprop");   
   if (parent.IFRAME_PROPUESTA !=null) parent.IFRAME_PROPUESTA.height(contenido.height()+80);
    SW_CTRLANEXO=0
        
    
</script>

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