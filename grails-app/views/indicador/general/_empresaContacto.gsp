 <style>
  .ui-autocomplete {
    max-height: 250px;
    overflow-y: auto;
    /* prevent horizontal scrollbar */
    overflow-x: hidden;
  }
 
  * html .ui-autocomplete {
    height: 100px;
  }
  </style>
<label  class="control-label">  
    <a href="#" style="text-decoration:underline;" onClick="var el = document.getElementById('infoCliente');el.style.display = (el.style.display == 'none') ? 'block' : 'none';">${xlabelEmpresa}</a>
    <span class="required-indicator">*</span>
</label>
<div class="controls">
    <%  if (swemp=='1') zronly="true" else zronly=xronly %>
 
    <g:hiddenField id="idempresa" name="idempresa" value="${xidempresa}"        
        onchange=" if (this.value ==''){clearCombo('nombreContacto','idContacto','infoCliente')}else{mi_ajax('/crm/empresa/datosCliente',this.value,'infoCliente')}"  /> 
    <div class="control-group">        
        <g:textField id="nombreEmpresa" name="nombreCliente"   required=""  maxlength="100" class="input-xlarge"
        value="${crm.Empresa.get(xidempresa)}" disabled="${zronly}" 
        onchange="if (this.value =='') clearCombo('nombreContacto','idContacto','infoCliente')"
        placeholder="Ingrese mínimo dos letras iniciales" 
        />
        
        <script>
             autoCompletar('nombreEmpresa','/crm/Empresa/autoCompletar/${autoSw}','idempresa') 
              $('#idempresa').change()
           
        </script>                         
         <%  String xtit1; String xtit2 
                   if(swNit=='1') {xtit1='empresat06';xtit2='empresat07'} else{ xtit1='empresat01';xtit2='empresat02'} 
         %>
        <g:if test="${zronly=='false'}">    
            <g:if test="${'MODIFICAR' in session['operaciones']}">
                <button type="button" class="btn btn-mini" style="margin-left:7px;"
                onclick="var xidempresa = document.getElementById('idempresa').value;if(xidempresa=='')return;cargar_modal('crm_modal','modal_body','/crm/empresa/edit/'+xidempresa+'?layout=detail&tipo=1&swnit=${swNit}&swmodal=1&t=${xtit2}','refresh_combo')" >
                <i class="icon-briefcase"></i>&nbsp;Editar</button>  
              </g:if>
           <g:if test="${'CREAR' in session['operaciones']}">
                
                <button type="button" class="btn btn-mini"
                    onclick="cargar_modal('crm_modal','modal_body','/crm/empresa/create?layout=detail&tipo=1&t=${xtit1}&swmodal=1&swnit=${swNit}','refresh_combo')">
                <i class="icon-briefcase"></i>&nbsp;Nuevo</button>
            </g:if>
        </g:if>
        <span id="msgNoExite" style="display:none;">
           <b style="color:red; padding-top:3px;"> Empresa no existe! </b>
        </span>
    </div>
</div>
<div id="infoCliente" style="display:none;">

</div><!-- fin div infocliente -->

<div class="control-group ${hasErrors(bean: entidadInstance, field: 'idContacto', 'error')} required ">
    <label class="control-label" for="idContacto">
        <a href="#" style="text-decoration:underline;" onClick="var el = document.getElementById('infoContacto');el.style.display = (el.style.display == 'none') ? 'block' : 'none';">${xlabelContacto}</a> 
        <span class="required-indicator">*</span>
    </label>
    <div class="controls" > 
        
        <span id="comboContactos">
            <g:textField id="nombreContacto" name="nombreContacto"   required=""  maxlength="100" class="input-xlarge"
            value="${crm.Persona.get(xidcontacto)}" disabled="${xronly}" 
            placeholder="Ingrese mínimo dos letras iniciales" 
            onchange="" />
            <g:hiddenField id="idContacto" name="${zidcontacto}" value="${xidcontacto}" 
            onchange="if (this.value ==''){clearCombo('nombreContacto','','infoContacto')}else{mi_ajax('/crm/Persona/datosContacto',this.value,'infoContacto');}" />

        </span>

        <script type="text/javascript">
             miAutoCompletar('nombreContacto','/crm/contacto/autoCompletar','idContacto','idempresa')
           $('#idContacto').change()
                  
            
        </script>
   
        <g:if test="${xronly=='false'}" >
         <g:if test="${'MODIFICAR' in session['operaciones']}">
            <button type="button" class="btn  btn-mini" style="margin-left:5px"
            onclick="idcontacto=document.getElementById('idContacto').value;if(idcontacto=='') return;cargar_modal('crm_modal','modal_body','/crm/persona/edit/'+idcontacto+'?layout=detail&tipo=1','refresh_combo');redimIframe(700);" >
            <i class="icon-briefcase" ></i>&nbsp;Editar</button>
        </g:if>
         <g:if test="${'CREAR' in session['operaciones']}">
            <button type="button" class="btn  btn-mini"  
            onclick="cargar_modal('crm_modal','modal_body','/crm/persona/create?layout=detail&tipo=1','refresh_combo');redimIframe(700);" >
            <i class="icon-user" ></i>&nbsp;Nuevo</button>
            </g:if>
        </g:if>
        <span id="msgNoExite2" style="display:none;">
               <b style="color:red; padding-top:3px;"> Contacto no existe! </b>
        </span>
      
    </div>

</div>
<div id="infoContacto" style="display:none;">
</div>