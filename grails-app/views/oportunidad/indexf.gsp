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

        <g:render template="../general/infoEmpleadoQ" />

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
                            <strong> Nuevos documentos</strong>
                        </a>

                    </g:if>  
                </div>
            </g:if>
            &nbsp;
            <div class="btn-group">

                <a href="#" class="btn btn-mini" >Acciones</a>
                <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                <ul class="dropdown-menu">
                    <g:if test="${xcerrada=='N'}">
                        <g:if test="${'ASIGNAR_VENDEDOR' in derechos}">
                            <li>
                                <g:actionSubmit 
                                onMouseOver="${mover}" 
                                onMouseOut="${mout}" 
                                style="${estilo}" 
                                    value="Cambiar Vendedor" 
                                    action="asignarVendedor" /></li>                           
                            </g:if>

                            <g:if test="${'CERRAR_OPORTUNIDAD' in derechos}">                
                            <li><g:actionSubmit 
                                onMouseOver="${mover}" 
                                onMouseOut="${mout}" 
                                style="${estilo}" 
                                    value="Cerrar Oportunidad"     
                                    action="cerrarOportunidad" /></li>                            
                            </g:if>

                            <g:if test="${'LISTAR_GANADAS' in derechos}">
                            <li><a   href="/crm/oportunidad/listarGanadas?sort=fechaApertura&order=desc">Oportunidades Ganadas</a></li> 
                            </g:if> 

                            <g:if test="${'LISTAR_PERDIDAS' in derechos}">
                            <li><a   href="/crm/oportunidad/listarPerdidas?sort=fechaApertura&order=desc">Oportunidades Perdidas</a></li>               
                            </g:if>

                           <%-- <g:if test="${'GENERAR_PEDIDO' in derechos}">                       
                            <li><g:actionSubmit onMouseOut="this.style.backgroundColor='#fff'" 
                                    onMouseOver="this.style.backgroundColor='#eee'" 
                                    style="border:none;background-color:#fff;" 
                                    value=" Generar Pedido" 
                                    action="generarPedido" /></li> 
                            </g:if> --%>

                            <g:if test="${'BORRAR' in derechos}">                       
                            <li><a   href="/crm/oportunidad/listarBorrados">Ver Borrados</a></li> 
                            </g:if>
                            <g:if test="${'DESTRUIR' in derechos}">                              
                            <li><a   href="/crm/oportunidad/delete">Destruir Oportunidad</a></li> 
                            </g:if>
                            <g:if test="${'EXPORTAR' in derechos}">                              
                            <li><a   href="/crm/oportunidad/exportar/excel">Exportar a Excel</a></li> 
                            </g:if>
                        </g:if>

                        <g:if test="${'ABRIR_OPORTUNIDAD' in derechos}">                
                        <li><g:actionSubmit 
                            onMouseOver="${mover}" 
                            onMouseOut="${mout}" 
                            style="${estilo}" 
                                value=" Abrir Oportunidad" 
                                action="abrirOportunidad" /></li>                            
                        </g:if>
                        <g:if test="${'VER' in derechos}">                              
                        <li><a   href="/crm/oportunidad/indexh">Ver Archivadas</a></li> 
                        </g:if>

                </ul>
            </div>
             
        <!--
            <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>                           
            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
         -->  

            <a  class="btn btn-mini" href="/crm/oportunidad/index?sort=fechaApertura&order=desc"><i class="icon-remove"></i>&nbsp;Cancelar</a>
            
            <g:set var="beanInstance"  value="${oportunidadInstance}" />                
            <g:render template="/general/mensajes" />

            <table class="table table-bordered">
                <tbody>
                 <!-- Start: Listado de oportunidades  -->
                <div class="box">
                    <!--div class="box-header"><i class="fa-icon-list-ul"></i><span class="break"></span>LISTADO DE OPORTUNIDADES</div-->

                       <g:each in="${nodos}" status="i" var="nodo1">
                        <div class="box-content-tabla">
                            <dl>                              
                                <dt class="margin-bottom">
                                <a  id="${nodo1?.id}" data-url="${createLink(controller: 'oportunidad', action: 'traerNodo1', params:[orden:'idSucursal',campoFiltro1:'trimestre', campoFiltro2:'',campoFiltro3:'', categoria:'idSucursal', idGuardar:'idSucursal', plantilla:'2', ultimoNodo:'No'])}" nodo="2" class="empresa" href="#${nodo1?.id}_container" data-toggle="collapse">
                                    <i class="fa-icon-caret-right margin-right"></i>${nodo1.label}
                                </a>
                                <div id="${nodo1?.id}_container" >
                                </div>
                      
                            </dl>
                        </div>
                       
                    </g:each>
                </div>
             <!-- End: Fin listado de oportunidades  -->   
            </tbody>
            </table>
          
            </div>                     
    </g:form>
   
</body>
</html>