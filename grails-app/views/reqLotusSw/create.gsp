<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'reqLotusSw.label', default: 'ReqLotusSw')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
    
    
    
    
    
    	<% def accion %>
                <g:if test="${params.vienedepedido =='Si'}"  >
                   <% accion= "sendJson"  %>
                </g:if>
                <g:else>
                     <% accion= "salvarAnexo"  %>
                </g:else>
    
    
    
    
    
    
    
    
        <g:form class="form-horizontal" controller="reqLotusSw" action="${accion}" enctype="multipart/form-data">
            <div id="create-reqLotusSw" class="content scaffold-create" role="main">
                <h1>${params.xtitulo}</h1>
                <g:render template="/general/mensajes" />
                
                <!-- dependiendo de donde venga asi paso el parametro para mostrar el boton de crear el nuevo requerimiento  -->
                 <% def parametrosLinkPediodo %>
                <g:if test="${params.vienedepedido =='Si'}"  >
                   <% parametrosLinkPediodo= "pedido=Si"  %>
                </g:if>
                <g:else>
                     <% parametrosLinkPediodo= "pedido=No"  %>
                </g:else>
                  
                
                <g:actionSubmit class="btn btn-mini btn-primary" action="${accion}" controller="reqLotusSw" params="[numOptty:params.numOportunidad, vienedepedido:params.vienedepedido]" value="${message(code: 'default.button.create.label')}" />				
                <a class="btn btn-mini" href="/crm/reqLotusSw/index/?${parametrosLinkPediodo}&numOptty=${params.numOportunidad}" ><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>
                <br>
                <br>
                <fieldset class="form">
                    <g:render template="form"/>
               		<g:if test="${params.vienedepedido =='No'}"  >
	                    <g:hiddenField  id ="hayAnexo" name="hayAnexo" value="N" />
	                    <g:hiddenField  id ="hayAnexo1" name="hayAnexo1" value="N" />
	                    <div class="control-group">
	                        <label class="control-label" for="nombreArchivo">
	                            <g:message code="adjunto.label" default="Adjunto"/> 1         
	                        </label>
	                        <div class="controls" >
	                            <div style="display:none;">
	                                <input type="file" id="inputFile" name="file"
	                                onchange=" document.getElementById('hayAnexo').value='S'; document.getElementById('nombreArchivo').value=getNameFile(document.getElementById('inputFile').value)" >
	                                
	                            </div>
	
	                            <g:textField id="nombreArchivo"  name="nombreArchivo" maxlength="200" value=""  readonly="" />
	                                <button type="button" class="btn  btn-mini" id="boton-subir"
	                                onClick="document.getElementById('inputFile').click()">
	                                <i class="icon-file" ></i>&nbsp;<g:message code="upload.file.label" default="Cargar Archivo"/></button>
	                            
	                        </div>
	                    </div>
	                    
	                    <div class="control-group">
	                        <label class="control-label" for="nombreArchivo1">
	                            <g:message code="adjunto.label" default="Adjunto"/> 2          
	                        </label>
	                        <div class="controls" >
	                            <div style="display:none;">
	                                <input type="file" id="inputFile1" name="file1"
	                                onchange=" document.getElementById('hayAnexo1').value='S'; document.getElementById('nombreArchivo1').value=getNameFile(document.getElementById('inputFile1').value)">
	                            </div>
	
	                            <g:textField id="nombreArchivo1"  name="nombreArchivo1" maxlength="200" value=""  readonly="" />
	                                <button type="button" class="btn  btn-mini" id="boton-subir"
	                                onClick="document.getElementById('inputFile1').click()">
	                                <i class="icon-file" ></i>&nbsp;<g:message code="upload.file.label" default="Cargar Archivo"/></button>
	                            
	                        </div>
	                    </div>
	                 </g:if>
                </fieldset>
                
        </div>
    </g:form>                         
</body>
</html>
