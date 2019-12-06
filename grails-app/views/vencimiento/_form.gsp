<%@page import="crm.Vencimiento"%>
<g:set var="generalService" bean="generalService" />
<g:set var="pedidoService" bean="pedidoService" />

<style>
#idTipoConvenio,#valoresTipoVencimiento,#pedido,#plataforma,#idTipoCobertura,#idTipoContrato{
	width:250px;
}

input#refTipModNumContract,input#serial,input#descripcion,input#observaciones{
	width:235px;
}

</style>
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>
<g:hiddenField name="eliminado" value="${vencimientoInstance?.eliminado?:0}" />
<g:hiddenField  name="idencvenc" value="${vencimientoInstance?.encvencimiento?.id?:params.idenc}" />
<g:hiddenField  name="vencimientoId" value="${vencimientoInstance?.id?:params.id}" />
<% println params %>
<g:set  var="encVencimientoInstance" value="${crm.EncVencimiento.get(params.long('idenc'))}"/>
<div  id="boxVenc">
    <g:if test="${vencimientoInstance?.eliminado==1}" >
        <div id="men_eliminado" class="pull-right label label-important">
            Eliminado
        </div>
    </g:if>
     <%  if (!xidemp) xidemp=params.idemp %>
    <g:set var="pedidoList" value="${pedidoService.getPedidosPorCliente(vencimientoInstance?.pedido?.empresa?.id?:xidemp.toLong())}" scope="request" />    
    <g:set var="xidpedido" value="${vencimientoInstance?.pedido?.id}" scope="request" />   
	    
	<% def mostrarTipoConvenio='';def mostrarSerie=''
		if(vencimientoInstance?.idTipoVencimiento!='venconsop')
			mostrarTipoConvenio='display:none;'
		

		if(vencimientoInstance?.idTipoVencimiento=='venhardw' ||vencimientoInstance?.idTipoVencimiento=='softhw'||vencimientoInstance?.idTipoVencimiento=='vensoftapl' )
		mostrarSerie='display:block;'
		else
		mostrarSerie='display:none;'
	 %>
	 

     
    <div id="tipovencimiento" class="control-group ${hasErrors(bean: vencimientoInstance, field: 'idTipoVencimiento', 'error')} ">
        <label class="control-label" for="idTipoVencimiento">
            <g:message code="vencimiento.idTipoVencimiento.label" default="Tipo Vencimiento" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls" id="tipovenci">
            <g:select id="valoresTipoVencimiento"   
            		name="idTipoVencimiento"         		  
            		  onchange="${remoteFunction(controller:'Vencimiento',
                             action:'getMarcas', params:'\'plataforma=\'+this.value',
                             update: [success: 'plataformasdiv'])}"                             
            		  from="${generalService.getValoresParametro('tipovencim')}"
                	  optionKey="idValorParametro"
            		  value="${vencimientoInstance?.idTipoVencimiento?:'venccubier'}"
            noSelection="['': 'Seleccione Tipo Vencimiento']" disabled="${disableSeriales}" required="" />
        </div>
    </div>
    
    <g:hiddenField  name="vencimientoEdit" value="${vencimientoInstance?.idTipoVencimiento}" />

    
    <g:render template="/pedido/pedidosPorCliente" />
    
    
    
    
    <div id="tipoConvenio" style="${mostrarTipoConvenio}" class="control-group ${hasErrors(bean: vencimientoInstance, field: 'idTipoConvenio', 'error')} ">
	        <label class="control-label" for="idTipoConvenio">
	            <g:message code="vencimiento.idTipoConvenio.label" default="Tipo de convenio" />
	            <span class="required-indicator">*</span>
	        </label>
	        <div class="controls" >
	            <g:select name="idTipoConvenio"  
	            from="${generalService.getValoresParametro('tipoConve')}"  value="${vencimientoInstance?.idTipoConvenio}"
	            optionKey="idValorParametro"  
	            disabled="${xronly}"
	            noSelection="['': 'Seleccione tipo de convenio']"
	            />
	        </div>
	</div>
    
    
    <% def mostrarPlataforma=''
		if(vencimientoInstance?.idTipoVencimiento=='venarrend' || vencimientoInstance?.idTipoVencimiento=='venarrter' )
		mostrarPlataforma='display:none;'
		 %>
    
	<div id="plataformasdiv" style="${mostrarPlataforma}">		
	    <g:set var="marcaList" value="${generalService.getMarcas(vencimientoInstance?.idTipoVencimiento)}" scope="request"/>
    	<g:set var="xvalor" value="${vencimientoInstance?.plataforma}" scope="request"/>
    	<g:set var="zronly" value="true" scope="request"/>
	    <g:render template="/vencimiento/marcas"/>
	</div>

  </div>

