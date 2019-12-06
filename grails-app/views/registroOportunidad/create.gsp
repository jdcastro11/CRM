<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'registroOportunidad.label', default: 'RegistroOportunidad')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="create-registroOportunidad" class="content scaffold-create" role="main">

            <h2><g:message code="nuevo.registroOp.label" default="Nuevo Registro de Oportunidad"/> </h2>
            <hr style="margin-top:10px;margin-bottom:10px;">
           
            <g:form class="form-horizontal" onsubmit="desactivar('btn_save_regop')" url="[resource:registroOportunidadInstance, action:'save']" >
                <fieldset class="form">
                    
                    <button type="submit" id='btn_save_regop' class="btn btn-mini btn-primary" name="create"><i class="icon-download-alt icon-white "></i>&nbsp;<g:message code="guardar.registro.label" default="Guardar registro"/> </button>
                    <a class="btn btn-mini" href="/crm/registroOportunidad/index/${params.idop}" ><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>
                    <br>
                    <br>
                    <g:set var="beanInstance"  value="${registroOportunidadInstance}" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:set var="xidpos" value="${params.id}" scope="request"/>
                    <g:render template="form"/>
                </fieldset>				
            </g:form>
        </div>
    </body>
</html>
