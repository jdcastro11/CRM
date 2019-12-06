<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'estilosPersonalizados.css')}" type="text/css">
<g:set var="generalService" bean="generalService" />
<%@ page import="crm.Empleado"%>


<!-- VERIFICAMOS SI SE PUEDE CARGAR O NO EL ENCABEZADO PARA EL ROL QUE VA ACCEDIENDO -->


<g:set var="generalService" bean="generalService" />
<%  
   def puedeMostrarse = "No" 
 %>
 <g:if test="${'VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())}" >
  <%  
    puedeMostrarse = "Si" 
  %>
 </g:if>

 <g:if test="${'GERENTE'  in generalService.getRolUsuario(session['idUsuario'].toLong())}" >
  <%  
    puedeMostrarse = "Si" 
  %>
 </g:if>
 
 <g:if test="${'ADMIN_FUNCIONAL'  in generalService.getRolUsuario(session['idUsuario'].toLong())}" >
  <%  
    puedeMostrarse = "Si" 
  %>
 </g:if>
 
 <g:if test="${'ADMIN_SISTEMAS'  in generalService.getRolUsuario(session['idUsuario'].toLong())}" >
  <%  
    puedeMostrarse = "Si" 
  %>
 </g:if>
 <!-- FINAL VERIFICACION SI SE PUEDE CARGAR O NO EL ENCABEZADO PARA EL ROL QUE VA ACCEDIENDO -->
 
