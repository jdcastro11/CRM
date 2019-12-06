<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'Prospecto')}" />
        <title>Ultima Nota</title>
    </head>
    <body>
         <% 
            if (oportunidadInstance?.idEtapa=='posventx25') xicono="25.png"
            else if (oportunidadInstance?.idEtapa=='posventx50') xicono="50.png"                              
           else xicono="nada.png"
        %>
        <h2>Gestión y Seguimiento de Oportunidad</h2>  
        <a  class="btn btn-mini" href="/crm/oportunidad/indexg"><i class="icon-remove"></i>&nbsp;Regresar</a>
        <hr style="margin-top:10px;margin-bottom:10px;width:80%;">   
      <g:form class="form-horizontal" >
        <div class="control-group">
            <label class="control-label" for="numOportunidad">Nro. Oportunidad </label>
            <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:210px;background-color:#EEE;">
               ${oportunidadInstance?.numOportunidad}               
               <img src="/crm/images/${xicono}" title="Probabilidad" class="pull-right">
            </div>
             
        </div>
       
        <div class="control-group">
            <label class="control-label">Proyecto</label>
            <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:210px;background-color:#EEE;">
             ${oportunidadInstance?.nombreOportunidad}
            </div>
        </div>
          <div class="control-group">
            <label class="control-label">Cliente</label>
            <div class="controls" style="padding:4px; border:solid;border-color:#ccc;border-width:1px;border-radius:5px;width:210px;background-color:#EEE;">
             ${oportunidadInstance?.nombreCliente}
            </div>
        </div>
        </g:form>
        <iframe id="ifnotas" src="/crm/nota/index/${oportunidadInstance?.id}?entidad=oportunidad&zw=1" 
                style="border:0;width:100%;"  scrolling="no"></iframe>
         <script>    
          IFRAME_DETALLE = $("#ifnotas");                    
          </script>
    </body>
</html>
