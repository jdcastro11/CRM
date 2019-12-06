<%@ page import="crm.Anexo" %>

%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />

<g:hiddenField  name="idEntidad"     value="${anexoInstance?.idEntidad?:params.ident}" />
<g:hiddenField  name="nombreEntidad" value="${anexoInstance?.nombreEntidad?:params.entidad}" />
<head>
<script type="text/javascript" src="//cdn.jsdelivr.net/jquery.dirtyforms/2.0.0/jquery.dirtyforms.min.js"></script>		
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js" type="text/javascript"></script>
	<script src="//cdn.jsdelivr.net/bootstrap/3.0.0/js/bootstrap.min.js" type="text/javascript"></script>	
	<g:javascript src="jquery.dirtyforms.min.js"/>
	<script src="//cdn.jsdelivr.net/jquery.dirtyforms/2.0.0/jquery.dirtyforms.dialogs.bootstrap.min.js" type="text/javascript"></script>
</head>

   <g:if test="${anexoInstance?.eliminado==1}" >
        <div id="men_eliminado" class="pull-right label label-important">
            Eliminado
        </div>
    </g:if>
 <div id="detAnexo">
    <div class="control-group ${hasErrors(bean: anexoInstance, field: 'fechaCreacion', 'error')} ">
         <label class="control-label" for="nombreArchivo">
             <g:message code="anexo.fechaCreacion.label" default="Fecha" />
         </label>
         <div class="controls">
             <g:textField class="input-med datepicker"
                          name="fechaCreacion" maxlength="10"
                          value="${anexoInstance?.fechaCreacion?:generalService.getHoy()}"
                          placeholder="dd/mm/aaaa" disabled="true" />
         </div>
     </div>
    <div class="control-group ${hasErrors(bean: anexoInstance, field: 'idTipoAnexo', 'error')} required ">

        <label class="control-label" for="idTipoAnexo" >
            <g:message code="anexo.idTipoAnexo.label" default="Tipo de Anexo" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
         <% def xtipoanexo='tipoanexos'
          if (params.anex ) xtipoanexo=params.anex 
         %>   
            <g:select name="idTipoAnexo" required="" from="${generalService.getValoresParametroxV(xtipoanexo)}"
                      optionKey="idValorParametro"
                      value="${anexoInstance?.idTipoAnexo}"
                      noSelection="['': "${message(code: 'seleccionar.label', default: 'Seleccione tipo de anexo')}"]"  />
        </div>
    </div>
 <g:hiddenField  id ="hayAnexo" name="hayAnexo" value="N" />
 

 
 <div class="control-group ${hasErrors(bean: anexoInstance, field: 'nombreArchivo', 'error')} ">
        <label class="control-label" for="nombreArchivo">
            <g:message code="anexo.nombreArchivo.label" default="Nombre Archivo" />           
        </label>
        <div class="controls" >
          <div style="display:none;">
              <input type="file" id="inputFile" name="file"
               onchange=" document.getElementById('hayAnexo').value='S'; document.getElementById('nombreArchivo').value=getNameFile(document.getElementById('inputFile').value)">
          </div>
             <g:set var="xruta" value="${generalService.getValorParametro('ruta00')}${anexoInstance.nombreArchivo}" />
           <g:textField id="nombreArchivo"  name="nombreArchivo" maxlength="200" value="${anexoInstance?.nombreArchivo}"  readonly="" />
           <g:if test="${anexoInstance?.nombreArchivo !=null}">
                <a class="btn btn-mini" href="${xruta}" target="_blank">Ver Anexo</a>
                </g:if>
           <g:if test="${xronly=='false'}" >
             
           <button type="button" class="btn  btn-mini" id="boton-subir"
               onClick="document.getElementById('inputFile').click()">
                <i class="icon-file" ></i>&nbsp;<g:message code="anexarArchivo.anexo.label" default="Anexar Archivo"/></button>
          </g:if>
        </div>
    </div>
    
    
    
    
    

    <div class="control-group ${hasErrors(bean: anexoInstance, field: 'comentarios', 'error')} ">
        <label class="control-label" for="comentarios">
            <g:message code="anexo.comentarios.label" default="Comentarios" />

        </label>
        <div class="controls">
          <g:textField name="comentarios" style="width:300px;" maxlength="200" value="${anexoInstance?.comentarios}"  readonly="${xronly}" />
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: anexoInstance, field: 'idEstadoAnexo', 'error')} ">
        <label class="control-label" for="idEstadoAnexo">
            <g:message code="anexo.idEstadoAnexo.label" default="Estado" />

        </label>
        <div class="controls">
            <g:select name="idEstadoAnexo" from="${generalService.getValoresParametro('estadogene')}"
                      optionKey="idValorParametro"
                      value="${anexoInstance?.idEstadoAnexo?:'genactivo'}"
                      noSelection="['': 'Seleccione tipo de Anexo']" disabled="${xronly}"  />
        </div>
    </div>
 
 <g:hiddenField  id ="eliminado" name="eliminado" value="${anexoInstance?.eliminado?:0}" />
</div>
 <script language="javascript">   
     
    var altura1= $("#detAnexo").height()+100;
    if (parent.IFRAME_ANEXO !=null) parent.IFRAME_ANEXO.height(altura1);
     
    var xiframePadre=parent.frameElement
    
    if (xiframePadre !=null && parent.SW_CTRLANEXO==0 ){ 
        parent.SW_CTRLANEXO=1
        var altura2=xiframePadre.clientHeight
        xiframePadre.style.height=altura1+ altura2-150 +"px"
    };        


    $('form').dirtyForms({
        // Message will be shown both in the Bootstrap Modal dialog 
        // and in most browsers when attempting to navigate away 
        // using browser actions.
        message: 'Los cambios que realizó pueden no guardarse',
        dialog: {
            title: 'Advertencia',
            dialogID: 'custom-dialog', 
            titleID: 'custom-title', 
            messageClass: 'custom-message', 
            proceedButtonText: 'Abandonar', 
            stayButtonText: 'Permanecer'
                 
        }
    });

    // If .dirtyForms() has already been called, you can override
    // the values after the fact like this.
    $.DirtyForms.dialog.title = 'Advertencia';
    $.DirtyForms.dialog.proceedButtonText = 'Abandonar';
    $.DirtyForms.dialog.stayButtonText = 'Permanecer aquí';
    $.DirtyForms.dialog.width = 150;
    </script> 
