<%@ page import="crm.ValorParametro" %>
<!DOCTYPE html>
<html>
    <head>
       <meta name="layout" content="main">
        <title>Mostrar</title>
    </head>
    <body>
        <h1>Mostrar Parametros</h1>
        <table>
        <thead>
        <tr>

            <g:sortableColumn property="idValorParametro" title="${message(code: 'valorParametro.idValorParametro.label', default: 'Id Valor Parametro')}" />

            <g:sortableColumn property="idParametro" title="${message(code: 'valorParametro.idParametro.label', default: 'Id Parametro')}" />

            <g:sortableColumn property="valor" title="${message(code: 'valorParametro.valor.label', default: 'Valor')}" />

            <g:sortableColumn property="orden" title="${message(code: 'valorParametro.orden.label', default: 'Orden')}" />

            <g:sortableColumn property="estadoValorParametro" title="${message(code: 'valorParametro.estadoValorParametro.label', default: 'Estado Valor Parametro')}" />
					
        </tr>
            </thead>
            <tbody>
            <g:each in="${datos}" status="i" var="it">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td>${it.idValorParametro}</td>
                    <td>${it.idParametro}</td>
                    <td>${it.valor}</td>
                    <td>${it.orden}</td>
                    <td>${it.estadoValorParametro}</td>
                    </tr>
              </g:each>
             </tbody>
	</table>
    </body>
</html>
