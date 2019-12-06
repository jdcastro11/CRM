<g:set var="generalService" bean="generalService" />
<div class="span2 main-menu-span">
   <div class="nav-collapse sidebar-nav">         
       <ul class="nav nav-tabs nav-stacked main-menu"> 
          <g:set var="menu" value="${generalService.getMenu(session['idUsuario'])}" />
          <li><a href="/crm" style="color:#EAC83A"><i class="icon-home icon-white"></i><g:message code="inicio.label"/></a></li>   
          <g:each in="${menu['padres']}" var="opcion">
 
          <li><a href="${opcion.url}" data-status="${opcion.tieneHijos}" class="${opcion.cls}">
               <i class="${opcion.tieneHijos==1?'icon-minus-sign icon-white':'icon-plus-sign icon-white'}"></i>
               <span class="hidden-tablet" style="color:#EAC83A"> ${opcion.nombreOpcion}
              </span></a>                 
               <% println generalService.subMenu(menu['hijos'],opcion.id) %> 
          </li>
         </g:each> 
        </ul>     
   </div>
 </div>