<!DOCTYPE html>
<html lang="es" >
    <head>
           <!-- start: Meta -->
        <meta charset="utf-8">
        <title>CRM - Redsis S.A.S</title>
        <meta name="description" content="CRM Redsis SAS">
        <meta name="author" content="">
        <g:set var="seguridadService" bean="seguridadService" />
         <g:set var="generalService" bean="generalService" />
        <!-- end: Meta -->
        <!-- start: Mobile Specific -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- end: Mobile Specific -->
        <!-- start: CSS -->
         <link  href="${resource(dir: 'js/treetable', file: 'jquery.treetable.css')}" rel="stylesheet" />
        <link  href="${resource(dir: 'js/treetable', file: 'jquery.treetable.theme.default.css')}" rel="stylesheet" />       
        <link id="bootstrap-style" href="${resource(dir: 'perfectum/css', file: 'bootstrap-2.2.2.css')}" rel="stylesheet">
    %{--<link id="bootstrap-style" href="${resource(dir: 'perfectum/css', file: 'bootstrap.css')}" rel="stylesheet">--}%
        <link  href="${resource(dir: 'perfectum/css', file: 'bootstrap-responsive.css')}" rel="stylesheet">
        <link id="base-style" href="${resource(dir: 'perfectum/css', file: 'style.css')}" rel="stylesheet">
        <link  id="base-style-responsive" href="${resource(dir: 'perfectum/css', file: 'style-responsive.css')}" rel="stylesheet">
        <link   href="${resource(dir: 'perfectum/css', file: 'bootstrap-dialog.css')}" rel="stylesheet">
        <link   href="${resource(dir: 'perfectum/css', file: 'bootstrap-datetimepicker.min.css')}" rel="stylesheet">
      
         <!--MODIFICACIONES REALIZADAS POR MARIO QUINTERO 06/01/2015 -->
      
        <link   href="${resource(dir: 'perfectum/css', file: 'jquery.dataTables.css')}" rel="stylesheet">
        <link   href="${resource(dir:'css/css-personalizados', file: 'estilosPersonalizados.css')}" rel="stylesheet">
        <link   href="${resource(dir:'css/css-personalizados', file: 'bootstrap-panel.css')}" rel="stylesheet">
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
         <!--MODIFICACIONES REALIZADAS POR MARIO QUINTERO 06/01/2015 -->
        
              %{-- <link   href="${resource(dir: 'perfectum/css', file: 'font-awesome.min.css')}" rel="stylesheet">--}%
        <g:javascript src="jquery/jquery-1.10.2.min.js" /> 
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
        <link rel="shortcut icon" href="${resource(dir: 'perfectum/img', file: 'favicon.png')}">
       
         <!-- end: Favicon -->
        <g:layoutHead/>
    <r:layoutResources />
</head>

<body >
     <g:render template="/general/cualBrowser"/>
   <!--  <g:set var="tlista" value="CRM" scope="session" />-->
    
  <%--  <div id="overlay">
        <ul>
            <li class="li1"></li>
            <li class="li2"></li>
            <li class="li3"></li>
            <li class="li4"></li>
            <li class="li5"></li>
            <li class="li6"></li>
        </ul>
    </div>--%>	
    <!-- start: Header -->
    <div class="navbar">
        <div class="navbar-inner">
            <div class="container-fluid">
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".top-nav.nav-collapse,.sidebar-nav.nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <a class="brand" href="#"> <img alt="Redsis.com" style="padding-left:1.7em" src="${resource(dir: 'perfectum/img', file: 'logoRedsis1.png')}" /> <span class="hidden-phone" style="padding-left:3.4em; font-style:italic;font-weight:bold;">Gestión de Ventas</span></a>

                            
               <!-- start: Header Menu -->
                <div class="nav-no-collapse header-nav">
                    <ul class="nav pull-right">                       
                                               
                        <li class="dropdown">
                            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="icon-user icon-white"></i> ${session["nombre"]}
                                <span class="caret"></span>
                            </a>
                             
                             <ul class="dropdown-menu">
                                    <!--<li><a href="#"><i class="icon-user"></i> Profile</a></li>-->
                                <li><a href="/crm/login/cerrarSesion"><i class="icon-off"></i><g:message code="cerrarSesion.label" default="Salir"/></a></li>
                                <li><a href="/crm/usuario/index"><i class="icon-lock"></i><g:message code="cambiarPass.label" default="Cambiar Password"/></a></li>
                            </ul>
                        </li>
                        <!-- end: User Dropdown -->
                    </ul>
                   
                </div>

