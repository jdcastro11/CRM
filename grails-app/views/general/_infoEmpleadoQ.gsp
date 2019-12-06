<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script> 
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
                                    <div class="panel-body"><span class="break">COP$</span>
                                        <g:formatNumber name="generado" number="${infoEmpleadoQ.generado}" format="###,###,###" locale="co"/></div>
                                </div>
                            </div>
                            
                             <!--  ASIGNADO -->
                               <div class="box span2">
                                <div class="panel panel-asigned">
                                    <div class="panel-heading panel-heading-asigned">
                                        <i class="fa-icon-list-ol margin-right"></i><span class="break"></span>Asignado
                                    </div>
                                    <div class="panel-body">
                                        <span class="break">COP$</span>
                                        <g:formatNumber name="asignado" number="${infoEmpleadoQ.asignado}" format="###,###,###" locale="co"/></div>
                                </div>
                            </div>      
                                

                             <!--  FORECAST -->
                            
                            <div class="box span2">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        <i class="fa-icon-bar-chart margin-right"></i><span class="break"></span>Forecast
                                    </div>
                                    <div class="panel-body"> 
                                        <span class="dollar">COP$</span>
                                        <g:formatNumber name="forecast" number="${infoEmpleadoQ.forecast}" format="###,###,###" locale="co"/></div>
                                </div>
                            </div>
                            
                             <!--  GANADO -->
                            <div class="box span2">
                                <div class="panel panel-win">
                                    <div class="panel-heading panel-heading-win">
                                        <i class="fa-icon-thumbs-up margin-right"></i><span class="break"></span>Ganado
                                    </div>
                                    <div class="panel-body">
                                        <span class="dollar">COP$</span>
                                        <g:formatNumber name="ganado" number="${infoEmpleadoQ.ganadas}" format="###,###,###" locale="co"/></div>
                                </div>
                            </div>
                            
                             <!--  FACTURADO -->
                            <div class="box span2">
                                <div class="panel panel-invoiced">
                                    <div class="panel-heading panel-heading-invoiced">
                                        <i class="fa-icon-money margin-right"></i><span class="break"></span>Facturado
                                    </div>
                                    <div class="panel-body"> 
                                        <span class="dollar">COP$</span>
                                        <g:formatNumber name="facturado" number="${infoEmpleadoQ.facturado}" format="###,###,###" locale="co"/></div>
                                </div>
                            </div>
                            
                            <!--  PERDIDO -->
                            <div class="box span2">
                                <div class="panel panel-lost">
                                    <div class="panel-heading panel-heading-lost">
                                        <i class="fa-icon-thumbs-down margin-right"></i><span class="break"></span>Perdido
                                    </div>
                                    <div class="panel-body">
                                        <span class="dollar">COP$</span>
                                        <g:formatNumber name="perdido" number="${infoEmpleadoQ.perdida}" format="###,###,###" locale="co"/></div>
                                </div>
                            </div>
                           
                            
                           
                        </div>
                    </div>
  </g:if>
                    <!-- End: Estado del ejecutivo -->


