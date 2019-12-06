$(document).on("ready", inicio);


function inicio () {
    adicionarFuncionesChar();
    cargarFuncionesPanelGerencia();
}

function adicionarFuncionesChar(){
  
    
    $('#mytab a').click(function (event) {
        event.preventDefault();
        $(this).tab('show');
    });
    
     /* Close Tab */
    $('#mytab').on('click', 'li a .closeTab', function(){
        var tabId = $(this).parents('li').children('a').attr('href');
        $(this).parents('li').remove('li');
        $(tabId).remove();
        $('#tabs a:last').tab('show');
    });
    
   
    /* Pestaña de detalles - Cuota VS Cumplimientio */
    $('#det-cc').click(function(){
        var temp = Handlebars.templates['detalle_cuotaVScumplimiento'];
       if($('#view-det-cc').length === 0){
           $('<li><a href="#view-det-cc" data-toggle="tab"><span class="close closeTab"><i class="icon-remove"></i></span>Detalle Cuota VS Cumplimiento</a></li>').appendTo('#mytab');
           $('<div class="tab-pane" id="view-det-cc">' + temp() + '</div>').appendTo('.tab-content');
           $('#mytab a:last').tab('show');
       } else{
           $('#mytab a[href="#view-det-cc"]').tab('show');
       }
    });
  
    
     /* Ver X Ciudad */
    $(document).on('click', '.active #ccXciu', function(){
        $('#chart_cc_ven').addClass('ocultar');
        $('#chart_cc_tri').addClass('ocultar');
        $('#chart_cc_ano').addClass('ocultar');
        $('#chart_cc_ciu').removeClass('ocultar');
    });
    
    /* Ver X Vendedor */
    $(document).on('click', '.active #ccXven', function(){
        $('#chart_cc_ciu').addClass('ocultar');
        $('#chart_cc_tri').addClass('ocultar');
        $('#chart_cc_ano').addClass('ocultar');
        $('#chart_cc_ven').removeClass('ocultar');
    });
    /* Ver X Trimestre */
    $(document).on('click', '.active #ccXtri', function(){
        $('#chart_cc_ciu').addClass('ocultar');
        $('#chart_cc_ven').addClass('ocultar');
        $('#chart_cc_ano').addClass('ocultar');
        $('#chart_cc_tri').removeClass('ocultar');
    });
    /* Ver X Año */
    $(document).on('click', '.active #ccXano', function(){
        $('#chart_cc_ciu').addClass('ocultar');
        $('#chart_cc_ven').addClass('ocultar');
        $('#chart_cc_tri').addClass('ocultar');
        $('#chart_cc_ano').removeClass('ocultar');
    });
    
    /* Pestaña de detalles - Leads Asignados */
    $('#det-la').click(function(){
        var temp = Handlebars.templates['detalle_leads'];
       if($('#view-det-la').length === 0){
           $('<li><a href="#view-det-la" data-toggle="tab"><span class="close closeTab"><i class="icon-remove"></i></span>Detalle Leads Asignados</a></li>').appendTo('#mytab');
           $('<div class="tab-pane" id="view-det-la">' + temp() + '</div>').appendTo('.tab-content');
           $('#mytab a:last').tab('show');
       } else{
           $('#mytab a[href="#view-det-la"]').tab('show');
       }
    });
    /* Ver X Trimestre */
    $(document).on('click', '.active #leadXtri', function(){
        $('#chart_ciu').addClass('ocultar');
        $('#chart_ven').addClass('ocultar');
        $('#chart_fab').addClass('ocultar');
        $('#chart_tri').removeClass('ocultar');
    });
    /* Ver X Fabricante */
    $(document).on('click', '.active #leadXfab', function(){
        $('#chart_tri').addClass('ocultar');
        $('#chart_ciu').addClass('ocultar');
        $('#chart_ven').addClass('ocultar');
        $('#chart_fab').removeClass('ocultar');
    });
    /* Ver X Ciudad */
    $(document).on('click', '.active #leadXciu', function(){
        $('#chart_tri').addClass('ocultar');
        $('#chart_ven').addClass('ocultar');
        $('#chart_fab').addClass('ocultar');
        $('#chart_ciu').removeClass('ocultar');
    });
    /* Ver X Vendedor */
    $(document).on('click', '.active #leadXven', function(){
        $('#chart_tri').addClass('ocultar');
        $('#chart_ciu').addClass('ocultar');
        $('#chart_fab').addClass('oultar');
        $('#chart_ven').removeClass('ocultar');
    });
    
    /* Pestaña de detalles - Forecast */
    $('#det-f').click(function(){
        var temp = Handlebars.templates['detalle_forecast'];
       if($('#view-det-f').length === 0){
           $('<li><a href="#view-det-f" data-toggle="tab"><span class="close closeTab"><i class="icon-remove"></i></span>Detalle Forecast</a></li>').appendTo('#mytab');
           $('<div class="tab-pane" id="view-det-f">' + temp() + '</div>').appendTo('.tab-content');
           $('#mytab a:last').tab('show');
       } else{
           $('#mytab a[href="#view-det-f"]').tab('show');
       }
    });
    /* Ver X Trimestre */
    $(document).on('click', '.active #fXtri', function(){
        $('#chart_f_ciu').addClass('ocultar');
        $('#chart_f_ven').addClass('ocultar');
        $('#chart_f_pro').addClass('ocultar');
        $('#chart_f_tri').removeClass('ocultar');
    });
    /* Ver X Ciudad */
    $(document).on('click', '.active #fXciu', function(){
        $('#chart_f_ciu').removeClass('ocultar');
        $('#chart_f_ven').addClass('ocultar');
        $('#chart_f_pro').addClass('ocultar');
        $('#chart_f_tri').addClass('ocultar');
    });
    /* Ver X Vendedor */
    $(document).on('click', '.active #fXven', function(){
        $('#chart_f_ciu').addClass('ocultar');
        $('#chart_f_ven').removeClass('ocultar');
        $('#chart_f_pro').addClass('ocultar');
        $('#chart_f_tri').addClass('ocultar');
    });
    /* Ver X Probabilidad */
    $(document).on('click', '.active #fXpro', function(){
        $('#chart_f_ciu').addClass('ocultar');
        $('#chart_f_ven').addClass('ocultar');
        $('#chart_f_pro').removeClass('ocultar');
        $('#chart_f_tri').addClass('ocultar');
    });
    
    /* Pestaña de detalles - Facturados y Pedidos */
    $('#det-fp').click(function(){
        var temp = Handlebars.templates['detalle_facYped'];
       if($('#view-det-fp').length === 0){
           $('<li><a href="#view-det-fp" data-toggle="tab"><span class="close closeTab"><i class="icon-remove"></i></span>Detalle Facturados y Pedidos</a></li>').appendTo('#mytab');
           $('<div class="tab-pane" id="view-det-fp">' + temp() + '</div>').appendTo('.tab-content');
           $('#mytab a:last').tab('show');
       } else{
           $('#mytab a[href="#view-det-fp"]').tab('show');
       }
    });
    /* Ver X Ciudad */
    $(document).on('click', '.active #fpXciu', function(){
        $('#chart_fp_ciu').removeClass('ocultar');
        $('#chart_fp_ven').addClass('ocultar');
        $('#chart_fp_tri').addClass('ocultar');
    });
    /* Ver X Vendedor */
    $(document).on('click', '.active #fpXven', function(){
        $('#chart_fp_ciu').addClass('ocultar');
        $('#chart_fp_ven').removeClass('ocultar');
        $('#chart_fp_tri').addClass('ocultar');
    });
    /* Ver X Trimestre */
    $(document).on('click', '.active #fpXtri', function(){
        $('#chart_fp_ciu').addClass('ocultar');
        $('#chart_fp_ven').addClass('ocultar');
        $('#chart_fp_tri').removeClass('ocultar');
    });
    
     /* funciones adicionadas por mario para la actualización
      *  de la grafica */
     
     /* Cuota vs Cumplimiento *******************/
    
    /* Trimestre */ 
     $('#chart-cc-tri').click(function () {
       google.setOnLoadCallback(drawChart_cuotaVScumplimiento(1200, 600));
    });
    
     /* Anual */ 
     $('#chart-cc-anual').click(function () {
       google.setOnLoadCallback(drawChart_cuotaVScumplimientoAnual());
    });
          
    
}


