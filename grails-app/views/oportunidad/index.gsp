<%@ page import="crm.Oportunidad" 
import="crm.Empresa"
import="crm.Persona"
import="crm.Estrategia"
%>

<g:set var="generalService" bean="generalService" />
<g:set var="oportunidadService" bean="oportunidadService" />
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'Oportunidad')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    <r:require module="filterpane" />
    <style type="text/css"> 
        a.gris:link{font-size:13px !important;}
        a.gris:hover{background:#eee !important;color:#000 !important}
    </style>
    <export:resource />
</head>

<body >
     <g:set var="seguridadService" bean="seguridadService" />
    <% def sw_crud=[1,1,1,1,0,0]  %>

    <div id="detalleconten">           

        <h2>${xtitulo}.</h2>

        <hr style="margin-top:10px;margin-bottom:10px;">   
         
        <%  def lista2=['10%','25%','50%'] 
            def lista1=generalService.getValoresParametro('fabricante')
			def listaEstrategias=crm.Estrategia.findAllByIdEstadoEstrategiaAndEliminado('genactivo',0)
			def listaTacticas=generalService.getValoresParametro('tpoactmerc')
            def lista3=Empresa.findAllByIdTipoEmpresaAndEliminado('empbase',0)          
            if (!xaccion)  xaccion="index"
         %>
         
        <filterpane:filterPane domain="Oportunidad" 
        formName="frmFiltro"
        action="${xaccion}"
        showTitle="no"
        dialog="true"
        filterProperties="${['numOportunidad', 'nombreCliente','nombreContacto','nombreVendedor','numOportunidadFabricante','idEtapa','idFabricante','idSucursal', 'propuesta','estrategiaId','trimestre']}"       
        filterPropertyValues="${['idEtapa':[values:lista2],'idFabricante':[values:lista1],'estrategiaId':[values:listaEstrategias],'idSucursal':[values:lista3],]}"
        associatedProperties="propuesta.numPropuesta"
        showSortPanel="false"
        fullAssociationPathFieldNames="false"
        />
        <%
             def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/oportunidad/index')             
        %>
        <%
           def mover=generalService.getMenuV(1)
           def mout=generalService.getMenuV(2)
           def estilo=generalService.getMenuV(3)
          
        %>

        <g:form id="frmoport" controller="Oportunidad" params="[titulo:xtitulo]" >
            <g:if test="${xcerrada=='N'}">
                <div class="pull-left">
                    <g:if test="${'CREAR' in derechos}">                                        
                        <a class="btn btn-mini btn-primary" id="btn_new_opor" href="/crm/oportunidad/create/?sw=1"   >
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
                            
                        </g:if>
                        
                        <g:if test="${'EXPORTAR' in derechos}"> 
                                <%  swacc=1 %>
                            <li class="dropdown-submenu">
                                <a  href="#"><g:message code="exportar.label"/></a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <g:link action="exportarDatos" params="[tipo_export:'1',xaccionx:xaccion,titulo:xtitulo]"><g:message code="exportarTodos.label"/></g:link>
                                    </li>
                                    <li><g:actionSubmit  
                                    onMouseOver="${mover}" 
                                    onMouseOut="${mout}" 
                                    style="${estilo}"  
                                    value="${message(code: 'exportarSeleccionados.label')}" 
                                    action="exportarDatos"
                                    params="[tipo_export:'2']" /></li>
                                    <li>
                               			<% xtitulo="Oportunidades sin items" %>
                               			<g:link action="exportarDatos" params="[tipo_export:'3',xaccionx:xaccion,titulo:xtitulo]">Oportunidades sin ítems</g:link>
                            		</li>                                                               
                                </ul>
                            </li>
                                                                                     
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
                        <g:if test="${swacc==0}" >
                        <li style="text-align=center">Ninguna </li>
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
                    <g:sortableColumn property="nombreOportunidad" title="${message(code: 'nombreOportunidad.label', default: 'Proyecto')}" params="${filterParams}"/>
                    <g:sortableColumn property="numOportunidadFabricante" title="${message(code: 'oportunidad.numOportunidadFabricante.label', default: 'Op. Fabricante')}" params="${filterParams}"/>
                    <g:sortableColumn property="valorOportunidad" title="${message(code: 'valorOportunidad.label', default: 'Valor')}" params="${filterParams}"/>
                    <g:sortableColumn property="nombreVendedor" title="${message(code: 'nombreVendedor.label', default: 'Vendedor')}" params="${filterParams}"/>
                    <g:sortableColumn property="fechaApertura" title="${message(code: 'oportunidad.fechaApertura.label', default: 'Fecha Apertura.')}" params="${filterParams}"/>
                    <g:sortableColumn property="fechaCierreEstimada" title="${message(code: 'fechaCierreEstimada.label', default: 'Fecha E. Cierre')}" params="${filterParams}"/>
                    <g:sortableColumn property="trimestre" title="${message(code: 'oportunidad.trimestre.label', default: 'Q')}" params="${filterParams}"/>
                    <g:sortableColumn property="idEtapa" title="${message(code: 'oportunidad.idEtapa.label', default: 'Prob.')}" params="${filterParams}"/>
                     
                </tr>
            </thead>
            <tbody>
                <g:each in="${oportunidadInstanceList}" status="i" var="oportunidadInstance">

                    <tr  class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td><g:checkBox name="oportunidades" value="${oportunidadInstance.id}" checked="false" /></td>

                        <td Style="width:93px">
                            <g:link action="show" target="_blank" style="text-decoration:underline;" id="${oportunidadInstance.id}" params="[sw:0]">
                                ${oportunidadInstance?.numOportunidad}</g:link>
                            </td>

                        <td style="overflow: hidden;text-overflow: ellipsis; white-space: nowrap;max-width: 350px;">${oportunidadInstance?.nombreCliente}</td>

                        <td>${fieldValue(bean:oportunidadInstance,field:"nombreOportunidad")}</td>

                        <td><% println "${oportunidadService.getNumRegistros(oportunidadInstance.id)}" %></td>

                        <td style="text-align:right">${fieldValue(bean:oportunidadInstance,field:"valorOportunidad")}</td>

                        <td>${oportunidadInstance?.nombreVendedor}</td>
                        
                        <td><g:formatDate format="dd-MM-yyyy" date="${oportunidadInstance?.fechaApertura}" /></td>

                        <td><g:formatDate format="dd-MM-yyyy" date="${oportunidadInstance?.fechaCierreEstimada}" /></td>                                         

                        <td>${fieldValue(bean:oportunidadInstance,field:"trimestre")} </td> 
                        
                        <td>${generalService.getValorParametro(oportunidadInstance?.idEtapa)}</td>
                        
                         
                    </tr>
                </g:each>
            </tbody>
        </table>
        <div class="pagination_crm">
            <filterpane:paginate total="${oportunidadInstanceCount ?: 0}" domainBean="Oportunidad"/>
        </div>
    </g:form>
    </div>                     

<script>
   <!-- resize el padre del iframe --> 
    var contenido= $("#detalleconten");                       
    if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+60);

</script>
</body>
</html>
