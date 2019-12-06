<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">       
        <title><g:message code="default.edit.label" args="[entityName]" /></title>       
    </head>
    <body>
        <script src="${resource(dir: 'js', file:'crm_helper.js')}"></script>
        <div id="edit-vencimiento" class="content scaffold-edit" role="main">
            <h2>Reporte de Vencimientos</h2>
            <hr style="margin-top:10px;margin-bottom:10px;"> 

            <form class="form-horizontal" action="/crm/vencimiento/infoVencimientoDef" method="post" >

                <fieldset class="form">
                    <button type="submit" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;Generar
                    </button> 
                    <a  class="btn btn-mini" href="/crm"><i class="icon-remove"></i>&nbsp;Cancelar</a>
                    <br><br>
                    <g:set var="beanInstance"  value="${vencimientoInstance}" />                
                    <g:render template="/general/mensajes" />  
                    <div class="control-group  ${hasErrors(bean: actividadInstance, field: 'fechaInicio', 'error')} ">
                        <label class="control-label"  for="fechaInicio">
                            <g:message code="actividad.fechaInicio.label" default="Mes Inicial" />

                        </label>
                        <div class="controls">
                            <g:datePicker name="fechaInicio" value="" precision="month" 
                                noSelection="['':'Selecione Mes']" />
                        </div>

                    </div>
                   
                    <div class="control-group  ${hasErrors(bean: actividadInstance, field: 'fechaFinal', 'error')} ">
                        <label class="control-label"  for="fechaFinal">
                            <g:message code="actividad.fechaFinal.label" default="Mes Final" />

                        </label>                    
                        <div class="controls">
                            <g:datePicker name="fechaFinal" value="" precision="month" 
                                noSelection="['':'Seleccione Mes']" />
                        </div>

                    </div>
                    <span id="errfec" style="display:none;"> <b style="color:red; padding-top:3px;"> Esta fecha debe ser posterior a la anterior </b>
                        <a href="#" onclick="document.getElementById('errfec').style.display='none'" ><i class="icon-remove"></i></a>
                    </span>
                </fieldset>				
            </form>
            <script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.js')}"></script>
            <script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.es.js')}"></script>
            <script type="text/javascript">

                $('.form_date').datetimepicker({
                language:  'es',
                weekStart: 1,
                todayBtn:  1,
                autoclose: 1,
                todayHighlight: 1,
                startView: 2,
                minView: 2,
                forceParse: 0
                });

            </script>
    </body>
</html>