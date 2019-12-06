<%@ page import="crm.DetPedido" %>
<!DOCTYPE html>
<html>
    <head>
          <g:if test="${xlayout=='main'}" >
            <g:set var="xlayout" value="perfectum"  />
        </g:if>
        <g:else>
            <g:set var="xlayout" value="detalle"  />
        </g:else>
        <meta name="layout" content="${xlayout}">
        <g:set var="entityName" value="${message(code: 'detPedido.label', default: 'DetPedido')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
  
    </head>
    <body>

        <div id="detcompra">

            <h2>Procesar Producto x Compra</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">                                               

            <form class="form-horizontal" action="/crm/detPedido/procesarProductoCompraDef/${xprod}"  >

                <fieldset class="form">
                    <% 
                       def xurl="/crm/detPedido/index/${xpedido}"
                      if (sw)
                         if (sw in [11,12]) xurl='/crm/detPedido/indexn'
                    %>
                    <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</button>
                    <a  class="btn btn-mini" href="${xurl}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                    <br><br>
                    <g:set var="beanInstance"  value="${detPedidoInstance}" />                
                    <g:render template="/general/mensajes" />
                    
                    <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'ordenCompra', 'error')} ">
                        <label class="control-label" for="ordenCompra">
                            <g:message code="detPedido.ordenCompra.label" default="Orden de Compra" />
                        </label> 
                        <div class="controls">
                            <g:textField name="ordenCompra" maxlength="20" value="${detPedidoInstance?.ordenCompra}" required="" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" >Proveedor</label>
                        <div class="controls">
                            <g:select name="idProveedor" style="width:300px;" from="${crm.Empresa.findAllByIdTipoEmpresaAndEliminado('empproveed',0)}"
                                optionKey="id"
                            value=""
                            noSelection="['': 'Seleccione Proveedor']"    disabled="${xronly}" />
                        </div>
                    </div>
                    <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'fechaPosibleLlegada', 'error')} ">
                        <label class="control-label" >Posible LLegada</label>

                        <div class="controls input-append date form_date" id="fechapllegada" data-date-format="dd-mm-yyyy" style="margin-left:20px;">
                            <input  type="text" name="fechaPosibleLlegada" id="fechaa" 
                            value=""  readonly="true" >
                            <g:if test="${xronly!='true'}"  >             
                                <span class="add-on"><i class="icon-th"></i></span>
                                </g:if>
                        </div>
                    </div>
                    <div class="control-group ">
                        <label class="control-label">Observaciones</label>
                        <div class="controls">
                            <g:textArea name="observaciones" maxlength="200" col="60" rows="6" 
                            value="" />
                        </div>
                    </div>
                    <div style="height: 70px"> </div>
                </fieldset>
                 <%              
                  def elegidos
                  if (params.detpedidos){
                    
                     def posList=new ArrayList()
                     posList.addAll(params.detpedidos)      
                    if (posList.size()>1) 
                     elegidos=params.detpedidos.join(',')
                    else 
                      elegidos=params.detpedidos
                  }else{                    
                     elegidos= xprod                     
                  }                 
                 %>
                <g:hiddenField name="sw"  value="${sw}"/>   
                <g:hiddenField name="detpedidos"  value="${elegidos}"/>   
                <g:hiddenField name="pedido"  value="${xpedido}"/>  
            </form>
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
            var contenido= $("#detcompra");
           if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+250);
        </script>
        
    </body>
</html>
