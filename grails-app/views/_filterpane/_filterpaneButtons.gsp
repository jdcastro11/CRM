<div class="buttons">
    <span class="button">
        <input type="button"   style="width:60px;"
               class="btn btn-mini"
               value="${cancelText}" 
               onclick="return grailsFilterPane.hideElement('${containerId}');" />
    </span>
    <span class="button">
        <input type="button" style="width:60px;"
               class="btn btn-mini"
               value="${clearText}"
               onclick="return grailsFilterPane.clearFilterPane('${formName}');" />
    </span>
    <span class="button">
      <g:actionSubmit id="birdboton" class="btn btn-mini btn-primary" style="width:60px;" value="${applyText}" action="${action}" disabled="disabled" />
    </span>
</div>