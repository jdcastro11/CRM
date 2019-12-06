<%@ page import="crm.ValorParametro" %>       
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="detalle">
        <g:set var="entityName" value="${message(code: 'valorParametro.label', default: 'ValorParametro')}" />
        <title>Valor Parametro</title>
         <r:require module="filterpane" />
    </head>

	

    <body id="valp" >
           	  
        <div id="detalleconten">
           

            <h2>${xtitulo}</h2>
            <g:render template="/general/mensajes" />
             <% 
               if (!xidparametro)
                  xidparametro=session['idparametro']
               else
                  session['idparametro']=xidparametro  
            %>
            <hr style="margin-top:10px;margin-bottom:10px;"> 
            
                 <filterpane:filterPane domain="ValorParametro" 
                       formName="frmFiltro"
                       action="index"
                       showTitle="no"
                       dialog="true"
                       filterProperties="${['valor', 'idValorParametro','descValParametro']}"
                       showSortPanel="false"
                       fullAssociationPathFieldNames="false"
                   />   
           
                
                    <div class="pull-left">
                         <g:if test="${'CREAR' in session['operaciones']}">
                        <a class="btn btn-mini btn-primary" href="/crm/valorParametro/create/?idp=${xidp}&idparametro=${xidparametro}">
                            <i class="icon-plus icon-white"></i>
                            <strong>&nbsp;Nuevo</strong>
                        </a>

                    </g:if>  
                </div>
                &nbsp;                     
                <div class="btn-group">

                     <a href="#" class="btn btn-mini" >Acciones</a>
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
                        <%  def swacc=0 %>
                    <ul class="dropdown-menu">                     
                         <g:if test="${'BORRAR' in session['operaciones']}">
                               <%  swacc=1 %>
                           <li><a href="/crm/ValorParametro/listarBorrados/${xidparametro}" >Ver Borrados</a></li>  
                        </g:if>
                        <g:if test="${swacc==0}" >
                         <li align="center">Ninguna </li>
                       </g:if>
                    </ul>
                </div>
           
                    <!-- inicio filter  buttons -->                           
                            <filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="Filtrar Lista" appliedText="Cambiar Filtro"/>                           
                            <filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
                            <!-- fin filter  buttons  -->
             
                 <a  class="btn btn-mini" href="/crm/valorParametro/index/${xidparametro}"><i class="icon-remove"></i>&nbsp;Cancelar</a>

              <g:set var="beanInstance"  value="${valorParametroInstance}" />
              
           
                <table class="table table-bordered">
                <thead>
                    <tr>
                        <td style="width:18px"> </td>
                        <g:sortableColumn property="idValorParametro" title="${message(code: 'valorParametro.idValorParametro.label', default: 'Código')}" />

                        <g:sortableColumn property="valor" title="${message(code: 'valorParametro.valor.label', default: 'Valor')}" />
                        
                        <g:sortableColumn property=" descValParametro" title="${message(code: 'valorParametro. descValParametro.label', default: 'Descripción')}" />
                       
                        <g:sortableColumn property="orden" title="${message(code: 'valorParametro.orden.label', default: 'Orden')}" style="text-align:center" />
                  
                    </tr>
                </thead>
                <tbody>
                    <g:if test="${valorParametroInstanceList!=null}">                           
                        <g:each in="${valorParametroInstanceList}" status="i" var="valorParametroInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td><g:checkBox name="valorparametros" value="${valorParametroInstance.id}" checked="false" /></td>		
                                <td><g:link action="show" id="${valorParametroInstance?.id}" style="text-decoration:underline;">${fieldValue(bean: valorParametroInstance, field: "idValorParametro")}</g:link></td>

                                <td>${fieldValue(bean: valorParametroInstance, field: "valor")}</td>
                                
                                <td>${fieldValue(bean: valorParametroInstance, field: "descValParametro")}</td>
                                 
                                <td><center>${fieldValue(bean: valorParametroInstance, field: "orden")}</center></td>           
                                
                        </tr>
                    </g:each>
                </g:if>
                </tbody>
            </table>
            
                <div class="pagination_crm">  
                 <filterpane:paginate id="${xidparametro}"   total="${valorParametroInstanceCount ?: 0}" domainBean="ValorParametro"/>  
                </div>
        </div>
        
        <script>                    
             <!-- calcula el alto del bloque htm del detalle de encaberzado respectivo --> 
            var contenido= $("#detalleconten");                       
            if (parent.IFRAME_DETALLE !=null)parent.IFRAME_DETALLE.height(contenido.height()+360);
            
        </script> 
         </body>

</html>

