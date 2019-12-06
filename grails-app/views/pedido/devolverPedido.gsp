<!DOCTYPE html>
<html>
	<head>
            <%@ page import="crm.Pedido" %>
	 <g:if test="${params.layout=='main'}" >
            <g:set var="xlayout" value="perfectum"  />
         </g:if>
        <g:else>
            <g:set var="xlayout" value="detalle"  />
        </g:else>
        <meta name="layout" content="${xlayout}">
		<g:set var="entityName" value="${message(code: 'nota.label', default: 'Pedido')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>

            <div id="create-nota" class="content scaffold-create" role="main">
            
            <h2>${xtitulo}</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">
		
		<form class="form-horizontal" action="/crm/pedido/devolverAVendedorDef" >
		 <fieldset class="form">
                     <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</button>

                    <button type="reset" class="btn btn-mini" onclick="history.go(-1)"><i class="icon-remove"></i>&nbsp;Cancelar</button>
                    <g:render template="/general/mensajes" />
                    <br>
                    <br>
                    
                    <g:set var="xentidad" value="${params.entidad}" scope="request"/>
                    <g:set var="xronly" value="false" scope="request"/>
		     
                    

                    <g:set var="generalService" bean="generalService" />
                    <g:hiddenField  name="idEntidad" value="${notaInstance.idEntidad?:params.ident}" />
                    <g:hiddenField  name="idTipoNota" value="${notaInstance.idTipoNota?:xtiponota}" />
                    <g:hiddenField  name="nombreEntidad" value="${notaInstance.nombreEntidad?:params.entidad}" />
                    <g:hiddenField  name="idAutor" value="${notaInstance?.idAutor?:generalService.getIdEmpleado(session['idUsuario'])}" />
                    <g:hiddenField  name="funcionariosNotificados"   value="${notaInstance?.funcionariosNotificados}" />
                    <g:hiddenField  name="idEstadoNota" value="genactivo" />


                     <div id="detalleconten">
                          <g:if test="${notaInstance?.eliminado==1}" >
                            <div id="men_eliminado" class="pull-right label label-important">
                                Eliminado
                            </div>
                        </g:if>
                        <div class="control-group ${hasErrors(bean: notaInstance, field: 'fecha', 'error')} ">
                             <label class="control-label" for="fecha">
                                 <g:message code="nota.fecha.label" default="Fecha" />
                             </label>
                             <div class="controls">

                                 <g:textField  name="fecha" maxlength="10"
                                              value="${g.formatDate(format:'dd-MM-yyyy HH:mm', date:notaInstance?.fecha)?:generalService.getHoy(1)}"  readonly="" />
                                 </div>
                         </div>


                        <div class="control-group  ${hasErrors(bean: notaInstance, field: 'idAutor', 'error')} required">
                            <label class="control-label"  for="idAutor">

                                <g:message code="nota.idAutor.label" default="Autor" />
                                <span class="required-indicator">*</span>
                            </label>
                            <div class="controls">
                                 <% def xidautor=generalService.getIdEmpleado(session['idUsuario'])  %>
                                <g:select id="idAutor" style="width:220px;" name="idAutor" required=""
                                          from="${crm.Empleado.findAll('from Empleado where idTipoEmpleado in(\'peremplead \', \'pervendedo\') and eliminado=0 order by primerNombre,primerApellido')}"
                                          optionKey="id"
                                          value="${notaInstance?.idAutor?:xidautor}"
                                          disabled="${xronly}"  />
                            </div>
                        </div>


                             <div class="control-group ${hasErrors(bean: notaInstance, field: 'funcionariosNotificados', 'error')} ">
                                 <label class="control-label" for="funcionariosNotificados">
                                     <g:message code="notaInstance.funcionariosNotificados.label" default="Notificados:" />

                                 </label>
                                 <div class="controls" > 
                                     <g:textField name="funcionariosNotificados1" style="width:500px;"  value="${notaInstance?.funcionariosNotificados}" />
                                 </div>
                            </div>



                        <div class="control-group ${hasErrors(bean: notaInstance, field: 'nota', 'error')} ">
                            <label class="control-label" for="nota">
                                <g:message code="nota.nota.label" default="Nota" />   
                               <span class="required-indicator">*</span>
                            </label>  
                             <div class="controls">
                               <g:textArea id="nota"  name="nota"  value="${notaInstance?.nota}"  
                                   cols="40" rows="5"  class="input-xlarge" required="" />          
                            </div>
                        </div>  


                     </div><!-- fin detalleconten -->
                     <g:hiddenField  id ="eliminado" name="eliminado" value="${notaInstance?.eliminado?:0}" />
                                     </fieldset>
	   </form>
		</div>
	</body>
</html>
