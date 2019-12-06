<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link id="bootstrap-style" href="${resource(dir: 'perfectum/css', file: 'bootstrap.css')}" rel="stylesheet">
    <link   href="${resource(dir: 'perfectum/css', file: 'bootstrap-datetimepicker.min.css')}" rel="stylesheet">
</head>

<body>
<div class="container">
    <form action="" class="form-horizontal">
        <fieldset>
            <legend>Test</legend>
            <div class="control-group">
                <label class="control-label">DateTime Picking</label>
                <div class="controls input-append date form_datetime" data-date="1979-09-16T05:25:07Z" data-date-format="dd MM yyyy - HH:ii p" data-link-field="dtp_input1">
                    <input size="16" type="text" value="" readonly>
                    <span class="add-on"><i class="icon-remove"></i></span>
                    <span class="add-on"><i class="icon-th"></i></span>
                </div>
                <input type="text" id="dtp_input1" value="" /><br/>
            </div>
            <div class="control-group">
                <label class="control-label">Date Picking</label>
                <div class="controls input-append date form_date" data-date="" data-date-format="dd MM yyyy" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                    <input size="16" type="text" value="" readonly>
                    <span class="add-on"><i class="icon-remove"></i></span>
                    <span class="add-on"><i class="icon-th"></i></span>
                </div>
                <input type="hidden" id="dtp_input2" value="" /><br/>
            </div>
            <div class="control-group">
                <label class="control-label">Time Picking</label>
                <div class="controls input-append date form_time" data-date="" data-date-format="hh:ii" data-link-field="dtp_input3" data-link-format="hh:ii">
                    <input size="16" type="text" value="" readonly>
                    <span class="add-on"><i class="icon-remove"></i></span>
                    <span class="add-on"><i class="icon-th"></i></span>
                </div>
                <input type="hidden" id="dtp_input3" value="" /><br/>
            </div>
        </fieldset>
    </form>
</div>

<script src="${resource(dir: 'perfectum/js', file: 'jquery-1.10.2.min.js')}"></script>
<script src="${resource(dir: 'perfectum/js', file: 'bootstrap.min.js')}"></script>
<script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.js')}"></script>
<script src="${resource(dir: 'perfectum/js', file: 'bootstrap-datetimepicker.es.js')}"></script>
<script src="${resource(dir: 'js', file: 'crm_helper.js')}"></script>
<script type="text/javascript">
    configFechaHora()
</script>

</body>
</html>