<%@ page import="crm.Oportunidad" %>
<%  def xlista=Oportunidad.executeQuery("select id,numOportunidad from Oportunidad where prospecto.id=${xidp} and eliminado=0") %>
 <div class="control-group">
        <label class="control-label" ><g:message code="oportunidades.template.label" default="Oportunidades"/></label>
        <div class="controls" >
         <g:each in="${xlista}" status="i" var="xop">   
            <a href="/crm/oportunidad/show/${xop[0]}" style="text-decoration:underline;"> ${xop[1]}</a>; 
         </g:each>   
        </div>
</div>