<%@ page import="crm.OportunidadH" 
import="crm.Empresa"
import="crm.Persona"
%>
<g:set var="generalService" bean="generalService" />
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'OportunidadH')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
    <style TYPE="text/css"> 
        a.gris:link{fon-size:13px !important;}
        a.gris:hover{background:#eee !important;color:#000 !important}
    </style>
</head>

<body >
    <% def sw_crud=[1,1,1,1,0,0]  %>

    <div id="detalleconten">           

        <h2>${xtitulo}</h2>
        <hr style="margin-top:10px;margin-bottom:10px;">                           
        <filterpane:filterPane domain="OportunidadH" 
        formName="frmFiltro"
        action="indexh"
        showTitle="no"
        dialog="true"
        filterProperties="${['numOportunidad','nombreOportunidad','nombreCliente','nombreContacto','nombreVendedor','idEstadoOportunidad','trimestre']}"      
        filterPropertyValues="${['idEstadoOportunidad':[values:crm.ValorParametro.executeQuery('select valor from ValorParametro where idParametro=\'eoportunid\'')]]}"
        showSortPanel="false"
        fullAssociationPathFieldNames="false"
        />

        <g:form id="frmoport" controller="Oportunidad" >
      
                   <!-- inicio filter  buttons -->                           
                <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>                           
                <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
                <!-- fin filter  buttons  -->
               
          <a  class="btn btn-mini" href="/crm/oportunidad/indexh?sort=fechaApertura&order=desc"><i class="icon-remove"></i>&nbsp;Cancelar</a>

            <g:set var="beanInstance"  value="${oportunidadInstance}" />                
            <g:render template="/general/mensajes" />

            <table class="table table-bordered">
                <thead>
                    <tr>
                        <td style="width:18px"> </td>
                        <g:sortableColumn property="numOportunidad" title="${message(code: 'oportunidad.numOportunidad.label', default: 'Nro.')}" params="${filterParams}" />
                        <g:sortableColumn property="nombreCliente" title="Empresa" params="${filterParams}"/>
                        <g:sortableColumn property="nombreOportunidad" title="${message(code: 'oportunidad.nombreOportunidad.label', default: 'Oportunidad')}" params="${filterParams}"/>
                        <g:sortableColumn property="numOportunidadFabricante" title="${message(code: 'oportunidad.numOportunidadFabricante.label', default: 'Op. Fabricante')}" params="${filterParams}"/>
                        <g:sortableColumn property="valorOportunidad" title="${message(code: 'oportunidad.valorOportunidad.label', default: 'Valor')}" params="${filterParams}"/>
                        <g:sortableColumn property="nombreVendedor" title="${message(code: 'oportunidad.nombreVendedor.label', default: 'Vendedor')}" params="${filterParams}"/>
                        <g:sortableColumn property="fechaCierreEstimada" title="${message(code: 'oportunidad.fechaCierreEstimada.label', default: 'Fecha Cierre')}" params="${filterParams}"/>
                        <g:sortableColumn property="trimestre" title="${message(code: 'oportunidad.trimestre.label', default: 'Q')}" params="${filterParams}"/>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${oportunidadInstanceList}" status="i" var="oportunidadInstance">

                        <tr  class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:checkBox name="oportunidades" value="${oportunidadInstance.id}" checked="false" /></td>

                            <td>
                                <g:link action="showh" style="text-decoration:underline;" id="${oportunidadInstance.id}">
                                    ${oportunidadInstance?.numOportunidad}</g:link>
                                </td>

                            <td>${oportunidadInstance?.nombreCliente}</td>

                            <td>${fieldValue(bean:oportunidadInstance,field:"nombreOportunidad")}</td>

                            <td>${fieldValue(bean:oportunidadInstance,field:"numOportunidadFabricante")}</td>

                            <td style="text-align:right">${fieldValue(bean:oportunidadInstance,field:"valorOportunidad")}</td>

                            <td>${oportunidadInstance?.nombreVendedor}</td>

                            <td><g:formatDate format="dd-MM-yyyy" date="${oportunidadInstance?.fechaCierreEstimada}" /></td>                                         

                            <td>${fieldValue(bean:oportunidadInstance,field:"trimestre")} </td>                                         
                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination_crm">
                <filterpane:paginate total="${oportunidadInstanceCount ?: 0}" domainBean="OportunidadH"/>
            </div>
        </div>                     
    </g:form>
    <script>
       <!-- resize el padre del iframe --> 
        var contenido= $("#detalleconten");                       
        if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+60);

    </script>
</body>
</html>
