
<%@ page import="crm.PropuestaH" %>
<%@ page import="crm.Persona" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="seguridadService" bean="seguridadService" />
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'propuesta.label', default: 'Propuesta')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <% def sw_crud=[1,1,1,1,0,0] %>
        <div id="boxprop">
            <div id="list-propuesta" class="content scaffold-list" role="main">

                <h2></span>${xtitulo}</h2>
                <hr style="margin-top:10px;margin-bottom:10px;">


                <div class="row-fluid sortable"> 
                
                    <a  class="btn btn-mini" href="/crm/propuesta/indexh/${params.id}?idemp=${xidempresa}"><i class="icon-remove"></i>&nbsp;Cancelar</a>

                    <g:set var="beanInstance"  value="${propuestaInstance}" />                
                    <g:render template="/general/mensajes" />

                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <td style="width:18px"> </td>

                                <g:sortableColumn property="numPropuesta" title="${message(code: 'propuesta.numPropuesta.label', default: 'Código')}" />

                                <g:sortableColumn property="fecha" title="${message(code: 'propuesta.fecha.label', default: 'Fecha')}" />

                                <g:sortableColumn property="idVendedor" title="${message(code: 'propuesta.idVendedor.label', default: 'Vendedor')}" />

                                <g:sortableColumn property="idContacto" title="${message(code: 'propuesta.idContacto.label', default: 'Contacto')}" />

                                <g:sortableColumn property="valor" title="${message(code: 'propuesta.valor.label', default: 'Valor')}" />

                                <g:sortableColumn property="idEstadoPropuesta" title="${message(code: 'propuesta.idEstadoPropuesta.label', default: 'Estado')}" />                                                                                             

                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${propuestaInstanceList}" status="i" var="propuestaInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td><g:checkBox name="propuestas" value="${propuestaInstance.id}" checked="false" /></td>

                                    <td><a  style="text-decoration: underline;"
                                        href="/crm/propuesta/show/${propuestaInstance.id}?idpos=${params.id}&idemp=${xidempresa}&sh=1">
                                        ${fieldValue(bean: propuestaInstance, field: "numPropuesta")}
                                        </a></td>

                                    <td><g:formatDate format="dd-MM-yyyy" date="${propuestaInstance?.fecha}" /></td>

                                    <td>${propuestaInstance?.empleado?.nombreCompleto()}</td>

                                    <td>${propuestaInstance?.persona?.nombreCompleto()}</td>

                                    <td style="text-align:right;">${formatNumber(number:fieldValue(bean: propuestaInstance, field: "valor"),format:'###,###,##0', locale:'co')}</td>

                                    <td>${generalService.getValorParametro(propuestaInstance?.idEstadoPropuesta)}</td>

                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                    <div class="pagination_crm">
                        <g:paginate id="${params.id}" total="${propuestaInstanceCount ?: 0}" />
                    </div>
                </div>
            </div>  <!-- fin content-scaffold-list !-->
        </div>  <!-- fin boxprop !-->
        <script language="javascript">
            var contenido= $("#boxprop");
            if (parent.IFRAME_PROPUESTA !=null) parent.IFRAME_PROPUESTA.height(contenido.height()+150);

        </script>
    </body>
</html>
