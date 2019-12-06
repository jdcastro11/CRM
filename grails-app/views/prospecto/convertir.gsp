<%@ page import="crm.Prospecto" %>
<%@ page import="crm.Empresa" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'prospecto.label', default: 'Prospecto')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>


    </head>
    <body>

        <div id="edit-prospecto" class="content scaffold-edit" role="main">

            <h2><g:message code="convertir.prospecto.label" default="Convertir en Oportunidad"/></h2>               
            <hr style="margin-top:10px;margin-bottom:10px;">    

            <g:set var="beanInstance"  value="${prospectoInstance}" />                
            <g:render template="/general/mensajes" />   

            <g:form  class="form-horizontal" url="[resource:prospectoInstance, action:'convertirDef']" method="PUT" >

                <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white ">
                    </i>&nbsp;<g:message code="default.convertir.button.label" default="Convertir"/> </button>
                <a class="btn btn-mini" href="/crm/Prospecto/index?sort=fechaApertura&order=desc">
                    <i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label" default="Cancelar"/></a>
                <br>
                <br>

                <fieldset class="form">                      
                    <div class="control-group">
                        <label class="control-label" >
                            <g:message code="prospectoDesc.label" default="Prospecto"/>
                        </label>
                        <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:400px;background-color:#EEE">
                            ${prospectoInstance?.nombreProspecto}
                        </div>
                    </div>
                    <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'idVendedor', 'error')} required ">
                        <label class="control-label" for="idVendedor">
                            <g:message code="prospecto.idVendedor.label" default="Ejecutivo de Venta" />
                            <span class="required-indicator">*</span>
                        </label>
                        <div class="controls">
                            <g:select name="idVendedor" required="" from="${vendedoresList}"
                                optionKey="id" 
                            value="${prospectoInstance?.empleado?.id}"
                                noSelection="['': 'Seleccione Ejecutivo']"   />
                        </div>
                    </div>                                              
                </fieldset>		

            </g:form>
        </div>
    </body>
</html>
