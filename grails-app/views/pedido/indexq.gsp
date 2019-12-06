<%@ page import="crm.Pedido" %>
<%@ page import="crm.Empresa" %>


<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'pedido.label', default: 'Pedido')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
     <g:javascript src="funcionesVistasCategorizadas.js"/>
</head>
<body>
    <g:set var="generalService" bean="generalService" />
    <%
   def mover=generalService.getMenuV(1)
   def mout=generalService.getMenuV(2)
   def estilo=generalService.getMenuV(3)
    %>
    <g:set var="pedidoService" bean="pedidoService" />
    <% def sw_crud=[1,1,1,1,0,0] %>
     <g:set var="seguridadService" bean="seguridadService" />
    <h2>${xtitulo}</h2>

    <hr style="margin-top:10px;margin-bottom:10px;">	
    <filterpane:filterPane domain="Pedido" 
    formName="frmFiltro"
    action="index"
    showTitle="no"
    dialog="true"
    filterProperties="${['numPedido', 'nombreCliente','nombrecontacto','nombreVendedor','idEstadoPedido', 'fechaApertura','ordenCompra']}"   
    filterPropertyValues="${[fechaApertura:[years:2030..2000, precision:'day'],'idEstadoPedido':[values:crm.ValorParametro.executeQuery('select valor from ValorParametro where idParametro=\'estapedido\'')]]}"
    showSortPanel="false"
    fullAssociationPathFieldNames="false"
    />                                               
    <%
             def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/pedido/index') 
            
     %>
    <div class="row-fluid sortable">
        <g:form controller="Pedido" >

            <div class="pull-left">
                <div class="pull-left">
                    <g:if test="${'CREAR' in derechos}">
                        <a class="btn btn-mini btn-primary" href="/crm/pedido/create">
                            <i class="icon-plus icon-white"></i>
                            <strong> Nuevo</strong>
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

                    <g:if test="${'CAMBIAR_DESTINATARIO_FACTURA' in derechos}">
                          <%  swacc=1 %>
                        <li><g:actionSubmit 
                              onMouseOver="${mover}" 
                              onMouseOut="${mout}" 
                              style="${estilo}" 
                                value="Cambiar Dest. Factura" action="cambiarDestinatarioFactura" />
                        </li>
                    </g:if>
                    <g:if test="${'CAMBIAR_ESTADO_PEDIDO' in derechos}">
                          <%  swacc=1 %>
                        <li><g:actionSubmit 
                              onMouseOver="${mover}" 
                              onMouseOut="${mout}" 
                              style="${estilo}" 
                              value="Cambiar Estado Pedido "
                              action="cambiarEstadoPedido" />
                        </li>
                    </g:if>

                    <g:if test="${'CAMBIAR_OPORTUNIDAD' in derechos}">
                          <%  swacc=1 %>
                        <li><g:actionSubmit 
                                onMouseOver="${mover}" 
                                onMouseOut="${mout}" 
                                style="${estilo}" 
                                value="Cambiar Oportunidad " 
                                action="cambiarOportunidad" />
                        </li>
                    </g:if>
                    <g:if test="${'CAMBIAR_VENDEDOR' in derechos}">
                          <%  swacc=1 %>
                        <li><g:actionSubmit 
                                onMouseOver="${mover}" 
                                onMouseOut="${mout}" 
                                style="${estilo}" 
                                value="Cambiar Vendedor" 
                                action="cambiarVendedor" />
                        </li>
                    </g:if>
                    <g:if test="${'APLICAR_DESCUENTO' in derechos}">
                          <%  swacc=1 %>
                        <li><g:actionSubmit 
                                onMouseOver="${mover}" 
                                onMouseOut="${mout}" 
                                style="${estilo}" 
                                value="Aplicar Descuento" 
                                action="aplicarDescuento" />
                        </li>
                    </g:if>
                     <g:if test="${'MOVER_PEDIDO' in derechos}">
                           <%  swacc=1 %>
                        <li><g:actionSubmit 
                              onMouseOver="${mover}" 
                              onMouseOut="${mout}" 
                              style="${estilo}" 
                              value="Mover Pedido" 
                              action="moverPedido" />
                        </li>
                    </g:if>
                    
                    <g:if test="${'VER' in derechos}">
                          <%  swacc=1 %>
                        <li><a  class="gris" href="/crm/pedido/index?sort=fechaApertura&order=desc&estado=pedfacturx">Ver Facturados</a></li> 
                    </g:if> 
                        
                   <g:if test="${'VER' in derechos}">
                         <%  swacc=1 %>
                        <li><a  class="gris" href="/crm/pedido/index?sort=fechaApertura&order=desc&estado=pedanuladx">Ver Anulados</a></li> 
                        </g:if> 
                        <g:if test="${'ANULAR_PEDIDO' in derechos}">
                           <%  swacc=1 %>
                        <li><g:actionSubmit 
                              onMouseOver="${mover}" 
                               onMouseOut="${mout}" 
                               style="${estilo}" 
                               value="Anular Pedido" 
                               action="anularPedido" />
                        </li>
                    </g:if>
                    <g:if test="${sw_crud[4]==1}">
                        <li><a href="${createLink(action:'eliminar')}" >Eliminar</a></li>
                        </g:if>
                        <g:if test="${'BORRAR' in derechos}">
                          <%  swacc=1 %>
                        <li><a href="${createLink(action:'listarBorrados')}" >Ver Borrados</a></li>
                        </g:if>
                     <g:if test="${swacc==0}" >
                        <li align="center">Ninguna </li>
                    </g:if>
                </ul>
            </div>
          <!-- inicio filter  buttons                          
            <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>
            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered> 
          <!-- fin filter  buttons  -->
              
            &nbsp; <a  class="btn btn-mini" href="/crm/pedido/index/?sort=fechaApertura&order=desc&estado=${params.estado}"><i class="icon-remove"></i>&nbsp;Cancelar</a>

            <div id="list-pedido" class="content scaffold-list" role="main">

                <g:set var="beanInstance"  value="${pedidoInstance}" />                
                <g:render template="/general/mensajes" />
               
                <table  class="table table-bordered">
                   <g:each in="${nodo}" status="i" var="pedido">
                        <div class="box-content-tabla">
                            <dl>                              
                                <dt class="margin-bottom">
                                <a  id="${pedido?.id}" data-url="${createLink(controller: 'pedido', action: 'buscarListadoRegistros', params:[mostrar:'pedidoXq'] )}" nodo="1" class="empresa" href="#${pedido?.id}_container" data-toggle="collapse">
                                    <i class="fa-icon-caret-right margin-right"></i>${pedido.label}
                                </a>
                                
                                  <div id="${pedido?.id}_container" >
                                </div>
                      
                            </dl>
                        </div>
                       
                    </g:each>
                    
                    
                </table>
                <!--div class="pagination_crm">
                    <filterpane:paginate total="${pedidoInstanceCount ?: 0}" domainBean="Pedido"/>
                </div-->
            </div>
        </div>
    </g:form>
</body>
</html>