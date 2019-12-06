<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">

        <g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'Oportunidad')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>         

    </head>
    <body>

        <h2><g:message code="nueva.oportunidad.label"/></h2>
        <hr style="margin-top:10px;margin-bottom:10px;">                

        <div id="create-oportunidad" class="content scaffold-create" role="main">
                  
            <g:form class="form-horizontal"  onsubmit="desactivar('btn_save_opor')" url="[resource:oportunidadInstance, action:'save']" >
           <%-- <form class="form-horizontal" action="/crm/oportunidad/save" method="post" >--%>

                <fieldset class="form">
                    <button type="submit" id='btn_save_opor' class="btn btn-mini btn-primary"  ><i class="icon-download-alt icon-white ">
                        </i>&nbsp;<g:message code="default.button.create.label"/></button>                                  
                   <a  class="btn btn-mini" href="/crm/oportunidad/index?sort=fechaApertura&order=desc"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>
                    <br>
                    <g:set var="beanInstance"  value="${oportunidadInstance}" />                
                    <g:render template="/general/mensajes" />
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:render template="form"/>
                </fieldset>				
            <%--</form>--%>
            </g:form>
        </div>
    </body>
</html>
