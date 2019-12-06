<%@ page import="crm.Prospecto" 
import="crm.Empresa"
import="crm.Persona"
%>
<g:set var="generalService" bean="generalService" />
<%
   def mover=generalService.getMenuV(1)
   def mout=generalService.getMenuV(2)
   def estilo=generalService.getMenuV(3)
%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'prospecto.label', default: 'Prospecto')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>   
    <r:require module="filterpane" />
</head>

<body >
    <% def sw_crud=[1,1,1,1,0,0] 
      def xaccion=xaccion?:"index" 
     %>
    <g:set var="seguridadService" bean="seguridadService" />
    <div id="detalleconten">       
        <h3>${xtitulo}</h3>                  
        <hr style="margin-top:10px;margin-bottom:10px;">
        
         <%           
            def listaSucursales=Empresa.findAllByIdTipoEmpresaAndEliminado('empbase',0)        
         %>
    
        <filterpane:filterPane domain="Prospecto" 
        formName="frmFiltro"
        action="${xaccion}"
        showTitle="no"
        dialog="true"
        filterProperties="${['numProspecto','fechaApertura','nombreCliente','nombreContacto','nombreVendedor','idEstadoProspecto','numProspecto','idSucursal']}"                                    
        filterPropertyValues="${[fechaApertura:[years:2030..2000, precision:'day'],'idEstadoProspecto':[values:crm.ValorParametro.executeQuery('select valor from ValorParametro where idParametro=\'eprospecto\'')],'idSucursal':[values:listaSucursales]]}"        
        showSortPanel="false"
        fullAssociationPathFieldNames="false"
        />

        <%
def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/prospecto/index') 

