<%@ page import="crm.ElementoPorOportunidad" %>
<%@ page import="crm.Oportunidad" %>
<%@ page import="crm.Empresa" %>
<%@ page import="crm.Empleado" %>
<%@ page import="crm.Linea" %>
<%@ page import="crm.Sublinea" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'elementoPorOportunidad.label', default: 'ElementoPorOportunidad')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <r:require module="filterpane" />
    </head>
    <body>

         %{--Use generalService--}%
        <g:set var="generalService" bean="generalService" />
		<g:set var="oportunidadService" bean="oportunidadService" />       
        <g:set var="seguridadService" bean="seguridadService" />
        <% def sw_crud=[1,1,1,1,0,0]%>
        <div id="detalleconten">

         <h2 style="margin-top:0px">${xtitulo}</h2>
         <hr style="margin-top:10px;margin-bottom:10px;">
        
        <%   
			def queryLinea='select distinct l.descLinea from Linea l where l.eliminado=0 order by l.descLinea asc'
			def querySubLinea='select distinct sl.descSublinea from Sublinea sl where sl.eliminado=0 order by sl.descSublinea asc'
			def queryTrimestre='select distinct op.trimestre from Oportunidad op where op.eliminado=0'
			def lineas=Linea.executeQuery(queryLinea) 
			def trimestres=Oportunidad.executeQuery(queryTrimestre)
			def sublineas=Sublinea.executeQuery(querySubLinea)			 
			def mover=generalService.getMenuV(1)
            def mout=generalService.getMenuV(2)
            def estilo=generalService.getMenuV(3)
         %>        
          
            
        <filterpane:filterPane domain="ElementoPorOportunidad" 
        formName="frmFiltro"
        action="indexItems"
        showTitle="no"
        dialog="true"
        filterProperties="${['oportunidad','linea','sublinea']}"       
        filterPropertyValues="${['linea.descLinea':[values:lineas],'oportunidad.trimestre':[values:trimestres],'sublinea.descSublinea':[values:sublineas]]}"
        associatedProperties="oportunidad.empresa.razonSocial,oportunidad.empleado.primerNombre,oportunidad.numOportunidad,linea.descLinea,sublinea.descSublinea,oportunidad.trimestre"
        showSortPanel="false"
        fullAssociationPathFieldNames="false"
        />                          

            <div class="row-fluid sortable"> 
				<g:form controller="ElementoPorOportunidad" params="[titulo:xtitulo]" >
                
                    
                    
                    <div class="btn-group">
                    <%  def swacc=0 %>
                        <a href="#" class="btn btn-mini" >Acciones</a>
                        <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                        <ul class="dropdown-menu">                            
                                 <li class="dropdown-submenu">
                                <a  href="#">Exportar</a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <g:link action="exportarDatos" params="[tipo_export:'1',xaccionx:xaccion,titulo:xtitulo]">Todos</g:link>
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

                        </ul>
                    </div>                
                
                
            <!-- inicio filter  buttons -->                           
        		<filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>                           
        		<filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
        	<!-- fin filter  buttons  -->

                <a  class="btn btn-mini" href="/crm/elementoPorOportunidad/indexItems">
                 <i class="icon-remove"></i>&nbsp;Cancelar</a>

                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <td style="width:12px"> </td>

                                <g:sortableColumn property="linea" title="${message(code: 'elementoPorOportunidad.idLinea.label', default: 'Línea')}" params="${filterParams}" />

                                <g:sortableColumn property="sublinea" title="${message(code: 'elementoPorOportunidad.idSublinea.label', default: 'Sublínea')}" params="${filterParams}" />

                                <%-- <g:sortableColumn property="idTipoProducto" title="${message(code: 'elementoPorOportunidad.idTipoProducto.label', default: 'Tipo')}" />--%>

                                <%--<g:sortableColumn property="idMarca" title="${message(code: 'elementoPorOportunidad.idMarca.label', default: 'Marca')}" />--%>

                                <g:sortableColumn property="cantidad" title="${message(code: 'elementoPorOportunidad.cantidad.label', default: 'Cant.')}"  params="${filterParams}"/>

                                <g:sortableColumn property="valor" title="${message(code: 'elementoPorOportunidad.valor.label', default: 'Valor')}" params="${filterParams}"/>
								
								<g:sortableColumn property="valor" title="${message(code: 'elementoPorOportunidad.total.label', default: 'Total')}" params="${filterParams}" />
                                <g:sortableColumn property="oportunidad.numOportunidad" title="${message(code: 'elementoPorOportunidad.total.label', default: 'Num. Oportunidad')}" params="${filterParams}"/>
                                <%--<g:sortableColumn property="valor" title="${message(code: 'elementoPorOportunidad.total.label', default: 'Reg. Oportunidad')}" params="${filterParams}"/> --%>
                                
                                <g:sortableColumn property="oportunidad.nombreVendedor" title="Vendedor" params="${filterParams}"/>
                                <g:sortableColumn property="oportunidad.valorOportunidad" title="${message(code: 'elementoPorOportunidad.oportunidad.valorOportunidad.label', default: 'Valor Oportunidad')}" params="${filterParams}"/>
                                <g:sortableColumn property="oportunidad.trimestre" title="Q" params="${filterParams}"/>
                                <g:sortableColumn property="oportunidad.nombreCliente" title="Empresa" params="${filterParams}"/>
                                

                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${elementoPorOportunidadInstanceList}" status="i" var="elementoPorOportunidadInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                    <td><g:checkBox name="prodelegidos" value="${elementoPorOportunidadInstance?.id}" checked="false" /></td>

                                    <td><a style="text-decoration:underline;" href="/crm/elementoPorOportunidad/show/${elementoPorOportunidadInstance?.id}?sw=0">
                                            ${elementoPorOportunidadInstance?.linea?.descLinea} </a>
                                    </td>

                                    <td style="width:12%">${elementoPorOportunidadInstance?.sublinea.descSublinea}</td>

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
                                    
                                    <td><a style="text-decoration:underline;" href="/crm/oportunidad/show/${elementoPorOportunidadInstance.oportunidad.id}">${elementoPorOportunidadInstance.oportunidad.numOportunidad}</a></td>
                                    <%--<td style="width:5%;"><% println "${oportunidadService.getNumRegistros(elementoPorOportunidadInstance.oportunidad.id)}" %></td> --%>
                                    <td>${elementoPorOportunidadInstance.oportunidad.empleado}</td>                                    
                                    <td style="text-align:right">${fieldValue(bean:elementoPorOportunidadInstance.oportunidad,field:"valorOportunidad")}</td>
                                    <td>${elementoPorOportunidadInstance.oportunidad.trimestre}</td>
                                    <td>${elementoPorOportunidadInstance.oportunidad.empresa.razonSocial}</td>

                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                    <div class="pagination_crm">                    
            				<filterpane:paginate total="${elementoPorOportunidadInstanceCount ?: 0}"  params="${filterParams}"/>
        			</div>
        		</g:form>
            </div>
        </div>
        <script>
            var contenido= $("#detalleconten");
            if (parent.IFRAME_DETALLE !=null) parent.IFRAME_DETALLE.height(contenido.height()+60);

        </script>
    </body>
</html>
