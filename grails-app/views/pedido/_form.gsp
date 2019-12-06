<%@ page import="crm.Pedido" %>
<%@ page import="crm.Persona" %>
<%@ page import="crm.Empresa" %>
<%@ page import="crm.Oportunidad" %>

<g:set var="generalService" bean="generalService" />
<g:set var="pedidoService" bean="pedidoService" />
<g:set var="seguridadService" bean="seguridadService" />

<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script> 
<script src="${resource(dir: 'js/jquery', file:'jquery.numeric.js')}"></script>
<script src="${resource(dir: 'js/jquery', file:'jquery-1.10.2.min.js')}"></script> 
<script>redimIFRAME();</script>
<script>

    function subir(){
    $(window).scrollTop(0);
    }
    function copiarDir(oriDir,oriPais,oriDpto,oriCiudad,desDir,desPais,desDpto,desCiudad){
       debugger;
        if (document.getElementById(oriDir).value != ''){
        document.getElementById(desDir).value=document.getElementById(oriDir).value
        document.getElementById(desPais).value=document.getElementById(oriPais).value
        document.getElementById(desDpto).value=document.getElementById(oriDpto).value
        document.getElementById(desCiudad).value=document.getElementById(oriCiudad).value
        }else{
           var iddirOri=dirOri=document.getElementById('dir-empresa-cli1')           
           if (iddirOri==null){ 
              alert("Primero elija un cliente");
              document.getElementById('nombreEmpresa').focus()
           }else{
               var dirOri=iddirOri.innerHTML;
               document.getElementById(desDir).value=dirOri.trim();
              }
        }
    }
    
   
</script>
<g:set var="generalService" bean="generalService" />
<g:set var="pedidoService" bean="pedidoService" />

<g:hiddenField   id="direccion" name="dir" value="${pedidoInstance?.empresa?.direccion}" />
<g:hiddenField   id="swcp" name="swcp" value="0" />
<g:hiddenField   id="idPaisb"    name="idPais" value="${pedidoInstance?.empresa?.idPais}" />
<g:hiddenField   id="idDptob"    name="idDpto" value="${pedidoInstance?.empresa?.idDpto}" />
<g:hiddenField   id ="idCiudadb" name="idCiudad" value="${pedidoInstance?.empresa?.idCiudad}" />

<g:hiddenField   id="idPaisDirDes"    name="idPaisDirDes"  value="${pedidoInstance?.idPaisDirDes}" />
<g:hiddenField   id="idDptoDirDes"    name="idDptoDirDes"  value="${pedidoInstance?.idDptoDirDes}" />
<g:hiddenField   id="idCiudadDirDes" name="idCiudadDirDes" value="${pedidoInstance?.idCiudadDirDes}" />

<g:hiddenField   id="idPaisDirFac"    name="idPaisDirFac"  value="${pedidoInstance?.idPaisDirFac}" />
<g:hiddenField   id="idDptoDirFac"    name="idDptoDirFac"  value="${pedidoInstance?.idDptoDirFac}" />
<g:hiddenField   id="idCiudadDirFac" name="idCiudadDirFac" value="${pedidoInstance?.idCiudadDirFac}" />

<g:hiddenField   id="swgenerar" name="swgenerar" value="${swgenerar?:'N'}" />
<g:hiddenField  id ="eliminado" name="eliminado" value="${pedidoInstance?.eliminado?:0}" />
<g:hiddenField  name ="idOportunidad"  value="${pedidoInstance?.oportunidad?.id}" />

