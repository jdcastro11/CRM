<%@ page import="crm.Persona" %>
<g:select id="cboContacto" style="width:250px;"
          name="${xcampo}"
          from="${Persona.findAll('from Persona where idTipoPersona=\'percontact\' and eliminado=0  order by primerNombre,primerApellido')}"
          optionKey="id" required=""
          value=" ${xidContacto}" class="many-to-one"
          noSelection="['': 'Seleccione Persona']"  disabled="${xronly}"  />