<!DOCTYPE HTML>
<html>
<head>
    <link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.2.2/css/bootstrap-combined.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" media="screen"
          href="/crm/static/perfectum/css/bootstrap-datetimepicker.min.css">
</head>
<body>
<div id="datetimepicker" class="input-append date">
    <input type="text"></input>
    <span class="add-on">
        <i data-time-icon="icon-time" data-date-icon="icon-calendar"></i>
    </span>
</div>
<script type="text/javascript"
        src="/crm/static/perfectum/js/jquery-1.10.2.min.js">
</script>
<script type="text/javascript"
        src="/crm/static/perfectum/js/bootstrap.min.js">
</script>
<script type="text/javascript"
        src="crm/static/perfectum/js/bootstrap-datetimepicker.min.js">
</script>
<script type="text/javascript"
        src="/crm/static/perfectum/js/bootstrap-datepicker.es.js">
</script>
<script type="text/javascript">
    $('#datetimepicker').datetimepicker({
        format: 'dd/MM/yyyy hh:mm',
        language: 'es'
    });
</script>
</body>
<html>