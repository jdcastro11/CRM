<%@ page import="crm.Faq" %>
<g:set var="generalService" bean="generalService"/>
<div class="control-group ${hasErrors(bean: faqInstance, field: 'pregunta', 'error')} ">
	<label class="control-label"    for="pregunta">
		<g:message code="faq.pregunta.label " default="Pregunta" />		
	</label >
	<div class="controls text-info">
             <g:textArea name="pregunta" cols="40" rows="5" maxlength="300" value="${faqInstance?.pregunta}" style="width:60%;" disabled="${xronly}"/>
       </div>
</div>

<div class="control-group ${hasErrors(bean: faqInstance, field: 'idTipo', 'error')} ">
	<label class="control-label"  for="idTipo">
		<g:message code="faq.idTipo.label " default="Tipo" />
		
	</label >
	<div class="controls">
	<g:select name="idTipo"  from="${generalService.getValoresParametro('faqtipopre')}" 
            optionKey="idValorParametro"
            value="${faqInstance?.idTipo}"
            disabled="${xronly}" />
       </div>
</div>

<div class="control-group">
	<label class="control-label"  for="respuesta">
		<g:message code="faq.respuesta.label " default="Respuesta"   />		
	</label >
	<div class="controls">           
           <g:textArea name="respuesta" value="${faqInstance?.respuesta}" rows="10" cols ="100" style="width:60%"  disabled="${xronly}" />   
     </div>
</div>

<div class="control-group ${hasErrors(bean: faqInstance, field: 'orden', 'error')} ">
	<label class="control-label"  for="orden">
		<g:message code="faq.orden.label " default="Orden" />
		
	</label>
        <div class="controls">
	<g:textField  name="orden" value="${faqInstance.orden}" disabled="${xronly}" />
        </div>
 </div>
 
<div class="control-group ${hasErrors(bean: faqInstance, field: 'estadoFaq', 'error')} ">
	<label class="control-label"  for="estadoFaq">
		<g:message code="faq.estadoFaq.label " default="Estado" />
		
	</label>
        <div class="controls">
	<g:select name="estadoFaq" from="['A','I']"
           value="${faqInstance?.estadoFaq?:'A'}"  
           noSelection="['': '']"  disabled="${xronly}" />
        </div>
 </div>

<g:hiddenField  id ="eliminado" name="eliminado" value="${valorParametroInstance?.eliminado?:0}" />

