  <div class="control-group ">
  
        <label class="control-label" for="idDpto">
            <g:message code="empresa.idDpto.label" default="Departamento" />
           <span class="required-indicator">*</span>
        </label>
        <div class="controls" > 
            <% 
            if (!dptoList){ 
                
                def sql="from Territorio where idTipoTerritorio='terdpto' and padre.id=${xpais} and eliminado=0  order by nombreTerritorio"
                dptoList=crm.Territorio.findAll(sql)
           
            }
           
            %>
            <g:select name="idDpto" from="${dptoList}" id="idDpto1"
                      optionKey="id"
                      value="${xdpto}"
                       onchange="${remoteFunction(controller:'Territorio',
                                  action:'traerMunicipios', params:'\'id=\'+this.value',
                                 update: [success: 'divmuni'])}"
                          noSelection="['': 'Seleccione Dpto']"  
                      disabled="${xronly}"  required="" />
        </div>
 </div>