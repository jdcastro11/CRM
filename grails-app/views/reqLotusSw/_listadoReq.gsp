<html>

    <g:hiddenField  id="numeroOportunidad" name="numeroOportunidad"  value="${numOportunidad}" />
    
		<table id="requerimientos" class="table table-bordered">
            <thead>
                <tr>
                   <td><b><g:message code="reg.numero.label"/> </b></td>  
                   <td><b><g:message code="reqLotusSwInstance.tema.label"/></b></td> 
                   <td><b><g:message code="reqLotusSwInstance.tipo.label"/></b></td> 
                   <td><b><g:message code="reqLotusSwIntance.requeridoPor.label"/> </b></td>
                   <td><b><g:message code="reqLotusSwIntance.fechaCreacion.label"/></b></td>   
                </tr>
               
            </thead>
            <tbody>
                
              <g:each in="${requerimientoList}" status="i" var="requerimientoInstance">
                 <tr  class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td Style="width:70px">
                            <a  target="_blank" style="text-decoration:underline;" href="${requerimientoInstance?.ruta}">
                                ${requerimientoInstance?.id}</a>
                        </td>
                        <td  Style="width:250px">${requerimientoInstance?.tema}</td>
                         <td>${requerimientoInstance?.tipoRequerimiento}</td>
                        <td>${requerimientoInstance?.creadoPor}</td>                        
                        <td>${requerimientoInstance?.fechaCreacion?:'NA'}</td>
                    </tr>
               </g:each>
               
			<%-- ESTO ES PARA AGREGAR LOS REQUERIMIENTOS QUE VIENEN DE LA NUEVA HERRAMIENTA DE SRR  --%>

               <g:each in="${requerimientosListSrr}" status="i" var="requerimientoInstanceSrr">              
                 <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                 <% def ruta=generalService.devolverUrlSrr(requerimientoInstanceSrr?.NoRequerimiento) %>

                        <td Style="width:70px">
                            <a  target="_blank" style="text-decoration:underline;" href="${ruta}">
                                ${requerimientoInstanceSrr?.NoRequerimiento}</a>
                        </td>
                        <td  Style="width:250px">${requerimientoInstanceSrr?.DescripcionTema}</td>
                         <td>${requerimientoInstanceSrr?.tipoRequerimiento}</td>
                        <td>${requerimientoInstanceSrr?.nombreUsrSolicitante}</td>
                        <td>${requerimientoInstanceSrr?.fechaCreacion}</td>
                    </tr>
               </g:each>
            </tbody>
        </table>
        
        
</html>