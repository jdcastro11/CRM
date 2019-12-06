<%@ page import="crm.DetPedido" %>
<!DOCTYPE html>
<html>
    <head>
         <g:if test="${params.layout=='detail'}" >
            <g:set var="xlayout" value="detalle"  />
        </g:if>
        <g:else>
            <g:set var="xlayout" value="perfectum"  />
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

            <h2>Recibo Completo de  Productos en Almacén</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">
            <g:form class="form-horizontal" url="[resource:detPedidoInstance, action:'reciboCompletoDef']" method="PUT" >

                <fieldset class="form">
                  <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Procesar </button>
                <% def xvista="indexg" 
                  	if (params.layout=="detail")   xvista="index"
				  
				  def vista
				  if(params.layout=="main")
				  	vista="main"
				  else
				  	vista="detalle"					  	
                %>
                <g:hiddenField name="layout" value="${vista}"/>
                  <a  class="btn btn-mini" href="/crm/detPedido/${xvista}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                    <br><br>
                 
                    <g:set var="beanInstance"  value="${detPedidoInstance}" />                
                    <g:render template="/general/mensajes" />
                  
                       <div class="control-group ${hasErrors(bean: detPedidoInstance, field: 'fechaLlegada', 'error')} ">
                        <label class="control-label" for="fechaLlegada">
                            <g:message code="detPedido.fechaLlegada.label" default="Fecha Llegada" />
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
                      <% 
                        def posList=new ArrayList()
                        posList.addAll(detpedidos)      
                        if (posList.size()>1) 
                        elegidos=detpedidos.join(',')
                        else 
                        elegidos=detpedidos
                        %>
                  <g:hiddenField name="detpedidos" value="${elegidos}" />
                </fieldset>
            </g:form>
            <div style="height:220px;"> </div>
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
