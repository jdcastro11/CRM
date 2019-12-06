<%@ page import="org.grails.plugins.google.visualization.formatter.BarFormatter" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <g:set var="entityName" value="${message(code: 'parametro.label', default: 'Parametro')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        
        
         <g:javascript src="handlebars-v1.3.0.js"/>
         <g:javascript src="funcionesPersonalizadasChar.js"/>
      
         <g:javascript src="templates/detalle_cuotaVScumplimiento.js"/>
        
         <g:javascript src="templates/detalle_facYped.js"/>
        
         <g:javascript src="templates/detalle_forecast.js"/>
         
         <g:javascript src="templates/detalle_leads.js"/>  
         
        <script>
            google.load("visualization", "1", {packages:["gauge"]});
            google.load('visualization', '1.0', {'packages':['corechart']});
       
        </script>

    </head>
    <body>
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
                        <ul class="nav tab-menu nav-tabs" id="mytab">
                            <li class="active"><a href="#cpanel">Gerencia</a></li>
                        </ul>

                        <button class="btn btn-success" style="margin-bottom: 20px;"><i class="icon-refresh"></i></button>

                        <div id="myTabContent" class="tab-content">
                            <div class="tab-pane active" id="cpanel">
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <div class="row-fluid">
                                                    <div class="span8">
                                                        <h2>Cuota vs Cumplimiento</h2>
                                                    </div>
                                                    <div class="span4" style="text-align: right">
                                                        <a href="javascript:void(0)" id="chart-cc-tri">Trimestral</a> |
                                                        <a href="javascript:void(0)" id="chart-cc-anual">Anual</a> |
                                                        <a href="javascript:void(0)" id="det-cc">Detalle</a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="chart_div"></div>
                                        </div>
                                    </div>

                                    <div class="span6">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <div class="row-fluid">
                                                    <div class="span8">
                                                        <h2>Leads Asignados</h2>
                                                    </div>
                                                    <div class="span4" style="text-align: right">
                                                        <a href="javascript:void(0)" id="chart-leads-tri">Trimestral</a> |
                                                        <a href="javascript:void(0)" id="chart-leads-anual">Anual</a> |
                                                        <a href="javascript:void(0)" id="det-la">Detalle</a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="chart_div2"></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <div class="row-fluid">
                                                    <div class="span8">
                                                        <h2>Forecast</h2>
                                                    </div>
                                                    <div class="span4" style="text-align: right">
                                                        <a href="javascript:void(0)" id="det-f">Detalle</a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="chart_div3">
                                                <br><br><br><br>
                                                <p>$1,000.000</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="span6">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <div class="row-fluid">
                                                    <div class="span8">
                                                        <h2>Facturados y Pedidos</h2>
                                                    </div>
                                                    <div class="span4" style="text-align: right">
                                                        <a href="javascript:void(0)" id="det-fp">Detalle</a>
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
            </div>
        </div>
    </body>
</html>
