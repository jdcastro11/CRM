<%@ page import="crm.Empresa" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">     
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-empresa" class="content scaffold-edit" role="main">

            <h2>Conversión Cliente Potencial a Cliente </h2>
            <hr style="margin-top:10px;margin-bottom:10px;">                                               

            <br>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <g:form class="form-horizontal" url="[resource:empresaInstance, controller:'Empresa', action:'update']" method="PUT" >
     
                <fieldset class="form">
                    <g:if test="${'MODIFICAR' in session['operaciones']}">
                    <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar
                    </button> 
                    </g:if>
                      <a  class="btn btn-mini" href="/crm/empresa/index/1?layout=main&sort=razonSocial">
                 <i class="icon-remove"></i>&nbsp;Cancelar</a>
                    <br><br>
                    <g:set var="beanInstance"  value="${empresaInstance}" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xronly" value="false" scope="request"/> 
                    <g:set var="xtipo" value="2" scope="request"/> 
                    <g:render template="cliente"/>
                </fieldset>

            </g:form>
        </div>
    </body>
</html>
