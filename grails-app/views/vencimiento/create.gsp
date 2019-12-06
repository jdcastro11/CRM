<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'vencimiento.label', default: 'Vencimiento')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="create-vencimiento" class="content scaffold-create" role="main">

            <h2>Nuevo Detalle Vencimiento</h2>
            <hr style="margin-top:10px;margin-bottom:10px;"> 		

            <g:form class="form-horizontal" method="post" onsubmit="return validarDatos()" enctype="multipart/form-data" url="[resource:vencimientoInstance, action:'save']" >

                <fieldset class="form">
                    <button type="submit" id='btn_save_venc' class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar
                    </button> 
                    <a  class="btn btn-mini" href="/crm/vencimiento/index?idenc=${params.idenc}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                    <br><br>
                    <g:set var="beanInstance"  value="${vencimientoInstance}" />                
                    <g:render template="/general/mensajes" />             
                    <g:set var="xronly" value="false" scope="request"/>
                    
                    
                    <g:render template="form"/>
                </fieldset>				
            </g:form>
        </div>        
    </body>
</html>
