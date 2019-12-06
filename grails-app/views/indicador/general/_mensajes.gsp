
<g:if test="${flash.message}">

    <div id="diverr" style="display:inline" class="alert alert-success" role="status"><strong>${flash.message} </strong>
   <g:if test="${flash.link}" >
       <% println flash.link %>
   </g:if>  
     <a href="#" onclick="$('#diverr').fadeOut('slow')" ><i class="icon-remove"></i></a></div>
 </g:if>
 <g:if test="${flash.warning}">
    <div id="divwar"  style="display:inline" class="alert alert-error" role="status"><strong> ${flash.warning} </strong>
    <a href="#" onclick="$('#divwar').fadeOut('slow')" ><i class="icon-remove"></i></a></div>
 </g:if>
<g:hasErrors bean="${beanInstance}">
    <ul  style="font-weight:bold;color:#CC0000;margin:15px;" role="alert">
            <g:eachError bean="${beanInstance}" var="error">
            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"
               </g:if>><g:message error="${error}"/>
            </li>
            </g:eachError>
    </ul>
 </g:hasErrors>

