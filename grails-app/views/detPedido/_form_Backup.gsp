<%@ page import="crm.DetPedido" %>
<%@ page import="crm.Producto" %>

<g:set var="generalService" bean="generalService"/>
<g:set var="pedidoService" bean="pedidoService"/>
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>
<script src="${resource(dir: 'js/jquery', file:'jquery.numeric.js')}"></script>



    <div class="tabbable" >
        <ul class="nav  nav-tabs" id="myTab" style="font-weight: bold;">
            <li class="active"><a href="#home" data-toggle="tab">Producto</a></li>
            <li><a href="#historial"  data-toggle="tab">Historial</a></li>                    
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="home">
                <div id="detalleconten">
                <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'producto.id', 'error')} required">
                    <label class="control-label" for="producto.id">
                        <a href="#" style="text-decoration:underline;" onClick="if (this.value ==''){return;}else{ var el = document.getElementById('infoProducto');el.style.display = (el.style.display == 'none') ? 'block' : 'none';}">Referencia</a>
                        <span class="required-indicator">*</span>
                    </label>
                    <div class="controls">
                        <g:hiddenField id="idproducto" name="idProducto" value="${detPedidoInstance.producto?.id}" 
                            onchange=" if (this.value ==''){return}else{mi_ajax('/crm/producto/datosProducto',this.value,'infoProducto')}"  
                        />
                        <g:textField id="refProducto" name="refProducto"   required=""  maxlength="100" class="input-large"                  
                        value="${detPedidoInstance.refProducto}" disabled="${xronly}" 
                            onblur="if (this.value ==''){document.getElementById('idescprod').value='';return;}else{mi_ajax('/crm/producto/datosProducto',this.value,'infoProducto');}"  
                            placeholder="digite mínimo dos caracteres" 
                            />
                        <script>
                            autoCompletar('refProducto','/crm/Producto/autoCompletarProducto/','idescprod') 
                            $('#refProducto').change()              
                            $('#idproducto').change()  
                        </script>   
                        <span id="msgNoExite" style="display:none;">
                            <b style="color:red; padding-top:3px;"> Producto no existe! </b>
                        </span>
                         <%--   <g:select  name="producto.id" from="${Producto.findAll('from Producto where eliminado=0 order by descProducto')}" optionKey="id" required=""
                            value="${detPedidoInstance?.producto?.id}" disabled="${xronly}" /> --%>
                    </div>
                    <div id="infoProducto" style="display:none;">

                    </div>
                </div>
               <%-- <g:set var="xrefProducto"  value="${detPedidoInstance?.refProducto}" scope="request" />
                <div id="refproducto"> 
                    <g:render template="refProducto" />
                </div>--%>
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
                            <g:textField name="cantidad" id="idcant" maxlength="10" 
                            value="${detPedidoInstance?.cantidad}"   required=""                    
                            disabled="${xronly}" 
                                style="text-align: right" class="entero" />
                        </g:if>
                        <g:else>
                            <g:textField name="cantidad_s" id="idcant_s"  
                            value="${formatNumber(number:detPedidoInstance?.cantidad,format:'###,###,###', locale:'co')}"                       
                            disabled="${xronly}" 
                                style="text-align: right" />
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
                            <g:textField name="valor" id="idvalor" maxlength="10" 
                            value="${detPedidoInstance?.valor}"                       
                            disabled="${xronly}"  required=""
                                style="text-align: right" class="decimal" />
                        </g:if>
                        <g:else>
                            <g:textField name="valor_s" id="idvalor_s"  
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
                                <g:message code="detPedido.fechaPosibleLlegada.label" default="Posible LLegada" />
                            </label>

                            <div class="controls input-append date form_date" id="fechapllegada" data-date-format="dd-mm-yyyy" style="margin-left:20px;">
                                <input  type="text" name="fechaPosibleLlegada" id="fechaa" 
                                value="${g.formatDate(format:'dd-MM-yyyy',date:detPedidoInstance?.fechaPosibleLlegada)}"  readonly
                                onchange="validarFechas(0,'fechaa','fechac')">
                                <g:if test="${xronly!='true'}"  >             
                                    <span class="add-on"><i class="icon-th"></i></span>
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
                                    <span class="add-on"><i class="icon-th"></i></span>
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


            
            <g:hiddenField  id ="eliminado" name="eliminado" value="${detPedidoInstance?.eliminado?:0}" />
            </div><!-- fin detalle conten-->
        </div>

        <div class="tab-pane" id="historial">              

            <a class="btn btn-mini" href="#" onclick="cargarHistorial(${detPedidoInstance?.id},'DetPedido')" > Ver Historial</a>  

            <iframe id="ifhistoria" src="" style="border:0;width:100%;"  scrolling="yes"></iframe>
        </div>
    </div>
</div>


<script>   
    //IFRAME_DETALLE9=document.getElementById('ifitems').contentWindow.document.getElementById('ifhistoria')

    $(".decimal").numeric();    
    $(".entero").numeric("0");
      <!-- calcula el alto del bloque htm del detalle de encaberzado respectivo -->
    var contenido= $("#detalleconten");
    if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+250);

</script>
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