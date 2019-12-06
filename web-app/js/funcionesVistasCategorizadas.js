var idEvento;
$(document).on("ready", inicio);


function inicio () {
    agregarEventoNodo1();
}

function agregarEventoNodo1(){
   $('.empresa').on("click",listarRegistros);
}

function agregarEventoNodo2(){
   $('.nodo2').on("click",listarRegistros);
}
function agregarEventoNodo3(){
   $('.nodo3').on("click",listarRegistros);
}

function agregarEventoNodo4(){
   $('.nodo4').on("click",listarRegistros);
}

function agregarEventoNodo5(){
   $('.nodo5').on("click",listarRegistros);
}

function listarRegistros(event) {
    //capturamos el id que es el que contiene el nit de la empresa
    event.preventDefault();
    var nroId = event.currentTarget.id;
    var url = $(this).attr("data-url");
    var nodo = $(this).attr("nodo");
    //adiciono en el mismo evento la clase para i 
    if(nroId !== "") {
         if($('#'+nroId + ' i').hasClass('fa-icon-caret-right')){
            $('#'+nroId + ' i').removeClass('fa-icon-caret-right').addClass('fa-icon-caret-down');
        }else{ 
            $('#'+nroId + ' i').removeClass('fa-icon-caret-down').addClass('fa-icon-caret-right');
        }
        bucarRegistros(nroId, url,nodo);
    } else {
      // alert("no hay id");
    }
}

function bucarRegistros(nroId, url, nodo) {
   /** alert("dato url " + url);
    alert("dato id " + nroId); **/
    //alert("nodo"+nodo);
   if(nodo=== "1"){
    $.ajax({
        type: "POST",
        url:  url,
        data: "numeroId=" + nroId,
        async:false,
        cache:false,
        success: function (respuesta) {
              actualizarTabla(respuesta, nroId);
              adicionarDataTable(nroId);
             
        }
    });
   }else{
        if(nodo=== "2"){
       //funcion para sacar el siguiente nodo o categoria
       $.ajax({
        type: "POST",
        url:  url,
        data: "numeroId=" + nroId,
        async:false,
        cache:false,
        success: function (respuesta) {   
            actualizarTabla(respuesta, nroId);
            agregarEventoNodo2();   
           
        }
        });
      
    }else{
        if(nodo=== "3"){
       //funcion para sacar el siguiente nodo o categoria
       $.ajax({
        type: "POST",
        url:  url,
        data: "numeroId=" + nroId,
        async:false,
        cache:false,
        success: function (respuesta) {   
            actualizarTabla(respuesta, nroId);
            agregarEventoNodo3();   
            
        }
        });
       }else{
         if(nodo=== "4"){
       //funcion para sacar el siguiente nodo o categoria
       $.ajax({
        type: "POST",
        url:  url,
        data: "numeroId=" + nroId,
        async:false,
        cache:false,
        success: function (respuesta) {
            actualizarTabla(respuesta, nroId);
            agregarEventoNodo4();   
            
        }
        });
       }else{
         if(nodo=== "5"){
           //funcion para sacar el siguiente nodo o categoria
           $.ajax({
           type: "POST",
           url:  url,
           data: "numeroId=" + nroId,
           async:false,
           cache:false,
           success: function (respuesta) {
            actualizarTabla(respuesta, nroId);
            agregarEventoNodo5();   
            adicionarDataTable(nroId);            
           }
        });
       }  
       }
            
       }
        
    }
   }
   
}

function actualizarTabla(respuesta, nroId){
    var datos = eval(respuesta);   
    //alert(datos.templateTablaOportunidad);
    $("#"+nroId+"_container").empty();
    $("#"+nroId+"_container").html(datos.templateTablaOportunidad);
}

function adicionarDataTable(nroId){
    $('#tbl-1-'+nroId).DataTable({
         order: [1, 'asc'],
         bFilter: true,
         bLengthChange: false,
         iDisplayLength: 100,
         sPaginationType : 'full_numbers',
         info: false,
         aoColumnDefs: [
          { 'bSortable': false, 'aTargets': [ 0, 6 ] }
       ]
       
    });
    }
    
    
function plegarDesplegar(nroId){
       // alert("en el plegar desplegar "+ nroId);
        if($('#'+nroId + ' i').hasClass('fa-icon-caret-right')){
            $('#'+nroId + ' i').removeClass('fa-icon-caret-right').addClass('fa-icon-caret-down');
        } else {
            $('#'+nroId + ' i').removeClass('fa-icon-caret-down').addClass('fa-icon-caret-right');
        }
    
}


