<%@ page import="crm.Empleado"%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <g:set var="entityName" value="${message(code: 'parametro.label', default: 'Parametro')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>   
		<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>

    </head>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <body>
    <p><b>MAURY</b></p>
    <p>${hola}</p>
        <div class="row-fluid">
            <div class="span12">
                <div class="box">
                    <div class="box-header">
                        <h2>
                            <i class="fa-icon-bar-chart"></i>
                            Panel Control
                        </h2>
                    </div>
                    
                    
					

                    <div class="box-content">
                                        
                    <g:formRemote name="myForm" url="[controller:'dashboard',action:'render']" update="bachart1">
                    	
                    	<g:submitButton name="Get The Sum"></g:submitButton>               
                    
                    

                    
                    
                    
                    
                    <gvisualization:barCoreChart elementId="bachart1" title="Porcentajes de cumplimiento (%)" width="${720}" height="${400}"
					columns="${myDailyActivitiesColumns}" data="${myDailyActivitiesData}" legend="right" />
					
					<!--<gvisualization:pieCoreChart elementId="chart_div2" title="Facturado vs Cuota" width="${450}" height="${200}"
					columns="${columns}" data="${rows}" />-->
					
					<gvisualization:pieCoreChart elementId="chart_div4" title="Probabilidad oportunidades" width="${530}" height="${280}"
					columns="${oportunidades}" data="${porcentajeOp}"  />
              
                                       
                    
                 					<div class="row-fluid">
	                                    <div class="span9">
	                                        <div class="panel panel-default"  style="height:470px;">
	                                            <div class="panel-heading">
	                                                <div class="row-fluid">
	                                                    <div class="span8">
	                                                        <h2>Indicador de gestión</h2>
	                                                    </div>                                                    
	                                                </div>
	                                            </div>
	                                            <div id="bachart1"></div>
	                                        </div>
	                                    </div>
	                                    
	                                    <div class="span3">
	                                        <div class="panel panel-default"  style="height:470px;">
	                                            <div class="panel-heading">
	                                                <div class="row-fluid">
	                                                    <div class="span8">
	                                                        <h2>Filtro</h2>
	                                                    </div>                                                    
	                                                </div>
	                                        </div>
	                                    <div>
	                                            
	                                            
	                                            
	                                            
	                           <div class="infoQ" style="float:none;width:inherit;">                                                	
									Q1<input type="checkbox" name="QinfoQ" value="Q1" style="float:right;"><br>
									Q2<input type="checkbox" name="QinfoQ" value="Q2" style="float:right;"><br>
									Q3<input type="checkbox" name="QinfoQ" value="Q3" style="float:right;" checked><br>
									Q4<input type="checkbox" name="QinfoQ" value="Q4" style="float:right;"><br>
								</div>				
								
								
																 
								<div class="infoQ" style="float:none;width:inherit;">
									<g:each in="${sucursales}" status="i" var="sucursalInstance">
									<% def sucursales =sucursalInstance.toString().replace('REDSIS','') %>
										
										<g:if test="${Empleado.get(usuarioLogueadoId).idSucursal==sucursalInstance.id}">
											${sucursales}<input style="float:right;" type="checkbox" name="sucursales" value="${sucursalInstance.id}" checked><br>
										</g:if>
										<g:else>
											${sucursales}<input style="float:right;" type="checkbox" name="sucursales" value="${sucursalInstance.id}"><br>
										</g:else>
									</g:each>
								</div>
								
								
								<div class="infoQ" style="float:none;width:inherit;">									
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
											${vendedor}<input style="float:right;" type="checkbox" name="vendedores" value="${vendedorInstance.id}" checked><br>
										</g:if>
										<g:else>
											${vendedor}<input style="float:right;" type="checkbox" name="vendedores" value="${vendedorInstance.id}"><br>
										</g:else>
									</g:each>																		
								</div>
								
								
												</g:formRemote>				 
								
	                                            
	                                            
	                                            
	                                            </div>
	                                            
	                                            
	                                        </div>
	                                    </div>
	                                    
	                                 </div>


                                    
                                    
                                    
                                    <div class="row-fluid">

                                    <div class="span13m">
                                        <div class="panel panel-default" style="height:350px;">
                                            <div class="panel-heading">
                                                <div class="row-fluid">
                                                    <div class="span8">
                                                        <h2>Oportunidades</h2>
                                                    </div>
                                                    
                                                </div>
                                            </div>
                                            <div id="chart_div4"></div>
                                        </div>
                                    </div>
                                </div>
                                    
                                    
                                    
                                    
                                    
                                    
                                </div>

                    
                    
                    
                    
                    
                    
                    
                    
                    
                        

                    </div>
                  </div>
              </div>
              <script>actualizarInfoQ();</script>          
    </body>
 <script>actualizarInfoQ();</script>
</html>
 