<%@ page import="crm.Actividad" %>
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
        <g:set var="entityName" value="${message(code: 'actividad.label', default: 'Actividad')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-anexo" class="content scaffold-edit" role="main">
            <% String xtit
            if (params.sh=='1') xtit="(Archivada)" else xtit="" 
            %>
            <h2>Ver Actividad ${xtit} </h2>
            <hr style="margin-top:10px;margin-bottom:10px;">

            <g:form class="form-horizontal" controller="Actividad" action="update" id="${params.id}" method="POST" >

                <fieldset class="form">
                    <g:if test="${params.sh=='1'}" >
                        <a  class="btn btn-mini" href="/crm/actividad/indexh/${params.identidad}?entidad=${params.entidad}">
                            <i class="icon-remove"></i>&nbsp;Cancelar</a>
                    </g:if>
                    <g:else>
                         <g:render template="acciones_r" />
                    </g:else>
                    <br><br>
                    <g:set var="beanInstance"  value="" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xoportunidad" value="${params.idopor}" scope="request"/>
                    <g:set var="xentidad" value="${params.entidad}" scope="request"/>
                    <g:set var="xidempresa" value="${params.idemp}" scope="request"/>

                    <g:set var="xronly" value="true" scope="request"/>
                    <g:render template="form"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
