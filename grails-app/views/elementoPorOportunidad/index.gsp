<%@ page import="crm.ElementoPorOportunidad" %>
<%@ page import="crm.Linea" %>
<%@ page import="crm.Sublinea" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'elementoPorOportunidad.label', default: 'ElementoPorOportunidad')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

          %{--Use generalService--}%
        <g:set var="generalService" bean="generalService" />
        <g:set var="seguridadService" bean="seguridadService" />
        <% def sw_crud=[1,1,1,1,0,0]  %>
        <div id="detalleconten">

            <h2 style="margin-top:0px">${xtitulo}</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">                           

            <div class="row-fluid sortable"> 

                <g:if test="${xcerrada=='N'}">
                    <div class="pull-left">
                        <div class="pull-left">
                            <g:if test="${'CREAR' in seguridadService.operacionesPorOpcion(session['idUsuario'],'/elementoPorOportunidad/index')}">
                                <a class="btn btn-mini btn-primary" href="/crm/ElementoPorOportunidad/create/${xoportunidad}">
                                    <i class="icon-plus icon-white"></i>
                                    <strong><g:message code="default.new.label"/></strong>
                                </a>
                                
                                
                            </g:if>
                        </div>
                    </div>
                    &nbsp;
                    <div class="btn-group">
                    <%  def swacc=0 %>
                        <a href="#" class="btn btn-mini" ><g:message code="acciones.label"/> </a>
                        <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                        <ul class="dropdown-menu">
                            <g:if test="${sw_crud[4]==1}">
                                <li><a href="${createLink(action:'eliminar')}" >Eliminar</a></li>
                                </g:if>
                            <g:if test="${'BORRAR' in session['operaciones']}">
                              <%  swacc=1 %>
                            <li><a href="/crm/elementoPorOportunidad/listarBorrados/${xoportunidad}" ><g:message code="borrados.label"/></a></li>  
                            </g:if>
                            <g:if test="${swacc==0}" >
                               <li align="center">Ninguna </li>
                           </g:if>
                        </ul>
                    </div>                
                </g:if>

                <a  class="btn btn-mini" href="/crm/elementoPorOportunidad/index/${xoportunidad}">
                 <i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>

                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <td style="width:18px"> </td>

                                <g:sortableColumn property="idLinea" title="${message(code: 'elementoPorOportunidad.idLinea.label', default: 'Línea')}" />

                                <g:sortableColumn property="idSublinea" title="${message(code: 'elementoPorOportunidad.idSublinea.label', default: 'Sublínea')}" />

                                <%-- <g:sortableColumn property="idTipoProducto" title="${message(code: 'elementoPorOportunidad.idTipoProducto.label', default: 'Tipo')}" />--%>

                                <%--<g:sortableColumn property="idMarca" title="${message(code: 'elementoPorOportunidad.idMarca.label', default: 'Marca')}" />--%>

                                <g:sortableColumn property="cantidad" title="${message(code: 'elementoPorOportunidad.cantidad.label', default: 'Cantidad')}" />

                                <g:sortableColumn property="valor" title="${message(code: 'elementoPorOportunidad.valor.label', default: 'Valor')}" />

                                <g:sortableColumn property="total" title="${message(code: 'elementoPorOportunidad.total.label', default: 'Total')}" />

                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${elementoPorOportunidadInstanceList}" status="i" var="elementoPorOportunidadInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                    <td><g:checkBox name="prodelegidos" value="${elementoPorOportunidadInstance?.id}" checked="false" /></td>

                                    <td><a   style="text-decoration:underline;" href="/crm/elementoPorOportunidad/show/${elementoPorOportunidadInstance?.id}?sw=0">
                                            ${elementoPorOportunidadInstance?.linea?.descLinea} </a>
                                    </td>

                                    <td>${elementoPorOportunidadInstance?.sublinea.descSublinea}</td>

                                   <%-- <td> ${generalService.getValorParametro(elementoPorOportunidadInstance?.idTipoProducto)} </td>--%>

                                   <%-- <td> ${generalService.getValorParametro(elementoPorOportunidadInstance?.idMarca)}</td>--%>

                                    <%  def xcant 
                                        if (elementoPorOportunidadInstance?.cantidad==null)
                                            xcant=0
                                        else
                                            xcant=elementoPorOportunidadInstance?.cantidad
                                        def xvalor
                                        if (elementoPorOportunidadInstance?.valor==null)
                                             xvalor=0
                                        else    
                                            xvalor=elementoPorOportunidadInstance?.valor
                                     %>
                                    <td style="text-align:center;">${formatNumber(number:elementoPorOportunidadInstance?.cantidad,format:'###,###', locale:'co')}</td>

                                    <td style="text-align:right;">${formatNumber(number:elementoPorOportunidadInstance?.valor,format:'###,###,###.00', locale:'co')}</td>

                                    <td style="text-align:right;">${formatNumber(number:xcant * xvalor,format:'###,###,###.00', locale:'co')}</td>

                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                    <div class="pagination_crm">
                        <g:paginate  id="${xoportunidad}" total="${elementoPorOportunidadInstanceCount?: 0}" />
                    </div>
            </div>
        </div>
        <script>
            var contenido= $("#detalleconten");
            if (parent.IFRAME_DETALLE !=null) parent.IFRAME_DETALLE.height(contenido.height()+60);

        </script>
    </body>
</html>