%>
        <g:form  controller="prospecto" params="[titulo:xtitulo]" >
            <div class="pull-left">  
                <g:if test="${xcerrada=='N'}">

                    <g:if test="${'CREAR' in derechos}"> 
                         <!-- ojo no llamar con id se requiere idemp para compativbilizar llamado de edit -->
                        <a class="btn btn-mini btn-primary" href="/crm/prospecto/create">
                            <i class="icon-plus icon-white"></i>
                            <strong>Nuevo</strong>
                        </a>

                    </g:if> 
                </g:if> 
            </div>

            &nbsp;  

            <div class="btn-group" >

                <a class="btn btn-mini" href="#" style="height:21px;"><g:message code="acciones.label"/></a>
                <button class="btn btn-mini dropdown-toggle" style="height:23px;" data-toggle="dropdown"><span class="caret"></span></button>
                <%  def swacc=0 %>
                <ul class="dropdown-menu" role="menu">
                    <g:if test="${xcerrada=='N'}">
                        <g:if test="${'ASIGNAR_VENDEDOR' in derechos}">
                            <%  swacc=1 %>
                            <li><g:actionSubmit     
                                    onMouseOver="${mover}" 
                                    onMouseOut="${mout}" 
                                    style="${estilo}" 
                                    value="${message(code: 'asignarVendedor.prospecto.label', default: 'Asignar Vendedor')}" 
                                    action="asignarVendedor" /></li>
                            </g:if> 
                            <g:if test="${'DESCALIFICAR' in derechos}">
                                  <%  swacc=1 %>
                            <li><g:actionSubmit 
                                    onMouseOver="${mover}" 
                                    onMouseOut="${mout}" 
                                    style="${estilo}" 
                                    value="${message(code: 'descalificar.prospecto.label', default: 'Descalificar')}" 
                                    action="descalificar" /></li>
                            </g:if> 
                        </g:if> 
                        <g:if test="${'VER' in derechos}"> 
                         <%  swacc=1 %>
                        <li><a 
                              href="/crm/prospecto/indexp?sort=fechaApertura&order=desc"><g:message code="descalificados.prospecto.label" default="Ver Descalificados"/></a></li> 
                        </g:if>    
                      
                        <g:if test="${xcerrada=='S'}">
                            <g:if test="${'CALIFICAR' in derechos}">
                               <%  swacc=1 %>
                            <li><g:actionSubmit 
                                    onMouseOver="${mover}" 
                                    onMouseOut="${mout}" 
                                    style="${estilo}" 
                                    value="${message(code: 'calificar.prospecto.label', default: 'Calificar')}"
                                    action="calificar" /></li>
                            </g:if> 
                        </g:if> 
                        <g:if test="${xcerrada=='N'}">

                            <g:if test="${'CONVERTIR_OPORTUNIDAD' in derechos}">
                            <%  swacc=1 %>
                            <li><g:actionSubmit
                                    onMouseOver="${mover}" 
                                    onMouseOut="${mout}" 
                                    style="${estilo}" 
                                    value="${message(code: 'convertir.prospecto.label', default: 'Convertir en Oportunidad')}" 
                                    action="convertir"  /></li>
                            </g:if>
                            <!--<g:if test="${'IMPORTAR_PROSPECTOS' in derechos}">    
                             <%  swacc=1 %>
                            <li><a href="/crm/prospecto/importarProspectos"><g:message code="importar.prospecto.label" default="Importar Prospectos"/> </a></li>
                            </g:if>-->
                            <g:if test="${'BORRAR' in derechos}">
                              <%  swacc=1 %>
                            <li><a 
                              href="/crm/prospecto/listarBorrados?sort=fechaApertura&order=desc"><g:message code="borrados.prospecto.label" default="Ver Borrados"/></a></li> 
                            </g:if>
                           
                        </g:if> 
                        <g:if test="${'REVERTIR_CONVERSION' in derechos}"> 
                         <%  swacc=1 %>
                        <li><g:actionSubmit 
                                onMouseOver="${mover}" 
                                onMouseOut="${mout}" 
                                style="${estilo}" 
                                value="${message(code: 'revertir.prospecto.label', default: 'Revertir Conversión')}" 
                                action="revertirConversion"  /></li>
                        </g:if>
                        <g:if test="${'VER' in derechos}">
                            <%  swacc=1 %>
                             <li><a class="gris" href="/crm/prospecto/indexg?sort=fechaApertura&order=desc"><g:message code="verconvertidos.prospecto.label"/></a></li> 
                        </g:if>
                         <g:if test="${'EXPORTAR' in derechos}">  
                            <%  swacc=1 %>
                            <li class="dropdown-submenu">
                                <a  href="#"><g:message code="exportar.prospecto.label"/></a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <g:link action="exportarDatos" params="[tipo_export:'1',xaccionx:xaccion,titulo:xtitulo]"><g:message code="exportarTodos.prospecto.label"/></g:link>
                                    </li>
                                    <li><g:actionSubmit  
                                    onMouseOver="${mover}" 
                                    onMouseOut="${mout}" 
                                    style="${estilo}"  
                                    value="${message(code: 'exportarSeleccionados.prospecto.label', default: 'Seleccionados')}" 
                                    action="exportarDatos"
                                    params="[tipo_export:'2']" /></li>
                                                               
                                </ul>
                            </li> 
                            </g:if>
                         <g:if test="${swacc==0}" >
                            <li align="center">Ninguna </li>
                         </g:if>
                </ul>                                     
            </div>

           <!-- inicio filter  buttons -->                           
            <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="${g.message(code:'fp.tag.filterButton.text',default:'Filtrar lista')}" appliedText="Cambiar Filtro"/>
            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
            <!-- fin filter  buttons  -->
            <a  class="btn btn-mini" href="/crm/Prospecto/index?sort=fechaApertura&order=desc"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>

<!-- <g:if test="${flash.message}">                    
            
            <div role="status" style="font-weight:bold;color:#CC0000;margin:5px;">${flash.message}</div>
