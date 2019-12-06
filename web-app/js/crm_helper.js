/* 
 * funciones varias de ayuda para trabajos varios pryecto CRM redsis 
 */
/* Utilizada para enviar listas como formularios . Manejo de checkbox*/
function crm_enviar_form(formulario, xaccion){
   document.getElementById(formulario).action =xaccion;   
   document.getElementById(formulario).submit();
    
}
/*refresca src del iframe elegico  acorde a Id del encabezado*/ 
function crm_cargardetalle(xiframe,xurl){          
   IFRAME_DETALLE = $("#"+xiframe);   
   document.getElementById(xiframe).contentDocument.location=xurl;

  }
 
function crm_cargardetalles(xiframe,xurl,xiframe1,xurl1){
      
     crm_cargardetalle(xiframe,xurl);      
     crm_cargardetalle(xiframe1,xurl1);
  }
  
function crm_deseliminar(){
          
         if (document.getElementById("eliminado").value==1){
            document.getElementById("eliminado").value=0
            document.getElementById("men_eliminado").innerHTML = "";            
          }else{
             document.getElementById("eliminado").value=1
             document.getElementById("men_eliminado").innerHTML = "Eliminado";
           }
   }   

function sleep(milliSeconds){ 
  var startTime = new Date().getTime(); 
  while (new Date().getTime() < startTime + milliSeconds); 

}

function cargar_modal(xmodal,xbodymodal,xurl,xrefresh){
    
      espere(1)  
    $('#'+xbodymodal).load(xurl,function(data){
        $(this).html(data);
        var altura=$('#'+xbodymodal).height();

    });


    $('#'+xmodal).modal('show');  // abre ventana modal
    espere(0)
}

 function cargar_div(xmodal,xbodymodal,xurl,xrefresh){
  
    $('#'+xbodymodal).load(xurl,function(data){
      $(this).html(data); 
      var altura=$('#'+xbodymodal).height();
      parent.IFRAME_DETALLE.height(altura+100); 
    
    });
     
     $('#'+xbodymodal).height(parent.IFRAME_DETALLE.height()-100)
     
     $('#'+xmodal).modal('show');  // abre ventana modal    
 }
 
function formatearFecha(xdiv){
  $('#'+xdiv).datepicker('option', 'dateFormat', 'dd/mm/yy');    
}

function addComas(xid){
    n=document.getElementById(xid).value
    if (n.indexOf(',') != -1) return
    var m = Math.abs(n);
    var sign = n < 0 ? '-' : '';
    var output = "";
    var chars = String(m).split('').reverse();
    var commas = Math.floor((chars.length-1) / 3);
    var i = 0;
    for(i=0; i<commas; i++){
        output = output + chars.slice(0,3).join('') + ',';
        chars = chars.slice(3);
    }
    output = output + chars.join('');

     document.getElementById(xid).value= sign + output.split('').reverse().join('');

}

function multiplicarDosVal(idval1,idval2,idresul){
      var val1=document.getElementById(idval1).value
      val1=val1.split(',').join('')
      var val2=document.getElementById(idval2).value
      val2=val2.split(',').join('')
      document.getElementById(idresul).value=val1*val2
      addComas(idresul)
      }
      
function getNameFile(url){
    if((url+"")!=""){
        var vector = url.split("\\");
        return vector[vector.length-1];
    }else{
        return "";
    }
}

function refresh_iframe(xiframe){
    window.frames[xiframe].location.reload();
}

 function  clearFiltro(id,exepto ) {
    var form = document.getElementById(id);
    var el;

    for ( var i = 0; i < form.elements.length; i++) {
        el = form.elements[i];

        if (el && el.name.indexOf('filter.') == 0 && exepto.indexOf(el.name)==-1 ) {

            if (el.type === 'select-one') {

                el.selectedIndex = 0;
            } else if (el.type === 'text' || el.type === 'textarea') {
                el.value = '';
            }
        }
    }
}

function redimIframe(altura){
    if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(altura);
}

