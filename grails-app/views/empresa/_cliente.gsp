<%@ page import="crm.Empresa" %>
<%@ page import="crm.Territorio" %>
<g:set var="generalService" bean="generalService"/>
<script src="${resource(dir: 'js', file:'crm_helper.js')}"></script> 
<script src="${resource(dir: 'js', file:'jquery-1.10.2.min.js')}"></script> 
<script>redimIFRAME();
 function fallaAja(){
   alert("falla la cosa")
}
 
</script>
<div>
    <g:if test="${empresaInstance?.eliminado==1}" >
        <div id="men_eliminado" class="pull-right label label-important">
            <g:message code="eliminado.label"/>
        </div>
    </g:if>
   <% def ztipo  
      if (params.tipo) ztipo=params.tipo
      else ztipo=xtipo   
   %>
   <g:hiddenField name="idempresa"  value="${params?.id}"/> 
   <g:hiddenField name="tipoF"  value="${ztipo}"/>
     <g:hiddenField name="layout"  value="${params.layout}"/>
    <g:hiddenField name="idTipoEmpresa"  value="empcliente"/>   
    <g:hiddenField name="idTipoSede"  value="empprincip"/>
    <g:hiddenField  id ="eliminado" name="eliminado" value="${empresaInstance?.eliminado?:0}" />

    <g:hiddenField   name="idPais" id="idPais" value="${empresaInstance?.idPais}" />
    <g:hiddenField   name="idDpto" id="idDpto" value="${empresaInstance?.idDpto}" />
    <g:hiddenField   name="idCiudad" id="idCiudad" value="${empresaInstance?.idCiudad}" />

    <div class="control-group ${hasErrors(bean: empresaInstance, field: 'razonSocial', 'error')} ">
        <label class="control-label" for="Empresa">
            <g:message code="empresa.razonSocial.label" default="Razón Social" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:textField name="razonSocial"   id="razonSocial"  maxlength="200"  style="width:400px;text-transform:uppercase;" 
            value="${empresaInstance?.razonSocial}" disabled="${xronly}" required="" onkeyup="upperCases();validarLongitudRazonSocial();" />            
            <div  style="display:none;color:red;" id="verifRazon">Razón social sólo puede contener 100 caracteres. Verifique</div>
        </div>
        
    </div>   

    <div class="control-group ${hasErrors(bean: empresaInstance, field: 'nit', 'error')} ">
        <label  class="control-label" for="nit">
            <g:message code="empresa.nit.label" default="Nit" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls" >
            <g:textField name="nit" id="nit" maxlength="15" value="${empresaInstance?.nit}" placeholder="${message(code: 'placeholder.nit.label')}" disabled="${xronly}" required="" 
                onkeypress="return isNit(event);" />
             <img  class="iconoAyudaEtiqueta"  src="${resource(dir: 'images', file:'ayuda.png')}" title="Sólo números, un guión y un dígito después del guión. Ej: 802006024-8">
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: empresaInstance, field: 'idSector', 'error')} ">
        <label class="control-label" for="idSector">
            <g:message code="empresa.idSector.label" default="Sector" />

        </label>
        <div class="controls" >
            <g:select name="idSector" from="${generalService.getValoresParametro('sectores')}"
                optionKey="idValorParametro"
            value="${empresaInstance?.idSector}"
            noSelection="['': "${message(code: 'seleccionar.sector.label')}"]"  disabled="${xronly}" />
        </div>
    </div>
    <div class="control-group ${hasErrors(bean: empresaInstance, field: 'idSucursal', 'error')} ">
        <label class="control-label" for="idSucursal">

            <g:message code="empresa.idSucursal.label" default="Sucursal" />     
          
        </label>
        <div class="controls">
            <g:select name="idSucursal"  from="${Empresa.findAllByIdTipoEmpresaAndEliminado('empbase',0)}"
                optionKey="id" 
            value="${empresaInstance?.idSucursal}"
            noSelection="['': "${message(code: 'prospecto.seleccioneSucursal.label', default: 'Seleccione Sucursal')}"]"  disabled="${xronly}" required="" />            
        </div>
         
    </div>

    <div class="control-group ${hasErrors(bean: empresaInstance, field: 'idVendedor', 'error')} ">
        <label class="control-label" for="idVendedor">
            <g:message code="empresa.idVendedor.label" default="Vendedor" />

        </label>
        <div class="controls" >
            <g:select name="idVendedor" from="${generalService.getVendedores()}"
                optionKey="id"
            value="${empresaInstance?.empleado?.id}"
            noSelection="['': "${message(code: 'seleccioneVendedor.propuesta.label', default: 'Seleccione Vendedor')}"]"  disabled="${xronly}" />
        </div>
    </div>
    <div class="control-group ${hasErrors(bean: empresaInstance, field: 'idEstadoEmpresa', 'error')} ">
        <label class="control-label" for="idEstadoEmpresa">
            <g:message code="empresa.idEstadoEmpresa.label" default="Estado" />

        </label>
        <div class="controls">
            <g:select name="idEstadoEmpresa" from="${generalService.getValoresParametro('eempresa')}"
                optionKey="idValorParametro"
            value="${empresaInstance?.idEstadoEmpresa?:'empactivo'}"
            noSelection="['': '']" disabled="${xronly}"  />
        </div>
    </div>

    <br>
    <div class=" pull-left" style="background-color:#f6f6f6;width:99%;padding:5px;font-weight:bold;}" ><g:message code="sedePrincipal.label"/></div>
    <p style="padding-top:1px">&nbsp;</p>

    <div class="control-group ${hasErrors(bean: empresaInstance, field: 'direccion', 'error')} ">
        <label class="control-label" for="direccion">
            <g:message code="empresa.direccion.label" default="Dirección" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:textArea name="direccion" id='direccion' rows="3" cols="120" class="input-xlarge" value="${empresaInstance?.direccion}" readonly  required="" />
            <g:if test="${xronly=='false'}" >
                <button type="button" class="btn  btn-mini"
                onclick="cargar_modal('crm_modal','modal_body','/crm/general/setDireccion/${empresaInstance?.id}?entidad=empresa&layout=detail&tipo=1','');redimIframe(700);" >
                <i class="icon-briefcase" ></i>&nbsp;<g:message code="default.button.edit.label"/></button>
            </g:if>
        </div>
    </div>


    <div class="control-group ${hasErrors(bean: empresaInstance, field: 'telefonos', 'error')} ">
        <label class="control-label" for="telefonos">
            <g:message code="empresa.telefonos.label" default="Teléfonos" />

        </label>
        <div class="controls">
            <g:textField name="telefonos" maxlength="20" value="${empresaInstance?.telefonos}" disabled="${xronly}"/>
        </div>
    </div>
    <div class="control-group  ${hasErrors(bean: empresaInstance, field: 'email', 'error')} ">
        <label  class="control-label"  for="email">
            <g:message code="empresa.email.label" default="E-mail" />

        </label>
        <div class="controls">
            <g:textField name="email" maxlength="200" value="${empresaInstance?.email}" disabled="${xronly}" />
        </div>
    </div>
    
    <div class="control-group ${hasErrors(bean: empresaInstance, field: 'numAnteFabricante', 'error')} ">
        <label class="control-label" for="observaciones">
            <g:message code="empresa.numAnteFabricante.label" default="Código Ante Fabricantes"  disabled="${xronly}" />

        </label>
        <div class="controls">
            <g:textArea name="numAnteFabricante" maxlength="150" col="60" rows="5" 
            value="${empresaInstance?.numAnteFabricante}" />
        </div>
    </div>
    
    <g:if test="${empresaInstance?.idUltimaTactica}" >        
        <% def tacticaInstance=crm.Tactica.get(empresaInstance?.idUltimaTactica)%>
        <br>  
        <div class=" pull-left" style="background-color:#f6f6f6;width:99%;padding:5px;font-weight:bold;}" >Última Gestión de Ventas</div>
        <br/><br>
        <div class="control-group ">
            <label  class="control-label">Fecha</label>
            <div class="controls">
                <g:formatDate format="dd-MM-yyyy" date="${tacticaInstance?.ultimaFecha}" />
            </div>
        </div>      
        <div class="control-group ">
            <label  class="control-label">Táctica</label>
            <div class="controls">
                ${tacticaInstance?.tactica}
            </div>
        </div> 
    </g:if> 
