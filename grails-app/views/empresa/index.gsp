
<%@ page import="crm.Empresa" %>
<%@ page import="crm.Territorio" %>

<g:set var="generalService" bean="generalService" />
<%
   def mover=generalService.getMenuV(1)
   def mout=generalService.getMenuV(2)
   def estilo=generalService.getMenuV(3)
%>
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
        <g:set var="entityName" value="${message(code: 'empresa.label', default: 'Empresa')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
         <r:require module="filterpane" />
    </head>
    <body>
    <g:set var="oportunidadService" bean="oportunidadService" />
<g:set var="seguridadService" bean="seguridadService" />
<%
def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/empresa/index')
%>

        <g:set var="generalService" bean="generalService" />
         
        <div id="list-empresa" class="content scaffold-list" role="main">
              
            <h2>${xtitulo}</h2>
            <hr style="margin-top:10px;margin-bottom:10px;">  
              <%
                 if (!xaccion)
                  xaccion="index"
                  
              %>   
              
            <filterpane:filterPane domain="Empresa" 
                formName="frmFiltro"
                action="${xaccion}"
                showTitle="no"
                dialog="true"
                filterProperties="${['nit', 'razonSocial','idSucursal','empleado']}"   
                associatedProperties="empleado.primerNombre,empleado.primerApellido"
                showSortPanel="false"
                               
            />
            <%  // parametrizacion de titulos create=xtitc y show=xtits
              def xtit; def xtits
              def xtipoF=params.id?:session['tipoF']
              if (xtipoF =='0') {xtitc='empresat15'; xtits='empresat14'}
              if (xtipoF =='1') {xtitc='empresat10'; xtits='empresat11'}
              else if (xtipoF =='2') {xtitc='empresat06'; xtits='empresat08'}
              else if (xtipoF =='5') {xtitc='provtitu03'; xtits='provtitu04'}
             %>
           <!--  fullAssociationPathFieldNames="false"-->
            <div class="row-fluid sortable">

           <g:form controller="empresa" >
                    <div class="pull-left">
                        <div class="pull-left">
                            
                        <g:if test="${'CREAR' in session['operaciones']}">
                              
                                <a class="btn btn-mini btn-primary" href="/crm/empresa/create?tipo=${params.id}&layout=main&t=${xtitc}&swmodal=">
                                    <i class="icon-plus icon-white"></i>
                                    <strong><g:message code="default.new.label"/></strong>
                                </a>
                            </g:if>         
                            
                        </div>
                    &nbsp;
                    <div class="btn-group">

                         <a href="#" class="btn btn-mini" ><g:message code="acciones.label"/></a>
                        <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                        <%  def swacc=0 %>
                        <ul class="dropdown-menu">
                         
                         <g:if test="${'BORRAR' in session['operaciones']}">
                            <%  swacc=1 %>
                          <li><a href="/crm/empresa/listarBorrados/${params.id}?layout=main&sort=razonSocial" ><g:message code="borrados.label"/></a></li>
                         </g:if>
                                                  
                         
                         <g:if test="${'MODIFICAR' in derechos}"><!-- CONVERTIR A CLIENTE -->
                           <li><g:actionSubmit  
                            onMouseOver="${mover}" 
                            onMouseOut="${mout}" 
                            style="${estilo}"  
                            value="${message(code: 'convertirCliente.label')}" 
                            action="convertirACliente" /></li>
                         </g:if>
                         
                         
                         
                         
                         <g:if test="${swacc==0}" >
                            <li align="center">Ninguna </li>
                           </g:if>
                           </ul>
                    </div>
                </div>
               
                    <!-- inicio filter  buttons -->                           
                            <filterpane:filterButton  class="btn btn-mini btn-warning" style="margin-left:2px;" text="${message(code: 'fp.tag.filterButton.text', default: 'Prospecto')}" appliedText="Cambiar Filtro"/>                           
                            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
                            <!-- fin filter  buttons  -->
                            
                 <a  class="btn btn-mini" href="/crm/empresa/index/${params.id}?layout=main&sort=razonSocial"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>
                
             <g:set var="beanInstance"  value="${empresaInstance}" />                
             <g:render template="/general/mensajes" />
             
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <td style="width:18px"> </td>
                            <g:sortableColumn style="width:95px;" property="nit" title="${message(code: 'empresa.nit.label', default: 'Nit')}" params="${filterParams}" />

                            <g:sortableColumn property="razonSocial" title="${message(code: 'empresa.razonSocial.label', default: 'Empresa')}"  params="${filterParams}" />

                            <g:sortableColumn property="direccion" title="${message(code: 'empresa.direccion.label', default: 'Dir. Principal')}" params="${filterParams}" />

                            <g:sortableColumn property="telefonos" title="${message(code: 'empresa.telefonos.label', default: 'Teléfono')}"  params="${filterParams}"/>

                            <g:sortableColumn property="persona" title="${message(code: 'empresa.idVendedor.label', default: 'Vendedor')}"  params="${filterParams}"/>                            
                            
                            <g:sortableColumn property="idCiudad" title="${message(code: 'empresa.Ciudad.label', default: 'Ciudad')}"  params="${filterParams}"/>  
                           
                            <g:sortableColumn property="idSucursal" title="${message(code: 'empresa.Sucursal.label', default: 'Sucursal')}"  params="${filterParams}"/>                            
                      
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${empresaInstanceList}" status="i" var="empresaInstance">
                            <% def xestilo
                               if (empresaInstance.idEstadoEmpresa=='empinactiv')  xestilo="background-color:#FFEFBF !important;"
                               else  xestilo=""
                             %>
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" style="${xestilo}" >
                                <td><g:checkBox name="empresas" value="${empresaInstance.id}" checked="false" /></td>
                                <td>
                                  <a  href="/crm/empresa/show/${empresaInstance.id}?tipo=${tipoF}&layout=main&t=${xtits}"
                                      style="text-decoration:underline;">
                                      <g:if test="${empresaInstance.nit !=null}">
                                        ${fieldValue(bean: empresaInstance, field: "nit")}
                                      </g:if>
                                      <g:else>
                                          Sin Nit
                                       </g:else>   
                                        </a>
                                    </td>

                                <td>${fieldValue(bean: empresaInstance, field: "razonSocial")}</td>

                                <td>${fieldValue(bean: empresaInstance, field: "direccion")}</td>

                                <td>${fieldValue(bean: empresaInstance, field: "telefonos")}</td>
                                
                                <td>${crm.Empleado.get(empresaInstance?.empleado?.id)}</td>

                                <td>${Territorio.get(empresaInstance.idCiudad)}</td>                               
                                
                                <td>${crm.Empresa.get(empresaInstance?.idSucursal)}</td>                               
                     
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <div class="pagination_crm">                   
                      <filterpane:paginate id="${params.id}"  total="${empresaInstanceCount?:0}" domainBean="Empresa" />
                </div>
            </div>
        </div>
	</g:form>
    </body>
</html>
