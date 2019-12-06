<%@ page import="crm.Oportunidad" 
import="crm.Empresa"
import="crm.Persona"
%>
%{--Use generalService--}%
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
</head>

<body >
     <g:set var="seguridadService" bean="seguridadService" />
    <% def sw_crud=[1,1,1,1,0,0] 
       def lista3=Empresa.findAllByIdTipoEmpresaAndEliminado('empbase',0)   
         if (!xaccion)
                  xaccion="index"
     %>

    <div id="detalleconten">           

        <h2>${xtitulo}</h2>

        <hr style="margin-top:10px;margin-bottom:10px;">                           
        <filterpane:filterPane domain="Oportunidad" 
        formName="frmFiltro"
        action="listarPerdidas"
        showTitle="no"
        dialog="true"
        filterProperties="${['numOportunidad','nombreOportunidad','nombreCliente','nombreContacto','nombreVendedor','idEstadoOportunidad','numOportunidadFabricante','trimestre','idSucursal']}"      
        filterPropertyValues="${['idEstadoOportunidad':[values:crm.ValorParametro.executeQuery('select valor from ValorParametro where idParametro=\'eoportunid\'')],'idSucursal':[values:lista3]]}"
        showSortPanel="false"
        fullAssociationPathFieldNames="false"
        />
        <%
             def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/oportunidad/index') 
             
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
            <div class="btn-group">

                <a href="#" class="btn btn-mini" ><g:message code="acciones.label"/></a>
                <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                <ul class="dropdown-menu">
                    <g:if test="${xcerrada=='N'}">
                        <g:if test="${'ASIGNAR_VENDEDOR' in derechos}">
                            <li>
                                <g:actionSubmit onMouseOut="this.style.backgroundColor='#fff'" 
                                    onMouseOver="this.style.backgroundColor='#eee'" 
                                    style="border:none;background-color:#fff;" 
                                    value="Cambiar Vendedor" 
                                    action="asignarVendedor" /></li>                           
                            </g:if>

                            <g:if test="${'CERRAR_OPORTUNIDAD' in derechos}">                
                            <li><g:actionSubmit onMouseOut="this.style.backgroundColor='#fff'" 
                                    onMouseOver="this.style.backgroundColor='#eee'" 
                                    style="border:none;background-color:#fff;" 
                                    value="Cerrar Oportunidad" 
                                    action="cerrarOportunidad" /></li>                            
                            </g:if>

                            <g:if test="${'LISTAR_GANADAS' in derechos}">
                            <li><a  class="gris" href="/crm/oportunidad/listarGanadas?sort=fechaApertura&order=desc">Oportunidades Ganadas</a></li> 
                            </g:if> 

                            <g:if test="${'LISTAR_PERDIDAS' in derechos}">
                            <li><a  class="gris" href="/crm/oportunidad/listarPerdidas?sort=fechaApertura&order=desc">Oportunidades Perdidas</a></li>               
                            </g:if>

                           <%-- <g:if test="${'GENERAR_PEDIDO' in derechos}">                       
                            <li><g:actionSubmit onMouseOut="this.style.backgroundColor='#fff'" 
                                    onMouseOver="this.style.backgroundColor='#eee'" 
                                    style="border:none;background-color:#fff;" 
                                    value="Generar Pedido" 
                                    action="generarPedido" /></li> 
                            </g:if> --%>

                            <g:if test="${'BORRAR' in derechos}">                       
                            <li><a  class="gris" href="/crm/oportunidad/listarBorrados">Ver Borrados</a></li> 
                            </g:if>
                            <g:if test="${'DESTRUIR' in derechos}">                              
                            <li><a  class="gris" href="/crm/oportunidad/delete">Destruir Oportunidad</a></li> 
                            </g:if>
                            <g:if test="${'EXPORTAR' in derechos}"> 

                            <li class="dropdown-submenu">
                                <a  href="#">Exportar</a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <g:link action="exportarDatos"  params="[tipo_export:'1',xaccionx:xaccion,titulo:xtitulo]">Todos</g:link>
                                    </li>
                                    <li><g:actionSubmit  
                                    onMouseOver="${mover}" 
                                    onMouseOut="${mout}" 
                                    style="${estilo}"  
                                    value="Seleccionados" 
                                    action="exportarDatos"
                                    params="[tipo_export:'2']" /></li>
                                                               
                                </ul>
                            </li> 
                       </g:if>
                        </g:if>

                        <g:if test="${'ABRIR_OPORTUNIDAD' in derechos}">                
                        <li><g:actionSubmit onMouseOut="this.style.backgroundColor='#fff'" 
                                onMouseOver="this.style.backgroundColor='#eee'" 
                                style="border:none;background-color:#fff;" 
                                value="${message(code: 'abrir.oportunidad.label', default: 'Abrir Oportunidad')}" 
                                action="abrirOportunidad" /></li>                            
                        </g:if>
                        <g:if test="${'VER' in derechos}">                              
                            <li><a  class="gris" href="/crm/oportunidad/indexh"><g:message code="archivadas.oportunidad.label"/></a></li> 
                        </g:if>
            <g:if test="${'EXPORTAR' in derechos}">

                <li class="dropdown-submenu">
                    <a  href="#">Exportar</a>
                    <ul class="dropdown-menu">
                        <li>
                            <g:link action="exportarDatos"  params="[tipo_export:'1',xaccionx:xaccion,titulo:xtitulo]">Todos</g:link>
                        </li>
                        <li><g:actionSubmit
                                onMouseOver="${mover}"
                                onMouseOut="${mout}"
                                style="${estilo}"
                                value="Seleccionados"
                                action="exportarDatos"
                                params="[tipo_export:'2']" />
                        </li>

                    </ul>
                </li>
            </g:if>
                    
            </ul>
        </div>

    <!-- inicio filter  buttons -->                           
        <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="${g.message(code:'fp.tag.filterButton.text',default:'Filtrar lista')}" appliedText="Cambiar Filtro"/>                           
        <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
        <!-- fin filter  buttons  -->

        <a  class="btn btn-mini" href="/crm/oportunidad/index?sort=fechaApertura&order=desc"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>

        <g:set var="beanInstance"  value="${oportunidadInstance}" />                
        <g:render template="/general/mensajes" />

        <table class="table table-bordered">
            <thead>
                <tr>
                    <td style="width:18px"> </td>
                    <g:sortableColumn property="numOportunidad" title="${message(code: 'oportunidad.numOportunidad.label', default: 'Nro.')}" params="${filterParams}" />
                    <g:sortableColumn property="nombreCliente" title="${message(code: 'nombre.cliente.label', default: 'Empresa')}" params="${filterParams}"/>
                    <g:sortableColumn property="nombreOportunidad" title="${message(code: 'oportunidad.nombreOportunidad.label', default: 'Proyecto')}" params="${filterParams}"/>                 
                    <g:sortableColumn property="valorOportunidad" title="${message(code: 'oportunidad.valorOportunidad.label', default: 'Valor')}" params="${filterParams}"/>
                    <g:sortableColumn property="nombreVendedor" title="${message(code: 'oportunidad.nombreVendedor.label', default: 'Vendedor')}" params="${filterParams}"/>
                    <g:sortableColumn property="fechaCierreReal" title="${message(code: 'oportunidad.fechaCierreReal.label', default: 'Fecha Cierre')}" params="${filterParams}"/>
                    <g:sortableColumn property="trimestre" title="${message(code: 'oportunidad.trimestre.label', default: 'Q')}" params="${filterParams}"/>
                     <g:sortableColumn property="idMotivoPerdida" title="${message(code: 'oportunidad.idMotivoPerdida.label', default: 'Motivo Perdida')}" params="${filterParams}"/>
                </tr>
            </thead>
            <tbody>
                <g:each in="${oportunidadInstanceList}" status="i" var="oportunidadInstance">

                    <tr  class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td><g:checkBox name="oportunidades" value="${oportunidadInstance.id}" checked="false" /></td>

                        <td Style="width:93px">
                            <g:link action="show" style="text-decoration:underline;" id="${oportunidadInstance.id}" params="[sw:0]">
                                ${oportunidadInstance?.numOportunidad}</g:link>
                            </td>

                        <td>${oportunidadInstance?.nombreCliente}</td>

                        <td>${fieldValue(bean:oportunidadInstance,field:"nombreOportunidad")}</td>                      

                        <td style="text-align:right">${fieldValue(bean:oportunidadInstance,field:"valorOportunidad")}</td>

                        <td>${oportunidadInstance?.nombreVendedor}</td>

                        <td><g:formatDate format="dd-MM-yyyy" date="${oportunidadInstance?.fechaCierreReal}" /></td>                                         

                        <td>${fieldValue(bean:oportunidadInstance,field:"trimestre")} </td> 
                        
                        <td>${generalService.getValorParametro(oportunidadInstance?.idMotivoPerdida)}</td> 
                    </tr>
                </g:each>
            </tbody>
        </table>
        <div class="pagination_crm">
            <filterpane:paginate total="${oportunidadInstanceCount ?: 0}" domainBean="Oportunidad"/>
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
