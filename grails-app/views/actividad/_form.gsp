<%@ page import="crm.Actividad" %>
<g:set var="generalService" bean="generalService" />

<g:hiddenField  name="idEntidad"     value="${actividadInstance?.idEntidad?:params.identidad}" />
<g:hiddenField  name="nombreEntidad" value="${params.entidad}" />
<g:hiddenField  id ="eliminado" name="eliminado" value="${anexoInstance?.eliminado?:0}" />

<div id="detalleconten">
<g:if test="${actividadInstance?.eliminado==1}" >

    <div id="men_eliminado" class="pull-right label label-important">
        Eliminado
    </div>
  </g:if>

    <div class="control-group  ${hasErrors(bean: actividadInstance, field: 'idTipoActividad', 'error')} ">
        <label class="control-label"  for="idTipoActividad">
            <g:message code="actividad.idTipoActividad.label" default="Tipo Actividad" />

        </label>
        <div class="controls">
            <g:select name="idTipoActividad" from="${generalService.getValoresParametro('tipoactivi')}"
                      optionKey="idValorParametro"    required=""
                      value="${actividadInstance?.idTipoActividad}"
                      noSelection="['': 'Seleccione Tipo Actividad']"  disabled="${xronly}" />
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: actividadInstance, field: 'descActividad', 'error')} required">
        <label class="control-label"  for="descActividad">
            <g:message code="actividad.descActividad.label" default="Desc. Actividad" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:textField name="descActividad" maxlength="200" required="" value="${actividadInstance?.descActividad}" disabled="${xronly}" />
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: actividadInstance, field: 'idAsignador', 'error')} required">
        <label class="control-label"  for="idAsignador">
            <g:message code="actividad.idAsignador.label" default="Asignada Por" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
           
            <g:set var="xidVendedor" value="${generalService.getIdEmpleado(session['idUsuario'].toLong())}" scope="request" />     
           
            <g:select id="idAsignador" style="width:220px;" name="idAsignador" required=""
                      from="${crm.Empleado.findAll('from Empleado where idTipoEmpleado in(\'peremplead \', \'pervendedo\') and eliminado=0 order by primerNombre,primerApellido')}"
                      optionKey="id"
                      value="${actividadInstance?.idAsignador?:xidVendedor}"
                      noSelection="['': 'Seleccione Empleado']"  disabled="${xronly}"  />
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: actividadInstance, field: 'idResponsable', 'error')} required">
        <label class="control-label"  for="idResponsable">
            
            <g:message code="actividad.idResponsable.label" default="Responsable" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
             <g:render template="/empleado/vendedorPorDefecto" />
            <g:select id="idResponsable" style="width:220px;" name="idResponsable" required=""
                      from="${crm.Empleado.findAll('from Empleado where idTipoEmpleado in(\'peremplead \', \'pervendedo\') and eliminado=0 order by primerNombre,primerApellido')}"
                      optionKey="id"
                      value="${actividadInstance?.idResponsable?:xidVendedor}"
                      noSelection="['': 'Seleccione Empleado']"  disabled="${xronly}"  />
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: actividadInstance, field: 'idContacto', 'error')} ">
        <label class="control-label"  for="idContacto">
            <g:message code="actividad.idContacto.label" default="Contacto" />

        </label>
        <div class="controls">
            <g:set var="xidValue" value="${actividadInstance.idContacto?:params.idcon}" scope="request" />
            <g:set var="xidEmpresa" value="${params.idemp}" scope="request" />
            <g:render template="/contacto/comboContacto" />
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: actividadInstance, field: 'fechaInicio', 'error')} ">
        <label class="control-label"  for="fechaInicio">
            <g:message code="actividad.fechaInicio.label" default="Inicia" />

        </label>
        <div class="controls input-append date form_datetime" id="fecini"
             data-date-format="dd-mm-yyyy HH:ii p" style="margin-left:20px;">

            <input size="16" type="text" name="fechaInicio" id="act_fechaI"
                   value="${actividadInstance?.fechaInicio}"
                   style="width:153px;" readonly
                   onchange="validarFechas(1,'act_fechaI','act_fechaF')">
          <g:if test="${xronly!='true'}" >
            <span class="add-on"><i class="icon-remove"></i></span>
            <span class="add-on"><i class="icon-th"></i></span>
          </g:if>
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: actividadInstance, field: 'fechaFinal', 'error')} ">
        <label class="control-label"  for="fechaFinal">
            <g:message code="actividad.fechaFinal.label" default="Finaliza" />

        </label>
        <div class="controls input-append date form_datetime"
             data-date-format="dd-mm-yyyy HH:ii p" style="margin-left:20px;" >

            <input size="16" type="text" name="fechaFinal" id="act_fechaF"
                   value="${actividadInstance?.fechaFinal}"
                   style="width:153px;" readonly
                   onchange="validarFechas(1,'act_fechaI','act_fechaF')">
            <g:if test="${xronly!='true'}"  >
              <span class="add-on"><i class="icon-remove"></i></span>
              <span class="add-on"><i class="icon-th"></i></span>
            </g:if>
        </div>
          <span id="errfec" style="display:none;"> <b style="color:red; padding-top:3px;"> Esta fecha debe ser posterior a la anterior </b>
          <a href="#" onclick="document.getElementById('errfec').style.display='none'" ><i class="icon-remove"></i></a>
         </span>
    </div>

    <div class="control-group  ${hasErrors(bean: actividadInstance, field: 'idAvance', 'error')} ">
        <label class="control-label"  for="idAvance">
            <g:message code="actividad.idAvance.label" default="Avance" />

        </label>
        <div class="controls">
            <g:select name="idAvance" from="${generalService.getValoresParametro('actiavance')}"
                      optionKey="idValorParametro"    required=""
                      value="${actividadInstance?.idAvance}"
                      noSelection="['': 'Seleccione Avance']"  disabled="${xronly}" />
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: actividadInstance, field: 'idPrioridad', 'error')} ">
        <label class="control-label"  for="idPrioridad">
            <g:message code="actividad.idPrioridad.label" default="Prioridad" />

        </label>
        <div class="controls">
            <g:select name="idPrioridad" from="${generalService.getValoresParametro('prioracti')}"
                      optionKey="idValorParametro"    required=""
                      value="${actividadInstance?.idPrioridad}"
                      noSelection="['': 'Seleccione Prioridad']"  disabled="${xronly}" />
        </div>
    </div>

    <div class="control-group  ${hasErrors(bean: actividadInstance, field: 'idEstadoActividad', 'error')} ">
        <label class="control-label"  for="idEstadoActividad">
            <g:message code="actividad.idEstadoActividad.label" default="Estado" />

        </label>
        <div class="controls">
            <g:select name="idEstadoActividad" from="${generalService.getValoresParametro('actiestado')}"
                      optionKey="idValorParametro"    required=""
                      value="${actividadInstance?.idEstadoActividad?:'actiesta01'}"
                      noSelection="['': 'Seleccione Estado']"  disabled="${xronly}" />
        </div>
    </div>



</div>

<script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.js')}"></script>
<script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.es.js')}"></script>
<script type="text/javascript">
<g:if test="${xronly!='true'}"  >
    $('.form_datetime').datetimepicker({
        language:  'es',
        weekStart: 1,
        todayBtn:  1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        forceParse: 0,
        showMeridian: 1

    });
</g:if>
</script>
<script>
    var contenido= $("#detalleconten");
    if (parent.IFRAME_DETALLE2 !=null)parent.IFRAME_DETALLE2.height(contenido.height()+250);
    
</script>
