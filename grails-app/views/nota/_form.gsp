<%@ page import="crm.Nota" %>

<g:set var="generalService" bean="generalService" />
<g:hiddenField  name="idEntidad" value="${notaInstance.idEntidad?:params.ident}" />
<g:hiddenField  name="idTipoNota" value="${notaInstance.idTipoNota?:xtiponota}" />
<g:hiddenField  name="nombreEntidad" value="${notaInstance.nombreEntidad?:params.entidad}" />
<g:hiddenField  name="idAutor" value="${notaInstance?.idAutor?:generalService.getIdEmpleado(session['idUsuario'])}" />
<g:hiddenField  name="funcionariosNotificados"   value="${notaInstance?.funcionariosNotificados}" />
<g:hiddenField  name="idEstadoNota" value="genactivo" />
<head>	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js" type="text/javascript"></script>
	<script src="//cdn.jsdelivr.net/bootstrap/3.0.0/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="//cdn.jsdelivr.net/jquery.dirtyforms/2.0.0/jquery.dirtyforms.min.js" type="text/javascript"></script>
	<script src="//cdn.jsdelivr.net/jquery.dirtyforms/2.0.0/jquery.dirtyforms.dialogs.bootstrap.min.js" type="text/javascript"></script>
</head>

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
                          value="${g.formatDate(format:'dd-MM-yyyy', date:notaInstance?.fecha)?:generalService.getHoy(1)}"  readonly="" />
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
                      disabled="true"  />
        </div>
    </div>
    
     <g:if test="${params.entidad=='pedido'}" >     
         <div class="control-group ${hasErrors(bean: notaInstance, field: 'funcionariosNotificados', 'error')} required ">
             <label class="control-label" for="funcionariosNotificados">
                 <g:message code="notaInstance.funcionariosNotificados.label" default="Notificados:" />
                 <span class="required-indicator">*</span>
             </label>
             <div class="controls" > 
                 <g:textField name="funcionariosNotificados1" required="" style="width:500px;"  value="${notaInstance?.funcionariosNotificados}" id="notaAutoComplete" disabled="${xronly}" />
                 <!-- <img  class="icon-question-sign" title="Digite las direcciones de correo completas en formato xxxxxx@redsis.com separándolas por coma"> -->
          
             </div>
        </div>
     </g:if>    
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
    <div class="control-group ${hasErrors(bean: notaInstance, field: 'nota', 'error')} ">
        <label class="control-label" for="nota">
            <g:message code="nota.nota.label" default="Nota" />   
           <span class="required-indicator">*</span>
        </label>  
         <div class="controls">
           <g:textArea id="nota"  name="nota"  value="${notaInstance?.nota}"  
               cols="40" rows="5"  class="input-xlarge" required=""  disabled="${xronly}"/>          
        </div>
    </div>  

           
 </div><!-- fin detalleconten -->
 <g:hiddenField  id ="eliminado" name="eliminado" value="${notaInstance?.eliminado?:0}" />
<script>
    <!-- calcula el alto del bloque htm del detalle de encaberzado respectivo -->
    var contenido= $("#detalleconten");
    if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+150);
    if (parent.IFRAME_DETALLE2 !=null)parent.IFRAME_DETALLE2.height(contenido.height()+150);

</script>

<script type="text/javascript">    
    /*$('form').dirtyForms({
        // Message will be shown both in the Bootstrap Modal dialog 
        // and in most browsers when attempting to navigate away 
        // using browser actions.
		message: 'Los cambios que realizó no se guardarán',
        dialog: {
            title: 'Advertencia',
            dialogID: 'custom-dialog', 
            titleID: 'custom-title', 
            messageClass: 'custom-message', 
            proceedButtonText: 'Abandonar', 
            stayButtonText: 'Permanecer'
                 
        }
    });

    // If .dirtyForms() has already been called, you can override
    // the values after the fact like this.
    $.DirtyForms.dialog.title = 'Advertencia';
    $.DirtyForms.dialog.proceedButtonText = 'Abandonar';
    $.DirtyForms.dialog.stayButtonText = 'Permanecer aquí';*/



    $(function() {
    	function split( val ) {
    	return val.split( /,\s*/ );
    	}
    	function extractLast( term ) {
    	return split( term ).pop();
    	}
    	     
    	var projects = [
    	{
    	value: "jmaury@redsis.com",
    	label: "Jose Maury"
    	},
    	{
    	value: "srua@redsis.com",
    	label: "Skarlee Rua"
    	},
    	{
    	value: "atecnico2@redsis.com",
    	label: "Milton Contreras"
    	}
    	];
    	     
    	$( "#notaAutoComplete" )
    	 // don't navigate away from the field on tab when selecting an item
    	.on( "keydown", function( event ) {
    	if ( event.keyCode === $.ui.keyCode.TAB &&
    	$( this ).autocomplete( "instance" ).menu.active ) {
    	event.preventDefault();
    	}
    	})
    	.autocomplete({
    	minLength: 3,
    	source: function( request, response ) {
			$.ajax({
				type: 'GET',
				url:'${createLink(controller:'nota',action:'empleadosNoti')}',
				dataType: 'json',
				success: function(jsonData) {
					//var results = $.ui.autocomplete.filter(jsonData, request.term);
		            //response(results);
					response( $.ui.autocomplete.filter(
							jsonData, extractLast( request.term ) ) );
		            
	              }				
				});
				
				





        	
    	// delegate back to autocomplete, but extract the last term
    	/*response( $.ui.autocomplete.filter(
    	projects, extractLast( request.term ) ) );*/
    	},

//    	    source:projects,    
    	focus: function() {
    	// prevent value inserted on focus
    	return false;
    	},
    	select: function( event, ui ) {
    	var terms = split( this.value );
    	// remove the current input
    	terms.pop();
    	// add the selected item
    	terms.push( ui.item.value );
    	// add placeholder to get the comma-and-space at the end
    	terms.push( "" );
    	this.value = terms.join( "," );
    	    
    	    var selected_label = ui.item.label;
    	    var selected_value = ui.item.value;
    	    
    	    var labels = $('#labels').val();
    	    var values = $('#values').val();
    	    
    	    if(labels == "")
    	    {
    	        $('#labels').val(selected_label);
    	        $('#values').val(selected_value);
    	    }
    	    else    
    	    {
    	        $('#labels').val(labels+","+selected_label);
    	        $('#values').val(values+","+selected_value);
    	    }   
    	    
    	return false;
    	}
    	});

    	 });     



    	
</script>