<% def mostrarContrato=''
	if(vencimientoInstance?.idTipoVencimiento=='venarrter')
		mostrarContrato='display:block;'		
	else	
		mostrarContrato='display:none;'
	
%>
  
    <div id="tipoContrato" style="${mostrarContrato}" class="control-group ${hasErrors(bean: vencimientoInstance, field: 'idTipoContrato', 'error')} ">
	        <label class="control-label" for="idTipoContrato">
	            <g:message code="vencimiento.idTipoContrato.label" default="Tipo de contrato" />
	            <span class="required-indicator">*</span>
	        </label>
	        <div class="controls">
	            <g:select name="idTipoContrato" 
	            from="${generalService.getValoresParametro('tipoContra')}"  value="${vencimientoInstance?.idTipoContrato}"
	            optionKey="idValorParametro" 
	            disabled="${xronly}"
	            noSelection="['': 'Seleccione tipo de contrato']"
	            />
	        </div>
	</div>
    
    
	
<% def textRefNumMod=''
		if(vencimientoInstance?.idTipoVencimiento=='venhardw' || vencimientoInstance?.idTipoVencimiento=='softhw' )
			textRefNumMod='Tipo modelo/referencia'
		else
		{
			if(vencimientoInstance?.idTipoVencimiento=='vensoftapl')
				textRefNumMod='Referencia/Número de contrato'
			else
				textRefNumMod='Número de contrato'
		}	
