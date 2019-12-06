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

            <h2><g:message code="descalificarTitle.prospecto.label" default="Descalificar Prospecto(s)"/></h2>               
            <hr style="margin-top:10px;margin-bottom:10px;"> 
            <g:if test="${flash.message}">
                <div  role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${prospectoInstance}">
                <ul  role="alert">
                    <g:eachError bean="${prospectoInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                </ul>
            </g:hasErrors> 

            <g:form  class="form-horizontal" url="[resource:prospectoInstance, action:'descalificarDef']" method="PUT" >

                <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white ">
                    </i>&nbsp;<g:message code="default.button.create.label" default="Guardar"/></button>

                <a class="btn btn-mini" href="/crm/Prospecto/index?sort=fechaApertura&order=desc">
                    <i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label" default="Cancelar"/> </a>
                <br><br>
                <div class="box-content" > 
                    <fieldset class="form">
                        <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'idRazonCancelacion', 'error')}">

                            <label class="control-label" for="idRazonCancelacion">
                                <g:message code="prospecto.idRazonCancelacion.label" default="Comentario" />
                                <span class="required-indicator">*</span>
                            </label>
                            <div class="controls">
                                <g:select name="idRazonCancelacion" from="${razonesList}" 
                                    optionKey="id"    required=""
                                value="${prospectoInstance?.idRazonCancelacion}"
                                    noSelection="['': "${message(code: 'razonCancela.prospecto.label', default: 'Seleccione Razón')}"]"  />
                            </div>
                        </div>  
                        <div class="control-group ${hasErrors(bean: prospectoInstance, field: 'otraRazonCancelacion', 'error')} ">
                            <label  class="control-label" for="otraRazonCancelacion">
                                <g:message code="prospecto.otraRazonCancelacion.label" default="Otra Razón" />
                            </label>
                            <div class="controls">
                                <g:textArea style="width:400px;"  name="otraRazonCancelacion"  rows="4"  value="${prospectoInstance?.otraRazonCancelacion}" disabled="${xronly}"  />
                            </div> 
                        </div>


                    </fieldset>		
                </div>
                <% 
                def posList=new ArrayList()
                   posList.addAll(prospectos)      
                if (posList.size()>1) 
                  elegidos=prospectos.join(',')
                else 
                   elegidos=prospectos
                %>
                <g:hiddenField name="prospectos"  value="${elegidos}"/>
                <g:hiddenField name="xempresa"  value="${params.xempresa}"/>
            </g:form>
        </div>
    </body>
</html>
