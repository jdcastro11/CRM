<!DOCTYPE html>
<html>
	<head>
     
       
        <meta name="layout" content="perfectum">
		<g:set var="entityName" value="${message(code: 'contacto.label', default: 'Contacto')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head> 
	<body>
	
	 	<div id="create-contacto" class="content scaffold-create" role="main">
                     <h2>Nueva Persona ...</h2>
                      <hr style="margin-top:10px;margin-bottom:10px;width:85%;">  
				
             	<form  class="form-horizontal" onsubmit="desactivar('btn_save_cont')" action="/crm/persona/save" method="post" >           
		   <fieldset class="form">
                                    
                                <button type="submit" id='btn_save_cont' class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar
                                </button>
                                                           
                                <a  class="btn btn-mini" href="/crm/persona/index?layout=main"><i class="icon-remove"></i>&nbsp;Cancelar</a>        
                              <br/>
                            <g:if test="${flash.message}">
                                <div  role="status">${flash.message}</div>
                              </g:if> 
                                 <br>
                                 <g:set var="xronly" value="false" scope="request"/>                                  
				<g:render template="form"/>
			   </fieldset>
				
		</form>
		</div>
	</body>
</html>