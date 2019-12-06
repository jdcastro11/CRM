
<tr>
    <td>${fieldLabel} &nbsp;</td>

    <td style="padding-left:3px;">
        <g:select id="${opName}" 
        name="${opName}" 
        from="${opKeys}" 
        keys="${opKeys}"
        value="${opValue}"
        valueMessagePrefix="fp.op"
        onChange="grailsFilterPane.filterOpChange('${opName}', '${ctrlAttrs.id}');document.getElementById('birdboton').disabled=''"   />        
    </td>
    <td style="padding-left:3px;">    
         <%              
          ctrlAttrs['id']=ctrlAttrs['name'].replace(".","_")
          ctrlAttrs['onChange']=ctrlAttrs['onChange']+";validarFiltro('"+ctrlAttrs['id']+"')"        
          ctrlAttrs['onkeyup']="validarFiltro('"+ctrlAttrs['id']+"')" 
          %>
    <filterpane:input ctrlType="${ctrlType}" ctrlAttrs="${ctrlAttrs}"   />
   
    <g:if test="${toCtrlAttrs != null}">
        <span style="${toCtrlSpanStyle}" id="between-span-${toCtrlAttrs.id}">
            &nbsp;<g:message code="fp.tag.filterPane.property.betweenValueSeparatorText" default="and" />&nbsp;
            <filterpane:input ctrlType="${ctrlType}" ctrlAttrs="${toCtrlAttrs}"   />
        </span>
    </g:if>
</td>
</tr>