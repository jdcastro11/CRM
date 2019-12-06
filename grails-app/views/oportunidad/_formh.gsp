<%@ page import="crm.Oportunidad" %>
<%@ page import="crm.Empresa" %>
<%@ page import="crm.Empleado" %>
<%@ page import="crm.ValorParametro" %>
<g:set var="generalService" bean="generalService" />
<g:set var="pedidoService" bean="pedidoService" />
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>
<div id="boxopor">

    <g:if test="${oportunidadInstance?.eliminado==1}" >
        <div id="men_eliminado" class="pull-right label label-important">
            Eliminado
        </div>
    </g:if>
    <g:hiddenField name="swconvertir"  value="${swconvertir?:'N'}" /> 
    <g:hiddenField name="nombreVendedor"  value="${oportunidadInstance?.nombreVendedor}" /> 
    <g:hiddenField name="numOportunidad"  value="${oportunidadInstance?.numOportunidad?:''}" /> 
    <g:hiddenField name="idProspecto"  value="${xidprospecto?:0}" /> 
    <g:hiddenField name="eliminado" type="number" value="${oportunidadInstance?.eliminado?:0}" />   
   
    <g:hiddenField  id="idEstadoOportunidad" name="idEstadoOportunidad"  value="${oportunidadInstance?.idEstadoOportunidad?:'oposinasig'}" />

    <div class="control-group pull-left ${hasErrors(bean: oportunidadInstance, field: 'idEstadoOportunidad', 'error')} ">
        <label class="control-label" for="idEstadoOportunidad">
            <b><g:message code="oportunidad.idEstadoOportunidad.label" default="Estado:" /></b>

        </label>
        <div class="controls"  style="padding-top:5px;" > 
            ${generalService.getValorParametro(oportunidadInstance?.idEstadoOportunidad)}
        </div>
    </div>
    <div class="control-group  pull-right  ${hasErrors(bean: oportunidadInstance, field: 'numOportunidad', 'error')} ">
        <label class="control-label" for="numOportunidad">
            <b><g:message code="oportunidad.numOportunidad.label" default="# Oportunidad:" /></b>

        </label>
        <div class="controls" style="padding-top:5px;">
            ${oportunidadInstance?.numOportunidad}
        </div>
    </div>

    <p>&nbsp;</p>
    <div class=" pull-left" style="background-color:#f6f6f6;width:99%;padding:5px;font-weight: bold;" >Datos del Cliente</div>
    <p style="padding-top:1px">&nbsp;</p>


    <g:set var="xlabelEmpresa"  value="Cliente"  scope="request" /> 
    <g:set var="xlabelContacto"  value="Contacto"  scope="request" /> 
    <g:set var="xidempresa"  value="${oportunidadInstance?.empresa?.id}"  scope="request" /> 
    <g:set var="zidcontacto"  value="idContacto"  scope="request" />
    <g:set var="xidcontacto"  value="${oportunidadInstance?.persona?.id}"  scope="request" /> 
    <g:set var="autoSw"  value="0"  scope="request" /> <!-- para filtrar   solo clientes -->
    <g:render template="/general/empresaContacto" />

    <div style="background-color:#f6f6f6;width:99%;padding:5px;font-weight: bold;">Datos de la Oportunidad</div>
    <br>
    <g:if test="${oportunidadInstance?.prospecto?.id!=null}">
        <div class="control-group">
            <label class="control-label">
                Prospecto
            </label>
            <div class="controls" >            
                <a href="/crm/prospecto/show/${oportunidadInstance?.prospecto?.id}" style="text-decoration:underline">
                    ${oportunidadInstance?.prospecto?.numProspecto}</a>
            </div>
        </div>
    </g:if>
    
    <g:if test="${oportunidadInstance?.prospecto?.id!=null}">
        <g:set var="xidop"  value="${oportunidadInstance?.id}"  scope="request" />
         <g:render template="listaPedidos" />
     </g:if>
    <div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'valorOportunidad', 'error')} ">
        <label class="control-label" for="valorOportunidad">
            <g:message code="oportunidad.valorOportunidad.label" default="Valor Oportunidad" />

        </label>
        <div class="controls" > 
            <g:textField name="valorOportunidad" value="${fieldValue(bean: oportunidadInstance, field: 'valorOportunidad')}"
            style="text-align: right" disabled="${xronly}" />
        </div>
    </div>
    <div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'numOportunidadFabricante', 'error')} ">
        <label class="control-label" for="numOportunidadFabricante">
            <g:message code="oportunidad.numOportunidadFabricante.label" default="Num Oportunidad Fabricante" />

        </label>
        <div class="controls" > 
            <g:textField name="numOportunidadFabricante" maxlength="50" 
            value="${oportunidadInstance?.numOportunidadFabricante}"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="fechaApertura">
            <g:message code="oportunidad.fechaApertura.label" default="Fecha Apertura" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls" >

            <div class="controls input-append date form_date" id="fechaa"
            data-date-format="dd-mm-yyyy" style="margin-left:0px;">
            <input type="text" name="fechaApertura" id="op_fechaa" readonly 
            value="${g.formatDate(format:'dd-MM-yyyy',date:oportunidadInstance?.fechaApertura)?:generalService.getHoy()}" style="width:153px;" 
            onchange="validarFechas(0,'op_fechaa','op_fechac')">
            <g:if test="${xronly!='true'}"  >            
                <span class="add-on"><i class="icon-th"></i></span>
                </g:if>
        </div>
    </div>
    <br>
    <div class="control-group">
        <label class="control-label" for="fechaCierreEstimada">
            <g:message code="oportunidad.fechaCierreEstimada.label" default="Cierre Estimado" />

        </label>
        <div class="controls" >

            <div class="controls input-append date form_date" id="fecha"       
            data-date-format="dd-mm-yyyy" style="margin-left:0px;">
            <input type="text" name="fechaCierreEstimada" id="op_fechac"
            value="${g.formatDate(format:'dd-MM-yyyy',date:oportunidadInstance?.fechaCierreEstimada)}"
            style="width:153px;" readonly
            onchange="validarFechas(0,'op_fechaa','op_fechac')">
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


