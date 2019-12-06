<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cambiar Empresa</title>
        <meta name="layout" content="detalle">
        <script src="${resource(dir: 'js', file: 'crm_helper.js')}"></script>   
       </head>

    <body>

        <g:set var="generalService" bean="generalService"/>
        <h2>CAMBIAR DESTINATARIO DE FACTURA</h2>
        <hr style="width:80%; margin-top:10px;margin-bottom:10px;">    
     
          <button id="btnAct00" class="btn btn-primary" data-dismiss="modal" aria-hidden="true"   disabled="true"           
             onclick="document.getElementById('idFacturarA').value=document.getElementById('idempresax').value;document.getElementById('nombreEmpresax').value=document.getElementById('nombreEmpresaz').value">Actualizar Empresa</button>
        <form id="frmFact" name="frmFact" class="form-horizontal" action=""  >
           <label  class="control-label">  Empresa </label>
           <div class="controls">
                       <g:hiddenField id="idempresax" name="xidempresa" value="" 
                           onchange="document.getElementById('btnAct00').disabled=false"
                           />
                      <g:textField id="nombreEmpresaz" name="nombreEmpresa"     maxlength="100" class="input-xlarge"
                        value="" 
                        placeholder="Digite mínimo dos letras iniciales"                         
                        />
                    
                    
                    <span id="msgNoExite" style="display:none;">
                       <b style="color:red; padding-top:3px;"> Empresa no exite! </b>
                    </span>
                </div>            
        </form>

 <script>
             autoCompletar('nombreEmpresaz','/crm/Empresa/autoCompletar','idempresax') 
          
 </script>      
</body>
</html>
