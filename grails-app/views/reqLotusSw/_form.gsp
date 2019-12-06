<%@ page import="crm.ReqLotusSw" %>
<%@ page import="crm.Oportunidad" %>
<%@ page import="crm.Pedido" %>
<%@ page import="crm.Empresa" %>
<%@ page import="crm.Empleado" %>
<%@ page import="crm.ValorParametro" %>
<g:set var="generalService" bean="generalService" />
<g:set var="oportunidadService" bean="oportunidadService" />
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>
<g:hiddenField  id="numOptty" name="numOptty"  value="${params.numOportunidad}" />
<g:hiddenField  id="vienedepedido" name="vienedepedido"  value="${params.vienedepedido}" />
<body>
   
<div id="boxreq">
 <div class="control-group">
        <label class="control-label" for="fechaAperturaReq">
            <g:message code="reqLotusSw.fechaAperturaReq.label" default="Fecha Apertura" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls" >

            <div class="controls input-append date form_date" id="fechaaReq" data-date-format="dd-mm-yyyy" style="margin-left:0px;">
            <input type="text" name="fechaAperturaReq" id="op_fechaaReq" readonly  value="${g.formatDate(format:'dd-MM-yyyy',date:reqLotusSwInstance?.fechaAperturaReq)?:generalService.getHoy()}" style="width:153px;" onchange="validarFechas(0,'op_fechaaReq','op_fechacReq')">
            <g:if test="${params.xronly!='true'}"  >            
                <span class="add-on"><i class="icon-th"></i></span>
            </g:if>
        </div>
    </div>
    <br>
    
    <div class="control-group">
                <label class="control-label" for="fechaCierreEstimadaReq">
                    <g:message code="reqLotusSw.fechaCierreEstimadaReq.label" default="Fecha Requerida" />
                    <span class="required-indicator">*</span>
                </label>
                <div class="controls" >  
                    <div class="controls input-append date form_date" id="fechaReq"
                    data-date-format="dd-mm-yyyy" style="margin-left:0px;">
                    <input type="text" name="fechaCierreEstimadaReq" id="op_fechacReq"
                    value="${g.formatDate(format:'dd-MM-yyyy',date:reqLotusSwInstance?.fechaCierreEstimadaReq)}"
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
    
</div>

<div class="control-group ${hasErrors(bean: reqLotusSwInstance, field: 'tipoRequerimiento', 'error')} required ">
    <label class="control-label" for="idCondicion">
        <g:message code="reqLotusSw.tipoRequerimiento.label" default="Tipo Requerimiento" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls" >       
        <g:if test="${params.vienedepedido =='No'}"  >
         <g:select name="tipoRequerimiento" from="${['Preventa General' , 'Preventa solo Servicios', 'Licitación', 'Levantamiento de información proy cableado']}"
            />
        </g:if>
        
        <g:if test="${params.vienedepedido=='Si'}"  >
         <g:select name="tipoRequerimiento" from="${['Servicio']}" readonly="true"
            />
        </g:if>
        
    </div>
</div>


<div class="control-group ${hasErrors(bean: reqLotusSwInstance, field: 'tema', 'error')} required ">
    <label class="control-label" for="tema">
        <g:message code="reqLotusSwInstance.tema.label" default="Tema" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls" /> 
    <g:textField name="tema" style="width:400px;" required="" maxlength="120" value="${reqLotusSwInstance?.tema }" disabled="${xronly}" />           
    </div>
</div>


<div class="control-group ${hasErrors(bean: reqLotusSwInstance, field: 'descripcionReq', 'error')} required ">
    <label class="control-label" for="descripcionReq">
        <g:message code="reqLotusSwInstance.descripcionReq.label" default="Descripción" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls" > 
        <g:textArea name="descripcionReq" style="width:500px;" rows="4"
        maxlength="1000" value="${reqLotusSwInstance?.descripcionReq}"  required="" />
    </div>
</div>

       





</div>

</body>


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
    
     
    var contenido= $("#boxreq");   
    if (parent.IFRAME_REQUERIMIENTO !=null) parent.IFRAME_REQUERIMIENTO.height(contenido.height()+280);
</script>  