<g:set var="pedidoList" value="${pedidoService.valorFacturadoOportunidad((String)oportunidadInstance?.id)}"/>    
<g:if test="${pedidoList['total'] !=null}" >

    <div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'valorFacturado', 'error')} ">
        <label class="control-label" for="valorFacturado">
            <g:message code="oportunidad.valorFacturado.label" default="Valor Facturado" />

        </label>
        <div class="controls" >         
            <g:textField name="valorFacturado" value="${pedidoList['total']}" disabled="true" />
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">
            Porcentaje Facturado
        </label>
        <div class="controls" >         
            <g:formatNumber number="${pedidoList['porcFac']}" type="percent" /> 
        </div>
    </div>
</g:if>
<div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'nombreOportunidad ', 'error')} required ">
    <label class="control-label" for="nombreOportunidad ">
        <g:message code="oportunidad.nombreOportunidad .label" default="Oportunidad " />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls" >
        <g:textField name="nombreOportunidad" style="width:300px;" required="" maxlength="50" value="${oportunidadInstance?.nombreOportunidad }" disabled="${xronly}" />
    </div>
</div>

<div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'descOportunidad', 'error')} ">
    <label class="control-label" for="descOportunidad">
        <g:message code="oportunidad.descOportunidad.label" default="Detalle  Oportunidad" />

    </label>
    <div class="controls" > 
        <g:textArea name="descOportunidad" style="width:500px;" rows="5" maxlength="300" value="${oportunidadInstance?.descOportunidad}" disabled="${xronly}" />
    </div>
