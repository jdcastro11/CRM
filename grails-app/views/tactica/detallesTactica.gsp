<%@ page import="crm.Empresa" %>
<%@ page import="crm.Tactica" %>

<g:set var="generalService" bean="generalService"/>



<!DOCTYPE html>
<html>
    <head>       

		
		<g:javascript src="pruebaTacticas.js" />
		<link rel="stylesheet" href="${resource(dir: 'css/css-personalizados', file: 'campanasYEventos.css')}" type="text/css">
		<meta name="layout" content="perfectum">
		
		

    </head>
    <body>

            <!-- <div class="controls input-append date form_date"  data-date-format="dd-mm-yyyy" style="margin-left:0px;">
            <input  type="text" name="fechaProspectos" value="${g.formatDate(format:'dd-MM-yyyy')}"
                    style="width:153px;" readonly id="fechaConsulta">
                    
                        <span class="add-on"><i class="icon-remove"></i></span>
                    <span class="add-on"><i class="icon-th"></i></span>
                    
        </div> -->

     <div class="container">
     	<div class="row" style="padding-top:30px;">
     	   	<div style="text-align:center;">
     	    	<p style="font-size:35px;font-family:'Lucida Console'">CAMPAÑAS Y EVENTOS<p>
     	    </div>
     	<!-- 	<div class="span6">
     			<input type="text" class="form-control" id="tacticasDisponibles" style="width:70%;float:right;margin-right:20px;" placeholder="Buscar táctica...">
     		</div> -->
     		     		
     	</div>     	
     	
     	
     	<div class="row" style="padding-top:30px;">
    <div class="span4">
    	<div class="controls" style="text-align:center">
    			<label class="control-label">
		            <g:message code="estrategia.descripcionFiltro" default="Seleccione una estrategia:" />
		        </label>
               <g:select name="idEstrategiasSelect" id="idEstrategiasSelect" style="width:260px;"  from="${listaEstrategias}"
                optionKey="id"                    
                noSelection="['': '']" disabled="false" required=""  />
        </div>
    </div>
    <div class="span4">
		    	
	            <div class="controls" style="text-align:center">
	            <label class="control-label">
		            <g:message code="tactica.descripcionFiltro" default="Seleccione una táctica:" />
		        </label>
                    <g:select name="idTacticasSelect" id="idTacticasSelect"  from="${listaTacticas}"
                        optionKey="id"                    
                    noSelection="['': '']" disabled="false" required="" />
                </div>    	
    </div>
    <div class="span4">
    		
    		<div class="controls" style="text-align:center">
    		<label class="control-label">
	            <g:message code="tactica.anioFiltro" default="Año:" />
    	    </label>
                   <g:select name="idFecha" id="idFecha"  from="${["2019","2018","2017","2016","2015","2014"]}"
                                 value="2019"
                    disabled="false" required="" style="width:80px;" />
            </div>
    </div>
    	
    </div>
       
     	
     	
     	<div class="row" style="margin-top:20px;">
     		<div class="span6">     			
	     		   <div class="mercadeo">
	     		   	<div class="row">
	     		   		<div class="span6 antesImagen" >
     						<div>
     							<div>
	     							<p class="numero" id="numeroProsp" style="padding-top:20px;text-align:right;">0</p>
	     		   				</div>
	     		   				<div>
	     		   					<p class="labelMercadeo">Prospectos asignados</p>
	     		   				</div>
	     		   			</div>	
     					</div>
     						<div class="span6">
     								<div>
	     		   						<img alt="Redsis.com" src="${resource(dir: 'perfectum/img', file: 'mercadeoprosp.png')}" />
	     		   					</div>	
     						</div>
	     		   	</div>	
	     		   </div>
	     		   
     		</div>
     		<div class="span6">
     				<div class="mercadeo">
     					<div class="row">
     						<div class="span6 antesImagen">
     							<div>
	     							<div>
		     							<p class="numero" id="numeroOpor"  style="padding-top:20px;text-align:right;">0</p>
		     		   				</div>
		     		   				<div>
		     		   					<p class="labelMercadeo">Oportunidades generadas</p>
		     		   				</div>
		     		   			</div>	
     						</div>
     							<div class="span6">
     								<div>
	     		   						<img alt="Redsis.com" src="${resource(dir: 'perfectum/img', file: 'mercadeopor.png')}" />
	     		   					</div>	
     						</div>
     					
     					</div>
     					
	     		   		
	     		   </div>
	     		   	     		   
     		</div>
     	</div>
     	
     	
     	
	   	<ul class="nav nav-tabs" style="margin-top:40px;">
			  <li class="active">
		    	<a href="#estrategiasYTacticas" data-toggle="tab">Estrategias-Tacticas</a>
		  	   </li>
		  <li>
		    <a href="#detalles" data-toggle="tab">Detalles</a>
		  </li>
		  <li><a href="#prospectosAsignados" data-toggle="tab">Prospectos por cliente</a></li>
		  <li><a href="#oportunidadesGeneradas" data-toggle="tab">Oportunidades por cliente</a></li>
		  <li><a href="#urlCampanasYEventos" data-toggle="tab">Piezas</a></li>
		</ul>

<div id="loading" style="margin:0 auto;" class="loadingGif">
	     		   						<img alt="Redsis.com" src="${resource(dir: 'perfectum/img', file: 'loading2.gif')}" />
	     		   					</div>
     	
     	
     	<div id="contenido">
     		<div class="tab-content" id="contenidoTabs">
     			<div id="estrategiasYTacticas" class="tab-pane fade in active">     			
     				<!-- <iframe id="iftactica" src="/crm/estrategia/index" style="border:0;overflow:hidden;width:100%;" ></iframe> -->
     				<object style="overflow:hidden;" type="text/html" width="100%" height="1500px" data="/crm/estrategia/index"></object>
     				
     			</div>
     			<div id="detalles" class="tab-pane fade in">
     			</div>
     			<div id="prospectosAsignados" class="tab-pane fade in">
     			</div>
     			<div id="oportunidadesGeneradas" class="tab-pane fade in">
     			</div>
     			<div id="urlCampanasYEventos" class="tab-pane fade in">
     			 <g:each in="${listaDePiezas}" status="piezaNumber" var="valorPieza">     			 
     			 	<br><a style="color:#e95a0c;font-size:1.7em;font-family:'Calibri'" target="_blank" href="${valorPieza.url}">${piezaNumber+1}. ${valorPieza.textoParaMostrar}</a><br>
     			 </g:each>
     			</div>
     		</div>     		
		</div>
     	</div>
     
        <script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.js')}"></script>
		<script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.es.js')}"></script>
		<script type="text/javascript">obtenerListaOrigen();//obtenerListaOrigen2();</script>            

									
    
</body>     

    
</html>
