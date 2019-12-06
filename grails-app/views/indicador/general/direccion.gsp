<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sample title</title>
        <meta name="layout" content="detalle">
        <script>
            function actualizarDireccion(divDir,divPais,divDpto,divCiudad){
                if (document.getElementById('idPais1').value=='') {
                    alert('Debe seleccionar un Pais')
                    return
                }
                if (document.getElementById('idDpto1').value=='') {
                    alert('Debe seleccionar un Dpto')
                    return
                }
                if (document.getElementById('idCiudad1').value=='') {
                    alert('Debe seleccionar una Ciudad')
                    return
                }
                if (document.getElementById('dirbase').value=='') {
                    alert('Debe ingresar dirección')
                    return
                }

                var xciudad=document.getElementById('idCiudad1').options[document.getElementById('idCiudad1').selectedIndex].text
                var xdpto=document.getElementById('idDpto1').options[document.getElementById('idDpto1').selectedIndex].text
                var xpais=document.getElementById('idPais1').options[document.getElementById('idPais1').selectedIndex].text

                document.getElementById(divDir).value=document.getElementById('dirbase').value.trim()+'\n['+xciudad+'-'+xdpto+'-'+xpais+']' 
                document.getElementById(divPais).value=document.getElementById('idPais1').value
                document.getElementById(divDpto).value=document.getElementById('idDpto1').value
                document.getElementById(divCiudad).value=document.getElementById('idCiudad1').value                
                document.getElementById('SalirModal').click()
            }
            function cargarDatos(divDir,divPais,divDpto,divCiudad){
                var xdir =document.getElementById(divDir).value

                var i=xdir.indexOf('[')
                if (i>0) xdir=xdir.substring(0,i)              
                debugger;
                document.getElementById('dirbase').value=xdir
                document.getElementById('idPais1').value=document.getElementById(divPais).value
                var xidpais=document.getElementById(divPais).value
                var  xiddpto=document.getElementById(divDpto).value 
                 $.ajax({
                      async:true,    
                      cache:false,                        
                      type: 'POST',   
                      url: "/crm/territorio/traerDptos",
                      data: "id="+xidpais, 
                      success:  function(data){  
                          $('#divdpto').html(data);
                          document.getElementById('idDpto1').value=document.getElementById(divDpto).value  
                      },
                      beforeSend:function(){},
                      error:function(objXMLHttpRequest){}
                    });        
                 $.ajax({
                      async:true,    
                      cache:false,                        
                      type: 'POST',   
                      url: "/crm/territorio/traerMunicipios",
                      data: "id="+xiddpto, 
                      success:  function(data){  
                          $('#divmuni').html(data);
                          document.getElementById('idCiudad1').value=document.getElementById(divCiudad).value  
                      },
                      beforeSend:function(){},
                      error:function(objXMLHttpRequest){}
                    });   
            }
      
        </script>
    </head>

    <body>

        <g:set var="generalService" bean="generalService"/>
        <h2>Actualización de Dirección</h2>
        <hr style="width:80%; margin-top:10px;margin-bottom:10px;">    

        <form id="frmDir" name="frmDir" class="form-horizontal" action="/crm/general/setDireccion"  >

            <button type="button" class="btn btn-mini btn-primary" 
            onclick="actualizarDireccion('${divdir}','${divPais}','${divDpto}','${divCiudad}')"><i class="icon-download-alt icon-white"></i>&nbsp;Actualizar</button>

            <button type="button" class="btn btn-mini" 
        onclick="cargarDatos('${divdir}','${divPais}','${divDpto}','${divCiudad}')"><i class="icon-download-alt"></i>&nbsp;Traer Dirección Actualizada</button>
        
        		<a  class="btn btn-mini" onclick="return document.getElementById('SalirModal').click()"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                     
                     
    <br/></br>
    <div class="control-group">
        <label class="control-label">
            Dirección
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <% 
            def i=xdireccion?.indexOf('[')?:0
            if (i>0) xdireccion=xdireccion.substring(0,i)  
            %>
            <g:textArea name="direccion" id='dirbase' rows="3" cols="120" class="input-xlarge"
            value="${xdireccion}" disabled="${xronly}" required="" />
        </div>
    </div>
    <div class="control-group ">
        <label class="control-label" >
            Pais
            <span class="required-indicator">*</span>
        </label>
        <div class="controls" >            
            <g:select name="idPais" id="idPais1" from="${crm.Territorio.findAll('from Territorio where idTipoTerritorio=\'terpais\' and eliminado=0 and estadoTerritorio=\'A\' order by nombreTerritorio')}"
                optionKey="id"
              value="${xpais}"   
                onchange="${remoteFunction(controller:'Territorio',
                        action:'traerDptos', params:'\'id=\'+this.value',
                        update: [success: 'divdpto'],
                        options:'[asynchronous:true]')}"
                noSelection="['': 'Seleccione Pais']"  
                required="" />
        </div>
    </div>
    <div id="divdpto">
         <g:set var="dptoList" value="${generalService.traerTerritorios('terdpto',params?.id?.toLong())}" scope="request"/>
         <g:set var="xdpto" value="${xdpto}" scope="request"  />     
         <g:set var="xpais" value="${xpais}" scope="request"  />     
        <g:render template="/territorio/dptos"/>
    </div>    

    <div id="divmuni">
         
        <g:set var="municipioList" value="${generalService.getMunicipios(xdpto)}" scope="request"/>
        <g:set var="xidciudad" value="${xciudad}" scope="request"  id="idCiudad2" />        
        <g:set var="xdiv" value="${divCiudad}" scope="request" /> 
        <g:render template="/territorio/municipios"/>      

    </div>
</div>
</div>
</form>

</body>
</html>
