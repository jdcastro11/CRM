<%@ page import="crm.DetPedido" %>
<%@ page import="crm.Producto" %>
<g:set var="generalService" bean="generalService"/>
<g:set var="pedidoService" bean="pedidoService"/>
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>
<script> redimIFRAME();</script>

<g:if test="${xronly=='true'}">
   <g:set var="zronly" value=" disabled " />
</g:if>

<g:if test="${detPedidoInstance?.tieneContrato}">
	<g:set var="rbSelected" value=" disabled " />
</g:if>

<div class="tabbable">
	<ul class="nav  nav-tabs" id="myTab" style="font-weight: bold;">
         <li class="active"><a href="#home" data-toggle="tab">Producto</a></li>
         <li><a href="#historial"  data-toggle="tab">Historial</a></li>                    
    </ul>
    
    <div class="tab-content">
    	<g:if test="${detPedidoInstance?.eliminado==1}">
    		<div id="men_eliminado" class="pull-right label label-important">
               Eliminado
            </div>
    	</g:if>
    	<div class="tab-pane active" id="home">
    		<div class="box-content">
    			<g:if test="${params.sw=='1' || params.sw=='0'}" >
    				<div class="control-group">
    					<label class="control-label" for="numPedido">
                           Nro. Pedido                           
                        </label>
                        <div class="controls">
                           <a href="/crm/pedido/show/${detPedidoInstance?.pedido?.id}" style="text-decoration:underline" target="_blank" >${detPedidoInstance?.pedido?.numPedido}</a>
                        </div>
    				</div>
    				<div class="control-group">
                        <label class="control-label" for="cliente">
                            Cliente                           
                        </label>
                        <div class="controls">
                            <g:textField name="cliente" Style="width:300px;" value="${detPedidoInstance?.pedido?.empresa}" disabled="true"/>
                        </div>
                    </div>                    
    			</g:if>
    			
    			
    			<div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'producto.id', 'error')} required">
    				<label class="control-label" for="producto.id">
                        <a href="#" style="text-decoration:underline;" onClick="if (this.value ==''){return;}else{ var el = document.getElementById('infoProducto');el.style.display = (el.style.display == 'none') ? 'block' : 'none';}">Referencia</a>
                        <span class="required-indicator">*</span>
                    </label>
                    <div class="controls">
                        <g:hiddenField id="idproducto" name="idProducto" value="${detPedidoInstance.producto?.id}"  />
                        <g:textField id="refProducto" name="refProducto"   required=""  maxlength="100" class="input-large"                  
                        value="${detPedidoInstance.refProducto}" disabled="${xronly}" 
                            onblur="if (this.value ==''){document.getElementById('idescprod').value='';return;}else{mi_ajax('/crm/producto/datosProducto',this.value,'infoProducto');}"  
                            placeholder=""/>                          
                        <span id="msgNoExite" style="display:none;">
                            <b style="color:red; padding-top:3px;"> Producto no existe! </b>
                        </span>                         
                    </div>
					<div id="infoProducto" style="display:none;">

                    </div>
    			</div>
    			
    			<div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'descProducto', 'error')} ">
                    <label class="control-label" for="descProducto">
                        <g:message code="detPedido.descProducto.label" default="Descripción" />
                    </label>
                    <div class="controls">
                        <g:textArea name="descProducto" id="idescprod" rows="3" cols="150" value="${detPedidoInstance?.descProducto}"           
                        disabled="${xronly}" />
                    </div>
                </div>
                
                
                <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'cantidad', 'error')} ">
                    <label class="control-label" for="cantidad">
                        <g:message code="detPedido.cantidad.label" default="Cantidad Pedida"  />
                        <span class="required-indicator">*</span>
                    </label>
                    <div class="controls">
                        <g:if test="${xronly=='false'}" >
                            <g:field  type ="number" name="cantidad" id="idcant" maxlength="10"  min="0"
                            value="${detPedidoInstance?.cantidad}"   required=""                    
                            disabled="${xronly}" style="text-align: right" class="entero" />
                        </g:if>
                        <g:else>
                            <g:textField name="cantidad_s" id="idcant_s"  
                            value="${formatNumber(number:detPedidoInstance?.cantidad,format:'###,###,###', locale:'co')}"                       
                            disabled="${xronly}" style="text-align: right" />
                        </g:else>    
                    </div>
                </div>
                
                <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'valor', 'error')}">
                    <label class="control-label" l for="valor">
                        <g:message code="detPedido.valor.label" default="Valor" />
                        <span class="required-indicator">*</span>
                    </label>
                    <div class="controls">
                        <g:if test="${xronly=='false'}" >
                            <g:field  type="number"  name="valor" id="idvalor" maxlength="15" min="0" step="any"
                            value="${detPedidoInstance?.valor}"                       
                            disabled="${xronly}"  required=""
                                style="text-align: right" class="decimal" />
                        </g:if>
                        <g:else>
                           <g:textField  name="valor_s" id="idvalor_s"  
                            value="${formatNumber(number:detPedidoInstance?.valor,format:'###,###,###.00', locale:'co')}"                       
                            disabled="${xronly}" 
                            style="text-align: right"  />
                        </g:else>  
                    </div>
                </div>
                
                
                <div class="control-group">
                    <label class="control-label" for="total">
                        Total
                    </label>
                    <div class="controls"  style="text-align:right;width:215px;">                  
                        <g:if test="${detPedidoInstance?.cantidad==null || detPedidoInstance?.valor==null}" >
                            <g:set var="xtotal" value="" />
                        </g:if>
                        <g:else>
                            <g:set var="xtotal" value="${detPedidoInstance?.cantidad*detPedidoInstance?.valor}" />
                            <g:textField name="total" id="idtotal"  
                            value="${formatNumber(number:xtotal,format:'###,###,###.00', locale:'co')}"
                                readonly=""  style="text-align: right" /> 
                        </g:else>
                    </div>
                </div>           
                
                <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'idProcesarPara', 'error')} ">
                    <label class="control-label" for="idProcesarPara">
                        <g:message code="detPedido.idProcesarPara.label" default="Procesar Para" />
                        <span class="required-indicator">*</span>
                    </label>
                    <div class="controls">
                        <g:select name="idProcesarPara" from="${generalService.getValoresParametro('procespara')}"
                            optionKey="idValorParametro" required=""
                        value="${detPedidoInstance?.idProcesarPara}"
                        noSelection="['': '']"    disabled="${xronly}" />
                    </div>
                </div>    
                
                
                <g:if test="${!(detPedidoInstance?.idEstadoDetPedido in ['peddetpd00','peddetpd01'])}" >
                	<g:if test="${detPedidoInstance?.ordenCompra != null}" >
                        <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'ordenCompra', 'error')} ">
                            <label class="control-label" for="ordenCompra">
                                <g:message code="detPedido.ordenCompra.label" default="Orden de Compra" />
                            </label> 
                            <div class="controls">
                                <g:textField name="ordenCompra" maxlength="20" value="${detPedidoInstance?.ordenCompra}" 
                                disabled="${xronly}"  />
                            </div>
                        </div>
                    </g:if>
                    <g:if test="${detPedidoInstance?.empresa?.id != null}" >
                        <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'idProveedor', 'error')} ">
                            <label class="control-label" for="empresa.id">
                                <g:message code="detPedido.empresa.id.label" default="Proveedor" />
                            </label>
                            <div class="controls">
                                <g:select name="idProveedor" from="${crm.Empresa.findAllByIdTipoEmpresaAndEliminado('empproveed',0)}"
                                    optionKey="id"
                                value="${detPedidoInstance?.empresa?.id}"
                                noSelection="['': 'Seleccione Proveedor']"    disabled="${xronly}" />
                            </div>
                        </div>
                    </g:if>
                    <g:if test="${detPedidoInstance?.fechaPosibleLlegada != null}" >
                        <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'fechaPosibleLlegada', 'error')} ">
                            <label class="control-label" for="fechaPosibleLlegada">
                                <g:message code="detPedido.fechaPosibleLlegada.label" default="Posible LLegada"/>
                            </label>

                            <div class="controls input-append date form_date" id="fechapllegada" data-date-format="dd-mm-yyyy" style="margin-left:20px;">
                                <input  type="text" name="fechaPosibleLlegada" id="fechaa" 
                                value="${g.formatDate(format:'dd-MM-yyyy',date:detPedidoInstance?.fechaPosibleLlegada)}"  readonly
                                onchange="validarFechas(0,'fechaa','fechac')">
                                <g:if test="${xronly!='true'}">             
                                    <span class="add-on">
                                    	<i class="icon-th"></i>
                                    </span>
                                </g:if>
                            </div>
                        </div>
                    </g:if>
                    <g:if test="${detPedidoInstance?.fechaLlegada != null}" >
                        <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'fechaLlegada', 'error')} ">
                            <label class="control-label" for="fechaLlegada">
                                <g:message code="detPedido.fechaLlegada.label" default="Fecha LLegada" />
                            </label>
                            <div class="controls input-append date form_date" id="fechallegada" data-date-format="dd-mm-yyyy" style="margin-left:20px;">
                                <input  type="text" name="fechaLlegada" id="fechaa" 
                                value="${g.formatDate(format:'dd-MM-yyyy',date:detPedidoInstance?.fechaLlegada)}"  readonly
                                onchange="validarFechas(0,'fechaa','fechac')">
                                <g:if test="${xronly!='true'}"  >             
                                    <span class="add-on"><i class="icon-th"></i>
                                    </span>
                                </g:if>
                            </div>
                        </div>
                    </g:if>
                    <g:if test="${detPedidoInstance?.cantidadRecibida !=null}" >
                        <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'cantidadRecibida', 'error')} ">
                            <label class="control-label" for="cantidadRecibida">
                                <g:message code="detPedido.cantidadRecibida.label" default="Cantidad Recibida"  />
                            </label>
                            <div class="controls">
                                <g:textField name="cantidadRecibida" id="idcant_r"  
                                value="${formatNumber(number:detPedidoInstance?.cantidadRecibida,format:'###,###,###', locale:'co')}"                       
                                    disabled="true" style="text-align: right" />
                            </div>
                        </div>
                    </g:if>
                    <g:if test="${detPedidoInstance?.observaciones != null}" >
                        <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'observaciones', 'error')} ">
                            <label class="control-label" for="observaciones">
                                <g:message code="detPedido.observaciones.label" default="Observaciones" />
                            </label>
                            <div class="controls">
                                <g:textArea name="observaciones" maxlength="200" col="60" rows="5" value="${detPedidoInstance?.observaciones}" disabled="${xronly}"/>
                            </div>
                        </div>
                    </g:if>
                </g:if>
                
                <%--aca va ES CONTRATO --%>
				<%--<div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'tieneContrato', 'error')} ">

                    <label class="control-label">Es contrato?</label>
                    <div class="controls">
                        <label class="radio">Si</label>
                        <input type="radio" name="esContrato"  value="S" ${rbSelected}                           
                               ${generalService.checked('S',detPedidoInstance?.tieneContrato)} required
                               onclick="document.getElementById('infoContrato').style.display='block';">
    
                        <label class="radio" style="padding-top:5px;">No</label>
                        <input type="radio" name="esContrato"  value="N"  ${rbSelected}
                               ${generalService.checked('N',detPedidoInstance?.tieneContrato)}
                               onclick="document.getElementById('infoContrato').style.display='none'">
                    </div>
                </div>--%>
                                
                
                <g:hiddenField  id ="eliminado" name="tieneContrato" value="${detPedidoInstance?.tieneContrato?:''}" />
                <g:hiddenField  id ="eliminado" name="eliminado" value="${detPedidoInstance?.eliminado?:0}" />
                
                <% String mostrarInfoContrato
                if (detPedidoInstance?.tieneContrato=='S')  mostrarInfoContrato='block' else mostrarInfoContrato='none' %>
                
                <div id="infoContrato" style="display:${mostrarInfoContrato}" >
				        <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'idEstadoDetPedido', 'error')} ">
					        <label class="control-label" for="idEstadoDetPedido">
					           <g:message code="detPedido.idEstadoDetPedido.label" default="Estado" />
					        </label>
				            <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:210px;background-color:#EEE;" >        
					           ${generalService.getValorParametro(detPedidoInstance?.idEstadoDetPedido?:'peddetpd00')}          
				    	    </div>
				        </div>		                    
	 
						<g:hiddenField  name="idEstadoDetPedido" value="${detPedidoInstance?.idEstadoDetPedido?:'peddetpd00'}" />
						<g:hiddenField  name="idPedido" value="${params.pedido}" />
						<g:hiddenField  name="idContrato" value="${detPedidoInstance?.contrato?.id}" />
					                
					     <% def mostrarTipoConvenio='';def mostrarSerie=''
							if(detPedidoInstance?.contrato?.idTipoVencimiento!='venconsop')
								mostrarTipoConvenio='display:none;'             
							if(detPedidoInstance?.contrato?.idTipoVencimiento=='venhardw' ||detPedidoInstance?.contrato?.idTipoVencimiento=='softhw'||detPedidoInstance?.contrato?.idTipoVencimiento=='vensoftapl' )
								mostrarSerie='display:block;'
							else
								mostrarSerie='display:none;'
					      %>                               
					                
					                
					                
					     <div id="tipovencimiento" class="control-group ${hasErrors(bean: detPedidoInstance,field: 'contrato.idTipoVencimiento', 'error')} ">
					         <label class="control-label" for="idTipoVencimiento">
					             <g:message code="vencimiento.idTipoVencimiento.label" default="Tipo Vencimiento" />
					     	      <span class="required-indicator">*</span>
					          </label>
					          <div class="controls" id="tipovenci">
					             <g:select id="valoresTipoVencimiento" name="idTipoVencimiento" 
					                  onchange="${remoteFunction(controller:'Vencimiento',
					                  action:'getMarcas', params:'\'plataforma=\'+this.value',
					                  update: [success: 'plataformasdiv'])}"
					                  from="${generalService.getValoresParametro('tipovencim')}"
					                  optionKey="idValorParametro"
					                  value="${detPedidoInstance?.contrato?.idTipoVencimiento?:'venccubier'}"
					                   noSelection="['': 'Seleccione Tipo Vencimiento']" disabled="${zronly}" />
					          </div>           
					     </div>
					             
					             
						 <div id="tipoConvenio" style="${mostrarTipoConvenio}" class="control-group ${hasErrors(bean: detPedidoInstance, field: 'contrato.idTipoConvenio', 'error')} ">
					           <label class="control-label" for="idTipoConvenio">
					              <g:message code="vencimiento.idTipoConvenio.label" default="Tipo de convenio" />
					              <span class="required-indicator">*</span>
					           </label>
					           <div class="controls" >
					              <g:select name="idTipoConvenio"
					                 from="${generalService.getValoresParametro('tipoConve')}"  value="${detPedidoInstance.contrato?.idTipoConvenio}"
					                 optionKey="idValorParametro"  
					                 disabled="${xronly}"
					                 noSelection="['': 'Seleccione tipo de convenio']"
					               />
					           </div>
					     </div>
					     
					     <% def mostrarPlataforma=''
	        				if(detPedidoInstance.contrato?.idTipoVencimiento=='venarrend' || detPedidoInstance.contrato?.idTipoVencimiento=='venarrter' )
	        					mostrarPlataforma='display:none;'
	         			  %>

						 <div id="plataformasdiv" style="${mostrarPlataforma}">      
						    <g:set var="marcaList" value="${generalService.getMarcas(detPedidoInstance.contrato?.idTipoVencimiento)}" scope="request"/>
						    <g:set var="xvalor" value="${detPedidoInstance.contrato?.plataforma}" scope="request"/>
						    <g:set var="zronly" value="true" scope="request"/>
						    <g:render template="/vencimiento/marcas"/>
						 </div>	         			  
	         			  
						 <% def mostrarContrato=''
						    if(detPedidoInstance.contrato?.idTipoVencimiento=='venarrter')
						        mostrarContrato='display:block;'        
						    else    
						        mostrarContrato='display:none;'    
						  %>	         			  			      
				     
					     <div id="tipoContrato" style="${mostrarContrato}" class="control-group ${hasErrors(bean: detPedidoInstance, field: 'contrato.idTipoContrato', 'error')} ">
					         <label class="control-label" for="idTipoContrato">
					             <g:message code="vencimiento.idTipoContrato.label" default="Tipo de contrato" />
					             <span class="required-indicator">*</span>
					         </label>
					         <div class="controls">
					             <g:select name="idTipoContrato" 
					             from="${generalService.getValoresParametro('tipoContra')}"  value="${detPedidoInstance.contrato?.idTipoContrato}"
					             optionKey="idValorParametro" 
					             disabled="${xronly}"
					             noSelection="['': 'Seleccione tipo de contrato']"
					             />
					         </div>
					     </div>
 						 <% def textRefNumMod=''
						     if(detPedidoInstance?.contrato?.idTipoVencimiento=='venhardw' || detPedidoInstance?.contrato?.idTipoVencimiento=='softhw' )
						         textRefNumMod='Tipo modelo/referencia'
						     else
						     {
						       if(detPedidoInstance?.contrato?.idTipoVencimiento=='vensoftapl')
						          textRefNumMod='Referencia/Número de contrato'
						        else
						          textRefNumMod='Número de contrato'
						     }
						  %>
						  
					     <div id="divNumeroRef" class="control-group ${hasErrors(bean: detPedidoInstance, field: 'contrato.refTipModNumContract', 'error')} ">
					        <label class="control-label" for="refTipModNumContract" id="textoRef">
					            <g:message code="vencimiento.refTipModNumContract.label" default="${textRefNumMod}" />            
					        </label>
					        <div class="controls">
					            <g:textField name="refTipModNumContract" maxlength="50" value="${detPedidoInstance?.contrato?.refTipModNumContract}" disabled="${xronlycontrato}"/>
					        </div>
					     </div>
					     
					     
					    <div id="radioButtonSeriales" style="${mostrarSerie}" class="control-group ${hasErrors(bean: detPedidoInstance, field: 'contrato.serialManual', 'error')}">
					        <label class="control-label" for="serial">
					           <g:message code="seriales.label" default="Seriales"/>
					           <span class="required-indicator">*</span>               
					         </label>                
					         <div class="controls">
					              <label class="radio">Ingresar manualmente</label>
					              <input type="radio" name="serialManual" id="radioManualSi" value="S" 
					              onclick="document.getElementById('numSerie').style.display='block';document.getElementById('subirArchivo').style.display='none';"
					              ${generalService.checked('S',detPedidoInstance?.contrato?.serialManual)} ${zronly}>
					
					              <label class="radio" style="padding-top:5px;">Cargar de archivo</label>
					              <input type="radio" name="serialManual"  value="N"
					              onclick="document.getElementById('numSerie').style.display='none';document.getElementById('subirArchivo').style.display='block';"
					              ${generalService.checked('N',detPedidoInstance?.contrato?.serialManual)} ${zronly}>
					          </div>
					    </div>
					    
						<div id="numSerie" style="${mostrarSerie}" class="control-group ${hasErrors(bean: detPedidoInstance, field: 'contrato.serial', 'error')} ">
					        <label class="control-label" for="serial">
					            <g:message code="vencimiento.serial.label" default="Número de serie" />            
					        </label>
					        <div class="controls">
					            <g:textField name="serial" maxlength="300" value="${detPedidoInstance.contrato?.serial}" disabled="${xronly}"  />            
					        </div>
					    </div>            					    
						
						<g:hiddenField  id ="hayAnexo" name="hayAnexo" value="N" />
						<g:hiddenField  name="empresaPedido" value="${detPedidoInstance?.pedido?.empresa?.id}" />
						
					     <div class="controls" id="subirArchivo" style="${mostrarSerie};margin-top:-24px;margin-bottom:10px;" >
			                  <div style="display:none">                            
		                        <input type="file" id="inputFile" name="file"
		                         onchange="document.getElementById('hayAnexo').value='S';document.getElementById('archivoSeriales').value=getNameFile(document.getElementById('inputFile').value)">                                
	  	                      </div>
					          <br>
					          <g:textField style="width:235px;" id="archivoSeriales"  name="archivoSeriales" maxlength="200" value="${detPedidoInstance.contrato?.archivoSeriales}" placeholder="Cargar archivo" readonly=""/>
					              <g:if test="${xronly=='false'}" >
					                   <button type="button" class="btn  btn-mini" id="boton-subir"
					                   onClick="document.getElementById('inputFile').click()">
					                    <i class="icon-file" ></i>&nbsp;Cargar Archivo Seriales</button>
					             </g:if>
					                                
					          <g:set var="xruta" value="${generalService.getValorParametro('ruta00')}${detPedidoInstance?.contrato?.archivoSeriales}" />    
					             <g:if test="${detPedidoInstance?.contrato?.archivoSeriales!=null}">
					                 <a class="btn btn-mini" href="${xruta}" target="_blank">Ver Anexo</a>
					             </g:if>        
					    </div>
					     
					    <div id="descripcion" class="control-group ${hasErrors(bean: detPedidoInstance, field: 'contrato.descripcion', 'error')} ">
					        <label class="control-label" for="descripcion">
					            <g:message code="vencimiento.descripcion.label" default="Descripción" />
					        </label>
					        <div class="controls">
					             <g:textArea name="descripcion" style="width:235px;height:150px;" maxlength="200" value="${detPedidoInstance.contrato?.descripcion}" disabled="${xronly}"/>
					        </div>
					    </div>					     
					    
					    
				      <% String xcant 
				         if (detPedidoInstance.contrato?.idTipoVencimiento?.contains('soft'))  xcant='block' else xcant='none' %>
				      <% def mostrarCobertura=''
				         if(detPedidoInstance.contrato?.idTipoVencimiento=='venadmter' || detPedidoInstance.contrato?.idTipoVencimiento=='venarrend' ||  detPedidoInstance.contrato?.idTipoVencimiento=='venarrter')
					         mostrarCobertura='display:none;'
				       %>
				       
					    <div id="tipoCobertura"  style="${mostrarCobertura}" class="control-group ${hasErrors(bean: detPedidoInstance, field: 'contrato.idTipoCobertura', 'error')} " >
					        <label class="control-label" for="idTipoCobertura">
					            <g:message code="vencimiento.idTipoCobertura.label" default="Tipo Cobertura" />
					            <span class="required-indicator">*</span>
					        </label>
					
					        <div class="controls">
					            <g:select from="${generalService.getValoresParametro('tipocobert')}"
					                optionKey="idValorParametro"
					            value="${detPedidoInstance?.contrato?.idTipoCobertura?:'tpcbrt1'}"
					            noSelection="['': 'Seleccione tipo de Cobertura']" disabled="${xronly}" name="idTipoCobertura"   />
					        </div>  
					    </div>
					    
					    
					    <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'contrato.fechaInicio', 'error')} ">
					        <label class="control-label" for="fechaInicio">
					            <g:message code="vencimiento.fechaInicio.label" default="Fecha Inicio" />
					            <span class="required-indicator">*</span>
					        </label>					        
					          <div class="controls input-append date form_date" id="fechaa1" data-date-format="dd-mm-yyyy" style="margin-left:20px;" >
					            
					            <input type="text" name="fechaInicio" id="ve_fechaa" readonly 
					            value="${g.formatDate(format:'dd-MM-yyyy',date:detPedidoInstance?.contrato?.fechaInicio)}" style="width:213px;" 
					            onchange="validarFechas(0,'ve_fechaa','ve_fechac')" required>
					            <g:if test="${xronlycontrato!='true'}"  >            
					                <span class="add-on">
					                	<i class="icon-th"></i>
					                </span>
					            </g:if>       
					        </div>  
					    </div>	
					    
					    <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'contrato.fechaVencimiento', 'error')} ">
					        <label class="control-label" for="fechaVencimiento">
					            <g:message code="vencimiento.fechaVencimiento.label" default="Fecha Vencimiento" />
					           <span class="required-indicator">*</span>
					        </label>
					        <div class="controls input-append date form_date" id="fechaVencimiento" data-date-format="dd-mm-yyyy" style="margin-left:20px;">
					            <input type="text" name="fechaVencimiento" id="ve_fechac" readonly 
					            value="${g.formatDate(format:'dd-MM-yyyy',date:detPedidoInstance?.contrato?.fechaVencimiento)}" style="width:213px;" 
					            onchange="validarFechas(0,'ve_fechaa','ve_fechac')" required="">
					            <g:if test="${xronlycontrato!='true'}"  >            
					                <span class="add-on"><i class="icon-th"></i></span>
					            </g:if> 
					        </div>  
					        <span id="errfec" style="display:none;"> <b style="color:red; padding-top:3px;"> Esta fecha debe ser posterior a la anterior </b>
					            <a href="#" onclick="document.getElementById('errfec').style.display='none'" ><i class="icon-remove"></i></a>
					        </span>
					    </div>
					    
					    <div id="observaciones" class="control-group ${hasErrors(bean: detPedidoInstance, field: 'contrato.observaciones', 'error')} ">
					        <label class="control-label" for="observaciones">
					            <g:message code="vencimiento.observaciones.label" default="Observaciones" />
					
					        </label>
					        <div class="controls">
					            <g:textField name="observaciones" maxlength="100" value="${detPedidoInstance?.contrato?.observaciones}" disabled="${xronlycontrato}"/>
					        </div>
					    </div>					                  					    				     				       					    
					     
					    <g:if test="${detPedidoInstance?.contrato?.id !=null}" >
					    <div class="control-group">
					        <label class="control-label" >
					         Estado
					        </label>
					        <% def xres=generalService.getEstadoVencimiento(detPedidoInstance?.contrato?.fechaInicio,detPedidoInstance?.contrato?.fechaVencimiento) %>  
					        <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:239px;min-height:21px;${xres[1]}">
					        <g:if test="${detPedidoInstance?.contrato?.idEstadoVencimiento=='vennorenov'}">                            
					                                    <% xres[0]='vennorenov' //vencimiento no renovado empanada
					                                       xres[1]='background:#F15850 !important' %>                                   
					        </g:if>
					         
					         <b style="${xres[1]};font-weight:bold;text-align:center;color:#303030">${generalService.getValorParametro(xres[0])}</b> 
					        </div>
					    </div>
					    </g:if>											    					       						  
						  					     				     
				     
				     
			      </div>                        
                                                  
    			
    			
    		
    			
    			
    
    			
    			
    			
    			
    			
    			
    			
    			
    			
    		</div>
    		
    			

    			
    	</div>
    	
    	    			
    			       <div class="tab-pane" id="historial">              

            <a class="btn btn-mini" href="#" onclick="cargarHistorial(${detPedidoInstance?.id},'DetPedido')" > Ver Historial</a>  

            <iframe id="ifhistoria" src="" style="border:0;width:100%;"  scrolling="yes"></iframe>
        </div>    
    </div>
