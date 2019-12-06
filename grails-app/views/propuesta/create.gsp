<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'propuesta.label', default: 'Propuesta')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="create-propuesta" class="content scaffold-create" role="main">

            <h2>Nueva Propuesta</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">	

            <g:form class="form-horizontal" onsubmit="desactivar('btn_save_prop')"  url="[resource:propuestaInstance, action:'save']" >
                <fieldset class="form">
                    <button type="submit" id='btn_save_prop' class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;<g:message code="guardar.propuesta.label"/> </button>
                    <a  class="btn btn-mini" href="/crm/propuesta/index/${params.idpos}">
                    <i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>
                    <br>
                    <br>
                    <g:set var="beanInstance"  value="${prospectoInstance}" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:set var="xpos" value="${params.idpos}" scope="request"/>
                    <g:set var="xemp" value="${params.idemp}" scope="request"/>
                    <g:render template="form"/>
                </fieldset>				
            </g:form>
        </div>
    </body>
</html>
