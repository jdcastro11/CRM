<%@ page import="crm.Empresa" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'prospecto.label', default: 'Prospecto')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-empresa" class="content scaffold-edit" role="main">		     
            <h2>Informe de Importación</h2>
             <hr style="margin-top:10px;margin-bottom:10px;">
            <a  class="btn btn-mini" href="/crm/Prospecto/index?sort=fechaApertura&order=desc"><i class="icon-remove"></i>&nbsp;Cancelar</a>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <td>Mensaje</td>
                        <td>Valor Errado</td>
                        <td>Fila</td>
                        <td>Columna</td> 
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${errors}" status="i" var="err">
                    <tr>
                    <td>${err['message']}</td>
                    <td>${err['badValue']}</td>
                    <td>${err['row']}</td>
                    <td>${err['field']}</td>
                    </tr>
                </g:each>    
             </tbody>
            </table>   
            Total Filas Importadas: ${total}
        </div>
    </body>
</html>
