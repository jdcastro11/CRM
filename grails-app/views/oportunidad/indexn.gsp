<%@ page import="crm.Oportunidad" 
import="crm.Empresa"
import="crm.Persona"
%>
%{--Use generalindeService--}%
<g:set var="generalService" bean="generalService" />
<g:set var="oportunidadService" bean="oportunidadService" />
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'Oportunidad')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
    <style TYPE="text/css"> 
        a.gris:link{fon-size:13px !important;}
        a.gris:hover{background:#eee !important;color:#000 !important}
    </style>
    <export:resource />
    
     <g:javascript src="funcionesVistasCategorizadas.js"/>
</head>

<body >
    <g:set var="seguridadService" bean="seguridadService" />
    <% def sw_crud=[1,1,1,1,0,0]  %>

    <div id="detalleconten">           

        <h2>${xtitulo}</h2>

        <hr style="margin-top:10px;margin-bottom:10px;">   
        <!--COMENTADO MIENTRAS SE ACTIVA EL PANEL DE CONTROL  -->
        <!--g:render template="../general/infoEmpleadoQ" /-->

        <%  def lista2=['10%','25%','50%'] 
def lista1=generalService.getValoresParametro('fabricante')
        %>

        <filterpane:filterPane domain="Oportunidad" 
        formName="frmFiltro"
        action="index"
        showTitle="no"
        dialog="true"
        filterProperties="${['numOportunidad','nombreOportunidad','nombreCliente','nombreContacto','nombreVendedor','numOportunidadFabricante','trimestre','idEtapa','idFabricante']}"      
        filterPropertyValues="${['idEtapa':[values:lista2],'idFabricante':[values:lista1]]}"
        showSortPanel="false"
        fullAssociationPathFieldNames="false"
        />
        <%
def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/oportunidad/index') 
/*println "derechos=${derechos}"*/
        %>
        <%
         def mover=generalService.getMenuV(1)
         def mout=generalService.getMenuV(2)
         def estilo=generalService.getMenuV(3)
        %>

        <g:form id="frmoport" controller="Oportunidad" >
          
            <g:if test="${xcerrada=='N'}">
                <div class="pull-left">
                    <g:if test="${'CREAR' in derechos}">                                        
                        <a class="btn btn-mini btn-primary" href="/crm/oportunidad/create/?sw=1">
                            <i class="icon-plus icon-white"></i>
                            <strong><g:message code="default.new.label"/></strong>
                        </a>

                    </g:if>  
                </div>
            </g:if>
            &nbsp;
            <div class="btn-group">

                <a href="#" class="btn btn-mini" ><g:message code="acciones.label"/></a>
                <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                <%  def swacc=0 %>
                <ul class="dropdown-menu">
                    <g:if test="${xcerrada=='N'}">
                        <g:if test="${'ASIGNAR_VENDEDOR' in derechos}">
                            <%  swacc=1 %>
                            <li>
                                <g:actionSubmit 
                                    onMouseOver="${mover}" 
                                    onMouseOut="${mout}" 
                                    style="${estilo}" 
                                    value="${message(code: 'cambiarVendedor.oppty.label')}" 
                                    action="asignarVendedor" /></li>                           
                            </g:if>
 
                            <g:if test="${'CERRAR_OPORTUNIDAD' in derechos}"> 
                               <%  swacc=1 %>
                            <li><g:actionSubmit 
                                    onMouseOver="${mover}" 
                                    onMouseOut="${mout}" 
                                    style="${estilo}" 
                                    value="${message(code: 'cerrarOportunidad.oppty.label')}"   
                                    action="cerrarOportunidad" /></li>                            
                            </g:if>

                            <g:if test="${'LISTAR_GANADAS' in derechos}">
                              <%  swacc=1 %>
                              <li><a href="/crm/oportunidad/listarGanadas?sort=fechaApertura&order=desc"><g:message code="ganadas.oppty.label"/></a></li> 
                            </g:if> 

                            <g:if test="${'LISTAR_PERDIDAS' in derechos}">
                                 <%  swacc=1 %>
                            <li><a   href="/crm/oportunidad/listarPerdidas?sort=fechaApertura&order=desc"><g:message code="perdidas.oppty.label"/></a></li>               
                            </g:if>

                           <%-- <g:if test="${'GENERAR_PEDIDO' in derechos}">                       
                            <li><g:actionSubmit onMouseOut="this.style.backgroundColor='#fff'" 
                                    onMouseOver="this.style.backgroundColor='#eee'" 
                                    style="border:none;background-color:#fff;" 
                                    value=" Generar Pedido" 
                                    action="generarPedido" /></li> 
                            </g:if> --%>

                            <g:if test="${'BORRAR' in derechos}">  
                                <%  swacc=1 %>
                            <li><a   href="/crm/oportunidad/listarBorrados"><g:message code="borrados.label"/></a></li> 
                            </g:if>
                            <g:if test="${'DESTRUIR' in derechos}">  
                                <%  swacc=1 %>
                            <li><a   href="/crm/oportunidad/delete">Destruir Oportunidad</a></li> 
                            </g:if>

                            <g:if test="${'EXPORTAR' in derechos}">                              
                            <li><a   href="/crm/oportunidad/exportar/excel"><g:message code="exportar.excel.label"/></a></li> 
                            </g:if>
                        </g:if>
						<g:if test="${'ABRIR_OPORTUNIDAD' in derechos}">   
                            <%  swacc=1 %>
                        <li><g:actionSubmit 
                                onMouseOver="${mover}" 
                                onMouseOut="${mout}" 
                                style="${estilo}" 
                                value="${message(code: 'abrir.oportunidad.label')}" 
                                action="abrirOportunidad" /></li>                            
                        </g:if>
                        <g:if test="${'VER' in derechos}">   
                            <%  swacc=1 %>
                            <li><a   href="/crm/oportunidad/indexh"><g:message code="archivadas.oportunidad.label"/></a></li> 
                        </g:if>

                </ul>
            </div>
             
        <!--
            <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>                           
            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
         -->  

            <a  class="btn btn-mini" href="/crm/oportunidad/index?sort=fechaApertura&order=desc"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>
            
            <g:set var="beanInstance"  value="${oportunidadInstance}" />                
            <g:render template="/general/mensajes" />

            <table class="table table-bordered">
                <tbody>
                 <!-- Start: Listado de oportunidades  -->
                <div class="box">
                    <!--div class="box-header"><i class="fa-icon-list-ul"></i><span class="break"></span>LISTADO DE OPORTUNIDADES</div-->

                       <g:each in="${empresaOportunidad}" status="i" var="oportunidad">
                        <div class="box-content-tabla">
                            <dl>                              
                                <dt class="margin-bottom">
                                <a  id="${oportunidad?.id}" data-url="${createLink(controller: 'oportunidad', action: 'buscarListadoRegistros')}" nodo="1" class="empresa" href="#${oportunidad?.id}_container" data-toggle="collapse">
                                    <i class="fa-icon-caret-right margin-right"></i>${oportunidad.label}
                                </a>
                                  <div id="${oportunidad?.id}_container" >
                                </div>
                      
                            </dl>
                        </div>
                       
                    </g:each>
                </div>
             <!-- End: Fin listado de oportunidades  -->   
            </tbody>
            </table>
            <!-- -->
                <div class="pagination_crm">     
                       <g:paginate 
                         controller="oportunidad"
                         action= "indexn" total="${oportunidadInstanceCount}"/>
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