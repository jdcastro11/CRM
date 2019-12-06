<%@ page import="crm.Contacto" %>
<!DOCTYPE html>
<html>
	<head>
        <g:if test="${params.layout=='detail'}" >
        <g:set var="xlayout" value="detalle"  />
        </g:if>
        <g:else>
            <g:set var="xlayout" value="perfectum"  />
        </g:else>
        <meta name="layout" content="${xlayout}">
		<g:set var="entityName" value="${message(code: 'contacto.label', default: 'Contacto')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>                
            <h2>Vista Contacto</h2>               
            <hr style="margin-top:10px;margin-bottom:10px;">                                               
      
            <g:form class="form-horizontal" url="[resource:contactoInstance, controller:'Contacto', action:'update']" method="PUT" >
                 
                 <g:render template="acciones_r" />  
                     <br>
                     <br>
                    <fieldset class="form">
                          <g:set var="xronly" value="true" scope="request"/>
                            <g:render template="form"/>
                    </fieldset>

            </g:form>
	   <!--	</div>-->
	</body>
</html>