%>

    <div id="divNumeroRef" class="control-group ${hasErrors(bean: vencimientoInstance, field: 'refTipModNumContract', 'error')} ">
        <label class="control-label" for="refTipModNumContract" id="textoRef">
            <g:message code="vencimiento.refTipModNumContract.label" default="${textRefNumMod}" />            
        </label>
        <div class="controls">
            <g:textField name="refTipModNumContract" maxlength="50" value="${vencimientoInstance?.refTipModNumContract}" disabled="${xronly}"  />
        </div>
    </div>  

    <!-- CONTINUAR POR ACÁ -->

    <div id="radioButtonSeriales" style="${mostrarSerie}" class="control-group ${hasErrors(bean: vencimientoInstance, field: 'serialManual', 'error')}">
   				<label class="control-label" for="serial">
            		<g:message code="seriales.label" default="Seriales"/>
            		<span class="required-indicator">*</span>       		
        		</label>  				
                <div class="controls">
                    <label class="radio">Ingresar manualmente</label>
                    <input type="radio" name="serialManual" id="radioManualSi" value="S" 
                    onclick="document.getElementById('numSerie').style.display='block';document.getElementById('subirArchivo').style.display='none';"
                    ${generalService.checked('S',vencimientoInstance?.serialManual)} ${disableSeriales}>

                    <label class="radio" style="padding-top:5px;">Cargar de archivo</label>
                    <input type="radio" name="serialManual"  value="N"
                    onclick="document.getElementById('numSerie').style.display='none';document.getElementById('subirArchivo').style.display='block';"
                    ${generalService.checked('N',vencimientoInstance?.serialManual)} ${disableSeriales}>
                </div>
    </div>

    <div id="numSerie" style="${mostrarSerie}" class="control-group ${hasErrors(bean: vencimientoInstance, field: 'serial', 'error')} ">
        <label class="control-label" for="serial">
            <g:message code="vencimiento.serial.label" default="Número de serie" />            
        </label>
        <div class="controls">
            <g:textField name="serial" maxlength="300" value="${vencimientoInstance?.serial}" disabled="${xronly}"  />
            
    	</div>
	</div>        
        
	<g:hiddenField  id ="hayAnexo" name="hayAnexo" value="N" />        
        
	 <div class="controls" id="subirArchivo" style="${mostrarSerie};margin-top:-24px;margin-bottom:10px;" >
                            <div style="display:none">                            
                                <input type="file" id="inputFile" name="file"
                                onchange="document.getElementById('hayAnexo').value='S';document.getElementById('archivoSeriales').value=getNameFile(document.getElementById('inputFile').value)">                                
                            </div>
							<br>
                            <g:textField style="width:235px;" id="archivoSeriales"  name="archivoSeriales" maxlength="200" value="${vencimientoInstance?.archivoSeriales}" placeholder="Cargar archivo" readonly=""/>
                            
                            <g:if test="${xronly=='false'}" >
                                <button type="button" class="btn  btn-mini" id="boton-subir"
                                onClick="document.getElementById('inputFile').click()">
                                <i class="icon-file" ></i>&nbsp;Cargar Archivo Seriales</button>
                             </g:if>
                                
                            <g:set var="xruta" value="${generalService.getValorParametro('ruta00')}${vencimientoInstance?.archivoSeriales}" />    
                              <g:if test="${vencimientoInstance?.archivoSeriales!=null}">
                				<a class="btn btn-mini" href="${xruta}" target="_blank">Ver Anexo</a>
                			</g:if>        
     </div>
    

	    <div id="descripcion" class="control-group ${hasErrors(bean: vencimientoInstance, field: 'descripcion', 'error')} ">
	        <label class="control-label" for="descripcion">
	            <g:message code="vencimiento.descripcion.label" default="Descripción" />
	            <%-- <span class="required-indicator">*</span>--%>
	        </label>
	        <div class="controls">
	            <g:textArea name="descripcion" style="width:235px;height:150px;" maxlength="200" value="${vencimientoInstance?.descripcion}" disabled="${xronly}"/>
	        </div>
		</div>
              <% String xcant
				if (vencimientoInstance?.idTipoVencimiento?.contains('soft'))  xcant='block' else xcant='none' %>

    <% def mostrarCobertura=''
		if(vencimientoInstance?.idTipoVencimiento=='venadmter' || vencimientoInstance?.idTipoVencimiento=='venarrend' ||  vencimientoInstance?.idTipoVencimiento=='venarrter')
		mostrarCobertura='display:none;'
	%>

    <div id="tipoCobertura" style="${mostrarCobertura}" class="control-group ${hasErrors(bean: vencimientoInstance, field: 'idTipoCobertura', 'error')} ">
        <label class="control-label" for="idTipoCobertura">
            <g:message code="vencimiento.idTipoCobertura.label" default="Tipo Cobertura" />
            <span class="required-indicator">*</span>
        </label>

        <div class="controls">
            <g:select from="${generalService.getValoresParametro('tipocobert')}"
                optionKey="idValorParametro"
            value="${vencimientoInstance?.idTipoCobertura?:'tpcbrt1'}"
            noSelection="['': 'Seleccione tipo de Cobertura']" disabled="${xronly}" name="idTipoCobertura"   />
        </div>	
    </div>

    <div class="control-group ${hasErrors(bean: vencimientoInstance, field: 'fechaInicio', 'error')} ">
        <label class="control-label" for="fechaInicio">
            <g:message code="vencimiento.fechaInicio.label" default="Fecha Inicio" />
            <span class="required-indicator">*</span>
        </label>
        
          <div class="controls input-append date form_date" id="fechaa1" data-date-format="dd-mm-yyyy" style="margin-left:20px;" >
            
            <input type="text" name="fechaInicio" id="ve_fechaa" readonly 
            value="${g.formatDate(format:'dd-MM-yyyy',date:vencimientoInstance?.fechaInicio)}" style="width:213px;" 
            onchange="validarFechas(0,'ve_fechaa','ve_fechac')" required="">
            <g:if test="${xronly!='true'}"  >            
                <span class="add-on"><i class="icon-th"></i></span>
            </g:if>       
        </div>	
    </div>

    <div class="control-group ${hasErrors(bean: vencimientoInstance, field: 'fechaVencimiento', 'error')} ">
        <label class="control-label" for="fechaVencimiento">
            <g:message code="vencimiento.fechaVencimiento.label" default="Fecha Vencimiento" />
           <span class="required-indicator">*</span>
        </label>
        <div class="controls input-append date form_date" id="fechaVencimiento" data-date-format="dd-mm-yyyy" style="margin-left:20px;">
            <input type="text" name="fechaVencimiento" id="ve_fechac" readonly 
            value="${g.formatDate(format:'dd-MM-yyyy',date:vencimientoInstance?.fechaVencimiento)}" style="width:213px;" 
            onchange="validarFechas(0,'ve_fechaa','ve_fechac')" required="">
            <g:if test="${xronly!='true'}"  >            
                <span class="add-on"><i class="icon-th"></i></span>
            </g:if> 
        </div>	
        <span id="errfec" style="display:none;"> <b style="color:red; padding-top:3px;"> Esta fecha debe ser posterior a la anterior </b>
            <a href="#" onclick="document.getElementById('errfec').style.display='none'" ><i class="icon-remove"></i></a>
        </span>
    </div>

    <div id="observaciones" class="control-group ${hasErrors(bean: vencimientoInstance, field: 'observaciones', 'error')} ">
        <label class="control-label" for="observaciones">
            <g:message code="vencimiento.observaciones.label" default="Observaciones" />

        </label>
        <div class="controls">
            <g:textField name="observaciones" maxlength="100" value="${vencimientoInstance?.observaciones}" disabled="${xronly}"/>
        </div>
    </div>

    <g:if test="${vencimientoInstance?.id !=null}" >
    <div class="control-group">
        <label class="control-label" >
         Estado
        </label>
        <% def xres=generalService.getEstadoVencimiento(vencimientoInstance?.fechaInicio,vencimientoInstance?.fechaVencimiento) %>  
        <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:239px;min-height:21px;${xres[1]}">
        <g:if test="${vencimientoInstance.idEstadoVencimiento=='vennorenov'}">                            
                            		<% xres[0]='vennorenov' //vencimiento no renovado empanada
									   xres[1]='background:#F15850 !important' %>                            		
        </g:if>
         <%-- --${generalService.getValorParametro(xres[0])}-->--%>
         <b style="${xres[1]};font-weight:bold;text-align:center;color:#303030">${generalService.getValorParametro(xres[0])}</b> 
        </div>
    </div>
    </g:if>
            <div style="height:150px;"></div>
    <g:hiddenField  name="idEstadoVencimiento" value="${vencimientoInstance?.idEstadoVencimiento?:'vennoinici'}" />
    <g:hiddenField  name="layout" value="${layout?:''}"/>
    

