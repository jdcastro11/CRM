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
            <button type="button" class="btn  btn-mini"
            onclick="idcontacto=document.getElementById('idContacto').value;if(idcontacto=='') return;cargar_modal('crm_modal_det','modal_body_det','/crm/persona/edit/'+idcontacto+'?layout=detail&tipo=1','refresh_combo');redimIframe(750);" >
            <i class="icon-briefcase" ></i>&nbsp;Editar</button>
        </g:if>
         <g:if test="${'CREAR' in session['operaciones']}">
            <button type="button" class="btn  btn-mini"  
            onclick="cargar_modal('crm_modal_det','modal_body_det','/crm/persona/create?layout=detail&tipo=1','refresh_combo');redimIframe(750);" >
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