<div>
    <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'idSucursal', 'error')} ">
        <label class="control-label" for="idSucursal">
            <g:message code="pedido.idSucursal.label" default="Sucursal" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls" >
            <g:set var="xidSucursal" value="${generalService.getIdSucursal(session['idUsuario'].toLong())}"  />  
            <g:select name="idSucursal" required="" from="${Empresa.findAllByIdTipoEmpresaAndEliminado('empbase',0)}"
                optionKey="id"
                value="${pedidoInstance?.idSucursal?:xidSucursal}"
                noSelection="['': 'Seleccione Sucursal']"  disabled="${xronly}" />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">
            Oportunidad
        </label>
        <div class="controls" >
            <g:if test="${pedidoInstance?.oportunidad?.id!=null}">
                <a href="/crm/oportunidad/show/${pedidoInstance.oportunidad?.id}" style="text-decoration:underline">
                    ${pedidoInstance?.oportunidad?.numOportunidad}</a>
                </g:if>
        </div>

    </div>
    <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'numPedido', 'error')} ">
        <label class="control-label" for="numPedido">
            <g:message code="pedido.numPedido.label" default="Nro. Pedido" />

        </label>
        <div class="controls" >
            <g:textField name="numPedido" maxlength="50" value="${pedidoInstance?.numPedido}" disabled="false" id="numPedido" readonly="true"/>
        </div>
    </div>
     <%
      String xtrm =0   
        ytrm =generalService.getValorParametro('trm')
      if (!pedidoInstance?.trm && xronly=='false')
          xtrm =ytrm
      else   
         xtrm=pedidoInstance?.trm?.toString()?:0
     %>
    <div class="control-group ">
        <label class="control-label" for="trm">TRM  </label>      
        <div class="controls">  
      <g:if test="${xronly=='false'}">  
         <g:field type="number"  name="trm" id="trm"  
                       value="${xtrm}"  
                       style="text-align: right"  required=""  min="0" step="0.01" />   
      </g:if>
      <g:else>
           <g:if test="${xtrm=='0' && xronly=='true'}">
               <g:textField name="trm"  value=""  disabled="true" />
           </g:if>     
           <g:else>
               <g:textField name="trm" id="trm"  
                        value="${formatNumber(number:xtrm,format:'###,###,###.##', locale:'co')}"                       
                        disabled="${true}" 
                        style="text-align: right"  required=""   />                        
         
          </g:else>   
       </g:else>
        </div>
    </div>
    
    <div class="control-group ">
        <label class="control-label" >
            Valor Pedido
        </label>
        <% 
            def xvalorpedido
            if (pedidoInstance?.valorPedido)
                 xvalorpedido=pedidoInstance?.valorPedido
             else {
                 if (pedidoInstance?.id) xvalorpedido=pedidoService.valorPedido(pedidoInstance?.id.toString()) else xvalorpedido=0
             }
          if (pedidoInstance?.idTipoPrecio=='pedtprec02'){
              if (xtrm =='0') xtrm=ytrm
             xvalorpedido=generalService.valorEnDolarTrm(xvalorpedido,xtrm)
          }
        %>
        <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:210px;background-color:#EEE;text-align:right;">           
            <g:formatNumber name="subtotal"  number="${xvalorpedido}"   format="###,###,###.00" locale="co"  />                              
        </div>
    </div>
    <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'fApertura', 'error')} ">
        <label class="control-label" for="fechaApertura">
            <g:message code="pedido.fechaApertura.label" default="Fecha" />

        </label>
        <div class="controls">
            <g:textField name="fechaApertura" maxlength="50" value="${g.formatDate(format:'dd-MM-yyyy',date:pedidoInstance?.fechaApertura)?:generalService.getHoy()}" readonly="true"/>
        </div>
    </div>

    <g:set var="xlabelEmpresa"  value="Cliente"  scope="request" /> 
    <g:set var="xlabelContacto"  value="Contacto"  scope="request" /> 
    <g:set var="xidempresa"  value="${pedidoInstance?.empresa?.id}"  scope="request" /> 
    <g:set var="zidcontacto"  value="idContacto"  scope="request" />
    <g:set var="xidcontacto"  value="${pedidoInstance?.persona?.id}"  scope="request" /> 
    <g:set var="autoSw"  value="2"  scope="request" /> <%---- para filtrar  solo clientes --> --%>
    <g:if test="${swgenerar=='N'}"> 
       <g:set var="swemp"  value="0"  scope="request" /> <%---- permite a usuario modificar empresa --> --%>
    </g:if>
    <g:else>
      <g:set var="swemp"  value="1"  scope="request" /> <%---- sw  control empresa solo lectura--%>
    </g:else>
    <g:render template="/general/empresaContacto" /> 

    <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'ordenCompra', 'error')} ">
        <label class="control-label" for="ordenCompra">
            <g:message code="pedido.ordenCompra.label" default="Orden Compra" />

        </label>
        <div class="controls">
            <g:textField name="ordenCompra" maxlength="50" value="${pedidoInstance?.ordenCompra}" disabled="${xronly}"/>
        </div>
    </div>

    <%-- <g:set var="xlabelEmpresax"  value="Facturar a"  scope="request" />   
    <g:set var="xcampo"  value="idFacturarA"  scope="request" />   
    <g:set var="xidempresa"  value="${pedidoInstance?.idFacturarA}"  scope="request" />   
    <g:set var="autoSw"  value="2"  scope="request" /> <!-- para filtrar  solo clientes -->
    <g:set var="zronly"  value="${xronly}"  scope="request" />   
    <g:render template="/general/cliente" /> --%>
  <div class="control-group">        
    <label  class="control-label">  
        <a href="#" style="text-decoration:underline;" onClick="var el = document.getElementById('infoClientex');el.style.display = (el.style.display == 'none') ? 'block' : 'none';">Facturar A:</a>
        <span class="required-indicator">*</span>
     </label>
    <div class="controls">
    <g:hiddenField id="idFacturarA" name="idFacturarA" value="${pedidoInstance?.idFacturarA}"        
        onchange="if (this.value ==''){document.getElementById('infoClientex').innerHTML=''}else{mi_ajax('/crm/empresa/datosCliente',this.value,'infoClientex')}"  /> 
          
        <g:textField id="nombreEmpresax" name="nombreEmpresa"     maxlength="150" class="input-xlarge"
        value="${crm.Empresa.get(pedidoInstance?.idFacturarA)}"   required=""  style="background:#eee"
        onfocus="alert('Debe seleccionar Empresa. Use los botones');document.getElementById('btnlm').focus()"
       
        
        /> 
        <g:if test="${xronly=='false'}">            
            <button id="btnlm" type="button" class="btn  btn-mini"
            onclick="var xidempresa = document.getElementById('idempresa').value;if(xidempresa=='')return; else document.getElementById('idFacturarA').value=xidempresa;document.getElementById('nombreEmpresax').value=document.getElementById('nombreEmpresa').value" >
            <i class="icon-home" ></i>&nbsp;La Misma</button>            
          
            <button type="button" class="btn  btn-mini"
                onclick="cargar_modal('crm_modal','modal_body','/crm/general/cliente')">
            <i class="icon-plus" ></i>&nbsp;Otra</button>
           <button type="button" class="btn  btn-mini"
                            onclick="cargar_modal('crm_modal','modal_body','/crm/empresa/create?layout=detail&tipo=1&t=empresat06&swmodal=1','refresh_combo')">
                        <i class="icon-briefcase" ></i>&nbsp;Nuevo</button>-->
            <img  class="iconoAyudaEtiqueta"  src="${resource(dir: 'images', file:'ayuda.png')}" title="Si desea crear un nuevo cliente haga clic en Clientes en el menú de navegación">
        </g:if>
     
      <script>
          
            var xidempresa = document.getElementById('idFacturarA').value
            if(xidempresa!=''){
              mi_ajax('/crm/empresa/datosCliente',xidempresa,'infoClientex')
              var el = document.getElementById('infoClientex');
              el.style.display = (el.style.display == 'none') ? 'block' : 'none';
              }
        </script> 
    </div> 
    
    <div id="infoClientex" style="display:none;">
      
      </div><%---- fin div infocliente --> --%>
