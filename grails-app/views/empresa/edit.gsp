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
        <g:if test="${params.swmodal==''}">
            <meta name="layout" content="${xlayout}">
        </g:if>
        <g:set var="entityName" value="${message(code: 'empresa.label', default: 'Empresa')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <g:set var="generalService" bean="generalService"/>
        <div id="edit-empresa" class="content scaffold-edit" role="main">

            <g:set var="xtitulo" value="${generalService.getValorParametro(params.t)}" />
            <h2>${xtitulo}</h2>
            <hr style="width:80%; margin-top:10px;margin-bottom:10px;">                                               


            <g:set var="beanInstance"  value="${empresaInstance}" />                
         

            <ul id="erroraSync">
            </ul>

            <g:form id="formEmpresa" class="form-horizontal" 
                url="[resource:empresaInstance,action:'update', controller:'Empresa']"
            method="${params.swmodal==''?'PUT':POST}" >

                <g:set var="swmodal" value="${params.swmodal}" scope="request"/>
                <g:render template="acciones" />
                  <br>
                 <g:render template="/general/mensajes" />
              
                <br>
              
                <fieldset class="form">
                    <g:set var="xronly" value="false" scope="request" />
                     <g:if test="${params.tipo=='0'}" >                       
                        <g:render template="empresaBase" />
                    </g:if>
                    <g:if test="${params.tipo=='1'}" >                       
                        <g:set var="swNit" value="${params.swnit}" scope="request" />
                        <g:render template="prospecto" />
                    </g:if>
                    <g:if test="${params.tipo=='2' || params.tipo=='5'}" >  
                        <g:set var="layout" value="main" scope="request" />
                        <g:render template="cliente" />
                    </g:if>
                    <g:if test="${params.tipo=='3'}" >
                        <g:set var="xidPadre" value="${params.id}" scope="request" />
                        <g:set var="layout" value="detail" scope="request" />
                        <g:render template="sede"/>
                    </g:if>
                     <g:if test="${params.tipo=='4'}" >
                        <g:set var="xidPadre" value="${params.padre}" scope="request" />
                        <g:render template="sucursal"/>
                    </g:if>
                </fieldset>
            </g:form>
              <div id="mierror"> </div>
        </div>
    </body>
</html>
