
<%@ page import="crm.EncVencimiento" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'encVencimiento.label', default: 'EncVencimiento')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <r:require module="filterpane" />
    </head>
    <body> 
      
        <filterpane:filterPane domain="EncVencimiento" 
        formName="frmFiltro"
        action="filter"
        showTitle="no"
        dialog="true"
        filterProperties="${['empresa','persona']}"
        associatedProperties="empresa.razonSocial,persona.primerApellido,persona.primerNombre"
        showSortPanel="false"
        fullAssociationPathFieldNames="false"
        />
        <div id="list-encVencimiento" class="content scaffold-list" role="main">
            <h2>${xtitulo}</h2>         
            <hr style="margin-top:10px;margin-bottom:10px;"> 

            <div class="pull-left">
                <div class="pull-left">
                    <g:if test="${'CREAR' in session['operaciones']}">

                        <a class="btn btn-mini btn-primary" href="/crm/EncVencimiento/create">
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
                   <g:if test="${'INFO_VENCIMIENTO' in session['operaciones']}">
                       <%  swacc=1 %>
                       <li><a href="/crm/vencimiento/infoVencimiento" >Reporte Vencimientos</a></li>
                    </g:if>
                    <g:if test="${'BORRAR' in session['operaciones']}">
                      <%  swacc=1 %>   
                     <li><a href="/crm/EncVencimiento/listarBorrados/" >Ver Borrados</a></li>
                    </g:if>
                    <g:if test="${swacc==0}" >
                     <li align="center">Ninguna </li>
                    </g:if>
                </ul>
            </div>
            <!-- inicio filter  buttons -->                           
            <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>
            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
            <!-- fin filter  buttons  -->  
            &nbsp;<a  class="btn btn-mini" href="/crm/EncVencimiento/index?sort=encVencimiento&max=10&order=asc"><i class="icon-remove"></i>&nbsp;Cancelar</a>
            <br>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <td width="18px"></td>
                        <g:sortableColumn property="encVencimiento" title="${message(code: 'encVencimiento.empresa.label', default: 'Cliente')}"  params="${filterParams}" />
                        <g:sortableColumn property="idContacto" title="${message(code: 'encVencimiento.idContacto.label', default: 'Contacto')}"  params="${filterParams}" />
                        <g:sortableColumn property="idEstadoEncVencimiento" title="${message(code: 'encVencimiento.idEstadoEncVencimiento.label', default: 'Estado General')}" params="${filterParams}" />

                    </tr>
                </thead>
                <tbody>
                    <g:each in="${encVencimientoInstanceList}" status="i" var="encVencimientoInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td><g:checkBox name="encvenc" value="${encVencimientoInstance.id}" checked="false" /></td>
                            <td><g:link action="show" style="text-decoration:underline" id="${encVencimientoInstance.id}">                                        
                                    ${encVencimientoInstance.empresa.razonSocial}   
                                </g:link></td>
                            <td>${encVencimientoInstance?.persona.nombreCompleto()}</td>                                       

                            <td>${generalService.getValorParametro(encVencimientoInstance?.idEstadoEncVencimiento)}</td>

                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination_crm">
              <filterpane:paginate total="${encVencimientoInstanceCount ?: 0}" domainBean="EncVencimiento"/>
            </div>
        </div>

    </body>
</html>
