<%@ page import="crm.Factura" %>
<%@ page import="crm.ValorParametro" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
 <script src="${resource(dir: 'js/jquery', file:'jquery.numeric.js')}"></script>
<g:hiddenField id="eliminado" name="eliminado" value="${facturaInstance?.eliminado?:0}"/>

<div id="boxFactura">
    <g:if test="${facturaInstance?.eliminado==1}" >
            <div id="men_eliminado" class="pull-right label label-important">
                Eliminado
            </div>
    </g:if>

        <div class="controls">
            <g:select id="pedido" name="pedido.id" from="${crm.Pedido.list()}"
                      optionKey="id" required="" value="${params.idped}"  style="display:none;"/>
        </div>

    <div class="control-group ${hasErrors(bean: facturaInstance, field: 'numFactura', 'error')}">
        <label class="control-label" for="numFactura">
            <g:message code="factura.numFactura.label" default="Num Factura" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
        <g:textField disabled="${xronly}" name="numFactura" maxlength="20" required="" value="${facturaInstance?.numFactura}"/>
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: facturaInstance, field: 'fechaFactura', 'error')} ">
        <label class="control-label" for="fechaFactura">
            <g:message code="factura.fechaFactura.label" default="Fecha Factura" />

        </label>
        <div class="controls input-append date form_date" id="fechaFactura" 
             data-date-format="dd-mm-yyyy" style="margin-left:20px;">
            <input readonly type="text" id="fechadefactura" name="fechaFactura" value="${facturaInstance?.fechaFactura}" style="width:153px">
            <g:if test="${xronly!='true'}"  >
                <span class="add-on"><i class="icon-remove"></i></span>
                <span class="add-on"><i class="icon-th"></i></span>
            </g:if>
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: facturaInstance, field: 'valorFactura', 'error')} ">
        <label class="control-label" for="valorFactura">
            <g:message code="factura.valorFactura.label" default="Valor" />

        </label>
        <div class="controls">
            <g:if test="${xronly=='false'}" >
	<g:textField name="valorFactura" id="idvalorfac" maxlength="10" 
             value="${facturaInstance?.valorFactura}"                       
             disabled="${xronly}" 
             style="text-align: right" class="decimal" />
         </g:if>
         <g:else>
             <g:textField name="valorFactura_s" id="idvalorfact_s"  
             value="${formatNumber(number:facturaInstance?.valorFactura,format:'###,###,###,###.00', locale:'co')}"                       
             disabled="${xronly}" 
             style="text-align: right" />
         </g:else>         
        </div>
    </div>
   <g:if test="${xronly=='true'}">
            <g:set var="zronly" value=" disabled " />
        </g:if>
        <g:else>
            <g:set var="zronly" value="" />
        </g:else>
    <div class="control-group ${hasErrors(bean: facturaInstance, field: 'idEstadoFactura', 'error')} ">
       
        <div class="controls">
            <span><h3> El estado del Pedido luego de esta Factura es:</h3> </span>
         
            <label >
                <input type="radio" name="idEstadoPedido"  value="pedfacpar2" checked ${zronly}>
            Facturado Parcialmente </label>
            <label >
                <input type="radio" name="idEstadoPedido"  value="pedfacturx" ${zronly}>
            Facturado </label>
    
          
        </div>
    </div>
    <div style="height:120px;"></div>
    
 <g:hiddenField  name="idEstadoFactura" value="${facturaInstance?.idEstadoFactura?:'pedestacti'}" />


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
    <script>
     $(".decimal").numeric();    
    <!-- calcula el alto del bloque htm del detalle de encaberzado respectivo -->
        var contenido= $("#boxFactura");
        if (parent.IFRAME_FACTURA !=null)parent.IFRAME_FACTURA.height(contenido.height()+250);


        $("#btn_save_fact").prop('disabled',true);
		$("#fechadefactura").change(function()
			{
				if($(this).val()=='')
					$("#btn_save_fact").prop('disabled',true);
				else
					$("#btn_save_fact").prop('disabled',false);  
		        				
			}

		)

    

    </script>