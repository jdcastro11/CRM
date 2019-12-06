<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'defLog.label', default: 'DefLog')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
         <br>
        <g:form class="form-horizontal" onsubmit="desactivar('btn_save_deflog')" url="[resource:defLogInstance, action:'save']" >
            <fieldset class="form">
                <button type="submit" id='btn_save_deflog' class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</button>

                <a  class="btn btn-mini" href="/crm/defLog/index/${params.id}">
                    <i class="icon-remove"></i>&nbsp;Cancelar</a>
                <br>
                <br>
                <g:render template="form"/>
            </fieldset>            
        </g:form>
    </div>
</body>
</html>
