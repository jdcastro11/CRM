<%@ page import="crm.Actividad" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'actividad.label', default: 'Actividad')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>   
</head>
<body>                                 

    <div class="row-fluid sortable">

            <div id="list-actividad" class="content scaffold-list" role="main">
                
                <table  style="font-size:0.9em" width="100%">
                    <thead>
                        <tr>
                           <g:sortableColumn property="nombreCliente" title="${message(code: 'actividad.nombreCliente.label', default: 'Cliente')}"  />
                           <g:sortableColumn property="descActividad" title="${message(code: 'actividad.descActividad.label', default: 'Actividad')}"  />
                           <g:sortableColumn property="fechaFinal" title="${message(code: 'actividad.fechaFinal.label', default: 'Vence')}"  />
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${actividadInstanceList}" status="i" var="actividadInstance">
                          <g:set var="oportunidadInstance" value="${crm.Oportunidad.get(actividadInstance?.idEntidad)}" />
                            
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td><a style="text-decoration:underline;" target="_parent"
                                       href="/crm/actividad/show/${actividadInstance.id}?identidad=${actividadInstance?.idEntidad}&spanel=1&&entidad=oportunidad&layout=main&idcon=${oportunidadInstance?.persona?.id}&idemp=${oportunidadInstance?.empresa?.id}">
                                        ${oportunidadInstance.nombreCliente.toLowerCase()}
                                    </a></td>
                                <td>${actividadInstance.descActividad}</td>
                                <td><g:formatDate format="dd-MM-yyyy hh:mm" date="${actividadInstance?.fechaFinal}"  /> </td>                               
                            </tr>
                             <% if (i>10) actividadInstanceList=[] %>
                        </g:each>
                    </tbody>
                </table>
                <div class="pagination_panel">
                    <g:paginate total="${actividadInstanceCount ?: 0}" domainBean="Actividad" />
                </div>
            </div>
        </div>
   
</body>
</html>
