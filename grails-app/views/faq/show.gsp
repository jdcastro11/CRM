<%@ page import="crm.Faq" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">	
		<title>Mostrar Preguntas Frecuente</title>
	</head>
	<body>          
            <h2>Ver Pregunta Frecuente</h2>               
            <hr style="margin-top:10px;margin-bottom:10px;">

                <g:form class="form-horizontal" url="[resource:faqInstance, action:'update']" method="PUT" >
                        <g:render template="acciones_r" /> 
                         <br><br>				
                        <fieldset class="form">                                    
                              <g:set var="xronly" value="true" scope="request"/>
                                <g:render template="form"/>
                        </fieldset>

                </g:form>

	</body>
</html>