<g:if test="${puedeMostrarse == 'Si'}" >	 
<!-- Start: Estado del ejecutivo -->
                    <div class="div-mobile">
                        <div class="row-fluid" id="pruebaencabezado">
                            <!--  GENERADO -->
                            <div class="box span2">
                                <div class="panel panel-generated">
                                    <div class="panel-heading panel-heading-generated">
                                        <i class="fa-icon-refresh margin-right"></i><span class="break"></span>Generado
                                    </div>
                                    <div class="panel-body" id="generado"><span class="break">USD$</span>
                                        ${infoEmpleadoQ.generado?:0}</div>
                                </div>
                            </div>
                            
                             <!--  ASIGNADO -->
                             <div class="box span2">
                                <div class="panel panel-asigned">
                                    <div class="panel-heading panel-heading-asigned">
                                        <i class="fa-icon-list-ol margin-right"></i><span class="break"></span>Asignado
                                    </div>
                                    <div class="panel-body" id="asignado">
                                        <span class="break">USD$</span>
                                        ${infoEmpleadoQ.asignado?:0}</div>
                                </div>
                            </div>      
                                

                             <!--  FORECAST -->
                            
                            <div class="box span2">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        <i class="fa-icon-bar-chart margin-right"></i><span class="break"></span>Forecast
                                    </div>
                                    <div class="panel-body" id="forecast"> 
                                        <span class="dollar">USD$</span>
                                        ${infoEmpleadoQ.forecast?:0}</div>
                                </div>
                            </div>
                            
                             <!--  GANADO -->
                            <div class="box span2">
                                <div class="panel panel-win">
                                    <div class="panel-heading panel-heading-win">
                                        <i class="fa-icon-thumbs-up margin-right"></i><span class="break"></span>Ganado
                                    </div>
                                    <div class="panel-body" id="ganadas">
                                        <span class="dollar">USD$</span>
                                        ${infoEmpleadoQ.ganadas?:0}</div>
                                </div>
                            </div>
                            
                             <!--  FACTURADO -->
                            <div class="box span2">
                                <div class="panel panel-invoiced"  >
                                    <div class="panel-heading panel-heading-invoiced">
                                        <i class="fa-icon-money margin-right"></i><span class="break"></span>Facturado
                                    </div>
                                    <div class="panel-body" id="facturado" style="font-size:9px;height:20px;line-height:12px;padding:2px 5px 7px 5px;"> 
                                        <span id="fpesos">USD$: ${infoEmpleadoQ.facturadoDolares?:0}</span><br>
                                        <span id="fdolar">COP  : ${infoEmpleadoQ.facturadoPesos?:0}</span> </div>
                                </div>
                            </div>
                            
                            <!--  PERDIDO -->
                            <div class="box span2">
                                <div class="panel panel-lost">
                                    <div class="panel-heading panel-heading-lost">
                                        <i class="fa-icon-thumbs-down margin-right"></i><span class="break"></span>Perdido
                                    </div>
                                    <div class="panel-body" id="perdida">
                                        <span class="dollar">USD$</span>
                                        ${infoEmpleadoQ.perdida?:0}</div>
                                </div>
                            </div>




                            
                            
                            
                  </div>
                  
                  <div class="container">
                  
                  
                  		<div style="margin-top:30px;">
							<h3 style="position:absolute;left:0;top:-7px;">Filtro y reportes oportunidades</h3>
							<h3 style="position:absolute;left:50%;top:-7px;">Porcentaje de cumplimiento</h3>
						</div>
						<form id="myForm"> 			
	                  	<div id="infoQIzq">
	                  		<div class="infoQHeader">
	                  			<p>Por trimestre</p>
	                  			<p>Por vendedor</p>
	                  			<p>Por ciudad</p>
	                  		</div>
	                  		<div>
	                  			<!-- Q's -->   
	                  			<div class="infoQ">                                                	
									Q1<input type="checkbox" name="QinfoQ" value="Q1" style="float:right;" checked><br>
									Q2<input type="checkbox" name="QinfoQ" value="Q2" style="float:right;"><br>
									Q3<input type="checkbox" name="QinfoQ" value="Q3" style="float:right;"><br>
									Q4<input type="checkbox" name="QinfoQ" value="Q4" style="float:right;"><br>
								</div>
								<!-- Q's -->
								
								
		
											
											
												
								
								<!-- LISTA DE VENDEDORES -->
								<div class="infoQ">									
									<g:each in="${vendedores}" status="i" var="vendedorInstance">
										<% def vendedor=vendedorInstance.toString()
											if(vendedor.equals('Televentas Bucaramanga'))
												vendedor=vendedor.replace('Televentas Bucaramanga','Televentas BUC')
											if(vendedor.equals('Televentas Barranquilla'))
												vendedor=vendedor.replace('Televentas Barranquilla', 'Televentas BAQ')
											if(vendedor.equals('Televentas Bogota'))										
												vendedor=vendedor.replace('Televentas Bogota', 'Televentas BOG')
										 %>
										 																						
										<g:if test="${vendedorInstance==usuarioLogueado}">
											${vendedor}<input style="float:right;" type="checkbox" name="vendedores" value="${vendedorInstance?.id}" checked><br>
										</g:if>
										<g:else>
											${vendedor}<input style="float:right;" type="checkbox" name="vendedores" value="${vendedorInstance?.id}"><br>
										</g:else>
										
										
									</g:each>																		
								</div>
								<!-- LISTA DE VENDEDORES -->

								 
								<div class="infoQ">
									<g:each in="${sucursales}" status="i" var="sucursalInstance">
									<% def sucursales =sucursalInstance.toString().replace('REDSIS','') %>
										
										<g:if test="${Empleado.get(usuarioLogueadoId).idSucursal==sucursalInstance?.id}">
											${sucursales}<input style="float:right;" type="checkbox" name="sucursales" value="${sucursalInstance?.id}" checked><br>
										</g:if>
										<g:else>
											${sucursales}<input style="float:right;" type="checkbox" name="sucursales" value="${sucursalInstance?.id}"><br>
										</g:else>										
									</g:each>
								</div>
								
	                  		</div>
	                  	</div>
	                  	
	                  	<div id="infoQDer">
	                  				<div class="infoQHeader">
	                  					<p style="width:100%;">%</p>		                  				
	                  				</div>	                  	
	                  	</div>            	
	                  	
						<!-- LISTA DE SUCURSALES -->	                  	
	                  	<div style="text-align:center;margin:27px 0;">
								<div id="porcenGener" class="divPorcentaje" style="background-color:#017489"><h4>Generado</h4><p>${infoEmpleadoQ.porcentajeGenerado}%</p></div>
								<div id="porcenAsig" class="divPorcentaje" style="background-color:#2F20AF"><h4>Asignado</h4><p>${infoEmpleadoQ.porcentajeAsignado}%</p></div>
								<div id ="porcenForec" class="divPorcentaje" style="background-color:#438BCA"><h4>Forecast</h4>
									<g:if test="${infoEmpleadoQ.porcentajeForecast==0 ||infoEmpleadoQ.porcentajeForecast=='No aplica'}"  >
										<p>No aplica</p>
									</g:if>
									<g:else>
										<p>${infoEmpleadoQ.porcentajeForecast}%</p>
									</g:else>
																	
								</div>
								<div id="porcenGana" class="divPorcentaje" style="background-color:#117200"><h4>Ganado</h4><p>${infoEmpleadoQ.porcentajeGanada}%</p></div>
								<div id="porcenFac" class="divPorcentaje" style="background-color:#E69100"><h4>Facturado</h4><p>${infoEmpleadoQ.porcentajeFacturado}%</p></div>
								<div id="porcenPerd" class="divPorcentaje" style="background-color:#DA1E0D"><h4>Perdido</h4><p>${infoEmpleadoQ.porcentajePerdido}%</p></div>					
						</div>
						<!-- LISTA DE SUCURSALES -->
						</form>
												
                  </div>










			

                  

						                           
                         
                        



				  
  					
						

			
						
						
						
						
						
</div>

                    
  </g:if>



                    
<script>actualizarInfoQ();</script> 