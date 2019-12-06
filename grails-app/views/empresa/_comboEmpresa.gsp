<%@ page import="crm.Empresa" %>

<g:select id="cboEmpresa" style="width:250px;"
          name="empresa.id"

          from="${Empresa.findAll("from Empresa where idTipoEmpresa in ('empcliente','empprospec','empproveed') and padreId=null order by razonSocial")}"
          optionKey="id" required=""
          value=" ${xidEmpresa}" class="many-to-one"
          noSelection="['': 'Seleccione Empresa']"  disabled="${xronly}"  />
