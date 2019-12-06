<%@ page import="crm.Prospecto" %>
<%@ page import="crm.Empresa" %>
<%@ page import="crm.Persona" %>        
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="oportunidadService" bean="oportunidadService" />
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>
<script src="${resource(dir: 'js/jquery', file:'jquery.numeric.js')}"></script>
<script>redimIFRAME();</script>
<div  id="boxposib"> 


    <g:if test="${prospectoInstance?.eliminado==1}" >
        <div id="men_eliminado" class="pull-right label label-important">
            <g:message code="eliminado.label"/>
        </div>
    </g:if>

    <div class="control-group  ${hasErrors(bean: prospectoInstance, field: 'numProspecto', 'error')} ">
        <label class="control-label" for="numProspecto">
            <b><g:message code="prospectoInstance.numProspecto.label" default="# Prospecto:" /></b>

        </label>
        <div class="controls" style="padding-top:5px;">
            ${prospectoInstance?.numProspecto}
        </div>
    </div>
    <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'idSucursal', 'error')}  required ">
        <label class="control-label" for="idSucursal">

            <g:message code="prospecto.idSucursal.label" default="Sucursal" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls" >
            <g:set var="xidSucursal" value="${generalService.getIdSucursal(session['idUsuario'].toLong())}"  />  

            <g:select name="idSucursal" required="" from="${Empresa.findAllByIdTipoEmpresaAndEliminado('empbase',0)}"
                optionKey="id" 
            value="${prospectoInstance?.idSucursal?:xidSucursal}"
            noSelection="['': "${message(code: 'prospecto.seleccioneSucursal.label', default: 'Seleccione Sucursal')}"]"  disabled="${xronly}" />
        </div>
    </div>

    <g:set var="xlabelEmpresa"  value="${message(code: 'empresa.template.label', default: 'Empresa')}"  scope="request" /> 
    <g:set var="xlabelContacto"  value="${message(code: 'contacto.template.label', default: 'Contact')}"  scope="request" /> 
    <g:set var="xidempresa"  value="${prospectoInstance?.empresa?.id}"  scope="request" /> 
    <g:set var="zidcontacto"  value="idContacto"  scope="request" />
    <g:set var="xidcontacto"  value="${prospectoInstance?.persona?.id}"  scope="request" /> 
    <g:set var="autoSw"  value="1"  scope="request" /> <!-- para filtrar   clientes y Prospectos -->
    <g:set var="swNit"  value="0"  scope="request" /> <!-- es un prospecto no nit -->
    <g:set var="swemp"  value="0"  scope="request" /> <!-- sw  control empresa solo lectura -->
    <g:render template="/general/empresaContacto" />
 
    
    <g:if test="${prospectoInstance?.empleado?.id==null}" >
        <g:set var="xmostrar" value="none" />
    </g:if>

    <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'empleado.id', 'error')} " >
        <label class="control-label" for="idVendedor">
            <g:message code="prospecto.idVendedor.label" default="Vendedor" />

            <g:set var="xmostrar" value="none" />
        </label>
        <div class="controls" >

            <g:render template="/empleado/vendedorPorDefecto" />    

            <g:select name="idVendedor" from="${generalService.getVendedores()}"
                optionKey="id"
            value="${prospectoInstance?.empleado?.id?:xidVendedor}"
            noSelection="['': "${message(code: 'seleccioneVendedor.propuesta.label', default: 'Seleccione Vendedor')}"]"  disabled="${xronly}" />
        </div>
    </div>
    <g:if test="${prospectoInstance?.id != null}" >
        <g:set var="xidp"  value="${prospectoInstance?.id}"  scope="request" />
        <g:render template="listaOportunidades" />
    </g:if>
    
    <div class="control-group">
	    <label class="control-label">
		    <g:message code="oportunidad.numOportunidadFabricante.label" default="Num Oportunidad Fabricante" />		
	    </label>	    
	    <div class="controls" >
            <g:textField name="numOportunidadFabricante" value="${fieldValue(bean: prospectoInstance, field: 'numOportunidadFabricante')}" disabled="${xronly}" maxlength="50" class="input-xlarge" />

           <%-- <g:if test="${prospectoInstance.oportunidad!=null}"  disabled="${xronly}">
                <% println "${oportunidadService?.getNumRegistros(prospectoInstance.oportunidad.id[0])}"%>
	    	</g:if> --%>
	    	
	    </div>    
    </div>
    
    
    <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'nombreProspecto', 'error')} required ">
        <label  class="control-label" for="nombreProspecto">
            <g:message code="prospecto.nombreProspecto.label" default="Nombre Proyecto" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:textField name="nombreProspecto"   required=""  maxlength="50" value="${prospectoInstance?.nombreProspecto}" 
            class="input-xlarge" disabled="${xronly}"/>
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'descProspecto', 'error')} ">
        <label  class="control-label" for="descProspecto">
            <g:message code="prospecto.descProspecto.label" default="Detalles" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:if test="${xronly}">
                <g:set var="xcss" value ="" />
            </g:if>
            <g:else>
                <g:set var="xcss" value="cleditor" />
            </g:else>
            <g:textArea name="descProspecto" cols="40" rows="5"  class="input-xlarge"
            value="${prospectoInstance?.descProspecto}" disabled="${xronly}" required="" />
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'fechaApertura', 'error')} ">
        <label class="control-label" for="fechaApertura">
            <g:message code="prospecto.fechaApertura.label" default="Apertura" />
        </label>
        <div class="controls input-append date" id="fechaapertura" data-date-format="dd-mm-yyyy" style="margin-left:20px;">
            <input  type="text" name="fechaApertura" id="fechaa" 
            value="${g.formatDate(format:'dd-MM-yyyy',date:prospectoInstance?.fechaApertura)?:generalService.getHoy()}"  readonly
            onchange="validarFechas(0,'fechaa','fechac')">
            <%--<g:if test="${xronly!='true'}"  >             
                <span class="add-on"><i class="icon-th"></i></span>
            </g:if> --%>
        </div>

    </div>

    <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'fechaCierreEstimada', 'error')} ">
        <label class="control-label" for="fechaCierreEstimada">
            <g:message code="prospecto.fechaCierreEstimada.label" default="Fecha Cierre" />
        </label>
        <div class="controls input-append date form_date" id="fechacierre"  data-date-format="dd-mm-yyyy" style="margin-left:20px;">
            <input  type="text" id="fechac" name="fechaCierreEstimada" value="${g.formatDate(format:'dd-MM-yyyy',date:prospectoInstance?.fechaCierreEstimada)}"   readonly
                    onchange="validarFechas(0,'fechaa','fechac')" >
                    <g:if test="${xronly!='true'}"  >
                        <span class="add-on"><i class="icon-remove"></i></span>
                    <span class="add-on"><i class="icon-th"></i></span>
                    </g:if>

        </div>
        <span id="errfec" style="display:none;"> <b style="color:red; padding-top:3px;"> Esta fecha debe ser posterior a la anterior </b>
            <a href="#" onclick="document.getElementById('errfec').style.display='none'" ><i class="icon-remove"></i></a>
        </span>
    </div>


    <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'valorProspecto', 'error')} ">
        <label class="control-label" for="valorProspecto">
            <g:message code="prospecto.valorProspecto.label" default="Valor USD " />

        </label>
        <div class="controls" >
            <g:textField id="idvalp" name="valorProspecto" value="${fieldValue(bean: prospectoInstance, field: 'valorProspecto')}" 
            disabled="${xronly}" style="text-align:right;padding-right:8px;" class="entero" />
           
        </div>
    </div>
    <% def zronly
      if(prospectoInstance?.estrategiaId==6)  zronly='true' else zronly=xronly       
     %>         
     
    <div class="fieldcontain ${hasErrors(bean: prospectoInstance, field: 'estrategiaId', 'error')} ">
        <label class="control-label"  for="estrategiaId">
            <g:message code="prospecto.estrategiaId.label" default="Estrategia" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
         <g:select name="estrategiaId" id="estrategiaId" from="${crm.Estrategia.findAllByIdEstadoEstrategiaAndEliminado('genactivo',0)}" 
                optionKey="id" 
            value="${prospectoInstance?.estrategiaId}"
            noSelection="['': "${message(code: 'prospecto.seleccionaEstrategia.label', default: 'Seleccione Estrategia')}"]" disabled="${zronly}" required=""
                onchange="${remoteFunction(controller:'Tactica',
                         action:'getTacticas', params:'\'id=\'+this.value',
                         update: [success: 'divtacticas'])}" />
        </div>
    </div>
    
    <g:hiddenField name="estrategiaId" type="number" value="${prospectoInstance?.estrategiaId}" />
    
    <br>
    <div id="divtacticas">  
      <g:set var="tacticaList" value="${generalService.getTacticas(prospectoInstance?.estrategiaId)}" scope="request"/>
      <g:set var="xvalor" value="${prospectoInstance?.idTactica}" scope="request"/>
      <g:set var="zronly" value="${zronly}" scope="request"/>
      <g:render template="/tactica/tacticas"/>
  </div>
  
    <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'idEstadoProspecto', 'error')} ">
        <label class="control-label" for="idEstadoProspecto">
            <g:message code="prospecto.IdEstadoProspecto.label" default="Estado" />

        </label>
        <div class="controls">

            <g:set var="xestadoProspecto" value="${prospectoInstance?.idEstadoProspecto?:'proactivo'}" />
            <div style="padding-top:5px">${generalService.getValorParametro(xestadoProspecto)} </div>
        </div>
    </div>


    <g:hiddenField name="eliminado" type="number" value="${prospectoInstance?.eliminado?:0}" />     
    <g:hiddenField  id ="idEstadoProspecto" name="idEstadoProspecto" value="${prospectoInstance?.idEstadoProspecto?:'proactivo'}" />

    <g:if test="${prospectoInstance?.idEstadoProspecto=='prodescalx'}" >
        <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'idRazonCancelacion', 'error')}">
            <label class="control-label" for="idRazonCancelacion">
                <g:message code="prospecto.idRazonCancelacion.label" default="Razón" />

            </label>
            <div class="controls">
                <g:select name="idRazonCancelacion" from="${generalService.getValoresParametro('trazon')}" 
                    optionKey="id" 
                value="${prospectoInstance?.idRazonCancelacion}"
                noSelection="['': '']" disabled="${xronly}"  />
            </div>
        </div>  
        <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'otraRazonCancelacion', 'error')} ">
            <label  class="control-label" for="otraRazonCancelacion">
                <g:message code="prospecto.otraRazonCancelacion.label" default="Otra Razón" />
            </label>
            <div class="controls">
                <g:textArea style="width:400px;"  name="otraRazonCancelacion"  rows="4"  value="${prospectoInstance?.otraRazonCancelacion}" disabled="${xronly}"  />
            </div> 
        </div>

    </g:if>    
