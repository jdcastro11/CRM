<%@ page import="crm.Persona" %>
<%@ page import="crm.Contacto" %>

<span id="comboContactos">
<% String xquery="select p from Persona p, Contacto c where p.id=c.persona.id and c.empresa.id=${xidEmpresa}" %>
<g:set var="generalService" bean="generalService" />
        <g:select id="cboContacto" class="input-xlarge"  required=""  name="idContacto"
                 from="${Persona.executeQuery(xquery)}"
           optionKey="id"
               value="${xidValue}"
         noSelection="['': "${message(code: 'seleccionarContacto.label', default: 'Seleccione Contacto')}"]"  disabled="${xronly}" 
             onchange="if (this.value=='') document.getElementById('infoContacto').innerHTML='';mi_ajax('/crm/Persona/datosContacto',this.value,'infoContacto');" />
</span>

