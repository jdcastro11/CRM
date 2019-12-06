
<!DOCTYPE html>
<html>
    <head>
        <g:if test="${params.layout=='main'}" >
            <g:set var="xlayout" value="perfectum"  />
        </g:if>
        <g:else>
            <g:set var="xlayout" value="detalle"  />
        </g:else>
        <g:if test="${params.swmodal==''}">
            <meta name="layout" content="${xlayout}">
        </g:if>
        <g:set var="entityName" value="${message(code: 'empresa.label', default: 'Empresa')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <script src="${resource(dir: 'js', file: 'crm_helper.js')}"></script> 
        <script>
        function validar(){
         var razon=document.getElementById('razonSocial')
          if (razon.value.trim()==''){
             var xerror = document.getElementById("mierror");
              xerror.innerHTML="<p style='color:red'> Debe Ingresar Razon Social</P>"
              razon.focus()
             return false
             }
         var nit=document.getElementById('nit')
         if (nit !=null){
          if (nit.value.trim()==''){
             var xerror = document.getElementById("mierror");
              xerror.innerHTML="<p style='color:red'>Debe Ingresar NIT</P>"
              nit.focus()
             return false
             }    
         }
          var tel=document.getElementById('telefonos')
          if (tel.value.trim()==''){
             var xerror = document.getElementById("mierror");
              xerror.innerHTML="<p style='color:red'> Debe Ingresar Telefono(s)</P>"
              tel.focus()
             return false
             }
         var dir=document.getElementById('direccion')
         if (dir.value.trim()==''){
             var xerror = document.getElementById("mierror");
              xerror.innerHTML="<p style='color:red'> Debe Ingresar Direccion</P>"
              dir.focus()
             return false
             } 
         return true
             
        }
        </script>
    </head>
    <body>
%{--Use generalService--}%
        <g:set var="generalService" bean="generalService"/>
        
        <g:set var="xtitulo" value="${generalService.getValorParametro(params.t)}" /> 
        <h2>${xtitulo}</h2>
        <hr style="width:80%;margin-top:10px;margin-bottom:10px;">                                               


<!-- inicio Zona  manejo de errores -->
        <div id="create-empresa" class="content scaffold-create" role="main">
        
            <ul id="erroraSync">

            </ul>
            <!-- fin Zona  manejo de errores -->
            <form class="form-horizontal" id="formEmpresa"   action="/crm/empresa/save" method="post" >
                <fieldset class="form">

                    <g:if test="${params.swmodal==''}">
                        <button type="button" id='btn_save_emp' onclick="if (obligar('direccion',' Dirección ')) {document.getElementById('formEmpresa').submit();desactivar('btn_save_emp')}" class="btn btn-mini btn-primary"><i class="icon-download-alt icon-white "></i>&nbsp;<g:message code="default.button.create.label"/></button>
                        <button class="btn btn-mini" onclick="history.go(-1)"><i class="icon-remove"></i>&nbsp;<g:message code="acciones.label"/></button>
                    </g:if>
                    <g:else>
                        <button type="button" class="btn btn-mini btn-primary" onclick="if (!validar()) return;guardarEntidad('/crm/empresa/saveAsync','formEmpresa','modal_body','idempresa','nombreEmpresa')"><i class="icon-download-alt icon-white"></i>&nbsp;<g:message code="default.button.create.label"/></button>
                    </g:else>
                    <br>
                    <g:render template="/general/mensajes" />
                    <g:set var="xronly" value="false" scope="request"/>
                    <g:if test="${params.tipo=='1'}" >
                        <g:set var="swNit" value="${params.swnit}" scope="request" />                      
                        <g:render template="prospecto"/>
                    </g:if>
                    <g:if test="${params.tipo=='2' || params.tipo=='5'}" >                    
                        <g:render template="cliente"/>
                    </g:if>
                    <g:if test="${params.tipo=='3'}" >
                        <g:set var="xidPadre" value="${params.id}" scope="request" />
                        <g:render template="sede"/>
                    </g:if>
                    <g:if test="${params.tipo=='4'}" >
                        <g:set var="xidPadre" value="${params.id}" scope="request" />
                        <g:render template="sucursal"/>
                    </g:if>
                </fieldset>
            </form>
           <div id="mierror"> </div>
        </div>
    </body>
</html>
