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
		<g:set var="entityName" value="${message(code: 'contacto.label', default: 'Contacto')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head> 
	<body>
	
	 	<div id="create-contacto" class="content scaffold-create" role="main">
                     <h2>Nuevo Contacto</h2>
                      <hr style="margin-top:10px;margin-bottom:10px;width:85%;">  

			
             	<form  class="form-horizontal" onsubmit="desactivar('btn_save_cont')" action="/crm/contacto/save" method="post" >           
		   <fieldset class="form">
                                    
                                <button type="submit" id='btn_save_cont' class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar
                                </button>
                             <g:if test="${params.swmodal==''}" >
                                <g:if test="${params.layout=='main'}" >
                                <a  class="btn btn-mini" href="/crm/contacto/index?layout=main"><i class="icon-remove"></i>&nbsp;Cancelar</a>        
                                </g:if> 
                                <g:else>
                                <a  class="btn btn-mini" href="/crm/contacto/listarContactos/${params.id}?t=contactt00&layout=detail"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                                </g:else>
                              </g:if>   
                            <g:if test="${flash.message}">
                                <div  role="status">${flash.message}</div>
                              </g:if> 
                            <g:hasErrors bean="${contactoInstance}">
                                <ul  role="alert">
                                        <g:eachError bean="${contactoInstance}" var="error">
                                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                                        </g:eachError>
                                </ul>
                            </g:hasErrors> 
                                 <br>
                                 <g:set var="xronly" value="false" scope="request"/>
                                  <g:set var="xswmodal" value="${params.swmodal}" scope="request"/>
				<g:render template="form"/>
			   </fieldset>
				
			</form>
		</div>
	</body>
</html>