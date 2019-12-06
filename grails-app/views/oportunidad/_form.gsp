<%@ page import="crm.Oportunidad" %>
<%@ page import="crm.Empresa" %>
<%@ page import="crm.Empleado" %>
<%@ page import="crm.ValorParametro" %>
<g:set var="generalService" bean="generalService" />
<g:set var="oportunidadService" bean="oportunidadService" />
<g:set var="pedidoService" bean="pedidoService" />
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>
<script> redimIFRAME(); SW_IFACTIVIDAD=0;SW_IFPROPUESTA=0;SW_IFREGOPOR=0;SW_IFREQUERIMIENTO=0;SW_CTRLANEXO=0;</script>
<div id="boxopor">

    <g:if test="${oportunidadInstance?.eliminado==1}" >
        <div id="men_eliminado" class="pull-right label label-important">
            Eliminado
        </div>
    </g:if>
    <g:hiddenField name="swconvertir"  value="${swconvertir?:'N'}" /> 
    <g:hiddenField name="idautor"  value="${session['idUsuario']}" /> 
    <g:hiddenField name="nombreVendedor"  value="${oportunidadInstance?.nombreVendedor}" /> 
    <g:hiddenField name="numOportunidad"  value="${oportunidadInstance?.numOportunidad?:''}" /> 
    <g:hiddenField name="idProspecto"  value="${xidprospecto?:0}" /> 
    <g:hiddenField name="eliminado" type="number" value="${oportunidadInstance?.eliminado?:0}" />   

    <g:hiddenField  id="idEstadoOportunidad" name="idEstadoOportunidad"  value="${oportunidadInstance?.idEstadoOportunidad?:'oporactiva'}" />
 
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
            <b><g:message code="oportunidad.numOportunidad.label" default="Oportunidad Número:" /></b>

        </label>
        <div class="controls" style="padding-top:5px;" id="numeroportunidad">
            ${oportunidadInstance?.numOportunidad}
        </div>
    </div>

    <p>&nbsp;</p>
    <div class=" pull-left" style="background-color:#f6f6f6;width:99%;padding:5px;font-weight: bold;" ><g:message code="datos.oppty.label" default="Datos del Cliente"/> </div>
    <p style="padding-top:1px">&nbsp;</p>


    <g:set var="xlabelEmpresa"  value="${message(code: 'nombreCliente.label', default: 'Cliente')}"  scope="request" /> 
    <g:set var="xlabelContacto"  value="${message(code: 'contacto.label', default: 'Contacto')}"  scope="request" /> 
    <g:set var="xidempresa"  value="${oportunidadInstance?.empresa?.id}"  scope="request" /> 
    <g:set var="zidcontacto"  value="idContacto"  scope="request" />
    <g:set var="xidcontacto"  value="${oportunidadInstance?.persona?.id}"  scope="request" /> 
    <g:set var="autoSw"  value="0"  scope="request" /> <!-- para filtrar   solo clientes -->
    <g:set var="swNit"  value="1"  scope="request" /> <!-- es un cliente nit obligatorio -->
    <g:if test="${swconvertir=='N'}"> 
       <g:set var="swemp"  value="0"  scope="request" /> <!-- permite a usuario modificar empresa -->
    </g:if>
    <g:else>
      <g:set var="swemp"  value="0"  scope="request" /> <!-- sw  control empresa solo lectura -->
    </g:else>
    <g:render template="/general/empresaContacto" />

    <div style="background-color:#f6f6f6;width:99%;padding:5px;font-weight: bold;"><g:message code="oppty.info.label" default="Datos de la Oportunidad"/> </div>
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

    <g:if test="${oportunidadInstance?.pedido?.id}">
        <g:set var="xidop"  value="${oportunidadInstance?.id}"  scope="request" />
        <g:render template="listaPedidos" />
    </g:if>
    <div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'valorOportunidad', 'error')} required">
       
        <label class="control-label" for="valorOportunidad">
            
            <g:message code="oportunidad.valorOportunidad.label" default="${message(code: 'valor.oppty.label', default: 'Valor USD')}" />
             <span class="required-indicator">*</span>
              </label>
        <div class="controls" > 
            <g:textField name="valorOportunidad" value="${fieldValue(bean: oportunidadInstance, field: 'valorOportunidad')}"
            style="text-align: right" disabled="${xronly}" required="" maxlength="7" />
            <img  class="iconoAyudaEtiqueta"  src="${resource(dir: 'images', file:'ayuda.png')}" title="Sólo valores en dólares, si el valor es en pesos, debe realizar la conversion con la TRM del día">
          
        </div>
    </div>
    
    <div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'numOportunidadFabricante', 'error')} ">
        <label class="control-label" for="numOportunidadFabricante">
            <g:message code="oportunidad.numOportunidadFabricante.label" default="Num Oportunidad Fabricante" />

        </label>
        <div class="controls"  >

            <%--<g:textField name="numOportunidadFabricante" value="${fieldValue(bean: oportunidadInstance, field: 'numOportunidadFabricante')}" disabled="${xronly}" required="" />--%>
             <% println "${oportunidadService.getNumRegistros(oportunidadInstance.id)}" %>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="fechaApertura">
            <g:message code="oportunidad.fechaApertura.label" default="Fecha Apertura" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls" >

            <div class="controls input-append date" id="fechaa"
            data-date-format="dd-mm-yyyy" style="margin-left:0px;">
	            <input type="text" name="fechaApertura" id="op_fechaa" readonly 
	            value="${g.formatDate(format:'dd-MM-yyyy',date:oportunidadInstance?.fechaApertura)?:generalService.getHoy()}" style="width:153px;" 
	            onchange="validarFechas(0,'op_fechaa','op_fechac')">
	            <%--<g:if test="${xronly!='true'}"  >            
	                <span class="add-on"><i class="icon-th"></i></span>
	            </g:if>--%>
               </div>
    </div>
    <br>
    <div class="control-group">
        <label class="control-label" for="fechaCierreEstimada">
            <g:message code="oportunidad.fechaCierreEstimada.label" default="Cierre Estimado" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls" >                 
            <div class="controls input-append date form_date" id="fecha"
            data-date-format="dd-mm-yyyy" style="margin-left:0px;">
            <input type="text" name="fechaCierreEstimada" id="op_fechac"
            value="${g.formatDate(format:'dd-MM-yyyy',date:oportunidadInstance?.fechaCierreEstimada)}"
            style="width:153px;"  required=""
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
            <g:message code="oportunidad.porcentajeFacturado.label" default="Porcentaje Facturado" />
        </label>
        <div class="controls" >         
            <g:formatNumber number="${pedidoList['porcFac']}" type="percent" /> 
        </div>
    </div>
