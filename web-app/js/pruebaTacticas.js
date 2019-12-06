
function obtenerListaOrigen()
{
	$(document).ready(function () {
	    $(document).ajaxStart(function () {
	        $("#loading").show();
	    }).ajaxStop(function () {
	        $("#loading").hide();
	    });
	});
	
	
	$("#idEstrategiasSelect").change(function(){
		//alert($(this).val());
		
		$.ajax({
			
			url:"/crm/tactica/tacticasDisponibles",
			type:'POST',
			data : {idEstrategia: $(this).val()},
			success:function(response)
			{
				//var a=JSON.stringify(response)
				//alert(a);
				//$("#idTacticasSelect").load(response);
			    /*$.each(response, function(){
			        //$("#idTacticasSelect").append('<option value="'+ this.value +'">'+ this.name +'</option>')
			    	alert(this.value)
			    )*/
				$('#idTacticasSelect').empty()
				var tamanioRespuesta=(response+'').length;
				if(tamanioRespuesta==0)
				{
					//alert("TAMAÑO RESPUESTA FUE DE "+tamanioRespuesta);
					//$("#idTacticasSelect").val("holaMund");
					$("#idTacticasSelect").append('<option value="" disabled selected>'+ "No hay tácticas disponibles" +'</option>');
				}
				    
				$.each(response, function( index, value ) {
					  //alert( index + ": " + value );
					
					  $("#idTacticasSelect").append('<option value="'+ index +'">'+ value +'</option>');
					});
				
				var tacticaSeleccionadaPorDefecto=$("#idTacticasSelect").find("option:selected").text();
				traerInformacionAsociadaTactica(tacticaSeleccionadaPorDefecto);				
			}
			
		});
		
	});
	
	
	$("#idTacticasSelect").change(function(){
		var tacticaSeleccionada=$(this).find("option:selected").text();
		traerInformacionAsociadaTactica(tacticaSeleccionada);
		//alert("hola mundo");
	});
	
	
	$("#idFecha").change(function(){
		//alert($("#idTacticasSelect").find("option:selected").text());
		var tacticaSeleccionada=$("#idTacticasSelect").find("option:selected").text();
		traerInformacionAsociadaTactica(tacticaSeleccionada);
		//alert("hola buenos dias mundo");
	});
	
	
}

function autoCompletarTacticas(fuenteDeDatos)
{	
	
		$(document).ready(function() {
		
			$("#tacticasDisponibles").autocomplete({
			source:fuenteDeDatos,
			minLength:2,
			select: function(event, ui) {
				//alert($(this).val());--ACÁ
				$("#tacticasDisponibles").val(ui.item.value);
				traerInformacionAsociadaTactica($(this).val());
				
	        }	        
		});
			
	});
}


function obtenerListaOrigen2()
{	
	$(document).ready(function () {
	    $(document).ajaxStart(function () {
	        $("#loading").show();
	    }).ajaxStop(function () {
	        $("#loading").hide();
	    });
	});
	
	
	
	
	var listaDeTacticas=""
		
		$.ajax({
			  //url : "http://localhost:8080/crm/tactica/tacticasDisponibles",
			  
			  url:"/crm/tactica/tacticasDisponibles",
			  type:'GET',
			  //data : {idP: '1030238'},
			  success:function(response)
			  {
				  //console.log(response);				  		  
				  autoCompletarTacticas(response)//Aqui envíamos el resultado del response que será utilizando como fuente
				  //para el autocompletar
			  }
			  
			});	
	
}

function traerInformacionAsociadaTactica(tacticaSeleccionada)
{	
	var fecha=$("#idFecha").val();
	//alert(fecha);
	
	$.ajax({
		  
		  url:"/crm/tactica/traerInformacionAsociadaTactica",
		  type:'POST',
		  data : {nombreTactica: tacticaSeleccionada,
			  	fechaFiltro:fecha},
		  success:function(response)
		  {
			  //console.log(response);
			//alert(response);
			  $("#contenidoTabs").empty(); 
			  //$("#detalles").empty();//se debe vaciar cada pestaña en especifico
			  
			  

			var respuesta=response;
			$("#contenidoTabs").append(respuesta);
			//$("#clientesAsociadosProsp").html(respuesta);
			$("#tablaProspectos").DataTable();
			$("#tablaOportunidades").DataTable();
			
			

			  
			//var resultado=JSON.parse(response);
			//alert(resultado)
			var filasProspectos = $('#tablaProspectos').DataTable().page.info().recordsTotal;
			var filasOportunidades = $('#tablaOportunidades').DataTable().page.info().recordsTotal;

			$("#numeroProsp").text(filasProspectos);
			$("#numeroOpor").text(filasOportunidades);
			//$("#numeroOpor").text(resultado[1]);
			
			$('#tablaProspectos_info').remove();
			$('#tablaOportunidades_info').remove();
			 $('#tablaProspectos_paginate').attr("class", "dataTables_paginate paging_simple_numbers pagination");
			 $('#tablaOportunidades_paginate').attr("class", "dataTables_paginate paging_simple_numbers pagination");
			 
			 $('input[type=search]').css({"width":"120px","height":"15px"});
			 //$('#tablaProspectos_previous').text("<<");
			 //$('#tablaProspectos_next').text(">>");
			 
		  }
		});
}