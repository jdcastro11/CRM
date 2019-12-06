<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'Prospecto')}" />
        <title>Ultima Nota</title>
    </head>
    <body>

            <h2>Ultima gestión de Venta </h2>               
            <hr style="margin-top:10px;margin-bottom:10px;width:80%;">             

            <g:form  class="form-horizontal"  >
                                    
                    <fieldset class="form">
                        <div class="control-group">

                            <label class="control-label" >Fecha</label>
                            <div class="controls">
                               <g:formatDate format="dd-MM-yyyy" date="${notaInstance.fecha}" disabled="true" /> 
                            </div>
                        </div>  
                        <div class="control-group">
                            <label  class="control-label" >
                                Ultima Gestión
                            </label>                           
                            <div class="controls">
                                <g:textArea style="width:400px;"  name="nota"  rows="4"  value="${notaInstance.nota}" disabled="true"  />
                            </div> 
                        </div>

                    </fieldset>		                
            </g:form>

    </body>
</html>
