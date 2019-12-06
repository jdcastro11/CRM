<!DOCTYPE html>
<html>
    <head>
        <g:if test="${params.layout=='main'}" >
            <g:set var="xlayout" value="perfectum"  />
        </g:if>
        <g:else>
            <g:set var="xlayout" value="detalle"  />
        </g:else>
        <meta name="layout" content="${xlayout}">
        <g:set var="entityName" value="${message(code: 'territorio.label', default: 'Territorio')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="create-territorio" class="content scaffold-create" role="main">

            <h2>Nuevo Territorio</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">                                               

             <g:set var="beanInstance"  value="${territorioInstance}" />                
            <g:render template="/general/mensajes" />
            <g:form class="form-horizontal" url="[resource:territorioInstance, action:'save']" >
                <fieldset class="form">
                    <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</button>
                    <button type="reset" class="btn btn-mini" onclick="history.go(-1)">Cancelar</button>
                    <br><br>
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>				
            </g:form>
        </div>
    </body>
</html>