</div>
<div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'idVendedor', 'error')} ">
    <label class="control-label" for="idVendedor">
        <g:message code="oportunidad.idVendedor.label" default="Vendedor" />

    </label>
    <div class="controls" > 

        <g:render template="/empleado/vendedorPorDefecto" />

        <g:select name="idVendedor" from="${generalService.getVendedores()}" 
            optionKey="id" 
        value="${oportunidadInstance?.empleado?.id?:xidVendedor}"
        noSelection="['': 'Seleccione Vendedor']"  disabled="${xronly}" />
    </div>
</div>

<div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'idSucursal', 'error')}  required ">
    <label class="control-label" for="idSucursal">
        <g:message code="oportunidad.idSucursal.label" default="Sucursal" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls" >
        <g:set var="xidSucursal" value="${generalService.getIdSucursal(session['idUsuario'].toLong())}"  />  
        <g:select name="idSucursal" required="" from="${Empresa.findAllByIdTipoEmpresaAndEliminado('empbase',0)}"
            optionKey="id" 
        value="${oportunidadInstance?.idSucursal?:xidSucursal}"
        noSelection="['': 'Seleccione Sucursal']"  disabled="${xronly}" />
    </div>
</div>

<div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'idActividadMercadeo', 'error')} ">
    <label class="control-label" for="idActividadMercadeo">
        <g:message code="oportunidad.idActividadMercadeo.label" default="Actividad Mercadeo" />

    </label>
    <div class="controls" >
        <g:select name="idActividadMercadeo" from="${generalService.getValoresParametro('tpoactmerc')}"
            optionKey="idValorParametro"
        value="${oportunidadInstance?.idActividadMercadeo}"
        noSelection="['': 'Seleccione Actividad']"  disabled="${xronly}" />
    </div>
</div>

<div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'idNombreActividadMercadeo', 'error')} ">
    <label class="control-label" for="idNombreActividadMercadeo">
        <g:message code="oportunidad.idNnombreActividadMercadeo.label" default="Nombre Actividad Mercadeo" />

    </label>
    <div class="controls" > 
        <g:select name="idNombreActividadMercadeo" from="${generalService.getValoresParametro('nomactmerc')}"
            optionKey="idValorParametro"
        value="${oportunidadInstance?.idNombreActividadMercadeo}"
        noSelection="['': 'Seleccione Nom. Actividad']"  disabled="${xronly}" />
    </div>
</div>

<div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'idCondicion', 'error')} required ">
    <label class="control-label" for="idCondicion">
        <g:message code="oportunidad.idCondicion.label" default="Condición" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls" >       
        <g:select name="idCondicion" from="${generalService.getValoresParametro('tipocondic')}" 
            optionKey="idValorParametro"    required=""
        value="${oportunidadInstance?.idCondicion}"
        noSelection="['': 'Seleccione Condición']"  disabled="${xronly}" />
    </div>
</div>

<div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'idEtapa', 'error')} ">
    <label class="control-label" for="idEtapa">
        <g:message code="oportunidad.idEtapa.label" default="Probabilidad" />

    </label>
    <div class="controls" >

        <g:select name="idEtapa" from="${ValorParametro.findAllByIdParametroAndEstadoValorParametroAndEliminadoAndIdValorParametroNotEqual('etapasvent','A',0,'posvent100')}"
            optionKey="idValorParametro"
        value="${oportunidadInstance?.idEtapa?:'posventx10'}"
        noSelection="['': 'Seleccione Etapa']"  disabled="${xronly}" style="direction: rtl;" />
    </div>
