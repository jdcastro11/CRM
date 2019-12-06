<%@ page import="crm.Pedido" %>
<g:set var="generalService" bean="generalService" />
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'pedido.label', default: 'Pedido')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
    

        <div id="edit-pedido" class="content scaffold-edit" role="main">

            
            <h2 style="display:inline">Vista de Pedido</h2>
            <g:if test="${generalService.esPedidoDetenido(pedidoInstance)==true}">&nbsp;
        		<i  class="fa-icon-ban-circle" style="font-size:2em;color:red;display:inline;position:relative;top:3px;"></i>
        		<label style="font-size:11px;">Este pedido se encuentra detenido en compras</label>
    		</g:if>
            
            
            
            
            
            <hr style="margin-top:10px;margin-bottom:10px;">                                                                           
			
            <g:uploadForm class="form-horizontal" url="[resource:pedidoInstance, action:'update']" method="PUT" >
            
                <fieldset class="form">
            	       
                  <g:set var="xid"  value="${params.estado}" /> 
                    <g:render template="acciones_r" />
                    <g:render template="/general/mensajes" />
                    <br><br>
                    <g:set var="beanInstance"  value="${pedidoInstance}" />                
                    
                    <g:set var="xronly" value="true" scope="request"/>
                    <g:render template="form"/>                                         
                </fieldset>

            </g:uploadForm>
        </div>
    </body>
</html>
