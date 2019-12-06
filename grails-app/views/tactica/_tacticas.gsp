<div class="control-group">
    <label class="control-label" for="idTactica">
        <g:message code="tacticas.prospecto.label" default="Tácticas"/>   
       <span class="required-indicator">*</span>
    </label>
    <div class="controls">
       
        <g:select name="idTactica" from="${tacticaList}"
                  optionKey="id"   
                  value="${xvalor}"
                  noSelection="['': "${message(code: 'prospecto.seleccionaTactica.label', default: 'Seleccione Tactica')}"]"    disabled="${xronly}" required="" />
    </div>
     
</div>