</g:if>
<div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'nombreOportunidad ', 'error')} required ">
    <label class="control-label" for="nombreOportunidad ">
        <g:message code="oportunidad.nombreOportunidad.label" default="Proyecto " />
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
        
        <% def xoblig; if(swconvertir=='N') xoblig="true" else xoblig="false" %>
        
        <g:render template="/empleado/vendedorPorDefecto" />

        <g:select name="idVendedor" from="${generalService.getVendedores()}" 
            optionKey="id" 
        value="${oportunidadInstance?.empleado?.id?:xidVendedor}"
        noSelection="['': "${message(code: 'seleccioneVendedor.propuesta.label')}"]"  disabled="${xronly}"  required="${xoblig}" />
    </div>
</div>

<div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'idSucursal', 'error')}  required ">
    <label class="control-label" for="idSucursal">
        <g:message code="oportunidad.idSucursal.label" default="Sucursal" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:set var="xidSucursal" value="${generalService.getIdSucursal(session['idUsuario'].toLong())}"  />  
        <g:select name="idSucursal" required="" from="${Empresa.findAllByIdTipoEmpresaAndEliminado('empbase',0)}"
            optionKey="id" noSelection="['': "${message(code: 'prospecto.seleccioneSucursal.label')}"]"  disabled="${xronly}" id="sucursalOp" 
             value="${oportunidadInstance?.idSucursal}" />
    	<div id="aja" style="display:inline;margin:3px 0px 0px 20px;height:30px;width:auto;"></div>        
    </div>
    
</div>
 <% def zronly
      if(oportunidadInstance?.estrategiaId==6)  zronly='true' else zronly=xronly
		def soloLect=true       
     %> 
