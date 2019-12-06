
<div class="control-group ${hasErrors(bean: elementoPorOportunidadInstance, field: 'sublinea.id', 'error')} required">
    <label class="control-label" for="idSublinea">
        <g:message code="elementoPorOportunidad.idSublinea.label" default="Sublínea" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select name="idSublinea" from="${sublineaList}"
                  optionKey="id"   required=""
                  value="${xidsublinea}"
                  noSelection="['': 'Selecciones Sublínea']"    disabled="${xronly}" />
    </div>

</div>
