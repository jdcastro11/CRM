<%@ page import="crm.RegistroOportunidad" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'registroOportunidad.label', default: 'RegistroOportunidad')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="edit-registroOportunidad" class="content scaffold-edit" role="main">

            <h2>Ver Registro Oportunidad </h2> 
            <hr style="margin-top:10px;margin-bottom:10px;">
           
            <g:form class="form-horizontal" url="[resource:registroOportunidadInstance, action:'update']" method="PUT" >
                
                <fieldset class="form">
                      <g:if test="${params.sh=='1'}" >
                        <a  class="btn btn-mini" href="/crm/registroOportunidad/indexh/${params.idpos}?sh=1">
                            <i class="icon-remove"></i>&nbsp;Cancelar</a>
                        </g:if>
                        <g:else>
                            <g:render template="acciones_r" />
                        </g:else>    
                    <br><br>
                    <g:set var="xronly" value="true" scope="request"/>
                    <g:render template="form"/>
                </fieldset>

            </g:form>
        </div>
    </body>
</html>