<div class="fieldcontain ${hasErrors(bean: tacticaInstance, field: 'idEstrategia', 'error')} ">
    <label class="control-label"  for="idEstrategia">
        <g:message code="tactica.idEstrategia.label" default="Estrategia" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select name="estrategiaId" id="estrategiaId"
        		  from="${crm.Estrategia.findAllByIdEstadoEstrategiaAndEliminado('genactivo',0)}" 
                  optionKey="id" 
                  value="${oportunidadInstance?.estrategiaId}"
                  noSelection="['': "${message(code: 'prospecto.seleccionaEstrategia.label', default: 'Seleccione Estrategia')}"]" disabled="${zronly}" required=""
                  onchange="${remoteFunction(controller:'Tactica',
                             action:'getTacticas', params:'\'id=\'+this.value',
                             update: [success: 'divtacticas'])}" />
    </div>
</div>
<br>
<g:hiddenField name="estrategiaId" type="number" value="${oportunidadInstance?.estrategiaId}" />
<div id="divtacticas">  
    <g:set var="tacticaList" value="${generalService.getTacticas(oportunidadInstance?.estrategiaId)}" scope="request"/>
    <g:set var="xvalor" value="${oportunidadInstance?.idTactica}" scope="request"/>
    <g:set var="zronly" value="true" scope="request"/>
    <g:render template="/tactica/tacticas" />
</div>

<div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'idFabricante', 'error')} ">
    <label class="control-label" for="idFabricante">
        <g:message code="oportunidad.idFabricante.label" default="Fabricante" />
          <span class="required-indicator">*</span>
    </label>
    <div class="controls" >

        <g:select name="idFabricante" from="${generalService.getValoresParametro('fabricante')}"
            optionKey="idValorParametro"
        value="${oportunidadInstance?.idFabricante}"
        noSelection="['': "${message(code: 'seleccionar.fabricante.label')}"]"  disabled="${xronly}" required="" />
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
        noSelection="['': "${message(code: 'seleccionar.condicion.label')}"]"  disabled="${xronly}" />
    </div>
</div>

<div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'idEtapa', 'error')} ">
    <label class="control-label" for="idEtapa">
        <g:message code="oportunidad.idEtapa.label" default="Probabilidad" />

    </label>
    <div class="controls" >
       <% 
           def xetapas=generalService.getValoresParametro('etapasvent')     
       
        if  ( oportunidadInstance?.idEstadoOportunidad !='xganada'){
            xetapas.remove(4)
            xetapas.remove(4)
        } 
       %>
        <g:select name="idEtapa" from="${xetapas}"
         optionKey="idValorParametro"   
        value="${oportunidadInstance?.idEtapa?:'posventx10'}"
        noSelection="['': 'Seleccione Etapa']"  disabled="${xronly}"  />
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

</div>--%>


</div>