<script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.js')}"></script>
<script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.es.js')}"></script>

<script type="text/javascript">

function validarDatos()
{
	var tipovencimiento=$("#tipovenci option:selected").val()//me muestra el valor seleccionado		
	var pedidoSelected=$("#pedido option:selected").val()//
	var plataformaSelected=$("#plataformasdiv option:selected").val()
	var rButtonSelected=$("input[name='serialManual']:checked").val()
	var textoReferencia=$("input[name='refTipModNumContract']").val()
	var numeroDeSerie=$("input[name='serial']").val()
	var coberturaSelected=$("#tipoCobertura option:selected").val()
	var tipoConvenioSelected=$("#idTipoConvenio option:selected").val()
	var tipoContratoSelected=$("#idTipoContrato option:selected").val()
	
	var archivoSeriales=$("input[name='archivoSeriales']").val()

	
	//alert("rButtonSelected "+rButtonSelected)
	//alert("archivo seriales "+archivoSeriales)
	

	if(pedidoSelected=='' || textoReferencia=='' )
	{
		alert("Faltan datos. Por favor verifique")
		return false
	}
	else
	{
	    if(coberturaSelected=='' && (tipovencimiento!='venarrter' && tipovencimiento!='venarrend' && tipovencimiento!='venadmter'))
	    {
	    	alert("Falta tipo cobertura. Por favor verifique")
	    	return false
	    }
	    else
	    {
		    
		    
		    if(tipoConvenioSelected=='' && tipovencimiento=='venconsop')
		    {
		    	alert("Faltan datos. Por favor verifique")
		    	return false
		    }
		    
		    else
		    {
		    	if(tipoContratoSelected=='' && tipovencimiento=='venarrter')
		    	{
		    		alert("Faltan datos. Por favor verifique")
		    		return false
		    	}	    	
		    	else
		    	{
		    		if((plataformaSelected=='') && (tipovencimiento!='venarrend' && tipovencimiento!='venarrter'))
		    		{
		    			alert("Faltan datos. Por favor verifique")
		    			return false
		    		}
		    		
		    		else
		    		{
			    		  //if(((rButtonSelected==undefined||numeroDeSerie=='')||(rButtonSelected=='S' && numeroDeSerie=='') ||(rButtonSelected=='N' && archivoSeriales==''))	&& ((tipovencimiento=='venhardw'|| tipovencimiento=='softhw'||tipovencimiento=='vensoftapl')))		    		  					
								 if(tipovencimiento=='venhardw' || tipovencimiento=='softhw' || tipovencimiento=='vensoftapl')
								 {
									
									if((rButtonSelected==undefined)||(rButtonSelected=='S' && numeroDeSerie=='')||(rButtonSelected=='N' && archivoSeriales==''))
									{
										//alert("entré acá ahora")										
					    		  		alert("Faltan datos. Por favor verifique")
					    		  		return false								
									}
									else
										return true	
											    		  	
					    		 }
				    	  		    	   
			    	  }
				}	
		
			}	
	    }

	}
}	
	