</div>      
    
    <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'fechaEntrega', 'error')} ">
        <label class="control-label" for="fechaEntrega">
            <g:message code="pedido.fechaEntrega.label" default="Fecha Entrega" />

        </label>
        <div class="controls">
            <div class="controls input-append date form_date" id="fecha"
            data-date-format="dd-mm-yyyy" style="margin-left:0px;">
            <input  type="text" name="fechaEntrega" value="${g.formatDate(format:'dd-MM-yyyy',date:pedidoInstance?.fechaEntrega)}"
                    style="width:153px;" readonly>
                    <g:if test="${xronly!='true'}"  >
                        <span class="add-on"><i class="icon-remove"></i></span>
                    <span class="add-on"><i class="icon-th"></i></span>
                    </g:if>
        </div>

    </div>
  <br/>
<div class="control-group ${hasErrors(bean: pedidoInstance, field: 'idVendedor', 'error')} ">
    <label class="control-label" for="idVendedor">
        <g:message code="pedido.idVendedor.label" default="Vendedor" />

    </label>
    <div class="controls" >
        <g:render template="/empleado/vendedorPorDefecto" />  
        <g:select id="idVendedor" style="width:300px;" name="idVendedor"
        from="${generalService.getVendedores()}"
            optionKey="id"
        value="${pedidoInstance?.empleado?.id?:xidVendedor}"
        noSelection="['': 'Seleccione Vendedor']"  disabled="${xronly}"  />
    </div>
</div>
<div class="control-group ${hasErrors(bean: pedidoInstance, field: 'idEstadoPedido', 'error')} ">
    <label class="control-label" for="idEstadoPedido">
        <g:message code="pedido.idEstadoPedido.label" default="Estado" />
    </label>
    <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:300px;min-height:21px;background-color:#EEE;">
        ${generalService.getValorParametro(pedidoInstance?.idEstadoPedido?:'pedenelab1')}
    </div>
</div> 
<g:hiddenField  name="idEstadoPedido" value="${pedidoInstance?.idEstadoPedido?:'pedenelab1'}" />

<%----   Comentario de Mquintero nuevo campo observaciones  
para la fecha de mayo12--> --%>

<div class="control-group ${hasErrors(bean: pedidoInstance, field: 'observacionesPedido', 'error')} ">
    <label class="control-label" for="observacionesPedido">
        <g:message code="pedido.observacionesPedido.label" default="Observaciones" />
    </label>
    <div class="controls" > 
        <g:textArea name="observacionesPedido" style="width:500px;" rows="5" maxlength="2000" value="${pedidoInstance?.observacionesPedido}" disabled="${xronly}" />
    </div>
</div>

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
<hr>
<ul class="nav nav-tabs" id="myTab">

    <li class="active"><a href="#home" id="tab-princ" data-toggle="tab">Condiciones</a></li>
    <li ><a href="#product" onclick="recargarIframe('ifproduct');" data-toggle="tab" >Productos</a></li>
    <li><a href="#propuesta" onclick="recargarIframe('ifpropuesta');"  data-toggle="tab" >Propuesta Final</a></li>
    <li><a href="#anexos" onclick="recargarIframe('ifanexos');" data-toggle="tab" >Anexos</a></li>
    <li><a href="#facturacion" onclick="recargarIframe('iffacturas');" data-toggle="tab" >Facturación</a></li>
    <li><a href="#actividades" onclick="recargarIframe('ifactividad');" data-toggle="tab" >Seguimiento</a></li>
    <li><a  href="#requerimiento"  data-toggle="tab">Requerimiento </a></li>
    <li><a href="#historia"  data-toggle="tab">Historial </a></li>   
