<!DOCTYPE html>

<html lang="es" class="no-js">

    <head>
              <!-- start: Meta -->
        <meta charset="utf-8">
        <title>CRM - Redsis S.A.S</title>
        <meta name="description" content="CRM Redsis SAS">
        <meta name="author" content="">
        <!-- end: Meta -->

<!-- start: Mobile Specific -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- end: Mobile Specific -->

<!-- start: CSS -->
    
        <link id="bootstrap-style" href="${resource(dir: 'perfectum/css', file: 'bootstrap-2.2.2.css')}" rel="stylesheet">
 %{-- <link id="bootstrap-style" href="${resource(dir: 'perfectum/css', file: 'bootstrap.css')}" rel="stylesheet">--}%
        <link  href="${resource(dir: 'perfectum/css', file: 'bootstrap-responsive.css')}" rel="stylesheet">
        <link id="base-style" href="${resource(dir: 'perfectum/css', file: 'style_d.css')}" rel="stylesheet">
        <link id="base-style-responsive" href="${resource(dir: 'perfectum/css', file: 'style-responsive.css')}" rel="stylesheet">
        <link   href="${resource(dir: 'perfectum/css', file: 'bootstrap-dialog.css')}" rel="stylesheet">
        <link   href="${resource(dir: 'perfectum/css', file: 'bootstrap-datetimepicker.min.css')}" rel="stylesheet">
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
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>	  <![endif]-->

        <g:layoutHead/>
    <r:layoutResources />
</head>
<body>            
    <g:layoutBody/>

    <div class="modal hide fade" id="crm_modal_det" style="position:absolute;top:0%;left:50%;zindex:10000;">      
        <div  class="modal-header pull-right" style="margin:0px !important">
            <img src="/crm/wait.gif" id="divwait" style="display:block" />
            <button id="SalirModal" class="btn" data-dismiss="modal" aria-hidden="true">Salir</button>
        </div>
          <div id="modal_body_det" class="modal-body" style="height:20% ;margin-top:0px;padding-top:0px !important;"  ></div>
    </div>
    <div class="clearfix"></div> 
    <div class="footer" role="contentinfo"></div>                   
    <script src="${resource(dir: 'perfectum/js', file: 'jquery-1.10.2.min.js')}"></script>
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
    <script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.js')}"></script>
    <script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.es.js')}"></script>
    <script src="${resource(dir: 'js', file: 'crm_helper.js')}"></script>
    <script src="${resource(dir: 'js', file: 'jquery-iframe-auto-height.min.js')}"></script> 
   <script src="${resource(dir: 'js', file: 'jquery.browser.js')}"></script>
<r:layoutResources />
</body>
</html>