</div>
<p>&nbsp;</p>

<g:if test="${empresaInstance?.id!=null}">
    <div class="tabbable" >

        <ul class="nav  nav-tabs" id="myTab" style="font-weight: bold;">

            <li class="active"><a href="#home" data-toggle="tab"><g:message code="contacto.title.label"/></a></li>
            <li><a href="#sedes"  data-toggle="tab"><g:message code="sedes.title.label"/></a></li>    
            <li><a href="#hvida"  data-toggle="tab"><g:message code="hojavida.label"/></a></li>    
        </ul>

        <div class="tab-content">
            <div class="tab-pane active" id="home">
                <div class="box-content">
                    <iframe id="ifcontactos" src="/crm/contacto/listarContactos/${empresaInstance?.id}?t=contactt00&layout=detail&sw=${sw}" style="border:0;overflow:hidden;width:100%;" ></iframe>

                   <%-- <script language="javascript">
                        IFRAME_DETALLE1 = $("#ifcontactos");
                    </script> --%>
                </div>
            </div>
            <div class="tab-pane" id="sedes">
                <div class="box-content">
                    <iframe id="ifsedes" src="/crm/empresa/listarSedes/${empresaInstance?.id}?t=sedest00&layout=detail&sw=${sw}" style="border:0;overflow:hidden;width:100%;" ></iframe>
                  <%--  <script language="javascript">
                        IFRAME_DETALLE2 = $("#ifsedes");
                    </script>--%>
                </div>
            </div>
             <div class="tab-pane" id="hvida">
                <div class="box-content">
                    <iframe id="ifhvida" src="/crm/anexo/index/${empresaInstance?.id}?entidad=empresa&anex=anexohvida" style="border:0;overflow:hidden;width:100%;" ></iframe>
                   <%-- <script language="javascript">
                        IFRAME_ANEXO = $("#ifhvida");
                    </script>--%>
                </div>
            </div>
        </div>
    </div>
</g:if>
<script>                    
<!-- calcula el alto del bloque htm del detalle de encaberzado respectivo --> 
    var contenido= $("#boxvalp"); 

    if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+150);     

</script>