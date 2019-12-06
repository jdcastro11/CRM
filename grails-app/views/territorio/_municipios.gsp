   <div class="control-group ${hasErrors(bean: empresaInstance, field: 'idCiudad', 'error')} ">
        <label class="control-label" for="idCiudad">
            <g:message code="empresa.idCiudad.label" default="Ciudad" />
          <span class="required-indicator">*</span>
        </label>
        <div class="controls" >
         
            <g:select name="idCiudad"  id="idCiudad1" from="${municipioList}"
                      optionKey="id"
                     value="${xidciudad}"
                      noSelection="['':"${message(code: 'seleccionarCiudad.label')}"]"  disabled="${xronly}"  required=""                          
                      />
        </div>
    </div>
   