function configFechaHora(){

    $('.form_datetime').datetimepicker({
        language:  'es',
        weekStart: 1,
        todayBtn:  1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        forceParse: 0,
        showMeridian: 1
    });
    $('.form_date').datetimepicker({
        language:  'es',
        weekStart: 1,
        todayBtn:  1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });
    $('.form_time').datetimepicker({
        language:  'es',
        weekStart: 1,
        todayBtn:  1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 1,
        minView: 0,
        maxView: 1,
        forceParse: 0
    });
}

function autoCompletar(xdiv,xurl,xid){
   
    $(document).ready(function() {   
        $("#"+xdiv).autocomplete({
          source: function(request, response){
              $.ajax({
               url: xurl, // fuente remota
               data: request,
               success: function(data){    
                response(data); // set the response
               },
               error: function(){ // handle server errors
                console.log("falla en llamada (autocompletar)");
               }
              });
          },
          minLength: 2, 
          select: function( event, ui ) {
            
            if(ui.item==null){           
              $("#"+xid).val('').change();
              document.getElementById('msgNoExite').style.display =  'inline';
              /*BootstrapDialog.confirm("La empresa "+this.value+" no existe, ¿desea crearla?",function(result){
                if(result)cargar_modal('crm_modal','modal_body','/crm/empresa/create?layout=detail&tipo=1&t=empresat01&swmodal=1','refresh_combo')
              });*/
              this.value = ''
            }else{               
              document.getElementById('msgNoExite').style.display =  'none';
              $("#"+xid).val(ui.item.id).change();
            }
            
          },
          change: function( event, ui ) {
            
            if(ui.item==null){            
              $("#"+xid).val('').change();
              document.getElementById('msgNoExite').style.display =  'inline';
              /*BootstrapDialog.confirm("La empresa "+this.value+" no existe, ¿desea crearla?",function(result){
                if(result)cargar_modal('crm_modal','modal_body','/crm/empresa/create?layout=detail&tipo=1&t=empresat01&swmodal=1','refresh_combo')
              });*/
              this.value = ''
            }else{          
              document.getElementById('msgNoExite').style.display =  'none';
              $("#"+xid).val(ui.item.id).change();
            }
            
          }
        });

    });  
}


function miAutoCompletar(xdiv,xurl,xid,campoOculto){
    
    $(document).ready(function() {   

        var field = $("#"+xdiv).autocomplete({
          source: function(request, response){
              var id = document.getElementById(campoOculto).value
              $.ajax({
                url: xurl, // fuente remota
                data: {
                  term:request.term,
                  idempresa:id+""
                },
                success: function(data){    
                  response(data); // set the response
                },
                error: function(){ // handle server errors
                 console.log("falla en llamada (miAutoCompletar)");
                }
              });
          },
          minLength: 2, // minimo numero caracteres para disparar autocompletar
          select: function(event, ui) { // evento al escoger item 
            if(ui.item==null){
              $("#"+xid).val('').change();
              document.getElementById('msgNoExite2').style.display =  'inline';
              /*BootstrapDialog.confirm("La empresa "+this.value+" no existe, ¿desea crearla?",function(result){
                if(result)cargar_modal('crm_modal','modal_body','/crm/empresa/create?layout=detail&tipo=1&t=empresat01&swmodal=1','refresh_combo')
              });*/
              this.value = ''
            }else{
              document.getElementById('msgNoExite2').style.display =  'none';
              $("#"+xid).val(ui.item.id).change();
            }
          },
          change: function( event, ui ) {
            
            if(ui.item==null){
              $("#"+xid).val('').change();
              document.getElementById('msgNoExite2').style.display =  'inline';
              this.value = ''
            }else{
              document.getElementById('msgNoExite2').style.display =  'none';
              $("#"+xid).val(ui.item.id).change();
            }
            
          }
        }).data("autocomplete")._renderItem=function( ul, item ) {
          var tagA = item.contacto=="SI"?"<a style='color:green; font-weight:bold;'></a>":"<a></a>"
          var tmp =  $( "<li></li>" )
          .data('item.autocomplete',item)
          .append( $( tagA ).text( item.label ) ) 
          .appendTo( ul );
          return tmp
        };

    });  
}

