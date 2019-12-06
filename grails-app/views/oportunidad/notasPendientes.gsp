<%@ page import="crm.Oportunidad" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'Oportunidad')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
       
    <r:require module="filterpane" />
</head>
<body>                                 

    <div class="row-fluid sortable">       
        <g:form controller="Oportunidad" >

            <div id="list-oportunidad" class="content scaffold-list" role="main">
                
                <table  style="font-size:0.9em" width="100%">
                    <thead>
                        <tr>
                            <g:sortableColumn property="numOportunidad" title="${message(code: 'oportunidad.numOportunidad.label', default: 'Nro.')}"  />

                            <g:sortableColumn property="nombreCliente" title="${message(code: 'oportunidad.nombreCliente.label', default: 'Empresa')}"  />

                            <g:sortableColumn property="fecha" title="${message(code: 'oportunidad.valorOportunidad.label', default: 'Fecha U.Nota')}"  />

                        </tr>
                    </thead>
                    <tbody>                        
                        <g:each in="${oportunidadInstanceList}" status="i" var="oportunidadInstance">

                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td><a style="text-decoration:underline;" target="_parent" href="/crm/oportunidad/show/${oportunidadInstance[0]}">
                                        ${oportunidadInstance[1]}
                                    </a></td>
                                
                                    <td>${oportunidadInstance[2]?.toLowerCase()}</td>
                                
                                <td style="text-align:center">
                                    <g:formatDate format="dd-MM-yyyy" date="${oportunidadInstance[3]}"  />                    
                                </td>                               
                                
                            </tr>                            
                        </g:each>
                    </tbody>
                </table>
                <div class="pagination_panel">
                    <g:paginate total="${oportunidadInstanceCount ?: 0}" domainBean="Oportunidad"/>
                </div>
            </div>
        </div>
    </g:form>
</body>
</html>
