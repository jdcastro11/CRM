<%@ page import="crm.Vencimiento" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<!DOCTYPE html>
<html>
    <head> 
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'vencimiento.label', default: 'Vencimiento')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <r:require module="filterpane" />
    </head>
    <body>
        <% def sw_crud=[1,1,1,1,0,0] %>
        
    <filterpane:filterPane domain="Vencimiento" 
        formName="frmFiltro"
        action="indexg"
        showTitle="no"
        dialog="true"
        filterProperties="${['serial', 'descripcion','idTipoVencimiento', 'fechaInicio','fechaVencimiento','idEstadoVencimiento','empleado','encvencimiento','idTipoCobertura']}"   
        filterPropertyValues="${['idTipoCobertura':[values:crm.ValorParametro.executeQuery('select valor from ValorParametro where idParametro=\'tipocobert\'')],'idTipoVencimiento':[values:crm.ValorParametro.executeQuery('select valor from ValorParametro where idParametro=\'tipovencim\'')],'idEstadoVencimiento':[values:crm.ValorParametro.executeQuery('select valor from ValorParametro where idParametro=\'estadovenc\'')],'fechaInicio':[precision:'day'],'fechaVencimiento':[precision:'day']]}"
         associatedProperties="empleado.primerApellido,encvencimiento.empresa.razonSocial"
        showSortPanel="false"
        fullAssociationPathFieldNames="false"
    /> 
        <div id="boxVencimiento">	                
            <div id="list-vencimiento" class="content scaffold-list" role="main">
                <h2>${xtitulo}</h2>         
                <hr style="margin-top:10px;margin-bottom:10px;"> 


            <!-- <div class="row-fluid sortable"> -->

                <div class="pull-left">
                    <div class="pull-left">                      
                    </div>
                </div>
                &nbsp;
                <div class="btn-group">

                    <a href="#" class="btn btn-mini" >Acciones</a>
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                    <ul class="dropdown-menu">
                    <g:if test="${'ACTUALIZAR_ESTADO_VENCIMIENTOS' in session['operaciones']}">
                            <li><a href="/crm/vencimiento/actualizarEstadoVencimientos" >Actualizar Estados</a></li>
                     </g:if>
                        <g:if test="${'BORRAR' in session['operaciones']}">
                            <li><a href="/crm/vencimiento/listarBorrados" >Ver Borrados</a></li>
                      </g:if>
                            
                    </ul>
                </div>
            <!-- inicio filter  buttons  -->                         
            <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>
            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered> 
            <!-- fin filter  buttons  -->
                &nbsp;<a  class="btn btn-mini" href="/crm/vencimiento/indexg?idenc=${xidencven}&sort=encvencimiento&max=10&order=asc"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                <br><br>

                <g:set var="beanInstance"  value="${vencimientoInstance}" />                
                <g:render template="/general/mensajes" />
                <table class="table table-bordered" >
                    <thead>
                        <tr>

                            <td width="18px"></td>

                             <g:sortableColumn property="encvencimiento" title="${message(code: 'vencimiento.encvencimiento.label', default: 'Cliente')}"  params="${filterParams}"/>

                            <g:sortableColumn property="empleado" title="${message(code: 'vencimiento.empleado.label', default: 'Vendedor')}"  params="${filterParams}" params="${filterParams}"/>

                            <g:sortableColumn property="idTipoVencimiento" title="${message(code: 'vencimiento.idTipoVencimiento.label', default: 'Tipo Vencimiento')}" params="${filterParams}" />

                            <g:sortableColumn property="serial" title="${message(code: 'vencimiento.serial.label', default: 'Serial')}"  params="${filterParams}"/>

                            <g:sortableColumn property="descripcion" title="${message(code: 'vencimiento.descripcion.label', default: 'Descripción')}"  params="${filterParams}"/>

                            <g:sortableColumn property="idTipoCobertura" title="${message(code: 'vencimiento.idTipoCobertura.label', default: 'Tipo Cobertura')}" params="${filterParams}" />

                            <g:sortableColumn property="fechaInicio" title="${message(code: 'vencimiento.fechaInicio.label', default: 'Inicio')}"  params="${filterParams}" />

                            <g:sortableColumn property="fechaVencimiento" title="${message(code: 'vencimiento.fechaVencimiento.label', default: 'Vence')}"  params="${filterParams}" />

                            <g:sortableColumn property="idEstadoVencimiento" title="${message(code: 'vencimiento.idEstadoVencimientoaVencimiento.label', default: 'Estado')}"  params="${filterParams}" />

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${vencimientoInstanceList}" status="i" var="vencimientoInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td><g:checkBox name="venc" value="${vencimientoInstance.id}" checked="false" /></td>

                                <td><a href="/crm/vencimiento/show/${vencimientoInstance.id}?layout=main&idemp=${vencimientoInstance?.encvencimiento?.empresa?.id}"
                                       style="text-decoration:underline" >
                                      ${crm.Empresa.get(vencimientoInstance?.encvencimiento?.empresa?.id)}
                                </a>
                            </td>                                       
                            <td>${crm.Empleado.get(vencimientoInstance?.encvencimiento?.empleado?.id)}</td>
                            
                            <td>${generalService.getValorParametro(vencimientoInstance?.idTipoVencimiento)}</td>
                            
                            <td>${fieldValue(bean: vencimientoInstance, field: "serial")}</td>

                            <td>${fieldValue(bean: vencimientoInstance, field: "descripcion")}</td>

                            <td>${generalService.getValorParametro(vencimientoInstance?.idTipoCobertura)}</td>

                            <td><g:formatDate format="dd-MM-yyyy" date="${vencimientoInstance?.fechaInicio}" /></td>

                            <td><g:formatDate format="dd-MM-yyyy" date="${vencimientoInstance?.fechaVencimiento}" /></td>

                            <% def xres=generalService.getEstadoVencimiento(vencimientoInstance?.fechaInicio,vencimientoInstance?.fechaVencimiento) %>
                            <td style="${xres[1]};font-weight:bold;text-align:center;">${generalService.getValorParametro(xres[0])}</td>                                             
                           
                           
                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination_crm">
                <filterpane:paginate total="${vencimientoInstanceCount?:0}" domainBean="Vencimiento"  />              
            </div>
        </div>
    </div>
    <script>                    
        var contenido= $("#boxVencimiento"); 
        if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+60);     
    </script> 
</body>
</html>
