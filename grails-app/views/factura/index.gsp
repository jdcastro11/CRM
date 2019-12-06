
<%@ page import="crm.Factura" %>
<%@ page import="crm.Persona" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="pedidoService" bean="pedidoService" />
<g:set var="seguridadService" bean="seguridadService" />


<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'factura.label', default: 'Factura')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <% def sw_crud=[1,1,1,1,0,0] %>
        <div id="boxFactura">

            <g:set var="facturaList" value="${pedidoService.valorFacturado(xidped)}"/>    
            <h2>Resumen de Facturas</h2>
            <hr style="margin-top:10px;margin-bottom:10px;"> 
        <!-- Campos para valores de factura -->
            <div class="form-horizontal">
                <div class="control-group">
                    <label class="control-label">
                        Subtotal
                    </label>
                    <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:220px;background-color:#EEE;text-align:right;">
                        <g:formatNumber name="subtotal" number="${facturaList['subtotal']}" format="###,###,###.00" locale="co"/>                    
                    </div>                                  
                </div>

                <div class="control-group">
                    <label class="control-label">
                        Descuento
                    </label>
                    <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:220px;background-color:#EEE;text-align:right;">
                        <g:formatNumber name="descuento" number="${facturaList['descuento']}" format="###,###,###.00" locale="co"/>
                    </div>                                  
                </div> 
                <div class="control-group">
                    <label class="control-label">
                        Iva
                    </label>
                    <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:220px;background-color:#EEE;text-align:right;">
                        <g:formatNumber name="iva" number="${facturaList['iva']}" format="###,###,###.00" locale="co"/>
                    </div>                                  
                </div>      

                <div class="control-group">
                    <label class="control-label">
                        Total
                    </label>
                    <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:220px;background-color:#EEE;text-align:right;">
                        <g:formatNumber name="total" number="${facturaList['total']}" format="###,###,###.00" locale="co"/> 
                    </div>                                  
                </div>   

                <hr style="margin-top:10px;margin-bottom:10px;">                                               
                <div id="list-factura" class="content scaffold-list" role="main">

                    <h2>${xtitulo}</h2>
                    <hr style="margin-top:10px;margin-bottom:10px;">                                               
                    <g:if test="${pedidoService.accesoPedido(xidped.toLong(),session['idUsuario'],'factura')}" > 
                        <div class="row-fluid sortable"> 

                            <div class="pull-left">
                                <div class="pull-left">

                                    <g:if test="${'CREAR' in seguridadService.operacionesPorOpcion(session['idUsuario'],'/factura/index')}">

                                        <a class="btn btn-mini btn-primary" href="/crm/factura/create/?idped=${xidped}">
                                            <i class="icon-plus icon-white"></i>
                                            <strong>&nbsp;Nuevo</strong>
                                        </a>

                                    </g:if>
                                </div>
                            </div>
                            &nbsp;
                            <div class="btn-group">

                                <a href="#" class="btn btn-mini" >Acciones</a>
                                <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                               <%  def swacc=0 %>
                                <ul class="dropdown-menu">
                                    <g:if test="${sw_crud[4]==1}">
                                        <li><a href="${createLink(action:'eliminar')}">Eliminar</a></li>
                                        </g:if>
                                        <g:if test="${'BORRAR' in session['operaciones']}">
                                          <%  swacc=1 %>
                                         <li><a href="/crm/factura/listarBorrados/${xidped}">Ver Borrados</a></li>
                                        </g:if>
                                        <g:if test="${swacc==0}" >
                                        <li align="center">Ninguna </li>
                                       </g:if>
                                </ul>
                            </div>        
                        </g:if>
                        <a  class="btn btn-mini" href="/crm/factura/index/${xidped}">
                            <i class="icon-remove"></i>&nbsp;Cancelar</a>


                            <g:set var="beanInstance"  value="${facturaInstance}" />                
                            <g:render template="/general/mensajes" />
                        <table class="table table-bordered">
                            <thead>
                                <tr>

                                    <td style="width:18px"></td>
                                    <g:sortableColumn property="numFactura" title="${message(code: 'factura.numFactura.label', default: 'Num Factura')}" />

                                    <g:sortableColumn property="fechaFactura" title="${message(code: 'factura.fechaFactura.label', default: 'Fecha Factura')}" />

                                    <g:sortableColumn property="valorFactura" title="${message(code: 'factura.valorFactura.label', default: 'Valor Factura')}" />

                                    <th><g:message code="factura.pedido.label" default="Pedido" /></th>

                                    <!--g:sortableColumn property="idEstadoFactura" title="${message(code: 'factura.idEstadoFactura.label', default: 'Estado.')}" /-->

                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${facturaInstanceList}" status="i" var="facturaInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                        <td><g:checkBox name="facturas" value="${facturaInstance?.id}" checked="false" /></td>

                                        <td>					
                                            <a action="show" style="text-decoration:underline" id="${facturaInstance.id}" href="/crm/factura/show/${facturaInstance.id}?idped=${xidped}">
                                                ${fieldValue(bean: facturaInstance, field: "numFactura")}</a>
                                        </td>

                                        <td><g:formatDate format="dd-MM-yyyy" date="${facturaInstance?.fechaFactura}" /></td>

                                        <td style="text-align:right;">${formatNumber(number:facturaInstance?.valorFactura,format:'###,###,###,###.00', locale:'co')}</td>

                                        <td>${fieldValue(bean: facturaInstance, field: "pedido")}</td>

                                        <!--td>${generalService.getValorParametro(facturaInstance.idEstadoFactura)}</td-->
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                        <div class="pagination_crm">
                            <g:paginate id="${xidped}" total="${facturaInstanceCount?:0}" />
                        </div>
                    </div>
                </div>
            </div>
            </div>
            <script language="javascript">
                var contenido= $("#boxFactura");
                if (parent.IFRAME_FACTURA !=null) parent.IFRAME_FACTURA.height(contenido.height());

            </script>		
    </body>
</html>
