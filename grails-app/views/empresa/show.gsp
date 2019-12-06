<%@ page import="crm.Empresa" %>
<!DOCTYPE html>
<html>
    <head>
        <g:if test="${params.layout=='main'}" >
            <g:set var="xlayout" value="perfectum"  />
        </g:if>
        <g:else>
            <g:set var="xlayout" value="detalle"  />
        </g:else>
        <meta name="layout" content="${xlayout}">
        <g:set var="entityName" value="${message(code: 'empresa.label', default: 'Empresa')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
%{--Use generalService--}%
        <g:set var="generalService" bean="generalService"/>
        <div id="edit-empresa" class="content scaffold-edit" role="main">

            <g:set var="xtitulo" value="${generalService.getValorParametro(params.t)}" />

            <h2>${xtitulo}</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">   
           
              <g:set var="beanInstance"  value="${empresaInstance}" />    
            <g:form class="form-horizontal" url="[resource:empresaInstance, action:'update']" method="PUT" >
                <g:render template="acciones_r" />                
                <br>
                <g:render template="/general/mensajes" />
                <br>
                <fieldset class="form">
                    <g:set var="xronly" value="true" scope="request" />
                     <g:if test="${params.tipo=='0'}" >
                        <g:set var="swNit" value="${params.sw}" scope="request" />
                        <g:render template="empresaBase" />
                    </g:if>
                    <g:if test="${params.tipo=='1'}" >
                        <g:set var="swNit" value="${params.sw}" scope="request" />
                        <g:render template="prospecto" />
                    </g:if>
                    <g:if test="${params.tipo=='2' || params.tipo=='5' }" >
                        <g:render template="cliente"/>
                    </g:if>
                    <g:if test="${params.tipo=='3'}" >
                        <g:set var="xidPadre" value="${params.id}" scope="request" />
                        <g:render template="sede"/>
                    </g:if>
                    <g:if test="${params.tipo=='4'}" >
                        <g:set var="xidPadre" value="${params.id}" scope="request" />
                        <g:render template="sucursal"/>
                    </g:if>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