</ul>
<div class="tab-content">   
    <div class="tab-pane" id="product">  
        <div class="pull-right" style="margin-top:-4px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifitems')"><i class="icon-refresh"></i></a></div>
                <g:if test="${pedidoInstance?.id != null}">
                	<iframe id="ifproduct" src="/crm/detPedido/index/${pedidoInstance?.id}?sw=${sw}&p=${params.p}"  style="border:0;width:100%;"  scrolling="no"></iframe>
                  <%--<object type="text/html" width="100%" height="1330px" data="/crm/detPedido/index/${pedidoInstance?.id}?sw=${sw}&p=${params.p}"></object>--%>
                </g:if>                
            
            
            <%--<script language="javascript">
                IFRAME_DETALLE = $("#ifprod");
            </script>--%>
        
    </div><!-- fin tab item -->

    <div class="tab-pane active"  id="home">

        <g:if test="${xronly=='true'}">
            <g:set var="zronly" value=" disabled " />
        </g:if>
        <g:else>
            <g:set var="zronly" value="" />
        </g:else>
        <div class="box-content">

            <div class="control-group">
                <label class="control-label">Cliente Nuevo</label>
                <div class="controls">
                    <label class="radio">Si </label>
                    <input type="radio" name="clienteNuevo"   id ="clienteNuevo" value="S"  ${generalService.checked('S',pedidoInstance?.clienteNuevo)}  ${zronly} required="" >
                    <label class="radio" style="padding-top:5px;">No </label>
                    <input type="radio" name="clienteNuevo"  value="N" ${generalService.checked('N',pedidoInstance?.clienteNuevo)} ${zronly} >

                </div>
            </div>
            
            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'idFormaPago', 'error')} ">
                <label class="control-label" for="idFormaPago">
                    <g:message code="pedido.idFormaPago.label" default="Forma de Pago" />

                </label>
                <div class="controls">
                    <g:select name="idFormaPago" id="idFormaPago"  from="${generalService.getValoresParametro('formadpago')}"
                        optionKey="idValorParametro"
                    value="${pedidoInstance?.idFormaPago}"
                    noSelection="['': '']" disabled="${xronly}" required="" />
                </div>
            </div>

<!-- JOSE DANIEL 15/07/2016 -->
  			<div class="control-group ${hasErrors(bean: pedidoInstance, field: 'notificarCuentaCobro', 'error')} ">
                <label class="control-label">Notificar cuenta cobro</label>
                <div class="controls">
                    <label class="radio">Si</label>
                    <input type="radio" name="notificarCuentaCobro"  value="S" ${generalService.checked('S',pedidoInstance?.notificarCuentaCobro)} required "${zronly}">
                    <label class="radio" style="padding-top:5px;">No   </label>
                    <input type="radio" name="notificarCuentaCobro"  value="N" ${generalService.checked('N',pedidoInstance?.notificarCuentaCobro)}  ${zronly}">
                </div>
            </div>
<!-- JOSE DANIEL 15/07/2016 -->




            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'idTipoPrecio', 'error')} ">
                <label class="control-label" for="idTipoPrecio">
                    <g:message code="pedido.idTipoPrecio.label" default="Precios en " />

                </label>
                <div class="controls">
                    <g:select name="idTipoPrecio" from="${generalService.getValoresParametro('tipoprecio')}"
                        optionKey="idValorParametro"
                    value="${pedidoInstance?.idTipoPrecio}"
                    noSelection="['': 'Seleccione Tipo Moneda']" disabled="${xronly}" required="" 
                    onchange='return controlTipoPrecio(${params.swtp})' />
                </div>
            </div>

            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'dirDespacho', 'error')} ">
                <label class="control-label" for="dirDespacho">
                    <g:message code="pedido.dirDespacho.label" default="Dir Despacho" />
					<span class="required-indicator">*</span>
                </label>
                <div class="controls"> 
                    <g:textArea id="dirDespacho" name="dirDespacho" rows="3" onclick="document.getElementById('btn-edit-dirdespacho').click()" cols="120" class="input-xlarge"  value="${pedidoInstance?.dirDespacho}"  style="background-color:#eee"  required="" />

                    <g:if test="${xronly!='true'}">
                        <button type="button" class="btn  btn-mini" id="btn-edit-dirdespacho"
                        onclick="cargar_modal('crm_modal','modal_body','/crm/general/setDireccion/${pedidoInstance?.id}?entidad=pedido1&layout=detail&tipo=1','');redimIframe(700);" >
                        <i class="icon-briefcase" ></i>&nbsp;Editar</button>
                        <a href="#" onclick="copiarDir('direccion','idPaisb','idDptob','idCiudadb','dirDespacho','idPaisDirDes','idDptoDirDes','idCiudadDirDes')" title="Copiar de Dir.Princial" ><i class="fa-icon-copy"></i></a>   
                        <a href="#" onclick="copiarDir('dirDespacho','idPaisDirDes','idDptoDirDes','idCiudadDirDes','dirEntregaFactura','idPaisDirFac','idDptoDirFac','idCiudadDirFac')" title="Copiar de Dir.Entrega Factura" ><i class="fa-icon-paste"></i></a> 
                     </g:if>  
                </div>
            </div>

            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'dirEntregaFactura', 'error')} ">
                <label class="control-label" for="dirEntregaFactura">
                    <g:message code="pedido.dirEntregaFactura.label" default="Dir Entrega Factura" />
                    <span class="required-indicator">*</span>
                </label>
                <div class="controls"> 
                    <g:textArea id='dirEntregaFactura' name="dirEntregaFactura" onclick="document.getElementById('btn-edit-dirdentrega-fact').click()" rows="3" cols="120" class="input-xlarge" style="background-color:#eee" 
                    value="${pedidoInstance?.dirEntregaFactura}"   required="" />
                   
                    <g:if test="${xronly!='true'}">
                        <button type="button" class="btn  btn-mini" id="btn-edit-dirdentrega-fact"
                        onclick="cargar_modal('crm_modal','modal_body','/crm/general/setDireccion/${pedidoInstance?.id}?entidad=pedido2&layout=detail&tipo=1','');redimIframe(700);" >
                        <i class="icon-briefcase" ></i>&nbsp;Editar</button>
                        <a href="#" onclick="copiarDir('direccion','idPaisb','idDptob','idCiudadb','dirEntregaFactura','idPaisDirFac','idDptoDirFac','idCiudadDirFac')" title="Copiar de Dir.Princial" ><i class="fa-icon-copy"></i></a>   
                        <a href="#" onclick="copiarDir('dirDespacho','idPaisDirDes','idDptoDirDes','idCiudadDirDes','dirEntregaFactura','idPaisDirFac','idDptoDirFac','idCiudadDirFac')" title="Copiar de Dir.Despacho" ><i class="fa-icon-paste"></i></a> 
                     </g:if> 
                </div>
            </div>

            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'idMondedaFactura', 'error')} ">
                <label class="control-label" for="idMondedaFactura">
                    <g:message code="pedido.idMondedaFactura.label" default="Facturar en " />

                </label>
                <div class="controls">
                    <g:select name="idMondedaFactura" from="${generalService.getValoresParametro('tipomoneda')}"
                        optionKey="idValorParametro" 
                    value="${pedidoInstance?.idMondedaFactura}"
                    noSelection="['': '']" disabled="${xronly}"  required="" />
                </div>
            </div>
            
            
            
