<div class="pull-left">
    <g:if test="${'MODIFICAR' in session['operaciones']}">
        <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Guardar</button>
    </g:if>
    <g:if test="${'BORRAR' in session['operaciones']}">
        <g:if test="${tacticaInstance?.eliminado==1}" >
            <a href="#" onclick="crm_deseliminar()" class="btn btn-success  btn-mini">Borrar | Des-Borrar</a>
        </g:if> 
    </g:if> 
    <div class="btn-group">
        <a href="#" class="btn btn-mini" >Acciones</a>
        <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
            <span class="caret"></span></button>
        <ul class="dropdown-menu">
             <li align="center">Ninguna </li>
        </ul>										
    </div>
    &nbsp;<a  class="btn btn-mini" href="/crm/tactica/index/${tacticaInstance?.estrategia?.id}"> <i class="icon-remove"></i>&nbsp;Cancelar</a>
</div>