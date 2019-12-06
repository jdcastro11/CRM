<%@ page import="crm.Territorio" %>
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
        <g:set var="entityName" value="${message(code: 'territorio.label', default: 'Territorio')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-territorio" class="content scaffold-edit" role="main">
            <% def xterri
                 
        %>
            <h2>Mostrar Territorio</h2> 
            <hr style="margin-top:10px;margin-bottom:10px;">                                               


             <g:set var="beanInstance"  value="${territorioInstance}" />                
            <g:render template="/general/mensajes" />
            <g:form class="form-horizontal" url="[resource:territorioInstance, action:'update']" method="PUT" >
                <g:hiddenField name="version" value="${territorioInstance?.version}" />
                <fieldset class="form">
                    <g:render template="acciones_r" />  
                    <br><br>
                    <g:set var="xronly" value="true" scope="request"/>
                    <g:render template="form"/>
                </fieldset>

            </g:form>
        </div>
    </body>
</html>
