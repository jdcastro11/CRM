<%@ page import="crm.Persona" %>

<g:select id="comboContactos" name="idContacto" from="${xcontactoList?:Persona.findAllByIdTipoPersonaAndEliminado('percontact',0)}" 
                      optionKey="id" 
                      value="${xidPosibilidad}"                      
                      noSelection="['': '']"  disabled="${xronly}"  />