<!-- NOTIFICACION REQ POLIZA JD MAURY -->
            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'requierePolizas', 'error')} ">

                <label class="control-label">Requiere Polizas</label>
                <div class="controls">
                    <label class="radio">Si</label>
                    <input type="radio" name="requierePolizas"  value="S" ${generalService.checked('S',pedidoInstance?.requierePolizas)} required "${zronly}"
                           onclick="document.getElementById('poli').style.display='block'"
                           ${generalService.checked('S',pedidoInstance?.requierePolizas)} >

                    <label class="radio" style="padding-top:5px;">No   </label>
                    <input type="radio" name="requierePolizas"  value="N" ${generalService.checked('N',pedidoInstance?.requierePolizas)}  ${zronly}"
                           onclick="document.getElementById('poli').style.display='none'"
                           ${generalService.checked('N',pedidoInstance?.requierePolizas)}>
                </div>

            </div>

            <% String xpoli
				if (pedidoInstance?.requierePolizas=='S')  xpoli='block' else xpoli='none' %>
            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'descPolizas', 'error')}" id="poli" style="display:${xpoli}">
                <label class="control-label" for="descPolizas">
                    <g:message code="pedido.descPolizas.label" default="Desc Polizas" />

                </label>
                <div class="controls" > 
                    <g:textArea name="descPolizas" cols="40" rows="5" maxlength="300"
                    value="${pedidoInstance?.descPolizas}"
                    disabled="${xronly}" />
                </div>
            </div>
            