function mi_ajax(xurl,xid,xdiv){ 
    $.ajax({
      type:'POST',
      url: xurl, 
      data: 'id='+xid,
      success: function(data){    
        $('#'+xdiv).html(data);
      },
      error: function(){ // handle server errors
        console.log("falla en llamada (mi_ajax)");
      }
    });
  }
  

function ajaxvalue(xurl,xid,xdiv){ 
    $.ajax({
      type:'POST',
      url: xurl, 
      data: 'id='+xid,
      success: function(data){    
        $('#'+xdiv).val(data);
      },
      error: function(){ // handle server errors
        //console.log("falla en llamada (ajax value)");
      }
    });
  }                  

function clearCombo(combo,campoOculto,info){
    if(campoOculto!='')  $("#"+campoOculto).val('').change()
      $("#"+combo).val('')
     if ( document.getElementById(info)!=null) 
          document.getElementById(info).innerHTML=''
  }
  
function espere(zw){
    var el = document.getElementById("divwait")
    if (zw==1)
    el.style.display = 'block' 
   else 
     el.style.display = 'none'      
  }


function guardarEntidad(url,form,xmodal,xid,xdvalor) {
    debugger;
    document.getElementById('erroraSync').innerHTML=''
    $.ajax({
      type: 'post',
      url: url,
      data: $("#"+form).serialize(),
      success: function (response) {         
        if(response.success){
          $("#"+xid).val(response.key).change();
          $("#"+xdvalor).val(response.value);
          $('#SalirModal').click(); 
        }else{
          var html = ''
          for (var i = 0; i < response.errors.length; i++) {
            html += '<li>'+response.errors[i].message+'</li>'
          };
          document.getElementById('erroraSync').innerHTML=html
        }
      },
      error: function (xhr, tipo, xerror) {
          //alert(xhr.responseText);
          var xerror = document.getElementById("mierror");
          xerror.innerHTML="<p style='color:red'>"+ xhr.responseText+"</p>";
      }
    });    

  } 
  
  function validarPersona(){
      debugger;
     if (formPersona.primerNombre.value.trim()==''){
        alert("Ingrese Primer Nombre");
        $("#primerNombre").focus(); 
        return false;
     } 
     if (formPersona.primerApellido.value.trim()==''){
         alert("Ingrese Primer Apellido");
         $("#primerApellido").focus(); 
         return false;
     }            
     if (formPersona.email.value.trim()==''){
         alert("Ingrese correo electrónico");
         $("#email").focus(); 
         return false;
     }                      
     if (formPersona.telefonoFijo.value.trim()==''){
        alert("Ingrese Telefono Fijo");
        $("#telefonoFijo").focus(); 
        return false;
     }
      return true
  }
  
function validarFechas(tipo,f1,f2){ //tipo=0 fechas normales tipo=1 fecha hora
     var xf1=stodate(tipo,document.getElementById(f1).value)
     var xf2=stodate(tipo,document.getElementById(f2).value)   
    if (xf2 <= xf1){
       document.getElementById('errfec').style.display =  'inline'
       document.getElementById(f2).value=''
    }else{
     document.getElementById('errfec').style.display =  'none'
    } 
  }
  
function stodate(tipo,fecha){
     if (tipo==0) {
     var partes =fecha.split('-')
     xfecha=new Date(partes[2],partes[1]-1,partes[0])
     }else{         
         var dt  = fecha.split(/\-|\s/)
          xfecha = new Date(dt.slice(0,3).reverse().join('/')+' '+dt[3]);        
     }
     
     return xfecha
 }

function recargarIframe(id){
     document.getElementById(id).contentDocument.location.reload(true);   
    }
    
function cargarHistorial(xidentidad,xentidad){              
               IFRAME_DETALLE9 = $("#ifhistoria");   
               document.getElementById("ifhistoria").contentDocument.location="/crm/encLog/index/"+xidentidad+"?entidad="+xentidad;
              
  }
  
