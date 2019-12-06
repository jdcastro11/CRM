  
<label  class="control-label">  
    <a href="#" style="text-decoration:underline;" onClick="var el = document.getElementById('infoClientex');el.style.display = (el.style.display == 'none') ? 'block' : 'none';">${xlabelEmpresax}</a>
    <span class="required-indicator">*</span>
</label>
<div class="controls">
    <g:hiddenField id="idempresax" name="${xcampo}" value="${xidempresa}"        
        onchange=" if (this.value ==''){document.getElementById('infoClientex').innerHTML=''}else{mi_ajax('/crm/empresa/datosCliente1',this.value,'infoClientex')}"  /> 
    <div class="control-group">        
        <g:textField id="idnempresa" name="nombreEmpresa"   required=""  maxlength="100" class="input-xlarge"
        value="${crm.Empresa.get(xidempresa)}" disabled="${xronly}" 
        placeholder="digite mínimo dos letras iniciales" 
        />
        
        <script>
           autoCompletar('idnempresa','/crm/Empresa/autoCompletar/${autoSw}','idempresax')             
            var xidempresa = document.getElementById('idempresax').value
            if(xidempresa!=''){
              mi_ajax('/crm/empresa/datosCliente',xidempresa,'infoClientex')
              var el = document.getElementById('infoClientex');
              el.style.display = (el.style.display == 'none') ? 'block' : 'none';
              }        
           
        </script>                         
        <g:if test="${xronly=='false'}">            
            <button type="button" class="btn  btn-mini"
            onclick="var xidempresa = document.getElementById('idempresax').value;if(xidempresa=='')return;cargar_modal('crm_modal','modal_body','/crm/empresa/edit/'+xidempresa+'?layout=detail&tipo=1&sw=1&swmodal=1&t=empresat07','refresh_combo')" >
            <i class="icon-briefcase" ></i>&nbsp;Editar</button>            
          
            <button type="button" class="btn  btn-mini"
                onclick="cargar_modal('crm_modal','modal_body','/crm/empresa/create?layout=detail&tipo=1&t=empresat01&swmodal=1','refresh_combo')">
            <i class="icon-briefcase" ></i>&nbsp;Nuevo</button>
        </g:if>
        <span id="msgNoExite" style="display:none;">
           <b style="color:red; padding-top:3px;"> Empresa no exite! </b>
        </span>
    </div>
</div>
<div id="infoClientex" style="display:none;">

</div><!-- fin div infocliente -->