function cargarFuncionesPanelGerencia(){
     /* adicion de funciones para las graficas del panel de gerencia */ 
      var datosCadena = new Array();
       $.ajax({
              type: "POST",
              data: "paramTipo=" + "anual",
              url:"http://localhost:8080/crm/oportunidad/traerDatosGraficaCuotaVsCump",
              async:false,
              cache:false,
              success: function (respuesta){      
               datosCadena = respuesta;
              }
         });
        //alert(datosCadena);
            google.setOnLoadCallback(drawChart_cuotaVScumplimiento(datosCadena, 600)); 
            google.setOnLoadCallback(drawChart_leads);
            google.setOnLoadCallback(drawChart_facturadoYpedido);
    
    /* fin de las funciones para las graficas del panel de gerencia */ 
    
}

 

/* CUOTA VS CUMPLIMIENTO DIV1  */
 function drawChart_cuotaVScumplimiento( dato1A, dato1B) {
           
            var  array = dato1A;
            var data = google.visualization.arrayToDataTable(array);

            var options = {
            title: 'Cuota VS Cumplimiento',
            hAxis: {title: 'Trimestre', titleTextStyle: {color: 'red'}}
            };

            var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));

            chart.draw(data, options);
            }
            
            function drawChart_leads() {
            var data = google.visualization.arrayToDataTable([
            ['Element', 'Leads', { role: 'style' }],
            ['IBM', 8, 'blue'],   
            ['VMWare', 10, '#0099FF'], 
            ['ORACLE', 19, '#d9000d'],
            ['CISCO', 20, '#a2a2a2' ],
            ['Red Hat', 0, '#e5e4e2' ]
            ]);

            var options = {
            title: 'Leads Asignados del Trimiestre Actual',
            vAxis: {title: 'Proveedores',  titleTextStyle: {color: 'Red'}}
            };
            var chart = new google.visualization.BarChart(document.getElementById('chart_div2'));
            chart.draw(data, options);
            }
          function drawChart_facturadoYpedidos() {
               alert("drawChart_facturadoYpedidos");
              var data = google.visualization.arrayToDataTable([
                ['Label', 'Value'],
                ['1Q', 10]
              ]);

              var options = {
                width: 400, height: 120,
                redFrom: 90, redTo: 100,
                yellowFrom:75, yellowTo: 90,
                minorTicks: 5
              };

              var chart = new google.visualization.Gauge(document.getElementById('chart_div4'));

              chart.draw(data, options);

              setInterval(function() {
                data.setValue(0, 1, 40 + Math.round(60 * Math.random()));
                chart.draw(data, options);
              }, 13000);
            }
            
            
             function drawChart_facturadoYpedido() {
              
                 var data = google.visualization.arrayToDataTable([
                ['Proveedor', 'Facturado', 'Pedido'],
                ['IBM',  10,      18],
                ['Oracle',  11,      50],
                ['CISCO',  6,       12],
                ['Red hat',  10,      70]
              ]);

              var options = {
                title: 'Facturados y Pedidos',
                hAxis: {title: 'Year', titleTextStyle: {color: 'red'}}
              };

                var chart = new google.visualization.ColumnChart(document.getElementById('chart_div4'));
                
                chart.draw(data, options);
            }
            
        function drawChart_cuotaVScumplimientoAnual() {
            $.ajax({
              type: "POST",
              data: "paramTipo=" + "anual",
              url:"http://localhost:8080/crm/oportunidad/traerDatosGraficaCuotaVsCump",
              async:false,
              cache:false,
              success: function (respuesta){         
                
              }
            });
             
           var array = [
            ['Proveedor', 'Cuota', 'Cumplimiento'],
            ['2014',  1000,      400],
            ['2015',  1170,      460]
            ];
            var data = google.visualization.arrayToDataTable(array);
              
            var options = {
            hAxis: {title: 'Período', titleTextStyle: {color: 'red'}},
            title : 'Cuota VS Cumplimiento',
            vAxis: {title: "Cups", minValue:0,gridlines:{count:6}}
            };
            var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));

            chart.draw(data, options);
            }
            
            function DrawChartJSON(){
             var data = google.visualization.arrayToDataTable([
                ['Proveedor', 'Facturado', 'Pedido'],
                ['IBM',  10,      18],
                ['Oracle',  11,      50],
                ['CISCO',  6,       12],
                ['Red hat',  10,      70]
              ]);
            var options = {
            hAxis: {title: 'Período', titleTextStyle: {color: 'red'}},
            title : 'Cuota VS Cumplimiento',
            vAxis: {title: "Cups"},
            seriesType: "bars",
            series: {5: {type: "line"}}
            };
           
           var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));

            chart.draw(data, options);
           
            }