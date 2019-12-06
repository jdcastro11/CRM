<%@ page import="crm.PruebaValFechas" %>
<%@ page import="crm.Oportunidad" %>
<%@ page import="crm.ValorParametro" %>
<g:set var="generalService" bean="generalService" />
<g:set var="oportunidadService" bean="oportunidadService" />
<g:set var="pedidoService" bean="pedidoService" />
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>

<div id="boxopor">

<div class="fieldcontain ${hasErrors(bean: pruebaValFechasInstance, field: 'descripcionReq', 'error')} ">
	<label for="descripcionReq">
		<g:message code="pruebaValFechas.descripcionReq.label" default="Descripcion Req" />
		
	</label>
	<g:textField name="descripcionReq" value="${pruebaValFechasInstance?.descripcionReq}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: pruebaValFechasInstance, field: 'fechaAperturaReq', 'error')} required">
	<label for="fechaAperturaReq">
		<g:message code="pruebaValFechas.fechaAperturaReq.label" default="Fecha Apertura Req" />
		<span class="required-indicator">*</span>
	</label>
	<!--g:datePicker name="fechaAperturaReq" precision="day"  value="${pruebaValFechasInstance?.fechaAperturaReq}"  /-->
  <div class="controls" >
            <div class="controls input-append date form_date" id="fechaaReq"
            data-date-format="dd-mm-yyyy" style="margin-left:0px;">
            <input type="text" name="fechaAperturaReq" id="op_fechaaReq" readonly 
            value="${g.formatDate(format:'dd-MM-yyyy',date:pruebaValFechasInstance?.fechaAperturaReq)?:generalService.getHoy()}" style="width:153px;" 
            >
            <g:if test="${xronly!='true'}"  >            
                <span class="add-on"><i class="icon-th"></i></span>
            </g:if>
        </div>


</div>

            <div class="control-group">
                <label class="control-label" for="fechaCierreEstimadaReq">
                    <g:message code="pruebaValFechas.fechaCierreEstimadaReq.label" default="Cierre Estimado" />
                    <span class="required-indicator">*</span>
                </label>
                <div class="controls" >  
                    <div class="controls input-append date form_date" id="fechaReq"
                    data-date-format="dd-mm-yyyy" style="margin-left:0px;">
                    <input type="text" name="fechaCierreEstimada" id="op_fechacReq"
                    value="${g.formatDate(format:'dd-MM-yyyy',date:pruebaValFechasInstance?.fechaCierreEstimadaReq)}"
                    style="width:153px;"  required=""
                    onchange="validarFechas(0,'op_fechaaReq','op_fechacReq')">
                    <g:if test="${xronly!='true'}"  >
                        <span class="add-on"><i class="icon-remove"></i></span>
                        <span class="add-on"><i class="icon-th"></i></span>
                        </g:if>
                </div>
                <span id="errfec" style="display:none;"> <b style="color:red; padding-top:3px;"> Esta fecha debe ser posterior a la anterior </b>
                    <a href="#" onclick="document.getElementById('errfec').style.display='none'" ><i class="icon-remove"></i></a>
                </span>
            </div>

<div class="fieldcontain ${hasErrors(bean: pruebaValFechasInstance, field: 'numOptty', 'error')} ">
	<label for="numOptty">
		<g:message code="pruebaValFechas.numOptty.label" default="Num Optty" />
		
	</label>
	<g:textField name="numOptty" value="${pruebaValFechasInstance?.numOptty}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: pruebaValFechasInstance, field: 'tema', 'error')} ">
	<label for="tema">
		<g:message code="pruebaValFechas.tema.label" default="Tema" />
		
	</label>
	<g:textField name="tema" value="${pruebaValFechasInstance?.tema}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: pruebaValFechasInstance, field: 'tipoRequerimiento', 'error')} ">
	<label for="tipoRequerimiento">
		<g:message code="pruebaValFechas.tipoRequerimiento.label" default="Tipo Requerimiento" />
		
	</label>
	<g:textField name="tipoRequerimiento" value="${pruebaValFechasInstance?.tipoRequerimiento}"/>
</div>


</div>

 <script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.js')}"></script>
<script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.es.js')}"></script>
<script type="text/javascript">
    <g:if test="${params.xronly!='true'}"  >
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