</div>
<div class="tabbable" >

    <ul class="nav  nav-tabs" id="myTab" style="font-weight: bold;">
		<li class="active"><a href="#anexos" data-toggle="tab" ><g:message code="anexos.tab.label" default="Anexos"/></a></li>
		<li><a href="#actividades" data-toggle="tab"><g:message code="bitacora.tab.label" default="Bitácora"/></a></li>
        <li><a href="#home" data-toggle="tab"><g:message code="seguimiento.tab.label" default="Seguimiento"/></a></li>
        <li><a href="#historial"  data-toggle="tab"><g:message code="historial.tab.label" default="Historial"/></a></li>    
    </ul>

    <div class="tab-content">
    
    
    	<!-- ANEXOSS -->
    	
    	
    	<div class="tab-pane active" id="anexos">
	        <g:if test="${prospectoInstance?.id != null}">
	            <div class="pull-right" style="margin-top:-4px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifanexos')"><i class="icon-refresh"></i></a></div>
	            <iframe id="ifanexos" src="/crm/anexo/index/${prospectoInstance?.id}?entidad=prospecto&sw=${sw}" style="border:0;width:100%;"  scrolling="no"></iframe>
	            <%--<script language="javascript">
	                /* IFRAME_DETALLE1 = $("#ifanexos");*/
	                   IFRAME_ANEXO=$("#ifanexos");
	            </script>--%>
	        </g:if>
    	</div><!-- fin tab anexos -->


    	<!-- BITACORA -->    	
    	
    	<div class="tab-pane" id="actividades">
                <div class="box-content" >
                    <div class="pull-right" style="margin-top:-10px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifactividad')"><i class="icon-refresh"></i></a></div>
                 
                    <%
                      def xtiponota='notagesven'
                      if ('GERENTE'  in generalService.getRolUsuario(session['idUsuario'].toLong()))
                          xtiponota='notaseguim'                      
                    %>
                    <iframe id="ifactividad" src="/crm/nota/index/${prospectoInstance?.id}?entidad=prospectoAdj&tnota=${xtiponota}&zw=1" style="border:0;width:100%;" scrolling="no"></iframe>
                </div>
               <%-- <script language="javascript">                      
                        //IFRAME_DETALLE2 = $("#ifactividad");
                </script>--%>
          </div><!-- fin tab anexos -->
    	
    	
    	
    	
    	
    
        <div class="tab-pane" id="home">
            <div class="box-content">
                <iframe id="ifnotas" src="/crm/nota/index/${prospectoInstance?.id}?entidad=prospecto" style="border:0;width:100%;"  scrolling="no"></iframe>

                <%--<script>    
                    IFRAME_DETALLE = $("#ifnotas");    
                    $(".entero").numeric();
                </script> --%>
            </div>
        </div>
        
        
        
        <div class="tab-pane" id="historial">
            <div class="box-content">    

                <a class="btn btn-mini" href="#" onclick="cargarHistorial(${prospectoInstance?.id},'Prospecto')" ><g:message code="historial.label" default="Ver Historial"/></a>  

                <iframe id="ifhistoria" src="" style="border:0;overflow:hidden;width:100%;" ></iframe>

            </div>
        </div>
        
        
    </div>
</div>




<hr style="margin-top:10px;margin-bottom:10px;"> 

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



