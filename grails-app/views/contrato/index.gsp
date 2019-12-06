<%@ page import="crm.Prospecto"
		import="crm.Empresa"
		import="crm.Persona"
%>
<g:set var="generalService" bean="generalService" />
<%
	def mover=generalService.getMenuV(1)
	def mout=generalService.getMenuV(2)
	def estilo=generalService.getMenuV(3)
%>

<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="perfectum">
	<g:set var="entityName" value="${message(code: 'contrato.label', default: 'Prospecto')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
	<r:require module="filterpane" />

	<style type="text/css">

	#content{
		padding:20px 15px;
	}

	</style>

</head>



<body >



<%
	def listaVenci=generalService.getValoresParametro('tipovencim')
	def tipoCobertura=generalService.getValoresParametro('tipocobert')
%>


<% def sw_crud=[1,1,1,1,0,0]
def xaccion=xaccion?:"index"
%>
<g:set var="seguridadService" bean="seguridadService" />
<div id="detalleconten">
<h3>${xtitulo}</h3>
<hr style="margin-top:10px;margin-bottom:10px;">

<filterpane:filterPane domain="Contrato"
formName="frmFiltro"
action="index"
showTitle="no"
filterProperties="${['descripcion', 'serial','idTipoVencimiento','idTipoCobertura']}"
filterPropertyValues="${['idTipoVencimiento':[values:listaVenci],'idTipoCobertura':[values:tipoCobertura]]}"
dialog="true"
listDistinct="true"
showSortPanel="false"
fullAssociationPathFieldName="false"
/>

<%
def  derechos=seguridadService.operacionesPorOpcion(session['idUsuario'],'/prospecto/index')

%>
<g:form  controller="contrato" params="[titulo:xtitulo]" >


	<!-- inicio filter  buttons -->
	<filterpane:filterButton class="btn btn-mini btn-warning" style="margin-left:2px;" text="${g.message(code:'fp.tag.filterButton.text',default:'Filtrar lista')}" appliedText="Cambiar Filtro"/>
	<filterpane:isFiltered>Filtro aplicado!</filterpane:isFiltered>
	<!-- fin filter  buttons  -->
	<a  class="btn btn-mini" href="/crm/Prospecto/index?sort=fechaApertura&order=desc"><i class="icon-remove"></i>&nbsp;<g:message code="cancelar.label"/></a>

	<!-- <g:if test="${flash.message}">

	<div role="status" style="font-weight:bold;color:#CC0000;margin:5px;">${flash.message}</div>
</g:if>-->

	<g:set var="beanInstance"  value="${contratoInstance}" />
	<g:render template="/general/mensajes" />

	<table class="table table-bordered table-condensed">
		<thead>
		<tr >

			<g:sortableColumn property="detpedido.pedido.nombreCliente" title="${message(code: 'pedido.nombreCliente.label', default:'Cliente')}" />
			
			<g:sortableColumn property="idTipoVencimiento" title="${message(code: 'contrato.idTipoVencimiento.label', default: 'Id Tipo Vencimiento')}" />

			<g:sortableColumn property="serial" title="${message(code: 'contrato.serial.label', default: 'Serial')}" />

			<g:sortableColumn property="descripcion" title="${message(code: 'contrato.descripcion.label', default: 'Descripcion')}" />

			<g:sortableColumn property="idTipoCobertura" title="${message(code: 'contrato.idTipoCobertura.label', default: 'Tipo Cobertura')}" />

			<g:sortableColumn property="fechaInicio" title="${message(code: 'contrato.fechaInicio.label', default: 'Fecha Inicio')}" />

			<g:sortableColumn property="fechaVencimiento" title="${message(code: 'contrato.fechaVencimiento.label', default: 'Fecha Fin')}" />

			<g:sortableColumn property="idEstadoVencimiento" title="${message(code: 'contrato.idEstadoVencimientoaVencimiento.label', default: 'Estado')}" params="${filterParams}" />


		</tr>
		</thead>
		<tbody>
		<%  i=0 %>
		<g:each in="${contratoInstanceList}" status="i" var="contratoInstance">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

				<td style="overflow: hidden;text-overflow: ellipsis; white-space: nowrap;max-width: 220px;" >${contratoInstance.detpedido.pedido.nombreCliente}</td>

				<td><a href="/crm/detPedido/show/${contratoInstance?.detpedido?.id}?&layout=main">${generalService.getValorParametro(contratoInstance.idTipoVencimiento)}</a></td>

				<g:if test="${contratoInstance?.serial}">
					<td>${fieldValue(bean: contratoInstance, field: "serial")}</td>
				</g:if>
				<g:else>
					<g:set var="xruta" value="${generalService.getValorParametro('ruta00')}${contratoInstance?.archivoSeriales}" />
					<td><g:if test="${contratoInstance?.archivoSeriales !=null}">
						<a class="btn btn-mini" href="${xruta}" target="_blank"><g:message code="verAnexo.label" default="Ver Archivo"/></a>
					</g:if>
					</td>
				</g:else>

				<td>${fieldValue(bean: contratoInstance, field: "descripcion")}</td>

				<td>${generalService.getValorParametro(contratoInstance?.idTipoCobertura)}</td>

				<td><g:formatDate format="dd-MM-yyyy" date="${contratoInstance.fechaInicio}" /></td>

				<td><g:formatDate format="dd-MM-yyyy" date="${contratoInstance.fechaVencimiento}" /></td>

				<% def xres=generalService.getEstadoVencimiento(contratoInstance?.fechaInicio,contratoInstance?.fechaVencimiento) %>
				<g:if test="${contratoInstance.idEstadoVencimiento=='vennorenov'}">
					<% xres[0]='vennorenov' //vencimiento no renovado empanada
					xres[1]='background:#F15850 !important' %>
				</g:if>
				<td style="${xres[1]};font-weight:bold;text-align:center;color:#303030"><b>${generalService.getValorParametro(xres[0])}</b></td>

				</tr>


			<%--  <td><g:formatDate format="dd-MM-yyyy" date="${prospectoInstance?.fechaCierreEstimada}" /></td> --%>

			</tr>
		</g:each>
		</tbody>
	</table>
	<div class="pagination_crm">
		<filterpane:paginate total="${contratoInstanceCount ?: 0}" domainBean="Contrato"/>
	</div>
	</div>
	<g:hiddenField name="xempresa"  value="${params.id}"/>

</g:form>
</body>
</html>