<g:if test="${oportunidadInstance?.id!=null}" >
    <hr>
    <div class="tabbable" >
        <ul class="nav  nav-tabs" id="myTab" style="font-weight: bold;margin-bottom:0px">
          
            <li class="active"><a href="#home" data-toggle="tab">Items</a></li>
            <li><a href="#actividades"   data-toggle="tab"  ><g:message code="bitacora.tab.label"/></a></li>
            <li><a href="#propuestas" onclick="recargarIframe('ifpropuesta');"  data-toggle="tab" ><g:message code="propuestas.label"/> </a></li>
            <li><a href="#anexos" onclick="recargarIframe('ifanexos');" data-toggle="tab" >Anexos</a></li>
            <li><a href="#regopor"  data-toggle="tab" ><g:message code="registro.oppty.label" default="Registro Oportunidad"/> </a></li>
            <li><a  href="#requerimiento"  data-toggle="tab" ><g:message code="requerimiento.oppty.label" default="Requerimiento"/>  </a></li>
            <li><a href="#historia"  data-toggle="tab"><g:message code="historial.tab.label" default="Historial"/> </a></li>
        </ul>

        <div class="tab-content">
            <div class="tab-pane active" id="home">
                <div class="box-content">
                    <div class="pull-right" style="margin-top:0px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifelemenxprod')"><i class="icon-refresh"></i></a></div>
                    <iframe id="ifelemenxprod" src="/crm/ElementoPorOportunidad/index/${oportunidadInstance?.id}?sw=${sw}" style="border:0;width:100%;"  scrolling="no"></iframe>
                   <%-- <script language="javascript">
                        IFRAME_DETALLE = $("#ifelemenxprod");
                    </script>--%>
                </div>
            </div>
            <div class="tab-pane" id="actividades">
                <div class="box-content" >
                    <div class="pull-right" style="margin-top:-10px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifactividad')"><i class="icon-refresh"></i></a></div>
                 
                    <%
                      def xtiponota='notagesven'
                      if ('GERENTE'  in generalService.getRolUsuario(session['idUsuario'].toLong()))
                          xtiponota='notaseguim'                      
                    %>
                    <iframe id="ifactividad" src="/crm/nota/index/${oportunidadInstance?.id}?entidad=oportunidad&tnota=${xtiponota}&zw=1" style="border:0;width:100%;" scrolling="no"></iframe>
                </div>
               <%-- <script language="javascript">  
                    
                        //IFRAME_DETALLE2 = $("#ifactividad");
                </script>--%>
            </div>
            <div class="tab-pane" id="propuestas">
                <div class="box-content">
                    <div class="pull-right" style="margin-top:-4px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifpropuesta')"><i class="icon-refresh"></i></a></div>
                    <iframe id="ifpropuesta" src="/crm/propuesta/index/${oportunidadInstance?.id}?idemp=${xidempresa}&sw=${sw}&swc=0" style="border:0;width:100%;height:0px;"  scrolling="no"></iframe>
                    <script language="javascript">
                        IFRAME_PROPUESTA = $("#ifpropuesta");
                    </script>
                </div>
            </div>
            <div class="tab-pane" id="anexos" >
                <g:if test="${oportunidadInstance?.id != null}">
                    <div class="pull-right" style="margin-top:-4px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifanexos')"><i class="icon-refresh"></i></a></div>
                    <iframe id="ifanexos" src="/crm/anexo/indexo/${oportunidadInstance?.id}?entidad=oportunidad&sw=${sw}" style="border:0;width:100%;"  scrolling="no"></iframe>

                </g:if><%--todo revisar esta seccion para que los anexos funcionen para las oportunidades--%>
            </div><%-- fin tab anexos --%>

            <div class="tab-pane" id="regopor">
                <div class="box-content">
                    <div class="pull-right" style="margin-top:-4px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifregopor')"><i class="icon-refresh"></i></a></div>
                    <iframe id="ifregopor" src="/crm/registroOportunidad/index/${oportunidadInstance?.id}?sw=${sw}" style="border:0;width:100%;height:0px;"  scrolling="no"></iframe>
                   <%-- <script language="javascript">
                        IFRAME_DETALLE3 = $("#ifregopor");
                    </script>--%>
                </div>
            </div>
            <!-- adicion para el iframe de requerimiento    -->
             <div class="tab-pane" id="requerimiento">
                <div class="box-content">                   
              
                      <iframe id="ifrequerimiento" src="/crm/reqLotusSw/index/?pedido=No&numOptty=${oportunidadInstance?.numOportunidad}" style="border:0;width:100%;height:0px;"  scrolling="no" onclick="recargarIframe('ifrequerimiento')"></iframe>
                     <%--<script language="javascript">
                        IFRAME_REQUERIMIENTO = $("#ifrequerimiento");
                    </script>--%>
                </div>
            </div>
            <!--  fin de las modificacines mq   -->
            <div class="tab-pane" id="historia">
                <div class="box-content">                   
                    <a class="btn btn-mini" href="#" onclick="cargarHistorial(${oportunidadInstance?.id},'Oportunidad')" ><g:message code="historial.label" default="Ver Historial"/></a>  

                    <iframe id="ifhistoria" src="" style="border:0;overflow:hidden;width:100%;height:0px;" >
                    
                    
                    </iframe>

                </div>
            </div>
            
        </div>

    </div>
    
    
</g:if>

<script>
		$("#sucursalOp").change(function()
		{
		
			if($('#sucursalOp').val())
		{		$("#aja").fadeIn(1100,function()
			 				{
			 					
			 					$(this).show().delay(5000).fadeOut();
		 					}
			 		
			 		)			
					$("#aja").css("font-size","14px");
					$("#aja").css("color","#DD1C1A");
					$("#aja").css("font-weight","600");
					$("#aja").css("background-color","#D3EBFA !important");
					$("#aja").css("color","#066BA7 !important");
					$("#aja").css("display","inline")
					$("#aja").css("border","1px solid #6DBEEE")
					$("#aja").css("border-radius","3px")
					$("#aja").css("padding","6px 18px 6px 18px")
					
					
					var x=($("#sucursalOp option:selected").text())
			
					$("#aja").text("Oportunidad será asignada a la sucursal de "+x)
			}
		})


</script>