function toggle(source,nombre) {
  checkboxes = document.getElementsByName(nombre);
  for(var i=0, n=checkboxes.length;i<n;i++) {
    checkboxes[i].checked = source.checked;
  }
  
}
// redimensionar frame via plugin de jquery 
  function redimIFRAME(){
       jQuery(function(){
        $('iframe').iframeAutoHeight({
          minHeight: 180,
        });
      });
    }
  
  
  function hola(){
	  alert("Pestana cambiada");
  }
  
  function REDIMIFRAMEJD(){
	  jQuery(function(){
	        $('iframe').iframeAutoHeight({
	          minHeight: 380,
	        });
	      });
  }
     
    function autoResize(id){
        debugger;
    var newheight;
    var newwidth;

    if(document.getElementById){
        newheight=document.getElementById(id).contentWindow.document.body.scrollHeight;
        newwidth=document.getElementById(id).contentWindow.document.body.scrollWidth;
    }

    document.getElementById(id).height= (newheight) + "px";    
    document.getElementById(id).width= (newwidth) + "px";
}

function desactivar(id){
    document.getElementById(id).disabled=true;    
}



function obligar(id,nombre){
    debugger;
    var obj=document.getElementById(id);
        if (obj.value=='' || obj.value==null){
            alert("Debe Ingresar "+nombre)
              obj.focus();
              return false;
          }
       return true;
}

function mialert(mensaje){
    BootstrapDialog.show({
          size: BootstrapDialog.SIZE_SMALL,
          message:mensaje,
           buttons:[{
                   label: 'Aceptar',
                   action: function(dialogItself){
                               dialogItself.close();
                              
                                }
                              }]
                     });  
    
}

 function isNit(evt) {
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    
    
    if (charCode != 45 && charCode > 31 && (charCode < 48 || charCode > 57))
    return false;
	
    if (charCode == 45 && evt.srcElement.value.split('-').length>1) { return false; }//SOLO 1 GUION

  //return true;
	 
    var regexp = /[0-9]+-[0-9]/;
    if(evt.srcElement.value.match(regexp))
    	return false;
    return true;
	 
}
 
function upperCases()
{
	var x = document.getElementById("razonSocial");
    x.value = x.value.toUpperCase();
	
}

function controlTipoPrecio(swaplica){
    swaplica=swaplica || false
    if (swaplica){
       BootstrapDialog.confirm("Desea modificar los precios definidos para este pedido?\n\nRecuerde definir la TRM,antes de Guardar,si lo requiere.\nEn caso contrario se tomará  la TRM x defecto parametrizada",
                function(result){
                    if(result) {
                        document.getElementById('swcp').value ='1';
                      
                    }                    
                }
        );  
       }
 }

function validarLongitudRazonSocial()
{
	var x=document.getElementById("razonSocial").value.length
	if(x>100)
		{
			document.getElementById("btn_save_emp").disabled=true
			document.getElementById("verifRazon").style.display = "inline";
			document.getElementById("verifRazon").style.visibility = "visible";
		}
	else
		{
			document.getElementById("btn_save_emp").disabled=false;
			document.getElementById("verifRazon").style.display = "none";			
		}
	
}



//GENERARPEDIDO.GSP
$('input[name="arquitectoSol"]').change(function(){
	if ($(this).val()=='N')
	{
		
		 
		 $('#comentariosSinArquitecto').prop('required',true);		
		 $("#botonPed").prop('disabled',false);
	}
	if ($(this).val()=='S')
	{
		
		$('#comentariosSinArquitecto').prop('required',false);		
		$("#botonPed").prop('disabled',true);
		$("#idlarqui").change(function()

		{
					if($(this).val()=='')  
						{
							alert('Seleccione al menos un arquitecto');				
							$("#botonPed").prop('disabled',true);
						}
					else
						$("#botonPed").prop('disabled',false);
		})
	}
})

function alertaop()
{
	var x=document.getElementById("numeroportunidad").innerHTML.length;
	if(x>31)//si el num de la oportunidad existe, es decir cuando tiene consecutivo
		document.getElementById("sucursalOp").disabled = true;
}


