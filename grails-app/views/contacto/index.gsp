<%@ page import="crm.Contacto" %>
<%@ page import="crm.Persona" %>
<%@ page import="crm.Empresa" %>
<!DOCTYPE html>
<html>
    <head>
        <g:if test="${params.layout=='detail'}" >
            <g:set var="xlayout" value="detalle"  />
        </g:if>
        <g:else>
            <g:set var="xlayout" value="perfectum"  />
        </g:else>
        <meta name="layout" content="${xlayout}">
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

        <h2>${xtitulo}</h2>
        <hr style="margin-top:10px;margin-bottom:10px;">
        
        <filterpane:filterPane domain="Contacto" 
        formName="frmFiltro"
        action="filter"
        showTitle="no"
        dialog="true"
        filterProperties="${['empresa','persona']}"
        associatedProperties="empresa.razonSocial,persona.primerApellido,persona.primerNombre"
        showSortPanel="false"
        fullAssociationPathFieldNames="false"
        />

        <div class="row-fluid sortable">

            <div class="pull-left">
                <div class="pull-left">
                    <g:if test="${'CREAR' in session['operaciones']}">

                        <a class="btn btn-mini btn-primary" href="/crm/contacto/create/${params.id}?layout=${params.layout}&swmodal=">
                            <i class="icon-plus icon-white"></i>
                            <strong>&nbsp;<g:message code="default.new.label"/></strong>
                        </a>

                    </g:if>  
                </div>
            </div>
            &nbsp;
           <%  def swacc=0 %>
            <div class="btn-group">

                 <a href="#" class="btn btn-mini" ><g:message code="acciones.label"/></a>
                <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                <ul class="dropdown-menu">
                   <g:if test="${'IMPORTAR_CONTACTOS' in session['operaciones']}">
                      <%  swacc=1 %>
                       <li><a href="${createLink(action:'importarContactos')}" >Importar contactos</a></li>
                  </g:if>
                    <g:if test="${'BORRAR' in session['operaciones']}">
                        <%  swacc=1 %>
                      <li><a href="/crm/contacto/listarBorrados/?layout=${params.layout}" ><g:message code="borrados.label"/></a></li>
                   </g:if>
                   <g:if test="${swacc==0}" >
                    <li align="center">Ninguna </li>
                   </g:if>
                    </ul>
            </div>
            <!-- inicio filter  buttons -->                           
            <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="${message(code: 'fp.tag.filterButton.text')}" appliedText="Cambiar Filtro"/>
            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
            <!-- fin filter  buttons  -->  
            <g:if test="${params.layout=='detail'}" >
                <a  class="btn btn-mini" href="/crm/contacto/listarContactos/${params.id}?t=contactt00&layout=detail"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>
            </g:if> 
            <g:else>
                 <a  class="btn btn-mini" href="/crm/contacto/index/?layout=main"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a> 
          
            </g:else>
<!-- Fin operaciones de la Opcion) -->
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <td style="width:18px"> </td>
                        <g:sortableColumn property="persona" title="${message(code: 'contacto.nombre.label', default: 'Nombre')}" params="${filterParams}"/>

                        <g:sortableColumn property="empresa" title="${message(code: 'contacto.empresa.label', default: 'Empresa')}" params="${filterParams}"/>

                        <g:sortableColumn property="telefonoFijo" title="${message(code: 'contacto.telefonoFijo.label', default: 'Teléfono')}" params="${filterParams}"/>

                        <g:sortableColumn property="celularPrincipal" title="${message(code: 'contacto.celularPrincipal.label', default: 'Celular')}" params="${filterParams}"/>

                        <g:sortableColumn property="email" title="${message(code: 'contacto.email.label', default: 'E-Mail')}" params="${filterParams}"/>
                       
                        <g:sortableColumn property="fechaRegistro" title="${message(code: 'contacto.fechaRegistro.label', default: 'Fecha Registro')}" params="${filterParams}"/>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${contactoInstanceList}" status="i" var="contactoInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td><g:checkBox name="contactos" value="${contactoInstance.id}" checked="false" /></td>

                            <g:set var="personaInstance"  value="${Persona.get(contactoInstance?.persona?.id)}"  />
                            <td>
                                <a style="text-decoration:underline" href="/crm/contacto/show/${contactoInstance?.id}?layout=${params.layout}">
                                    ${Persona.get(contactoInstance?.persona?.id)}</a>                           
                            </td>

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
