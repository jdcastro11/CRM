<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Angular con Grails</title>
    </head>
    <body>
        <div ng-app>
        <h1>Prueba Angular Integrado con Grails</h1>
     <input type="text" ng-model="dato" ng-init="dato='Hola'">
     
    <p> Escribi=>{{dato}}</p>
    </div>
     <script src="${resource(dir: 'perfectum/js', file: 'jquery-1.10.2.min.js')}"></script>
   <script src="${resource(dir: 'js/treetable', file: 'jquery.treetable.js')}"></script>
    <script src="${resource(dir: 'perfectum/js', file: 'jquery-ui-1.8.21.custom.min.js')}"></script>   
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
   <%-- <script src="${resource(dir: 'angular/lib', file: 'angular.min.js')}"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.26/angular.min.js"></script>
    </body>
</html>