<!-- end: Header Menu -->

            </div>
        </div>

    </div>
           <!-- start: Header -->

    <div class="container-fluid" >
        <div class="row-fluid" >
      
<!-- start: Main Menu -->
      <g:render template="/layouts/menu" /> 
      
         <!--/span-->
             
            <!-- end: Main Menu -->

            <noscript>
            <div class="alert alert-block span10">
                <h4 class="alert-heading">Advertencia!</h4>
                <p>Necesita tener  <a href="http://en.wikipedia.org/wiki/JavaScript" target="_blank">JavaScript</a> Habilitado  para usuar esta aplicación</p>
            </div>
            </noscript>

            <div id="content" class="span10" >

           <!-- INICIO DEL CONTENIDO DE LA PAGINA-->                        

                <div class="row-fluid sortable">		
                    <div class="box span12">                   
                        <div class="box-content">           
                            <g:layoutBody/>
                        </div>

                    </div><!--/span-->

          <!-- FIN DEL CONTENIDO DE LA PAGINA DE AHI PARA ABAJO ES LO DEL CHAT -->

                    <hr> 

                </div><!--/span-->

            </div> <!-- end: Content -->
        </div><!--row-fluid-->
    </div><!--container-fluid -->

    <div class="modal hide fade" id="crm_modal" style="width:50%;position:fixed;top:15%;left:50%;z-index:10000;">
         <div class="pull-right" style="margin-top:10px;margin-bottom:0px;margin-right: 10px !important">             
            <img src="/crm/wait.gif" id="divwait" style="display:block" />
            <button id="SalirModal"class="btn btn-mini" data-dismiss="modal" aria-hidden="true"><i class="icon-remove"></i><g:message code="salir.label" default="Salir"/></button>
        </div>        
        <div id="modal_body" class="modal-body"  style="width:110%;height:20%;margin-top:0px ;padding-top:0px;overflow-y:auto !important;" ></div>       
    </div>
   <div class="modal hide fade" id="crm_modal_1" style="width:50%;position:fixed;top:15%;left:50%;z-index:10000;">
       <div class="modal-header pull-right" style="margin-top:10px;margin-bottom:0px;margin-right: 10px !important">
           
            <button class="btn" data-dismiss="modal" aria-hidden="true">Salir</button>
        </div>
        <div id="modal_body_1" class="modal-body"  style="width:110%;height:20%;margin-top:0px;padding-top:0px !important;" ></div>
        
    </div>
    <div class="clearfix"></div>
    <br>
    
     <%
      def  version = generalService.getValorParametro('versioncrm')?:" - - "
      %>
    <footer class="navbar-fixed-bottom">
        <p>
            <span style="text-align:left;float:left">&copy; <a href="http://www.redsis.com" target="_blank">Redsis</a>Versión ${version}</span>            
        </p>
    </footer>
    <!-- start: JavaScript-->   
    
   <script src="${resource(dir: 'perfectum/js', file: 'jquery-1.10.2.min.js')}"></script>
   <script src="${resource(dir: 'js/treetable', file: 'jquery.treetable.js')}"></script>
    <script src="${resource(dir: 'perfectum/js', file: 'jquery-ui-1.10.0.custom.min.js')}"></script>   
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
    <script src="${resource(dir: 'js', file: 'jquery-iframe-auto-height.min.js')}"></script> 
   <script src="${resource(dir: 'js', file: 'jquery.browser.js')}"></script>
   <script src="${resource(dir: 'perfectum/js', file: 'jquery.dataTables.1.10.15.min.js')}"></script>
   
    
    <script>
       /* Script para el manejo del menu jerarquico principal */
      $(".link").on("click", function(e){
        e.preventDefault();
        if($(this).attr("data-status")==1){
          $(this).attr("data-status","0");
          $(this).find("i").removeClass("icon-minus-sign icon-white").addClass("icon-plus-sign icon-white");
        }else{
        $(this).attr("data-status","1");
          $(this).find("i").removeClass("icon-plus-sign icon-white").addClass("icon-minus-sign icon-white");
        }
        $(this).next("ul").slideToggle();
      });       
   </script>
     
<r:layoutResources />
<!-- end: JavaScript-->
</body>
</html>
