
<%@ page import="crm.Propuesta" %>
<%@ page import="crm.Persona" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="seguridadService" bean="seguridadService" />
<%
   def mover=generalService.getMenuV(1)
   def mout=generalService.getMenuV(2)
   def estilo=generalService.getMenuV(3)
%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'propuesta.label', default: 'Propuesta')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <% def sw_crud=[1,1,1,1,0,0] %>
          <%
             def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/propuesta/index') 
            
           %>
        <div id="boxprop">
            <div id="list-propuesta" class="content scaffold-list" role="main">

                <h2 style="margin-top:0px">${xtitulo}</h2>
                <hr style="margin-top:10px;margin-bottom:10px;">


                <div class="row-fluid sortable"> 
                    <g:form controller="propuesta"  id="${params.id}" >
                        <g:if test="${xcerrada=='N'}">
                            <div class="pull-left">
                                <div class="pull-left">
                                    <g:if test="${'CREAR' in seguridadService.operacionesPorOpcion(session['idUsuario'],'/propuesta/index')}">

                                        <a class="btn btn-mini btn-primary" href="/crm/propuesta/create/?idpos=${params.id}&idemp=${xidempresa}">
                                            <i class="icon-plus icon-white"></i>
                                            <strong><g:message code="default.new.label"/> </strong>
                                        </a>

                                    </g:if>
                                </div>
                            </div>
                            &nbsp;
                            <div class="btn-group">

                                <a href="#" class="btn btn-mini" ><g:message code="acciones.label"/></a>
                                <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                                <%  def swacc=0 %>
                                <ul class="dropdown-menu">
                                  <g:if test="${'PROPUESTA_FINAL' in derechos }">
                                        <%  swacc=1 %>
                                    <li><g:actionSubmit 
                                     onMouseOver="${mover}" 
                                    onMouseOut="${mout}" 
                                    style="${estilo}" 
                                    value="${message(code: 'propuesta.final.label')}" 
                                    action="propuestaFinal" /></li>
                                   </g:if>
                                  <g:if test="${'PROPUESTA_NORMAL' in derechos }">
                                        <%  swacc=1 %>
                                     <li><g:actionSubmit 
                                          onMouseOver="${mover}" 
                                          onMouseOut="${mout}" 
                                          style="${estilo}" 
                                          value="${message(code: 'propuesta.normal.label')}" 
                                          action="propuestaNormal" /></li>
                                   </g:if> 
                                    <g:if test="${'BORRAR' in derechos}">
                                          <%  swacc=1 %>
                                        <li><a href="/crm/propuesta/listarBorrados/${params.id}?idemp=${xidempresa}" ><g:message code="borrados.label"/></a></li>
                                        </g:if>
                                    <g:if test="${swacc==0}" >
                                            <li align="center">Ninguna </li>
                                     </g:if>
                                </ul>
                              
                            </div>
                            &nbsp;
                        </g:if>
                        <a  class="btn btn-mini" href="/crm/propuesta/index/${params.id}?idemp=${xidempresa}"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>

                        <g:set var="beanInstance"  value="${propuestaInstance}" />  
                        &nbsp;              
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

                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${propuestaInstanceList}" status="i" var="propuestaInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td><g:checkBox name="propuestas" value="${propuestaInstance.id}" checked="false" /></td>

                                        <td><a action="show" style="text-decoration: underline;"
                                            href="/crm/propuesta/show/${propuestaInstance.id}?idpos=${params.id}&idemp=${xidempresa}&swc=0">
                                            ${fieldValue(bean: propuestaInstance, field: "numPropuesta")}
                                            </a>
                                            <g:if test="${propuestaInstance?.idEstadoPropuesta=='propfinal'}" >&nbsp;
                                            <i class="fa-icon-trophy" style="font-size:1.2em;"></i>
                                            </g:if>
                                        </td>

                                        <td><g:formatDate format="dd-MM-yyyy" date="${propuestaInstance?.fecha}" /></td>

                                        <td>${propuestaInstance?.empleado?.nombreCompleto()}</td>

                                        <td>${propuestaInstance?.persona?.nombreCompleto()}</td>

                                        <td style="text-align:right;">${formatNumber(number:fieldValue(bean: propuestaInstance, field: "valor"),format:'###,###,##0', locale:'co')}</td>

                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                        <div class="pagination_crm">
                            <g:paginate id="${params.id}" total="${propuestaInstanceCount ?: 0}" />
                        </div>
                    </g:form>
                </div>
            </div>  <!-- fin content-scaffold-list !-->
        </div>  <!-- fin boxprop !-->
        <script language="javascript">
            var contenido= $("#boxprop");
            if (parent.IFRAME_PROPUESTA !=null) parent.IFRAME_PROPUESTA.height(contenido.height()+120);

        </script>
    </body>
</html>
