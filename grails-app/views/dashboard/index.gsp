<%@ page import="org.grails.plugins.google.visualization.formatter.BarFormatter" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'parametro.label', default: 'Parametro')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <script src="${resource(dir: 'js', file:'crm_helper.js')}"></script> 
        <script type="text/javascript" src="http://www.google.com/jsapi"></script>
    </head>
    <body>
        <g:set var="generalService" bean="generalService" />
        <g:set var="pedidoService" bean="pedidoService" />
        <h1>Panel de Control</h1>  
        <hr style="margin-top:10px;margin-bottom:10px;">
        <g:if test="${'VENDEDOR'  in generalService.getRolUsuario(session['idUsuario'].toLong())}" >	   
            <div class="row-fluid">
                <div class="box span6" onTablet="span6" onDesktop="span6">
                 <% def xidvendedor=generalService.getIdEmpleado(session['idUsuario']) %>
                  <a href="#" class="btn btn-success  btn-mini" style="margin-top:-50px;"
                  onclick='return BootstrapDialog.confirm("Está seguro de actualizar indicadores?",
                  function(result) { if(result)window.location.href="/crm/pedido/actualizarIndicadores/${xidvendedor}"})'
                  >Actualizar Indicadores </a>                   
                  
                    <div class="tabbable" >
                        <ul class="nav  nav-tabs" id="myTab" style="font-weight: bold;">
                            <li class="active"><a href="#home" data-toggle="tab">Indicadores x Trimestre</a></li>
                            <li><a href="#xmeses"  data-toggle="tab">Indicadores x Meses</a></li>                    
                        </ul>
                        <div class="tab-content" style="overflow:hidden;">
                            <div class="tab-pane active" id="home">
                                <%
                                    def idemp= generalService.getIdEmpleado(session['idUsuario'])                                      
                                    def cols1 = [['string', 'Year'], ['number', 'Ventas'],['number', 'Meta']]
                                    def datos1=pedidoService.indicadorVentasQ(idemp) 
                                    def hoy =  new Date()
                                    def xanio=hoy[Calendar.YEAR]
                                    def periodo=generalService.getTrim(hoy)
                                    def xmes1=hoy[Calendar.MONTH]+1
                                    def xmes=xmes1.toString().padLeft(2,'0')
                                    
                                %>
                                <gvisualization:columnCoreChart elementId="ventasQ" title="Ventas & Meta Acumuladas (en miles Us)" width="${480}" height="${250}" 
                                                                columns="${cols1}" data="${datos1}" isStacked="${false}"  />
                                <div id="ventasQ"></div> 
                                
                                <g:select id="trim" name="trim" from="['Q1','Q2','Q3','Q4']" 
                                          value="${periodo}" 
                                          onchange="${remoteFunction(controller:'Indicador',
                                                        action:'mostrarGraficaHbar',params:'\'id=\'+this.value',
                                                        update: [success: 'divtrim'])}" />  
                                <%
                                 def colsQ = [['string', ''], ['number', 'Miles Us']]
        
                                 def datosQ = [['Prosp'  ,generalService.getValorIndicador(idemp,periodo,xanio,'prospecto','vprospxven')], 
                                               ['Opor10%', generalService.getValorIndicador(idemp,periodo,xanio,'oportunidad','opor10xven')], 
                                               ['Opor25%', generalService.getValorIndicador(idemp,periodo,xanio,'oportunidad','opor25xven')], 
                                               ['Opor50%', generalService.getValorIndicador(idemp,periodo,xanio,'oportunidad','opor50xven')],
                                               ['Ganadas', generalService.getValorIndicador(idemp,periodo,xanio,'oportunidad','vopganxven')]]
                                %>
                              <div id="divtrim"> 
                                    <g:set var="colsQ"  value="${colsQ}" scope="request" />
                                    <g:set var="datosQ"  value="${datosQ}" scope="request" />
                                    <g:set var="xdiv"  value="Hbarra01" scope="request" />
                                 <g:render template="/indicador/mostrarGraficaHbar" />
                               </div>
                            </div>
                            <div class="tab-pane" id="xmeses">
                                <%                                                                   
                                def cols = [['string', 'Year'], ['number', 'Ventas'],['number', 'Meta']]
                                def datos=pedidoService.indicadorVentasM(idemp) 
                                %>
                                <gvisualization:columnCoreChart elementId="ventasM" title="Ventas & Meta Acumuladas (en miles Us)" width="${480}" height="${250}"                                                                 
                                                                columns="${cols}" data="${datos}" isStacked="${false}"   />
                                <div id="ventasM"></div> 
                                
                                <% 
                                   def zmeses=['01':'Enero','02':'Febrero','03':'Marzo','04':'Abril','05':'Mayo','06':'Junio',
                                               '07':'Julio','08':'Agosto','09':'Septiembre','10':'Octubre','11':'Noviembre','12':'Diciembre' ]                                   
                                %>     
                                <g:select name="mes" from="${zmeses.entrySet()}" 
                                          optionKey="key" optionValue="value" value="${xmes}"                                          
                                          onchange="${remoteFunction(controller:'Indicador',
                                                        action:'mostrarGraficaHbar',params:'\'id=\'+this.value',
                                                        update: [success: 'divtrim1'])}"
                                          />
                                 <%
                                 def colsQ1 = [['string', ''], ['number', 'Miles Us']]
                                
                                 def datosQ1 = [['Prosp'  ,generalService.getValorIndicador(idemp,xmes,xanio,'prospecto','vprospxven')], 
                                               ['Opor10%', generalService.getValorIndicador(idemp,xmes,xanio,'oportunidad','opor10xven')], 
                                               ['Opor25%', generalService.getValorIndicador(idemp,xmes,xanio,'oportunidad','opor25xven')], 
                                               ['Opor50%', generalService.getValorIndicador(idemp,xmes,xanio,'oportunidad','opor50xven')],
                                               ['Ganadas', generalService.getValorIndicador(idemp,xmes,xanio,'oportunidad','vopganxven')]]
                                %>  
                                          
                                 <div id="divtrim1"> 
                                    <g:set var="colsQ"  value="${colsQ1}" scope="request" />
                                    <g:set var="datosQ"  value="${datosQ1}" scope="request" />
                                     <g:set var="xdiv"  value="Hbarra02" scope="request" />
                                 <g:render template="/indicador/mostrarGraficaHbar" />
                               </div>
                            </div>
                        </div>
                    </div>                

                </div>
                <div class="box span6 " onTablet="span6" onDesktop="span6" style="margin-top:-15px">

                    <h2>Pedidos <a href="#" onclick="recargarIframe('ifpedidos')"><i class="icon-refresh"></i></a></h2>      
                    <iframe id="ifpedidos" src="/crm/pedido/indexp/" style="border:0;width:100%;height:180px" scrolling="no"></iframe>

                    <h2>Oportunidades <a href="#" onclick="recargarIframe('ifoportun')"><i class="icon-refresh"></i></a></h2>      
                    <iframe id="ifoportun" src="/crm/oportunidad/indexp/" style="border:0;width:100%;height:180px" scrolling="no"></iframe>

                    <h2>Oportunidades Pendientes x Bitacora <a href="#" onclick="recargarIframe('ifactivi')"><i class="icon-refresh"></i></a></h2>      
                    <iframe id="ifactivi" src="/crm/oportunidad/listaPendientesPorNota" style="border:0;width:100%;height:260px" scrolling="no"></iframe>
                </div>           
            </div>
        </g:if>
        <g:else>
            <div style="min-height:600px;"></div>  
        </g:else>
    </body>
</html>