</g:if>-->

            <g:set var="beanInstance"  value="${prospectoInstance}" />                
            <g:render template="/general/mensajes" />

            <table class="table table-bordered table-condensed">
                <thead>
                    <tr >

                        <td style="width:14px;"> </td>

                        <g:sortableColumn Style="width:125px;" property="numProspecto" title="${message(code: 'prospecto.numProspecto.label', default: 'Código')}" params="${filterParams}" />            

                        <g:sortableColumn property="nombreCliente" title="${message(code: 'prospecto.nombreCliente.label', default: 'Empresa')}"  params="${filterParams}"/>

                        <g:sortableColumn property="nombreProspecto" title="${message(code: 'prospecto.nombreProspecto.label', default: 'Proyecto')}" params="${filterParams}" />

                        <g:sortableColumn property="nombreContacto" title="${message(code: 'prospecto.Contacto.label', default: 'Contacto')}"  params="${filterParams}"/>

                        <g:sortableColumn property="valorProspecto" title="${message(code: 'prospecto.valorProspecto.label', default: 'Valor')}"  params="${filterParams}"/>

                        <g:sortableColumn property="nombreVendedor" title="${message(code: 'prospecto.idVendedor.label', default: 'Vendedor')}"  params="${filterParams}"/>								

                        <g:sortableColumn property="fechaApertura" title="${message(code: 'prospecto.fechaApertura.label', default: 'Fecha Apertura')}"  params="${filterParams}"/>

                      <%--  <g:sortableColumn property="fechaCierreEstimada" title="${message(code: 'prospecto.fechaCierreEstimada.label', default: 'Cierre Estimado')}"  params="${filterParams}"/> --%>

                        <g:sortableColumn property="idEstadoProspecto" title="${message(code: 'prospecto.IdEstadoProspecto.label', default: 'Estado')}" params="${filterParams}" />

                    </tr>
                </thead>
                <tbody>
                    <%  i=0 %>
                    <g:each in="${prospectoInstanceList}" status="i" var="prospectoInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td style="vertical-align: middle"><g:checkBox name="prospectos" value="${prospectoInstance.id}" checked="false" /></td>
                            <td style="vertical-align: middle">
                                <a   style="text-decoration:underline" href="/crm/prospecto/show/${prospectoInstance.id}" >
                                    ${fieldValue(bean: prospectoInstance, field: "numProspecto")}
                                </a>
                            </td>

                            <td style="vertical-align: middle">${prospectoInstance?.nombreCliente}</td>

                            <td style="vertical-align: middle"> ${fieldValue(bean: prospectoInstance, field: "nombreProspecto")}</td>

                            <td style="vertical-align: middle">${prospectoInstance?.nombreContacto}</td>                            

                            <td style="text-align:right;vertical-align: middle">${fieldValue(bean:prospectoInstance,field:"valorProspecto")}</td>

                            <td style="vertical-align: middle">${prospectoInstance?.nombreVendedor}</td>

                            <td style="vertical-align: middle"><g:formatDate format="dd-MM-yyyy" date="${prospectoInstance?.fechaApertura}" /></td>

                          <%--  <td><g:formatDate format="dd-MM-yyyy" date="${prospectoInstance?.fechaCierreEstimada}" /></td> --%>
                          <g:if test="${!(prospectoInstance?.idEstadoProspecto in ['propasopox','prodescalx']) && prospectoInstance?.evolucion!=null}" >
                           <td style="text-align:center;vertical-align: middle">
                               <img src="/crm/images/${generalService.mostrarIcono(prospectoInstance?.evolucion,0)}" 
                                  title="${generalService.mostrarIcono(prospectoInstance?.evolucion,1)}">
                           </td>                                              
                          </g:if>
                          <g:else>
                            <td style="text-align:center;vertical-align: middle" >${generalService.getValorParametro(prospectoInstance?.idEstadoProspecto)}</td>                                              
                          </g:else>
                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination_crm">
                <filterpane:paginate total="${prospectoInstanceCount ?: 0}" domainBean="Prospecto"/>
            </div>
        </div>  
        <g:hiddenField name="xempresa"  value="${params.id}"/>

    </g:form>
    <script>                    
                 <!-- resize el padre del iframe --> 
        var contenido= $("#detalleconten");                       
        if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+60);   

    </script>
</body>
</html>
