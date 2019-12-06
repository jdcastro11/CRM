<!DOCTYPE html>
<html>
    <head>
        <g:if test="${params.layout=='detail'}" >
            <g:set var="xlayout" value="detalle"  />
        </g:if>
        <g:else>
            <g:set var="xlayout" value="perfectum"  />
        </g:else>
        <g:if test="${params.swmodal==''}">
            <meta name="layout" content="${xlayout}">
        </g:if>
        <g:set var="entityName" value="${message(code: 'persona.label', default: 'Persona')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>

    </head>
    <body>

        <div id="create-persona" class="content scaffold-create" role="main">
            <h2><g:message code="nuevapersona.title.label"/></h2>
            <hr style="width:80%; margin-top:10px;margin-bottom:10px;">           
           
            
            <ul id="erroraSync">
                
            </ul>
            <form  name="formPersona" id="formCliente" class="form-horizontal" onsubmit="desactivar('btn_save_pers')"  action="${createLink(url:[controller:'Persona',action:'save'])}" method="post">
                <fieldset class="form">
                    <g:if test="${params.swmodal==''}">
                        <button type="submit" id='btn_save_pers' class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;<g:message code="default.button.create.label"/></button>
                        <button type="reset" class="btn btn-mini" onclick="history.go(-1)">Cancelar</button>
                    </g:if>
                    <g:else>
                        <button type="button" class="btn btn-mini btn-primary" onclick="if (validarPersona()) guardarEntidad('/crm/persona/saveAsync','formCliente','modal_body','idContacto','nombreContacto')"><i class="icon-download-alt icon-white"></i>&nbsp;<g:message code="default.button.create.label"/></button>
                    </g:else>

                    <br><br>
                     <g:set var="beanInstance"  value="${personaInstance}" />                
                     <g:render template="/general/mensajes" />
                    <g:if test="${params.tipo='1'}" >
                        <g:set var="xronly" value="false" scope="request"/>
                        <g:render template="contacto"/>
                    </g:if>
                </fieldset>
            </form>

        </div>
    </body>
</html>
