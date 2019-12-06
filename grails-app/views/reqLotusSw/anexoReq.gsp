<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
       
    </head>
    <body>

        <div id="create-anexo" class="content scaffold-create" role="main">

           
            <hr style="margin-top:10px;margin-bottom:10px;">

            <g:uploadForm class="form-horizontal" controller="reqLotusSw" action="salvarAnexo" >
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
                    <g:hiddenField  id ="hayAnexo1" name="hayAnexo1" value="N" />
                    <div class="control-group">
                        <label class="control-label" for="nombreArchivo">
                            Adjunto 1         
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
                    
                    <div class="control-group">
                        <label class="control-label" for="nombreArchivo1">
                            Adjunto 2         
                        </label>
                        <div class="controls" >
                            <div style="display:none;">
                                <input type="file" id="inputFile1" name="file1"
                                onchange=" document.getElementById('hayAnexo1').value='S'; document.getElementById('nombreArchivo1').value=getNameFile(document.getElementById('inputFile1').value)">
                            </div>

                            <g:textField id="nombreArchivo1"  name="nombreArchivo1" maxlength="200" value=""  readonly="" />
                                <button type="button" class="btn  btn-mini" id="boton-subir"
                                onClick="document.getElementById('inputFile1').click()">
                                <i class="icon-file" ></i>&nbsp;Cargar Archivo</button>
                            
                        </div>
                    </div>
                      <g:hiddenField  name="idPedido" value="${params.id}" />
                </fieldset>
            </g:uploadForm>
        </div>
    </body>
</html>
