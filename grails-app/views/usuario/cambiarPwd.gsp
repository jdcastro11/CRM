<%@ page import="crm.Usuario" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'usuario.label', default: 'Prospecto')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-empresa" class="content scaffold-edit" role="main">		     
            <h2>Cambiar Password</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">        

            <g:set var="beanInstance"  value="${usuarioInstance}" />                
            <g:render template="/general/mensajes" />
            
            <g:form class="form-horizontal" url="[resource:usuarioInstance,action:'update', controller:'usuario']" method="PUT" >                         

                <div class="pull-left">
                    <g:if test="${'MODIFICAR' in session['operaciones']}">    
                        <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar
                        </button> 
                    </g:if>
                    <button type="reset" class="btn btn-mini" style="height:22px;" onclick="history.go(-1)"><i class=" icon-remove"></i>&nbsp;Cancelar</button>
                </div>
                <br><br>
                <fieldset class="form">
                    <div class="control-group ${hasErrors(bean: usuarioInstance, field: 'usuario', 'error')} required">
                        <label class="control-label"  for="usuario">
                            <g:message code="usuario.usuario.label" default="Usuario" />
                            <span class="required-indicator">*</span>
                        </label>
                        <div class="controls" >
                            <g:textField name="usuario" maxlength="50" required="" 
                            value="${usuarioInstance?.usuario}" readonly="" />
                        </div>
                    </div>
                    <div class="control-group ${hasErrors(bean: usuarioInstance, field: 'contrasena0', 'error')} ">
                        <label class="control-label" for="contrasena0">
                            <g:message code="usuario.contrasena.label" default="Contraseña Actual " />
                            <span class="required-indicator">*</span>
                        </label>
                        <div class="controls" >
                            <g:passwordField name="contrasena0" maxlength="100" value="" type="password" required="" />
                        </div>
                    </div>

                    <div class="control-group ${hasErrors(bean: usuarioInstance, field: 'contrasena1', 'error')} ">
                        <label class="control-label" for="contrasena1">
                            <g:message code="usuario.contrasena.label" default=" Nueva Contraseña" />
                            <span class="required-indicator">*</span>
                        </label>
                        <div class="controls" >
                            <g:passwordField name="contrasena1" maxlength="100" value="" type="password"  required="" />
                        </div>
                    </div>

                    <div class="control-group ${hasErrors(bean: usuarioInstance, field: 'contrasena2', 'error')} ">
                        <label class="control-label"  for="contrasena2">
                            <g:message code="usuario.contrasena.label" default="Repita Contraseña" />
                            <span class="required-indicator">*</span>
                        </label>
                        <div class="controls" >
                            <g:passwordField name="contrasena2" maxlength="100" type="password" value="" required="" />
                        </div>
                    </div>

                </fieldset>				
            </g:form>
        </div>
    </body>
</html>
