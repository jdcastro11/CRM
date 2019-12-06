<%@ page import="crm.RegistroOportunidad" %>
<%@ page import="crm.Persona" %>
<g:set var="generalService" bean="generalService"/>
<g:hiddenField  name="idoportunidad" value="${params.idop}"/>
<g:hiddenField id="eliminado" name="eliminado" value="${registroOportunidadInstance?.eliminado?:0}"/>
 <g:hiddenField id="swcambio" name="swcambio" value="0" />  
<head>	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js" type="text/javascript"></script>
	<script src="//cdn.jsdelivr.net/bootstrap/3.0.0/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="//cdn.jsdelivr.net/jquery.dirtyforms/2.0.0/jquery.dirtyforms.min.js" type="text/javascript"></script>
	<script src="//cdn.jsdelivr.net/jquery.dirtyforms/2.0.0/jquery.dirtyforms.dialogs.bootstrap.min.js" type="text/javascript"></script>
	<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>
	<script> redimIFRAME(); SW_IFACTIVIDAD=0;SW_IFPROPUESTA=0;SW_IFREGOPOR=0;SW_IFREQUERIMIENTO=0;SW_CTRLANEXO=0 </script>
</head>
 <div id="boxRegOp">

    <g:if test="${registroOportunidadInstance?.eliminado == 1}">
        <div id="men_eliminado" class="pull-right label label-important">
            Eliminado
        </div>
    </g:if>

    <div class="control-group ${hasErrors(bean: registroOportunidadInstance, field: 'fecha', 'error')} ">
        <label class="control-label" for="fecha">
            <g:message code="registroOportunidad.fecha.label" default="Fecha"/>

        </label>

        <div class="controls input-append date form_datetime" id="fecha"
             data-date-format="dd-mm-yyyy HH:ii p" style="margin-left:20px;">
            <input  type="text" name="fecha" value="${registroOportunidadInstance?.fecha?:generalService.getHoy(1)}" style="width:153px;"  readonly>
            
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: registroOportunidadInstance, field: 'idAutor', 'error')} required">
        <label class="control-label" for="idAutor">
            <g:message code="registroOportunidad.idAutor.label" default="Solicitante"/>
            <span class="required-indicator">*</span>
        </label>

        <div class="controls">
             <g:set var="xidEmpleado" value="${generalService.getIdEmpleado(session['idUsuario'].toLong())}" scope="request" />     
            <g:select id="idAutor" style="width:220px;" name="idAutor" required=""
                      from="${generalService.getVendedores()}"
                      optionKey="id"
                      value="${registroOportunidadInstance?.idAutor?:xidEmpleado}"
                      noSelection="['': 'Seleccione Solicitante']" disabled="${xronly}"/>
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: registroOportunidadInstance, field: 'idAsignadoA', 'error')} ">
        <label class="control-label" for="idAsignadoA">
            <g:message code="registroOportunidad.idAsignadoA.label" default="Asignado A"/>
            <span class="required-indicator">*</span>
        </label>

        <div class="controls">
            <g:select id="idAsignadoA" style="width:220px;" name="idAsignadoA" required=""
                      from="${generalService.getUsuariosFromParametro('usersregop',0)}"
                      optionKey="id"
                      value="${registroOportunidadInstance?.idAsignadoA}"
                      disabled="${xronly}"/>
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: registroOportunidadInstance, field: 'idRegistroEn', 'error')} ">
        <label class="control-label" for="idRegistroEn">
            <g:message code="registroOportunidad.idRegistroEn.label" default="Registrar En"/>
           <span class="required-indicator">*</span>
        </label>

        <div class="controls">
            <g:select from="${generalService.getValoresParametro('mayoristas')}"
                      optionKey="idValorParametro"
                      value="${registroOportunidadInstance?.idRegistroEn}"
                      noSelection="['': '']" disabled="${xronly}" name="idRegistroEn" required="" />
        </div>
    </div>
    
    
