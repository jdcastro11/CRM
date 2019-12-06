<%@ page import="crm.Tactica" %>
<g:set var="generalService" bean="generalService" />

<g:hiddenField id="eliminado" name="eliminado" value="${tacticaInstance?.eliminado?:0}"/>
<g:hiddenField name="idEstadoTactica"  value="${tacticaInstance?.idEstadoTactica?:'genactiva'}"/>
<g:hiddenField name="idestrategia" value="${params.id}"/>

<script>redimIFRAME();</script>
 
<g:if test="${tacticaInstance?.eliminado==1}" >
    <div id="men_eliminado" class="pull-right label label-important">
        Eliminado
    </div>
</g:if>
<%--<div class="fieldcontain ${hasErrors(bean: tacticaInstance, field: 'idEstrategia', 'error')} ">
    <label class="control-label"  for="idEstrategia">
        <g:message code="tactica.idEstrategia.label" default="Estrategia" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select name="idEstrategia" from="${generalService.getValoresParametro('tpoactmerc')}" 
                  optionKey="idValorParametro" 
                  value="${tacticaInstance?.idEstrategia}"
                  noSelection="['': 'Seleccione Estrategia']" disabled="${xronly}" required="" />
    </div>
</div>--%>
<br/>
<div class="fieldcontain ${hasErrors(bean: tacticaInstance, field: 'tactica', 'error')} ">
    <label class="control-label"  for="tactica">
        <g:message code="tactica.tactica.label" default="Tactica" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textArea class="" name="tactica" cols="40" rows="5"  class="input-xlarge"
        value="${tacticaInstance?.tactica}" disabled="${xronly}" required="" />
    </div>  
<br>
    <div class="fieldcontain ${hasErrors(bean: tacticaInstance, field: 'idFrecuencia', 'error')} ">
    <label class="control-label"  for="idFrecuencia">
        <g:message code="tactica.idFrecuencia.label" default="Frecuencia" />
       
    </label>
    <div class="controls">
        <g:select name="idFrecuencia" from="${generalService.getValoresParametro('frecuencia')}" 
                  optionKey="idValorParametro" 
                  value="${tacticaInstance?.idFrecuencia}"
                  noSelection="['': 'Seleccione Frecuencia']" disabled="${xronly}" required="" />
    </div>
</div>
 <br>   
    <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'ultimaFecha', 'error')} ">
        <label class="control-label" for="ultimaFecha">
            Ultima Fecha
        </label>
        <div class="controls input-append date form_date" id="fechau" data-date-format="dd-mm-yyyy" style="margin-left:20px;">
            <input  type="text" name="ultimaFecha" id="fechau" 
            value="${g.formatDate(format:'dd-MM-yyyy',date:tacticaInstance?.ultimaFecha)?:generalService.getHoy()}"  readonly >
            <g:if test="${xronly!='true'}"  >             
                <span class="add-on"><i class="icon-th"></i></span>
                </g:if>
        </div>

    </div>
</div>


<g:if test="${tacticaInstance.id !=null}">
	<object type="text/html" width="100%" height="600px" data="/crm/pieza/index/${tacticaInstance.id}"></object>
   <!-- <iframe id="ifPiezas" height="500" src="/crm/pieza/index/${tacticaInstance.id}" style="border:0;overflow:hidden;width:100%;" ></iframe> --> 
</g:if>

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

