<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'anexo.label', default: 'Anexo')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="create-anexo" class="content scaffold-create" role="main">

            <h2>Importar Productos vía Hoja de Costos</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">

            <g:uploadForm class="form-horizontal" controller="detPedido" action="importarProductosPedidoDef" >
                <fieldset class="form">
                    <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Importar</button>

                    <a  class="btn btn-mini" href="/crm/detPedido/index/${params.id}">
                        <i class="icon-remove"></i>&nbsp;Cancelar</a>
                    <br>
                    <br>
                    <g:set var="beanInstance"  value="${detPedidoInstance}" />                
                    <g:render template="/general/mensajes" />
                    <br><br>
                    <g:hiddenField  id ="hayAnexo" name="hayAnexo" value="N" />
                    <div class="control-group">
                        <label class="control-label" for="nombreArchivo">
                            Hoja de Costos         
                        </label>
                        <div class="controls" >
                            <div style="display:none;">
                                <input type="file" id="inputFile" name="file"
                                onchange=" document.getElementById('hayAnexo').value='S'; document.getElementById('nombreArchivo').value=getNameFile(document.getElementById('inputFile').value)">
                            </div>

                            <g:textField id="nombreArchivo"  name="nombreArchivo" maxlength="200" value=""  readonly="" />
                                <button type="button" class="btn  btn-mini" id="boton-subir"
                                onClick="document.getElementById('inputFile').click()">
                                <i class="icon-file" ></i>&nbsp;Cargar Archivo</button>
                            
                        </div>
                    </div>
                      <g:hiddenField  name="idPedido" value="${params.id}" />
                </fieldset>
            </g:uploadForm>
        </div>
    </body>
</html>
