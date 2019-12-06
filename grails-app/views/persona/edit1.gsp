<%@ page import="crm.Persona" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'persona.label', default: 'Persona')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>


    </head>
    <body>
        <h2>Edición de Persona...</h2>               
        <hr style="margin-top:10px;margin-bottom:10px;">  

        <div id="edit-persona" class="content scaffold-edit" role="main">            
            <g:form class="form-horizontal" url="[resource:personaInstance,controller:'Persona',action:'update']" method="PUT" >
                <g:render template="acciones" />  
                <br>
                <br>                                   
                <g:set var="beanInstance"  value="${personaInstance}" />                
                <g:render template="/general/mensajes" />
                <fieldset class="form">
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>                
             <hr>   
          
            </fieldset>
            </g:form>
        </div>
    </body>
</html>