<!-- NOTIFICACION REQ POLIZA JD MAURY -->

            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'campaniaRedsis', 'error')} ">

                <label class="control-label">Campaña Redsis</label>
                <div class="controls">
                    <label class="radio">Si</label>
                    <input type="radio" name="campaniaRedsis"  value="S"  required  ${zronly}"
                           onclick="document.getElementById('camp').style.display='block'"
                           ${generalService.checked('S',pedidoInstance?.campaniaRedsis)} >

                    <label class="radio" style="padding-top:5px;">No</label>
                    <input type="radio" name="campaniaRedsis"  value="N"   ${zronly}"
                           onclick="document.getElementById('camp').style.display='none'"
                           ${generalService.checked('N',pedidoInstance?.campaniaRedsis)}>
                </div>
            </div>
            <% String xcamp
                if (pedidoInstance?.campaniaRedsis=='S')  xcamp='block' else xcamp='none'
            %>
            <div id="camp" style="display:${xcamp}" class="control-group ${hasErrors(bean: pedidoInstance, field: 'descCampania', 'error')} ">
                <label class="control-label" for="descCampania">
                    <g:message code="pedido.descCampania.label" default="Desc Campaña" />

                </label>
                <div class="controls"> 
                    <g:textField name="descCampania" maxlength="200" value="${pedidoInstance?.descCampania}" disabled="${xronly}" />
                </div>
            </div>

            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'idBidNexsys', 'error')} ">

                <label class="control-label">BID Nexsys</label>
                <div class="controls">
                    <label class="radio">Si </label>
                    <input type="radio" name="idBidNexsys"  value="S"  required  ${zronly}"
                           ${generalService.checked('S',pedidoInstance?.idBidNexsys)} >

                    <label class="radio" style="padding-top:5px;">No</label>
                    <input type="radio" name="idBidNexsys"  value="N"   ${zronly}"
                           ${generalService.checked('N',pedidoInstance?.idBidNexsys)}>

                </div>

            </div>

            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'compraIbm', 'error')} ">

                <label class="control-label">Compra IBM</label>
                <div class="controls">
                    <label class="radio">Si</label>
                    <input type="radio" name="compraIbm"  value="S"  required   ${zronly}"
                           onclick="document.getElementById('idibm').style.display='block'"
                           ${generalService.checked('S',pedidoInstance?.compraIbm)} >

                    <label class="radio" style="padding-top:5px;">No</label>
                    <input type="radio" name="compraIbm"  value="N"       ${zronly}"
                           onclick="document.getElementById('idibm').style.display='none'"
                           ${generalService.checked('N',pedidoInstance?.compraIbm)}>

                </div>

            </div>
            <% String xibm
            if (pedidoInstance?.compraIbm=='S')  xibm='block' else xibm='none'
            %>
            <div id="idibm" style="display:${xibm}">
                <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'numCliente', 'error')} ">
                    <label class="control-label" for="numCliente">
                        <g:message code="pedido.numCliente.label" default="Num Cliente" />

                    </label>
                    <div class="controls"> 
                        <g:textField name="numCliente" maxlength="20" value="${pedidoInstance?.numCliente}" disabled="${xronly}"/>
                    </div>
                </div>

                <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'idProductoDisponible' , 'error')} ">
                    <label class="control-label" for="idProductoDisponible">
                        <g:message code="pedido.idProductoDisponible.label" default="Disponibilidad IBM" />
                    </label>
                    <div class="controls">
                        <g:select   name="idProductoDisponible" from="${generalService.getValoresParametro('disponiibm')}"
                            optionKey="idValorParametro"
                        value="${pedidoInstance?.idProductoDisponible}"
                        noSelection="['': '']" disabled="${xronly}"  />
                    </div>
                </div>
                <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'bidIbm', 'error')} ">

                    <label class="control-label">Hay BID</label>
                    <div class="controls">
                        <label class="radio">Si </label>
                        <input type="radio" name="bidIbm"  value="S"       ${zronly}"
                               ${generalService.checked('S',pedidoInstance?.bidIbm)} >

                        <label class="radio" style="padding-top:5px;">No </label>
                        <input type="radio" name="bidIbm"  value="N"     ${zronly}"
                               ${generalService.checked('N',pedidoInstance?.bidIbm)}>

                    </div>

                </div>

                <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'servicioIbm', 'error')} ">

                    <label class="control-label">Servicio IBM</label>
                    <div class="controls">
                        <label class="radio">Si </label>
                        <input type="radio" name="servicioIbm"  value="S"       ${zronly}"
                               ${generalService.checked('S',pedidoInstance?.servicioIbm)} >

                        <label class="radio" style="padding-top:5px;">No </label>
                        <input type="radio" name="servicioIbm"  value="N"     ${zronly}"
                               ${generalService.checked('N',pedidoInstance?.servicioIbm)}>

                    </div>

                </div>
            </div>
            
            <div class="control-group">
                <label class="control-label">Servicios Redsis</label>
                <div class="controls">
                    <label class="radio">Si </label>
                    <input type="radio" name="handOff"  value="S" required
                    ${generalService.checked('S',pedidoInstance?.handOff)}  ${zronly} >

                    <label class="radio" style="padding-top:5px;">No </label>
                    <input type="radio" name="handOff"  value="N"
                    ${generalService.checked('N',pedidoInstance?.handOff)} ${zronly} >

                </div>
            </div> 
            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'facturacionParcial', 'error')} ">

                <label class="control-label">Facturación Parcial</label>
                <div class="controls">
                    <label class="radio">Si </label>
                    <input type="radio" name="facturacionParcial"  value="S"   required  ${zronly}"
                           ${generalService.checked('S',pedidoInstance?.facturacionParcial)} >

                    <label class="radio" style="padding-top:5px;">No</label>
                    <input type="radio" name="facturacionParcial"  value="N"  ${zronly}"
                           ${generalService.checked('N',pedidoInstance?.facturacionParcial)}>

                </div>

            </div>
