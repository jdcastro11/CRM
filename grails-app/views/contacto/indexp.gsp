<%@ page import="crm.Contacto" %>
<%@ page import="crm.Persona" %>
<%@ page import="crm.Empresa" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'persona.label', default: 'Contacto')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript library="jquery" />  
    <r:require module="filterpane" />
</head>
<body>
    %{--Use generalService--}%            
    <% def sw_crud=[1,1,1,1,0,1] %>
    <g:set var="generalService" bean="generalService"/>
    <div id="detalleconten">
                  <!--Inicio Operaciones de la opcion   -->

        <h2>Lista de Contactos x Persona </h2>
        <hr style="margin-top:10px;margin-bottom:10px;">
     
         
<!-- Fin operaciones de la Opcion) -->
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <td style="width:18px"> </td>
  
                        <g:sortableColumn property="empresa" title="${message(code: 'contacto.empresa.label', default: 'Empresa')}" />

                        <g:sortableColumn property="telefonoFijo" title="${message(code: 'contacto.telefonoFijo.label', default: 'Teléfono')}" />

                        <g:sortableColumn property="celularPrincipal" title="${message(code: 'contacto.celularPrincipal.label', default: 'Celular')}" />

                        <g:sortableColumn property="email" title="${message(code: 'contacto.email.label', default: 'E-Mail')}" />
                       
                        <g:sortableColumn property="fechaRegistro" title="${message(code: 'contacto.fechaRegistro.label', default: 'Fecha Registro')}" />
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${contactoInstanceList}" status="i" var="contactoInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td><g:checkBox name="contactos" value="${contactoInstance.id}" checked="false" /></td>

                            <g:set var="personaInstance"  value="${Persona.get(contactoInstance?.persona?.id)}"  />
                             <td>${Empresa.get(contactoInstance?.empresa?.id)}</td>

                            <td>${personaInstance.telefonoFijo}</td>

                            <td>${personaInstance.celularPrincipal}</td>

                            <td>${personaInstance.email}</td>   

                            <td><g:formatDate format="dd-MM-yyyy" date="${contactoInstance?.fechaRegistro}" /></td>  
                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination_crm">
                 <filterpane:paginate total="${contactoInstanceCount ?: 0}" domainBean="Contacto"/>
             </div>

        </div>
    </div>
    <script>
        <!-- resize el padre del iframe -->
        var contenido= $("#detalleconten");
        if (parent.IFRAME_DETALLE1 !=null)parent.IFRAME_DETALLE1.height(contenido.height()+380);

    </script>
</body>

</html>
