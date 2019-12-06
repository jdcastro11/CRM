<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'prospecto.label', default: 'Prospecto')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="create-empresa" class="content scaffold-create" role="main">

            <h2><g:message code="prospecto.nuevo.label"/></h2><hr style="margin-top:10px;margin-bottom:10px;">                               

            <g:form  class="form-horizontal" onsubmit="desactivar('btn_save_prosp')" url="[resource:prospectoInstance, action:'save']" >
                <fieldset class="form">
                    <button type="submit" id='btn_save_prosp' class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;<g:message code="default.button.create.label"/>
                    </button> 
                    <a class="btn btn-mini" href="/crm/Prospecto/index?sort=fechaApertura&order=desc">
                        <i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>
                    <br><br>
                    <g:set var="beanInstance"  value="${prospectoInstance}" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>

            </g:form>
        </div>
    </body>
</html>
