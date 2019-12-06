<%@ page import="crm.DefLog" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'defLog.label', default: 'DefLog')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <h2>Definición de Auditoria para ${xnom}</h2>
        
        <hr style="margin-top:10px;margin-bottom:10px;"> 
         <a  class="btn btn-mini" href="/crm/defLog/listarAuditables">
         <i class="icon-remove"></i>&nbsp;Regresar</a>
        <div id="edit-defLog" class="content scaffold-edit" role="main">

            <iframe id="ifsubl" src="/crm/defLog/index/${xentidad}" style="border:0;overflow:hidden;width:100%;" ></iframe> 

            <script>
                IFRAME_DETALLE=$("#ifsubl");
            </script> 
        </div>
        
    </body>
</html>
