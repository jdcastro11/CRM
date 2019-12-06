var idEvento;
$(document).on("ready", inicio);


function inicio () {
    alert("wewew");
    //agregarEventoListarRequerimiento();
    listarRegistros();
}

function agregarEventoListarRequerimiento(){
    $('.req').on("click",listarRegistros);
   //$('.req').on("click",listarRegistros);
}


function listarRegistros(event) {
    //capturamos el id que es el que contiene el numero de la oportunidad para ver el listado
   // event.preventDefault();
   // var nroId = event.currentTarget.id;
   // var url = $(this).attr("data-url");
   //var nodo = $(this).attr("nodo");
    var numOportunidad =$(this).attr("numeroOportunidad");
    alert(numOportunidad.val());
    bucarRegistros(numOportunidad.value);
   
}

function bucarRegistros(numOportunidad) {
  
    $.ajax({
        type: "POST",
        url:  '../general/webServiceRequerimiento',
        data: "numOportunidad="+ numOportunidad ,
        async:false,
        cache:false,
        success: function (respuesta) {
              
              actualizarTabla(respuesta);
          
        }
    });
   
   
}

function actualizarTabla(respuesta){
    var datos = eval(respuesta);   
    //alert(datos.templateTablaOportunidad);
    $("#requerimientos").empty();
    $("#requerimientos").html(datos.templateTablaOportunidad);
}


