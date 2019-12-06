<%@ page import="crm.Vencimiento" %>
%{--Use generalService--}%
<g:set var="generalService" bean="generalService" />

<!DOCTYPE html>
<html>
    <head> 
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'vencimiento.label', default: 'Vencimiento')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        
            
        
    </head>
    <body>

        <% def sw_crud=[1,1,1,1,0,0] %>
        <div id="boxVencimiento">	                
            <div id="list-vencimiento" class="content scaffold-list" role="main">                      
                <hr style="margin-top:10px;margin-bottom:10px;"> 		
		  <% def clase="active" 
			%>  
      <div class="tabbable" style="margin-bottom: 18px;">
 		  <ul class="nav nav-tabs" id="myTab">
 		  
			    <li class="active"><a href="#tab1" id="tab-princ" data-toggle="tab">Mantenimiento de hardware</a></li>
			    <li><a href="#tab2" data-toggle="tab" >Mantenimiento de software asociado al hardware</a></li>
			    <li><a href="#tab3"  data-toggle="tab" >Mantenimiento de software aplicativo</a></li>
			    <li><a href="#tab4" data-toggle="tab" >Convenios de soporte</a></li>
			    <li><a href="#tab5" data-toggle="tab" >Contratos de administración-Redsis</a></li>
			    <li><a href="#tab6" data-toggle="tab" >Contratos de administración-Terceros</a></li>
			    <li><a href="#tab7" data-toggle="tab" >Contratos de arrendamiento-Redsis</a></li>
			    <li><a href="#tab8" data-toggle="tab" >Contratos de arrendamiento-Terceros</a></li>			    
			    <li><a href="#tab9"  data-toggle="tab">Vencidos</a></li>
		  </ul>		  
		  <g:render template="/general/mensajes" />
          <div class="tab-content" style="padding-bottom: 9px; border-bottom: 1px solid #ddd;">
            <div class="tab-pane active" id="tab1">              
              <g:include controller="vencimiento" action="pestanasVencimientos" params="${[tipoVenc:'venhardw'] }"/>
            </div>
            <div class="tab-pane" id="tab2">            	
           	  <g:include controller="vencimiento" action="softhw" params="${[tipoVenc:'softhw'] }"/>
            </div>
            <div class="tab-pane" id="tab3">
              <g:include controller="vencimiento" action="softapl" params="${[tipoVenc:'vensoftapl'] }"/>
            </div>
            <div class="tab-pane" id="tab4">
			  <g:include controller="vencimiento" action="consop" params="${[tipoVenc:'venconsop'] }"/>              	
            </div>
            <div class="tab-pane" id="tab5">
              <g:include controller="vencimiento" action="adminRedsis" params="${[tipoVenc:'venadmin'] }"/>
            </div>
            <div class="tab-pane" id="tab6">
			  <g:include controller="vencimiento" action="adminTerceros" params="${[tipoVenc:'venadmter'] }"/>              	
            </div>
            <div class="tab-pane" id="tab7">
			  <g:include controller="vencimiento" action="arrRedsis" params="${[tipoVenc:'venarrend'] }"/>              	
            </div>
            <div class="tab-pane" id="tab8">
			  <g:include controller="vencimiento" action="arrTerceros" params="${[tipoVenc:'venarrter'] }"/>              	
            </div>
            <div class="tab-pane" id="tab9">
			  <g:include controller="vencimiento" action="vencidos" params="${[tipoVenc:'otrocontr'] }"/>              	
            </div>            
          </div>
        </div>                        
        </div>
    </div>

</body>
<script type="text/javascript">
$(function() 
        { 
          $('a[data-toggle="tab"]').on('shown', function () {
            //save the latest tab; use cookies if you like 'em better:
            localStorage.setItem('lastTab', $(this).attr('href'));
           });

          //go to the latest tab, if it exists:
          var lastTab = localStorage.getItem('lastTab');
          if (lastTab) {
             $('a[href=' + lastTab + ']').tab('show');
          }
          else
          {
            // Set the first tab if cookie do not exist
            $('a[data-toggle="tab"]:first').tab('show');
          }
      });

</script>
</html>