<!--JD Castro Enero 2019 -->
            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'uniSinco', 'error')}  ">
                <label class="control-label">Unidad SINCO</label>
                <div class="controls">
                    <label class="radio">Si   </label>
                    <input type="radio" name="uniSinco"  value="S"  ${zronly}
                       ${generalService.checked('S',pedidoInstance?.uniSinco)} >

                    <label class="radio" style="padding-top:5px;">No</label>
                    <input type="radio" name="uniSinco"  value="N"    ${zronly}
                    ${generalService.checked('N',pedidoInstance?.uniSinco)}>

                </div>

            </div>
            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'eyc', 'error')}  ">
                <label class="control-label">Energia y Conectividad</label>
                <div class="controls">
                    <label class="radio">Si   </label>
                    <input type="radio" name="eyc"  value="S"  ${zronly}
                           onclick="document.getElementById('costoMat').style.display='block';document.getElementById('costoMan').style.display='block';
                                    document.getElementById('ventaMat').style.display='block';document.getElementById('ventaMan').style.display='block';"
                        ${generalService.checked('S',pedidoInstance?.eyc)} >

                    <label class="radio" style="padding-top:5px;">No</label>
                    <input type="radio" name="eyc"  value="N"    ${zronly}
                           onclick="document.getElementById('costoMat').style.display='none';document.getElementById('costoMan').style.display='none';
                                    document.getElementById('ventaMat').style.display='none';document.getElementById('ventaMan').style.display='none';"
                        ${generalService.checked('N',pedidoInstance?.eyc)}>
                    <%
                        String ImgEyC
                        String sImgEyC= 'none'
                        if(pedidoInstance?.eyc == 'S' && (pedidoInstance?.costoManoObra == 0 || pedidoInstance?.costoMateriales == 0 || pedidoInstance?.precioVentaMaterales == 0
                                || pedidoInstance?.preicoVentaManoObra == 0 )) ImgEyC='inline-block' else ImgEyC='none'
                    %>
                    <img class="iconoAyudaEtiqueta" style="display:${ImgEyC};"  src="${resource(dir: 'images', file:'ayuda.png')}"
                         title="Seleccione para indicar que es un pedido correspondiente a energia y conectividad">


                </div>

            </div>

            <div id="costoMat" class="control-group " style="display:${sImgEyC};">
                <label class="control-label" >
                    Costo materiales
                </label>
                <%
                    def xCostoMateriales
                    if (pedidoInstance?.costoMateriales != null)
                        xCostoMateriales=pedidoInstance?.costoMateriales
                    else {
                        xCostoMateriales=0
                    }

                %>
                <div class="controls" disabled="${xronly}" >
                    <g:field type="number" name="costoMateriales"  value="${xCostoMateriales}"   format="###,###,###.##" locale="co"  disabled="${xronly}"/>
                </div>
            </div>

            <div id="costoMan" class="control-group " style="display:${sImgEyC};">
                <label class="control-label" >
                    Costo mano obra
                </label>
                <%
                    def xCostoManoObra
                    if (pedidoInstance?.costoManoObra != null)
                        xCostoManoObra=pedidoInstance?.costoManoObra
                    else {
                        xCostoManoObra=0
                    }

                %>
                <div class="controls" disabled="${xronly}" >
                    <g:field type="number" name="costoManoObra"  value="${xCostoManoObra}"   format="###,###,###.##" locale="co"  disabled="${xronly}"/>
                </div>
            </div>
            <div id="ventaMat" class="control-group " style="display:${sImgEyC};">
                <label class="control-label" >
                    Precio venta materiales
                </label>
                <%
                    def xVentaMateriales
                    if (pedidoInstance?.costoMateriales != null)
                        xVentaMateriales=pedidoInstance?.precioVentaMaterales
                    else {
                        xVentaMateriales=0
                    }

                %>
                <div class="controls" disabled="${xronly}" >
                    <g:field type="number" name="precioVentaMaterales"  value="${xVentaMateriales}"   format="###,###,###.00" locale="co"  disabled="${xronly}"/>
                </div>
            </div>

            <div id="ventaMan" class="control-group " style="display:${sImgEyC};">
                <label class="control-label" >
                    Precio venta mano obra
                </label>
                <%
                    def xVentaManoObra
                    if (pedidoInstance?.costoManoObra != null)
                        xVentaManoObra=pedidoInstance?.preicoVentaManoObra
                    else {
                        xVentaManoObra=0
                    }

                %>
                <div class="controls" disabled="${xronly}" >
                    <g:field type="number" name="preicoVentaManoObra"  value="${xVentaManoObra}"   format="###,###,###.00" locale="co"  disabled="${xronly}"/>
                </div>
            </div>


            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'gerenteProye', 'error')}  ">
                <label class="control-label">Gerente de proyecto</label>
                <div class="controls">
                    <label class="radio">Si   </label>
                    <input type="radio" name="gerenteProye"  value="S"  ${zronly}
                        ${generalService.checked('S',pedidoInstance?.gerenteProye)} >

                    <label class="radio" style="padding-top:5px;">No</label>
                    <input type="radio" name="gerenteProye"  value="N"    ${zronly}
                        ${generalService.checked('N',pedidoInstance?.gerenteProye)}>

                </div>


            </div>
            <% String xgproye
                String gproyect =pedidoInstance?.listaGerenteProye
                if (pedidoInstance?.gerenteProye=='S' && (gproyect != null || gproyect  != ''))  xgproye='block' else xgproye='none'

                gproyect = generalService.getValorParametroByIDValorParametro('gproyecto',gproyect)
            %>
            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'listaGerenteProye', 'error')} " style="display:${xgproye}" >
                <label class="control-label" for="listaGerenteProye">
                    <g:message code="pedido.listaGerenteProye.label" default="Gerente de proyecto" />

                </label>
                <div class="controls">
                    <g:textField name="listaGerenteProye" maxlength="50" value="${gproyect}" disabled="true"/>
                    <%
                        String styloImgProy
                        if((pedidoInstance?.listaGerenteProye == '' || pedidoInstance?.listaGerenteProye == null) && pedidoInstance?.gerenteProye == 'S') styloImgProy='inline-block' else styloImgProy='none'
                    %>
                    <img class="iconoAyudaEtiqueta" style="display:${styloImgProy}"  src="${resource(dir: 'images', file:'ayuda.png')}" title="Gerente de proyecto aun sin asignar">
                </div>
            </div>
    <!--JD Castro Enero 2019  -->

            <div class="control-group ${hasErrors(bean: pedidoInstance, field: 'arquitectoSol', 'error')} ">

                <label class="control-label">Arquitecto(s)</label>
                <div class="controls">
                    <label class="radio">Si   </label>
                    <input type="radio" name="arquitectoSol"  value="S"  ${zronly}"
                           onclick="document.getElementById('arqui').style.display='block';document.getElementById('sinArquitecto').style.display='none';"
                           ${generalService.checked('S',pedidoInstance?.arquitectoSol)} >

                    <label class="radio" style="padding-top:5px;">No</label>
                    <input type="radio" name="arquitectoSol"  value="N"    ${zronly}"
                           onclick="document.getElementById('arqui').style.display='none';document.getElementById('idlarqui').value='';document.getElementById('sinArquitecto').style.display='block';"
                           ${generalService.checked('N',pedidoInstance?.arquitectoSol)}>

                </div>

            </div>
            <% String motivosNoArqui=''
            	if (pedidoInstance?.arquitectoSol=='N')  motivosNoArqui='block' else motivosNoArqui='none'
			%>      
			
			<% String xarqui
            	if (pedidoInstance?.arquitectoSol=='S')  xarqui='block' else xarqui='none'
			%>

            
            <div id="arqui" style="display:${xarqui}" class="control-group ${hasErrors(bean: pedidoInstance, field: 'listaArquitectos', 'error')} ">
                <label class="control-label" for="listaArquitectos">
                    <g:message code="pedido.listaArquitectos.label" default="Lista Arquitectos" />

                </label>
                <div class="controls">
                    <g:select id="idlarqui" multiple="true"  name="listaArquitectos" from="${generalService.getValoresParametro('arquitecto')}"
                        optionKey="idValorParametro" size='12'
                    value="${pedidoService.getArquitectosPedido(pedidoInstance?.id)}"
                    noSelection="['': '']" disabled="${xronly}"  />
                    <img class="iconoAyudaEtiqueta"  src="${resource(dir: 'images', file:'ayuda.png')}" title="Para seleccionar mas de uno, presione la tecla Ctrl y haga click en el siguiente nombre del arquitecto">
                    
                </div>
            </div>
            
            <div id="sinArquitecto" style="display:${motivosNoArqui}" class="control-group ${hasErrors(bean: pedidoInstance, field: 'razonesSinArquitecto', 'error')}">
                <label class="control-label">Motivos:</label>
                <div class="controls">                
                	<g:textArea id="comentariosSinArquitecto"  name="comentariosSinArquitecto"  value="${pedidoInstance?.razonesSinArquitecto}"  
              			cols="40" rows="3"  class="input-xlarge" disabled="${xronly}"/>
                </div>

            </div>



        </div> <%-- fin box conten --%>

    </div><%-- fin tab condiciones --%>
      <%  def  xidpropuesta=null
          if(pedidoInstance) xidpropuesta=pedidoInstance?.oportunidad?.idPropuesta  
         
      %>
    <div class="tab-pane" id="propuesta">
        <g:if test="${pedidoInstance?.id !=null}">
            <g:if test="${xidpropuesta !=null}">
            <div class="pull-right" style="margin-top:-4px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifanexos')"><i class="icon-refresh"></i></a></div>
            <iframe id="ifpropuesta" src="/crm/propuesta/show/${xidpropuesta}?idpos=${pedidoInstance?.oportunidad?.id}&idemp=${pedidoInstance?.empresa?.id}&swc=1" style="border:0;width:100%;"  scrolling="no"></iframe>
            
            </g:if>
        </g:if>
    </div><%-- fin tab propuesta final --%>
    
    <div class="tab-pane" id="anexos" >
        <g:if test="${pedidoInstance?.id != null}">
            <div class="pull-right" style="margin-top:-4px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifanexos')"><i class="icon-refresh"></i></a></div>
            <iframe id="ifanexos" src="/crm/anexo/index/${pedidoInstance?.id}?entidad=pedido&sw=${sw}" style="border:0;width:100%;"  scrolling="no"></iframe>            
                        
        </g:if>
    </div><%-- fin tab anexos --%>

    <div class="tab-pane" id="facturacion">
        <g:if test="${pedidoInstance?.id != null}">
            <div class="pull-right" style="margin-top:-4px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('iffacturas')"><i class="icon-refresh"></i></a></div>
            <iframe id="iffacturas" src="/crm/factura/index/${pedidoInstance?.id}?sw=${sw}" class="auto-height" style="border:0;width:100%;"  scrolling="no"></iframe>
                        
        </g:if>
    </div><%-- fin tab facturacion --%>
    
     <div class="tab-pane" id="actividades">
                <div class="box-content">
                    <div class="pull-right" style="margin-top:-4px;margin-bottom:0px; "><a href="#" onclick="recargarIframe('ifactividad')"><i class="icon-refresh"></i></a></div>
                    <%
                      def xtiponota='notagesven'
                      if ('GERENTE'  in generalService.getRolUsuario(session['idUsuario'].toLong()))
                          xtiponota='notaseguim'
                      
                    %>
                    <iframe id="ifactividad" src="/crm/nota/index/${pedidoInstance?.id}?entidad=pedido&tnota=${xtiponota}&zw=1" style="border:0;width:100%;"  scrolling="no"></iframe>
                   
                </div>
     </div>
            
     <%-- adicion para el iframe de requerimiento    --%>
             <div class="tab-pane" id="requerimiento">
                <div class="box-content">                   
              
                   
                    <iframe id="ifrequerimiento" src="/crm/reqLotusSw/index/?pedido=Si&numOptty=${pedidoInstance?.numPedido}" style="border:0;width:100%;"  scrolling="no" onclick="recargarIframe('ifrequerimiento')"></iframe>
                     
                </div>
            </div>
            <%--  fin de las modificacines mq   --%>
            
    <div class="tab-pane" id="historia">
        <div class="box-content">                   
            <a class="btn btn-mini" href="#" onclick="cargarHistorial(${pedidoInstance?.id},'Pedido')" > Ver Historial</a>  

            <iframe id="ifhistoria" src="" style="border:0;overflow:hidden;width:100%;" ></iframe>

        </div>
    </div>
<script>


    
    $(".decimal").numeric();
 $('#dirDespacho').focus(function()
   {    
     document.getElementById('btn-edit-dirdespacho').focus();
  }
 );
 $('#dirEntregaFactura').focus(function()
   {    
     document.getElementById('btn-edit-dirdentrega-fact').focus();
  }
 );

</script>