function actualizarInfoQ()
{
	var vendedoresCheckbox=[]
	var Q=[]
	var ciudadesCheckbox=[]
	$('input').change(function() {
		vendedoresCheckbox=[]
		ciudadesCheckbox=[]
		Q=[]
		
		
		$("input[name='QinfoQ']").each( function () {
	        if($(this).is(':checked')){	        	
	        	Q.push($(this).val());
	        }        
	        
	    });
		
		
		
		$("input[name='vendedores']").each( function () {
	        if($(this).is(':checked')){
	        	vendedoresCheckbox.push($(this).val());	        	
	        }        
	        
	    });
		
		
		
		$("input[name='sucursales']").each( function () {
	        if($(this).is(':checked')){	        	
	        	ciudadesCheckbox.push($(this).val());
	        }        
	        
	    });
		
		//var url="${createLink(controller:'Oportunidad',action:'retornarValor')}";
		
		
		//alert("ALGO HA CAMBIADO")
		//alert(vendedoresCheckbox)
		$.ajax({			
			dataType: 'json',		
			type: "POST",
			url:"https://crm.redsis.com/crm/oportunidad/retornarValor",					
			//url:"http://localhost:8080/crm/oportunidad/retornarValor",
			//url:url,
			data:
				{
					//Q:$('input[name=QinfoQ]:checked', '#myForm').val(),
					Q:Q.toString(),
					vAsociados:vendedoresCheckbox.toString(), //vendedores Asociados
					ciudadesAsociadas:ciudadesCheckbox.toString() //ciudades Asociadas
					
					
				},
			success:function(response)
			{
				var respuesta=JSON.stringify(response);				
				var r=JSON.parse(respuesta)
				var perdida=r.perdida
				var forecast=r.forecast
				var ganadas=r.ganadas
				var generado=r.generado
				var asignado=r.asignado
				var facturadoPesos=r.facturadoPesos
				var facturadoDolares=r.facturadoDolares
				var porcenGener=r.porcentajeGenerado
				var porcenAsig=r.porcentajeAsignado
				var porcenForec=r.porcentajeForecast
				var porcenGana=r.porcentajeGanada
				var porcenFac=r.porcentajeFacturado
				var porcenPerd=r.porcentajePerdido
				
				
							
				/*if(r.asignado>0)
					asignado=r.asignado
					else
						asignado="No aplica"*/
				
				$("#ganadas").text("USD$ "+ganadas)
				$("#asignado").text("USD$ "+asignado)
				$("#forecast").text("USD$ "+forecast)
				$("#generado").text("USD$ "+generado)
				
				//$("#facturado").text("USD$ "+facturadoDolares+" COP "+facturadoPesos)
				$("#fpesos").text("USD$ "+facturadoDolares)
				$("#fdolar").text("COP: "+facturadoPesos)
				
				$("#perdida").text("USD$ "+perdida)
				$("#porcenGener>p").text(porcenGener+"%")
				$("#porcenAsig>p").text(porcenAsig+"%")
				
				if(r.porcentajeForecast>0)
				$("#porcenForec>p").text(porcenForec+"%")
				else
				$("#porcenForec>p").text("No aplica")
				
				
				$("#porcenGana>p").text(porcenGana+"%")
				$("#porcenFac>p").text(porcenFac+"%")
				$("#porcenPerd>p").text(porcenPerd+"%")
			},
			
		});
		
		
		});
	
	

}


function dataTablePedidos()
{
	//alert("hola mundo");
	
	$(document).ready(function () {
		
		$("#tablaPedidos").DataTable();
		$('#tablaPedidos_first').remove();		
		$('#tablaPedidos_last').remove();
		$('#tablaPedidos_info').remove();
		$('#tablaPedidos_paginate').attr("class", "dataTables_paginate paging_simple_numbers pagination");		 
		
	});
	
}


function recorrerColumnaPesos()
{
	var pesosTemp=0;
	var totalPesos=0
	$("table tr td:nth-child(5)").each(function () {
		
		if($(this).text()!="")
		{
			var sinComa=$(this).text().replace(',','');			
			pesosTemp+=parseFloat(sinComa);
			totalPesos=(pesosTemp/1000).toFixed(3);
		}
		
	});
	//alert("TOTAL DÓLARES ES... "+totalPesos);
	//$("#totalUSD").html("<b>USD$</b> "+totalPesos);
}