var serialManual='${vencimientoInstance?.serialManual}'
if(serialManual=='N')
	$("#numSerie").hide()
if(serialManual=='S')
    $("#subirArchivo").hide()	    
	    

$("#radioButtonSeriales").change(function()
{
	var radioSelected=$("input[name='serialManual']:checked").val()
	
	if(radioSelected=='S')
	{		
		$("#archivoSeriales").val('')		
	}
	else
	{		
		$("#serial").val('')
	}	
})




$("#tipovenci").change(function()
{

		var tipovencimiento=$("#tipovenci option:selected").val()//me muestra el valor seleccionado
		//alert(tipovencimiento)
		
		//validarDatos(tipovencimiento)	
		
		
		if(tipovencimiento=="venarrend" || tipovencimiento=="venarrter")
		{
				$("#tipoContrato").show()
				$("#plataformasdiv").hide()
				$("#tipoCobertura").hide()		
				$("#textoRef").text("Número de contrato")
				$("#tipoConvenio").hide()
				
				if(tipovencimiento=="venarrend")
					$("#tipoContrato").hide()	
				
				
		}
		else
		{
				$("#tipoContrato").hide()
				$("#plataformasdiv").show()
				$("#divNumeroRef").show()
				
				if(tipovencimiento=="venadmter")
				{
						$("#tipoCobertura").hide()
						$("#tipoConvenio").hide()
				}


	
				if(tipovencimiento=="venhardw" || tipovencimiento=="softhw")
				{
					$("#textoRef").text("Tipo modelo/referencia")
					$("#tipoCobertura").show()						
				}
					
			
				
					
					
				if(tipovencimiento=="vensoftapl")
				{
					$("#textoRef").text("Referencia/Número de contrato")
					$("#tipoConvenio").hide()
					$("#tipoCobertura").show()
				}

				if(tipovencimiento=="venadmin" ||tipovencimiento=="venadmter")					
				{
					$("#textoRef").text("Número de contrato")
					$("#tipoConvenio").hide()

					if(tipovencimiento=="venadmin")
						$("#tipoCobertura").show()
				}

				if(tipovencimiento=="venconsop")
				{
					$("#tipoConvenio").show()
					$("#textoRef").text("Número de contrato")
				}
				else
					$("#tipoConvenio").hide()
				
		}
				
		if(tipovencimiento=="venhardw" || tipovencimiento=="softhw" || tipovencimiento=="vensoftapl")
		{	
		$("#numSerie").show()
		$("#radioButtonSeriales").show()
		$("#subirArchivo").show()
		}
		else
		{
			$("#numSerie").hide()
			$("#radioButtonSeriales").hide()
			$("#subirArchivo").hide()
			
		}
})

		
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
                    
    var contenido= $("#boxVenc"); 
    if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+850);


</script>
