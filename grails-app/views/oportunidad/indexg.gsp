<%@ page import="crm.Oportunidad" 
import="crm.Empresa"
import="crm.Persona"
%>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
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
    <% def sw_crud=[1,1,1,1,0,0]  %>

    <div id="detalleconten">           
        <%   
          def lista1=crm.ValorParametro.executeQuery("select valor from ValorParametro where idValorParametro in ('posventx25','posventx50')")
          def lista2=crm.Empresa.executeQuery("select razonSocial  from Empresa where idTipoEmpresa='empbase' and eliminado=0")
          def lista3=generalService.getValoresParametro('fabricante')
        %>
        <h2>Forecast Trimestre ${Qactual}</h2>

        <hr style="margin-top:10px;margin-bottom:10px;">                           
        <filterpane:filterPane domain="Oportunidad" 
        formName="frmFiltro"
        action="indexg"
        showTitle="no"
        dialog="true"
        filterProperties="${['numOportunidad','nombreOportunidad','nombreCliente','nombreVendedor','trimestre','idSucursal','idEtapa','idFabricante']}"      
        filterPropertyValues="${['idSucursal':[values:lista2],'idEtapa':[values:lista1],'idFabricante':[values:lista3]]}"
        showSortPanel="false"
        fullAssociationPathFieldNames="false"
        />
        <%
def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/oportunidad/index') 

%>
        <g:form id="frmoport" controller="Oportunidad" >            
            <div class="btn-group">

                <a href="#" class="btn btn-mini" >Acciones</a>
                <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                <ul class="dropdown-menu">                    
                    <g:if test="${'EXPORTAR' in derechos}">                              
                        <li><a href="/crm/oportunidad/exportar1/excel">Exportar a Excel</a></li> 
                        </g:if>
                        <g:if test="${'EXPORTAR' in derechos}">
                            <%  swacc=1 %>
                            <li class="dropdown-submenu">
                                <a  class="gris" href="#">Exportar</a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <g:link action="exportarDatos" params="[tipo_export:'1',xaccionx:xaccion,titulo:xtitulo]">Todos</g:link>
                                    </li>
                                    <li><g:actionSubmit
                                            onMouseOver="${mover}"
                                            onMouseOut="${mout}"
                                            style="${estilo}"
                                            value="Seleccionados"
                                            action="exportarDatos" />
                                    </li>
                                </ul>
                            </li>
                         </g:if>
                        </ul>
            </div>

    <!-- inicio filter  buttons -->                           
            <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>                           
            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
            <!-- fin filter  buttons  -->

            <a  class="btn btn-mini" href="/crm/oportunidad/indexg"><i class="icon-remove"></i>&nbsp;Cancelar</a>

            <g:set var="beanInstance"  value="${oportunidadInstance}" />                
            <g:render template="/general/mensajes" />

            <table class="table table-bordered">
                <thead>
                    <tr>
                        <td style="width:18px"> </td>
                        <g:sortableColumn style="width:100px" property="numOportunidad" title="${message(code: 'oportunidad.numOportunidad.label', default: 'Nro.')}" params="${filterParams}" />
                        <g:sortableColumn property="nombreCliente" title="Empresa" params="${filterParams}"/>
                        <g:sortableColumn property="nombreOportunidad" title="${message(code: 'oportunidad.nombreOportunidad.label', default: 'Proyecto')}" params="${filterParams}"/>
                        <g:sortableColumn property="valorOportunidad" title="${message(code: 'oportunidad.valorOportunidad.label', default: 'Valor')}" params="${filterParams}"/>
                        <g:sortableColumn property="nombreVendedor" title="${message(code: 'oportunidad.nombreVendedor.label', default: 'Vendedor')}" params="${filterParams}"/>
                        <g:sortableColumn property="trimestre" title="${message(code: 'oportunidad.trimestre.label', default: 'Q')}" params="${filterParams}"/>
                        <td style="width:50px"></td>
                    </tr>
                </thead>
                <tbody>
                  
                    <g:each in="${oportunidadInstanceList}" status="i" var="oportunidadInstance">
                          <% 
                                if (oportunidadInstance?.idEtapa=='posventx25') xicono="25.png"
                                else if (oportunidadInstance?.idEtapa=='posventx50') xicono="50.png"                              
                                     else xicono="nada.png"                               
                                       def notaInstance=crm.Nota.get(oportunidadInstance.idUltimaNota)
                                def xdias                                                 
                                if  (notaInstance) xdias=xhoy-notaInstance.fecha  else xdias=9                            
                            %>
                        <tr  class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:checkBox name="oportunidades" value="${oportunidadInstance.id}" checked="false" /></td>

                            <td>
                                <g:link action="show" style="text-decoration:underline;" id="${oportunidadInstance.id}" params="[sw:0,sm:1]">
                                    ${oportunidadInstance?.numOportunidad}</g:link>
                                </td>

                            <td>${oportunidadInstance?.nombreCliente}</td>

                            <td>${fieldValue(bean:oportunidadInstance,field:"nombreOportunidad")}</td>                      

                            <td style="text-align:right">${fieldValue(bean:oportunidadInstance,field:"valorOportunidad")}</td>

                            <td>${oportunidadInstance?.nombreVendedor}</td>


                            <td>${fieldValue(bean:oportunidadInstance,field:"trimestre")} </td> 
                           
                            <td><img src="/crm/images/${xicono}" title="Probabilidad">
                                 
                            <g:if test="${xdias <= xdiasmax}" >                                                           
                              <a href="/crm/nota/mostrarNota/${oportunidadInstance?.id}"><img src="/crm/images/nota.png" title="Ultima gestión"></a>                               
                             
                             </g:if> 
                            </td>   
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
