<div class="control-group">
    <label class="control-label" for="plataforma">
            <g:message code="vencimiento.plataforma.label" default="Plataforma/Marca"/>
    </label>
    <div class="controls">
       
        <g:select name="plataforma" from="${marcaList}"
                  optionKey="id"   
                  value="${xvalor}"
                  noSelection="['': 'Seleccione Marca']"    disabled="${xronly}"  />
    </div>
     
</div>
