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
		<g:set var="entityName" value="${message(code: 'nota.label', default: 'Nota')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>

            <div id="create-nota" class="content scaffold-create" role="main">
            
            <h2>${xtitulo}</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">		
		<g:form class="form-horizontal" onsubmit="desactivar('btn_save_nota')"  url="[resource:notaInstance, action:'save']" >
		 <fieldset class="form">
                     <button type="submit" id='btn_save_nota' class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;<g:message code="guardarSeg.label" default="Guardar Seguimiento"/></button>
                      
                      &nbsp;<a  class="btn btn-mini" href="/crm/nota/index/${params.ident}?entidad=${params.entidad}&tnota=${params.tnota}&zw=1">
                     <i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label" default="Cancelar"/></a>                      
                    <g:render template="/general/mensajes" />
                    <br>
                    <br>
                    
                    <g:set var="xentidad" value="${params.entidad}" scope="request"/>
                    <g:set var="xtiponota" value="${params.tnota}" scope="request"/>
                    <g:set var="xronly" value="false" scope="request"/>
		   <g:render template="/nota/form"/>
		 </fieldset>
	   </g:form>
		</div>
	</body>
</html>
