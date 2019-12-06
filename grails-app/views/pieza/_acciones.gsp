<div class="pull-left">
    <g:if test="${'MODIFICAR' in session['operaciones']}">
        <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</button>
    </g:if>
    <g:if test="${'BORRAR' in session['operaciones']}">
        <g:if test="${piezaInstance?.eliminado==1}" >
            <a href="#" onclick="crm_deseliminar()" class="btn btn-success  btn-mini">Borrar | Des-Borrar</a>
        </g:if> 
    </g:if>    
    &nbsp;<a  class="btn btn-mini" href="/crm/pieza/index/${piezaInstance?.tactica?.id}"> <i class="icon-remove"></i>&nbsp;Cancelar</a>
</div>