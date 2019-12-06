<%@ page import="crm.Oportunidad" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'Oportunidad')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:set var="generalService" bean="generalService" />
        <div id="edit-oportunidad" class="content scaffold-edit" role="main">

            <h2>Solicitar Registro de Oportunidad </h2>
            <hr style="margin-top:10px;margin-bottom:10px;"> 

            <g:set var="beanInstance"  value="${oportunidadInstance}" />
            <g:render template="/general/mensajes" />
            <g:set var="xronly" value="false" scope="request"/>         

            <form  class="form-horizontal" action="/crm/oportunidad/solicitarRegistroDef" method="post" >
                <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar
                </button>
                <button type="reset" class="btn btn-mini" onclick="history.go(-1)"><i class="icon-remove"></i>&nbsp;Cancelar</button>
                <br>
                <br>
                <div class="box-content" > 
                    <fieldset class="form">
                        <div class="control-group" >
                            <label class="control-label" for="nombreOportunidad ">
                                Oportunidad
                            </label>
                            <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:300px;min-height:21px;background-color:#EEE;">
                                ${Oportunidad.get(idOp)}
                            </div>
                        </div>

                        <div class="control-group ${hasErrors(bean: oportunidadInstance, field: 'idRegistroEn', 'error')}">
                            <label class="control-label" for="idRegistroEn">
                                <g:message code="oportunidad.idRegistroEn.label" default="Registrar Op. En" />
                                <span class="required-indicator">*</span>
                            </label>
                            <div class="controls">
                                <g:select name="idRegistroEn" from="${generalService.getValoresParametro('mayoristas')}"
                                    optionKey="idValorParametro"    required="" value=""
                                    noSelection="['': 'Seleccione Fabricante']"  />
                            </div>
                        </div>

                    </fieldset>		
                </div>
                <g:hiddenField name="idOp"  value="${idOp}"/>             

            </form>
        </div>
    </body>
</html>