<div class="control-group">
        <label class="control-label" for="fechaCierreEstimada">
            <g:message code="registroOportunidadInstance.fechaCierreEstimada.label" default="Fecha Cierre Estimado" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <div class="controls input-append date form_date" id="fechaa"
            data-date-format="dd-mm-yyyy" style="margin-left:0px;">
            <input type="text" name="fechaCierreEstimada" id="op_fechaa" readonly 
            value="${g.formatDate(format:'dd-MM-yyyy',date:registroOportunidadInstance?.fechaCierreEstimada)}" >
            <g:if test="${xronly!='true'}"  >            
                <span class="add-on"><i class="icon-th"></i></span>
            </g:if>
        </div>
    </div>
</div>



    <div class="control-group ${hasErrors(bean: registroOportunidadInstance, field: 'valorRegOp', 'error')} ">
        <label class="control-label" for="valorRegOp">
            <g:message code="registroOportunidad.valorRegOp.label" default="Valor"/>

        </label>

        <div class="controls">
            <g:textField name="valorRegOp" maxlength="50" disabled="${xronly}"
                         value="${registroOportunidadInstance?.valorRegOp}"/>
        </div>
    </div>
    
    
    <div class="control-group ${hasErrors(bean: registroOportunidadInstance, field: 'numRegistroOportunidad', 'error')} ">
        <label class="control-label" for="numRegistroOportunidad">
            <g:message code="registroOportunidad.numRegistroOportunidad.label" default="Num Registro Oportunidad"/>

        </label>

        <div class="controls">
            <g:textField name="numRegistroOportunidad" maxlength="50" disabled="${xronly}"
                         value="${registroOportunidadInstance?.numRegistroOportunidad}"/>
        </div>
    </div>
    
    
    

    <div class="control-group ${hasErrors(bean: registroOportunidadInstance, field: 'idEstadoRegistroOportunidad', 'error')} ">
        <label class="control-label" for="idEstadoRegistroOportunidad">
            <g:message code="registroOportunidad.idEstadoRegistroOportunidad.label"
                       default="Estado"/>

        </label>

        <div class="controls">
            <g:select from="${generalService.getValoresParametro('estregop')}"
                      optionKey="idValorParametro"
                      value="${registroOportunidadInstance?.idEstadoRegistroOportunidad ?:'regenproc'}"
                      noSelection="['': '']" disabled="${xronly}" name="idEstadoRegistroOportunidad"
                      onchange="document.getElementById('swcambio').value=1"    
                          />
                   
        </div>
    </div>
    <%--AGREGAR CAMPO DE COMENTARIOS OPCION REGISTRO DE OPORTUNIDAD --%>
    
    <div class="control-group ${hasErrors(bean: registroOportunidadInstance, field: 'comentarioRegistroOportunidad', 'error')} ">
        <label class="control-label" for="comentarioRegistroOportunidad">
            <g:message code="registroOportunidad.comentarioRegistroOportunidad.label" default="Comentarios"/>

        </label>

        <div class="controls">
            <g:textArea name="comentarioRegistroOportunidad" style="width:300px;height:125px" maxlength="500" disabled="${xronly}"
                         value="${registroOportunidadInstance?.comentarioRegistroOportunidad}"/>
        </div>
    </div>
    
    
    
    
    
    
    
    <g:if test="${registroOportunidadInstance?.id!=null}">
    <div class="pull-right" style="margin-top:-4px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifanexos')"><i class="icon-refresh"></i></a></div>
	   <iframe id="ifanexos" src="/crm/anexo/${xindex}/${registroOportunidadInstance?.id}?entidad=registroOportunidad" style="border:0;width:100%;"  scrolling="No"></iframe>
	  <%-- <script language="javascript">  
	       IFRAME_ANEXO=$("#ifanexos")      
	   </script>--%>
	</g:if>
    
   

</div>
<script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.js')}"></script>
<script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.es.js')}"></script>
<script>alertaop(); </script>
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
    /*calcula el alto del bloque htm del detalle de encaberzado respectivo*/
    var contenido = $("#boxRegOp");

    if (parent.IFRAME_DETALLE3 != null)parent.IFRAME_DETALLE3.height(contenido.height() + 150);
    
    
		    
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