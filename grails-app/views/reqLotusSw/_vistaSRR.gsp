<html>
<g:set var="generalService" bean="generalService" />
<%--esta es la que tengo que editar mañana --%>
    <g:hiddenField  id="numeroOportunidad" name="numeroOportunidad"  value="${numOportunidad}" />
    
			<table id="requerimientos" class="table table-bordered">
            <thead>
                <tr>
                   <td><b><g:message code="reg.numero.label"/> </b></td>  
                   <td><b><g:message code="reqLotusSwInstance.tema.label"/></b></td> 
                   <td><b><g:message code="reqLotusSwInstance.tipo.label"/></b></td> 
                   <td><b><g:message code="reqLotusSwIntance.requeridoPor.label"/> </b></td>  
                </tr>
               
            </thead>
            <tbody>
                
              <g:each in="${requerimientoList}" status="i" var="requerimientoInstance">              
                 <tr  class="${(i % 2) == 0 ? 'even' : 'odd'}">
                 <% def ruta=generalService.devolverUrlSrr(requerimientoInstance.NoRequerimiento) %>

                        <td Style="width:70px">
                            <a  target="_blank" style="text-decoration:underline;" href="${ruta}">
                                ${requerimientoInstance?.NoRequerimiento}</a>
                        </td>
                        <td  Style="width:250px">${requerimientoInstance?.DescripcionTema}</td>
                         <td>${requerimientoInstance?.tipoRequerimiento}</td>
                        <td>${requerimientoInstance?.nombreUsrSolicitante}</td>
                    </tr>
               </g:each>
            </tbody>
        </table>
</html>