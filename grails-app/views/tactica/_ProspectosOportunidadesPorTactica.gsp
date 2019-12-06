<g:set var="generalService" bean="generalService"/>
<div id="estrategiasYTacticas" class="tab-pane fade">     			
     				<!-- <iframe id="iftactica" src="/crm/estrategia/index" style="border:0;overflow:hidden;width:100%;" ></iframe> -->
     				<object type="text/html" width="100%"; height="700px;" data="/crm/estrategia/index"></object>
     				
</div>




	<!-- <div id="estrategiasYTacticas" class="fade tab-pane">HOLA MUNDO</div> -->
	<div id="detalles" class="row tab-pane fade in active">
	
	<div class="span6" style="padding-bottom:20px;">


<table class="table table-condensed display" id="tablaProspectos" style="width:100%;">
                <thead>
                    <tr>
                        <td>Código</td>                        
                        <td>Cliente</td>
                        <td>Vendedor</td>                        
                        <td>Estado</td>
                    </tr>
                </thead>
                <tbody>
                	<% i=0 %>
                	<g:each in="${prospectoInstanceList}" status="i" var="prospectoInstance">                	                    
	                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">                       
	                       <td style="vertical-align: middle">
                                <a style="text-decoration:underline" href="/crm/prospecto/show/${prospectoInstance.id}" >
                                    ${fieldValue(bean: prospectoInstance, field: "numProspecto")}
                                </a>
                            </td>                      
                            <td style="vertical-align: middle;max-width:190px;"> ${fieldValue(bean: prospectoInstance, field: "nombreCliente")}</td>
                            <td style="vertical-align: middle;">${prospectoInstance?.nombreVendedor}</td>      
                            <td style="vertical-align: middle;">${generalService.getValorParametro(prospectoInstance?.idEstadoProspecto)}</td>
	                    </tr>
	                </g:each>                    
                </tbody>
</table>

</div>

<div class="span6" style="padding-bottom:20px;">

<table class="table table-condensed" id="tablaOportunidades" style="width:100%;">             
                	    <thead>
                    <tr>
						<td>Código</td>                        
                        <td>Cliente</td>
                        <td>Vendedor</td>
                        <td>Estado</td>                  
                    </tr>
                </thead>
                <tbody>
                	<% i=0 %>
                	  <g:each in="${oportunidadInstanceList}" status="i" var="oportunidadInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">    

                       
                            <td style="vertical-align: middle">
                                <a   style="text-decoration:underline" href="/crm/oportunidad/show/${oportunidadInstance.id}" >
                                    ${fieldValue(bean: oportunidadInstance, field: "numOportunidad")}
                                </a>
                            </td>                     
                        <td style="max-width:190px;">${fieldValue(bean:oportunidadInstance,field:"nombreCliente")}</td>
                        <td>${fieldValue(bean:oportunidadInstance,field:"nombreVendedor")}</td>         
                        <% def estadoOptty=generalService.getValorParametro(oportunidadInstance.idEstadoOportunidad) %>              
                        <td>${estadoOptty}</td>
                    </tr>
                	</g:each>             
                </tbody>                
                
</table>

</div>
 
	</div>


<div id="prospectosAsignados" class="fade tab-pane">
     <table class="table table-condensed">             
                	    <thead>
                    <tr>
                        <td>Razón Social</td>
                        <td>Nro. de prospectos</td>                                              
                    </tr>
                </thead>
                <tbody>
                	<% cliente=0 %>
     			 <g:each in="${resultadoProspsGeneradosPorCliente}" status="i" var="prospPorClienteInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">    

                        
                                       <td> ${prospPorClienteInstance[0]}</td> 
                                       <td> ${prospPorClienteInstance[1]}</td>                    
                    </tr>
                	</g:each>             
                </tbody>                
                
</table>
</div>


<div id="oportunidadesGeneradas" class="fade tab-pane">
     <table class="table table-condensed">             
                	    <thead>
                    <tr>
                        <td>Razón Social</td>
                        <td>Nro. de oportunidades</td>                                              
                    </tr>
                </thead>
                <tbody>
                	<% cliente=0 %>
     			 <g:each in="${resultadoOpptysAsignadasPorCliente}" status="i" var="opptyPorClienteInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">                            
                                       <td> ${opptyPorClienteInstance[0]}</td> 
                                       <td> ${opptyPorClienteInstance[1]}</td>                    
                    </tr>
                	</g:each>             
                </tbody>                
                
</table>
</div>

     			<div id="urlCampanasYEventos" class="tab-pane fade in">     			
     			 <g:each in="${listaDePiezas}" status="piezaNumber" var="valorPieza">     			 
     			 	<br><a style="color:#e95a0c;font-size:1.7em;font-family:'Calibri'" target="_blank" href="${valorPieza.url}">${piezaNumber+1}. ${valorPieza.textoParaMostrar}</a><br>
     			 </g:each>
     			</div>