</div>

<script>   
    //IFRAME_DETALLE9=document.getElementById('ifitems').contentWindow.document.getElementById('ifhistoria')

      <!-- calcula el alto del bloque htm del detalle de encaberzado respectivo -->
    var contenido= $("#detalleconten");
    if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+250);

</script>
<script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.js')}"></script>
<script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.es.js')}"></script>
<script type="text/javascript">
    <g:if test="${xronlycontrato!='true'}"  >
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

    function validarDatos()
    {
        
        var tipovencimiento=$("#tipovenci option:selected").val()//me muestra el valor seleccionado     
        //var pedidoSelected=$("#pedido option:selected").val()//
        var plataformaSelected=$("#plataformasdiv option:selected").val()
        var rButtonSelected=$("input[name='serialManual']:checked").val()   
        var textoReferencia=$("input[name='refTipModNumContract']").val()
        var numeroDeSerie=$("input[name='serial']").val()
        var coberturaSelected=$("#tipoCobertura option:selected").val()
        var tipoConvenioSelected=$("#idTipoConvenio option:selected").val()
        var tipoContratoSelected=$("#idTipoContrato option:selected").val()    
        var archivoSeriales=$("input[name='archivoSeriales']").val()
        var fechaInicio=$("#ve_fechaa").val()
        var fechaFin=$("#ve_fechac").val()
        var esContrato=$("input[name='esContrato']:checked").val()
		if(esContrato=='S')
		{
	        if(textoReferencia=='' || fechaInicio=='' || fechaFin=='')
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
	                              //if(((rButtonSelected==undefined||numeroDeSerie=='')||(rButtonSelected=='S' && numeroDeSerie=='') ||(rButtonSelected=='N' && archivoSeriales==''))   && ((tipovencimiento=='venhardw'|| tipovencimiento=='softhw'||tipovencimiento=='vensoftapl')))                                      
	                                     if(tipovencimiento=='venhardw' || tipovencimiento=='softhw' || tipovencimiento=='vensoftapl')
	                                     {
	                                        
	                                        if((rButtonSelected==undefined)||(rButtonSelected=='S' && numeroDeSerie=='')||(rButtonSelected=='N' && archivoSeriales==''))
	                                        {
	                                            //alert("entré acá ahora")                                      
	                                            alert("Faltan datos. Por favor verifique")
	                                            return false                                
	                                        }
	                                        else
	                                            {                                        		
	                                        		$('#btn_save_prod').prop("disabled",true);
		                                        	return true
	                                            }
	                                             
	                                                                
	                                     }
	                                               
	                          }
	                    }   
	            
	                }   
	            }
	            
            
            
            
            
            
            
            
            
            
             

        }
	  }
        desactivar('btn_save_prod');

    }

    var serialManual='${detPedidoInstance?.contrato?.serialManual}'
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
                        $("#tipoCobertura").hide()

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
</script>
