<%@ page contentType="text/html;charset=UTF-8" %>

<html lang="es">
<head>
	
	<!-- start: Meta -->
	<meta charset="utf-8">
	<title>CRM Redsis</title>
	<meta name="description" content="Perfectum Dashboard Bootstrap Admin Template.">
	<meta name="author" content="Łukasz Holeczek">
	<!-- end: Meta -->
	<%--<base target="_parent" /> --%>
	<!-- start: Mobile Specific -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- end: Mobile Specific -->
	
	<!-- start: CSS -->
	<link id="bootstrap-style" href="${resource(dir: 'perfectum/css', file: 'bootstrap-2.2.2.css')}" rel="stylesheet">
    %{--<link id="bootstrap-style" href="${resource(dir: 'perfectum/css', file: 'bootstrap.css')}" rel="stylesheet">--}%
    <link  href="${resource(dir: 'perfectum/css', file: 'bootstrap-responsive.css')}" rel="stylesheet">
    <link id="base-style" href="${resource(dir: 'perfectum/css', file: 'style.css')}" rel="stylesheet">
	<link  id="base-style-responsive" href="${resource(dir: 'perfectum/css', file: 'style-responsive.css')}" rel="stylesheet">
    <link   href="${resource(dir: 'perfectum/css', file: 'bootstrap-dialog.css')}" rel="stylesheet">
    <link   href="${resource(dir: 'perfectum/css', file: 'bootstrap-datetimepicker.min.css')}" rel="stylesheet">
   %{-- <link   href="${resource(dir: 'perfectum/css', file: 'font-awesome.min.css')}" rel="stylesheet">--}%
     <g:javascript src="jquery/jquery-1.7.2.min.js" />
	<!--[if lt IE 7 ]>
	<link id="ie-style" href="perfectum/css/style-ie.css" rel="stylesheet">
	<![endif]-->
	<!--[if IE 8 ]>
	<link id="ie-style" href="perfectum/css/style-ie.css" rel="stylesheet">
	<![endif]-->
	<!--[if IE 9 ]>
	<![endif]-->
	<!-- end: CSS -->
	

	<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
	  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->

	<!-- start: Favicon -->
	<link rel="shortcut icon" href="img/favicon.ico">
	<!-- end: Favicon -->
	
			<style type="text/css">
			body { background: url(${resource(dir: 'perfectum/img', file: 'bg-login.jpg')}) !important; }
		</style>
		
		
		
</head>

<body  onload="javascript:document.getElementById('username').focus();">
        <div class="container-fluid">
        <div class="row-fluid">

                  <div class="row-fluid">
                            <div class="login-box">
                                      <div  style="background-color: black; padding: 10">
                                    <img alt="Redsis.com" src="${resource(dir: 'perfectum/img', file: 'logoRedsis1.png')}" />
                                                <!--
                                    <a href="index.html"><i class="icon-home"></i></a>
                                                <a href="#"><i class="icon-cog"></i></a>
                                    -->
                                      </div>
                                      <form class="form-horizontal" action="/crm/login/autenticacion" method="post">
                                                <fieldset>

                                                          <div class="input-prepend" title="Username">
                                                                    <span class="add-on"><i class="icon-user"></i></span>
                                                                    <input class="input-large span10" name="username" id="username" type="text" placeholder="${g.message(code:'username.label',default:'Usuario')}"/>
                                                                    <g:hiddenField name="estado"  value="${estado}"/>
                                                                    <g:hiddenField name="uriAnterior"  value="${uriAnterior}"/>


                                                          </div>
                                                          <div class="clearfix"></div>

                                                          <div class="input-prepend" title="Password">
                                                                    <span class="add-on"><i class="icon-lock"></i></span>
                                                                    <input class="input-large span10" name="password" id="password" type="password" placeholder="${g.message(code:'contrasena.label',default:'contraseña')}"/>
                                                          </div>
                                                          <div class="clearfix"></div>

                                                          <label class="remember" for="remember"><input type="checkbox" id="remember" /><g:message code="recordar.label"/></label>

                                                          <div class="button-login">	
                                                                    <button type="submit" class="btn btn-primary"><i class="icon-off icon-white"></i><g:message code="login.label"/></button>
                                                          </div>
                                                          <div class="clearfix"></div>
                                                 </fieldset>
                                      </form>
                                      <!--<hr>
                                      <h3>Olvido su contraseña?</h3>
                                      <p>
                                                No hay problema, <a href="#">click Aquí </a> para obtener una nueva contraseña.
                                      </p>-->	
                            <p style="color:#991e1e;">
                                ${flash.message}
                            </p>
                            </div><!--/span-->
                  </div><!--/row-->

                            </div><!--/fluid-row-->

</div><!--/.fluid-container-->

	<!-- start: JavaScript-->
    <script src="${resource(dir: 'perfectum/js', file: 'jquery-1.7.2.min.js')}"></script>
   %{-- <script src="${resource(dir: 'perfectum/js', file: 'jquery-migrate-1.2.1.min.js')}"></script>--}%
   %{-- <script src="${resource(dir: 'perfectum/js', file: 'jquery-1.10.2.min.js')}"></script>--}%
    <script src="${resource(dir: 'perfectum/js', file: 'jquery-ui-1.8.21.custom.min.js')}"></script>
   %{-- <script src="${resource(dir: 'perfectum/js', file: 'jquery-ui-1.10.3.custom.min.js')}"></script>--}%
	<script src="${resource(dir: 'perfectum/js', file: 'bootstrap.js')}"></script>
   	<script src="${resource(dir: 'perfectum/js', file: 'jquery.cookie.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'fullcalendar.min.js')}"></script>
    <script src="${resource(dir: 'perfectum/js', file: 'jquery.dataTables.min.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'excanvas.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.flot.min.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.flot.pie.min.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.flot.stack.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.flot.resize.min.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.chosen.min.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.uniform.min.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.cleditor.min.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.noty.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.elfinder.min.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.raty.min.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.iphone.toggle.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.uploadify-3.1.min.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.gritter.min.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.imagesloaded.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.masonry.min.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.knob.js')}"></script>
	<script src="${resource(dir: 'perfectum/js', file: 'jquery.sparkline.min.js')}"></script>
    <script src="${resource(dir: 'perfectum/js', file: 'custom.js')}"></script>
    <script src="${resource(dir: 'perfectum/js', file: 'bootstrap-dialog.js')}"></script>
    <script src="${resource(dir: 'js', file: 'crm_helper.js')}"></script>

    <r:layoutResources />
<!-- end: JavaScript-->
	
</body>
</html>

