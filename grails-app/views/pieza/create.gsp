<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="detalle">
		<g:set var="entityName" value="${message(code: 'pieza.label', default: 'Pieza')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
        <div id="create-tactica" class="content scaffold-create" role="main">

            <h2>Nueva Pieza</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">
            <g:form class="form-horizontal" onsubmit="desactivar('btn_save_pieza')" url="[resource:piezaInstance, action:'save']" >
                <fieldset class="form">
                    <button type="submit" id='btn_save_pieza' class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</button>
                     <a class="btn btn-mini" href="/crm/pieza/index/${params.id}"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                    <br>
                    <br>
                    <g:set var="beanInstance"  value="${piezaInstance}" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>				
            </g:form>
        </div>

	</body>
</html>
