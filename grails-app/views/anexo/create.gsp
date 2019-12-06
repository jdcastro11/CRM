<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'anexo.label', default: 'Anexo')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="create-anexo" class="content scaffold-create" role="main">

            <h2>Nuevo Anexo</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">

            <g:uploadForm class="form-horizontal" onsubmit="desactivar('btn_save_anex')"  url="[resource:anexoInstance, action:'save']" >
                <fieldset class="form">
                    <button type="submit" id='btn_save_anex' class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;<g:message code="guardarAnexo.label" default="Guardar Anexo"/> </button>

                      <a  class="btn btn-mini" href="/crm/anexo/index/${params.ident}?entidad=${params.entidad}">
                      <i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label" default="Cancelar"/> </a>
                    <br>
                    <br>
                    <g:set var="beanInstance"  value="${anexoInstance}" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>
            </g:uploadForm>
        </div>
    </body>
</html>
