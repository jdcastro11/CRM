<%@ page import="crm.DetPedido" %>
<!DOCTYPE html>
<html>
    <head>
        <g:if test="${params.layout=='main'}" >
            <g:set var="xlayout" value="perfectum"  />
        </g:if>
        <g:else>
            <g:set var="xlayout" value="detalle"  />
        </g:else>
        <meta name="layout" content="${xlayout}">
        <g:set var="entityName" value="${message(code: 'detPedido.label', default: 'DetPedido')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
         <script src="${resource(dir: 'js/jquery', file:'jquery.numeric.js')}"></script>
        <script>
              function esFecha(obj){
                    var ExpReg = /^([0][1-9]|[12][0-9]|3[01])(\/|-)([0][1-9]|[1][0-2])\2(\d{4})$/;
                   return (obj.value.match(ExpReg));
            }
            function validarRecibo(){
               var xcant= document.getElementById('cantidadRecibida')
              if (xcant.value <=0) {
               xcant.value=''              
               xcant.focus()
               return 
               }              
            }
       </script>
    </head>
    <body>

        <div id="edit-detPedido" class="content scaffold-edit" role="main">

            <h2>Recibo de Producto en Almacén</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">                                               

            <g:form class="form-horizontal" url="[resource:detPedidoInstance, action:'procesarProductoAlmacenDef']" method="PUT" >

                <fieldset class="form">
                    <g:render template="acciones" />
                    <br><br>
                    <g:set var="beanInstance"  value="${detPedidoInstance}" />                
                    <g:render template="/general/mensajes" />
                    <div class="control-group">                      
                           <label class="control-label">
                             Referencia          
                           </label>
                       <div class="controls"> 
                        <g:textField id="refProducto" name="refProducto"     maxlength="100" class="input-large"                  
                        value="${detPedidoInstance.refProducto}" disabled="true"  />  
                        </div>
                    </div>
                  <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'descProducto', 'error')} ">
                         <label class="control-label" for="descProducto">
                             <g:message code="detPedido.descProducto.label" default="Descripción" />

                         </label>
                         <div class="controls">
                             <g:textArea name="descProducto" id="idescprod" rows="3" cols="150" value="${detPedidoInstance?.descProducto}"           
                             disabled="true" />
                           </div>
                 </div>
                    <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'cantidad', 'error')} ">
                        <label class="control-label" for="cantidad">
                            <g:message code="detPedido.cantidad.label" default="Cantidad Pedida"  />
                        </label>
                        <div class="controls">
                            <g:textField name="cantidad_s" id="idcant_s"  
                            value="${formatNumber(number:detPedidoInstance?.cantidad,format:'###,###,###', locale:'co')}"                       
                                disabled="true" 
                                style="text-align: right" />
                        </div>
                    </div>  

                    <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'cantidadRecibida', 'error')} ">
                        <label class="control-label" for="cantidadRecibida">
                            <g:message code="detPedido.cantidadRecibida.label" default="Cantidad Recibida"  />                           
                        </label>
                        <div class="controls">
                            <g:textField name="cantidadRecibida" id="cantidadRecibida"  
                            value="${detPedidoInstance?.cantidadRecibida?:0}"                               
                               style="text-align: right"   class="entero" disabled="true" />
                        </div>
                    </div>  
                    
                    <div class="control-group">
                        <label class="control-label"  >
                             <g:message code="detPedido.cantidadARecibir.label" default="Cantidad A Recibir"  />
                            <span class="required-indicator">*</span>
                        </label>
                        <div class="controls">
                            <g:textField name="cantidadARecibir" id="cantidadARecibir"  
                            value="" 
                               onchange="validarRecibo()" 
                               style="text-align: right" required=""  class="entero" />
                        </div>
                    </div>  
                       <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'fechaLlegada', 'error')} ">
                        <label class="control-label" for="fechaLlegada">
                            <g:message code="detPedido.fechaLlegada.label" default="Fecha LLegada" />
                               <span class="required-indicator">*</span>
                        </label>

                        <div class="controls input-append date form_date" id="fechapllegada" data-date-format="dd-mm-yyyy" style="margin-left:20px;">
                            <input  type="text" name="fechaLlegada" id="fechaa"  required=""
                            value="${g.formatDate(format:'dd-MM-yyyy',date:detPedidoInstance?.fechaLlegada)}"
                            onchange="if (!esFecha(this)){this.value='';this.focus()}">
                            <g:if test="${xronly!='true'}"  >             
                                <span class="add-on"><i class="icon-th"></i></span>
                                </g:if>
                        </div>
                    </div>

                </fieldset>
                 <g:hiddenField  name="layout" value="${layout}" />
            </g:form>
            <div style="height:220px"></div>
        </div>
        <script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.js')}"></script>
        <script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.es.js')}"></script>
        <script type="text/javascript">
          $(".entero").numeric("0");
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
    </body>
</html>