</div>
<g:if test="${oportunidadInstance?.idEstadoOportunidad=='xperdida'}" >
    <div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'idMotivoPerdida', 'error')} ">
        <label class="control-label" for="idMotivoPerdida">
            <g:message code="oportunidad.idMotivoPerdida.label" default="Motivo Perdida" />                
        </label>
        <div class="controls" > 
            <g:select name="idMotivoPerdida" from="${generalService.getValoresParametro('tpoperdida')}"
                optionKey="idValorParametro"
            value="${oportunidadInstance?.idMotivoPerdida}"
            noSelection="['': 'Seleccione Motivo']" readonly="${xronly}" />                  
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'observCierre', 'error')} ">
        <label class="control-label" for="observCierre">
            <g:message code="oportunidad.observCierre.label" default="Observaciones Cierre" />

        </label>
        <div class="controls" > 
            <g:textArea name="observCierre" style="width:500px;" rows="5"
            maxlength="300" value="${oportunidadInstance?.observCierre}" readonly="${xronly}" />
        </div>
    </div>
</g:if>

<%--<div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'fechaCierreReal', 'error')} ">
<label class="control-label" for="fechaCierreReal">
        <g:message code="oportunidad.fechaCierreReal.label" default="Fecha Cierre Real" />
        
</label>
<div class="controls" > 
   <g:textField name="fechaCierreReal" maxlength="20" value="${oportunidadInstance?.fechaCierreReal}"/>
</div>
</div>
--%>

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


<g:if test="${oportunidadInstance?.id!=null}" >
    <hr>
    <div class="tabbable" >
        <ul class="nav  nav-tabs" id="myTab" style="font-weight: bold;">

            <li class="active"><a href="#home" data-toggle="tab">Items</a></li>
            <li><a href="#actividades"  data-toggle="tab">Actividades</a></li>
            <li><a href="#propuestas"  data-toggle="tab">Propuestas</a></li>
            <li><a href="#regopor"  data-toggle="tab"> Registro Oportunidad</a></li>
            
        </ul>

        <div class="tab-content">
            <div class="tab-pane active" id="home">
                <div class="box-content">
                    <div class="pull-right" style="margin-top:-4px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifelemenxprod')"><i class="icon-refresh"></i></a></div>
                    <iframe id="ifelemenxprod" src="/crm/ElementoPorOportunidad/indexh/${oportunidadInstance?.id}?sw=${sw}" style="border:0;width:100%;"  scrolling="no"></iframe>
                    <script language="javascript">
                        IFRAME_DETALLE = $("#ifelemenxprod");
                    </script>
                </div>
            </div>
            <div class="tab-pane" id="actividades">
                <div class="box-content">
                    <div class="pull-right" style="margin-top:-4px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifactividad')"><i class="icon-refresh"></i></a></div>
                    <iframe id="ifactividad" src="/crm/actividad/indexh/${oportunidadInstance?.id}?entidad=oportunidad&idcon=${xidcontacto}&sh=1" style="border:0;width:100%;"  scrolling="no"></iframe>
                    <script language="javascript">
                        IFRAME_DETALLE2 = $("#ifactividad");
                    </script>
                </div>
            </div>
            <div class="tab-pane" id="propuestas">
                <div class="box-content">
                    <div class="pull-right" style="margin-top:-4px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifpropuesta')"><i class="icon-refresh"></i></a></div>
                    <iframe id="ifpropuesta" src="/crm/propuesta/indexh/${oportunidadInstance?.id}?sh=1" style="border:0;width:100%;"  scrolling="no"></iframe>
                    <script language="javascript">
                        IFRAME_DETALLE1 = $("#ifpropuesta");
                    </script>
                </div>
            </div>
            <div class="tab-pane" id="regopor">
                <div class="box-content">
                    <div class="pull-right" style="margin-top:-4px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifregopor')"><i class="icon-refresh"></i></a></div>
                    <iframe id="ifregopor" src="/crm/registroOportunidad/indexh/${oportunidadInstance?.id}?sh=1" style="border:0;width:100%;"  scrolling="no"></iframe>
                    <script language="javascript">
                        IFRAME_DETALLE3 = $("#ifregopor");
                    </script>
                </div>
            </div>
        
        </div>

    </div>
</g:if>

