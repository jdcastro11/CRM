(function() {

  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['detalle_cuotaVScumplimiento'] = template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "<div>\r\n    <a href=\"javascript:void(0)\" id=\"ccXciu\">Ciudad</a> |\r\n    <a href=\"javascript:void(0)\" id=\"ccXven\">Vendedor</a> |\r\n    <a href=\"javascript:void(0)\" id=\"ccXtri\">Trimestre</a> |\r\n    <a href=\"javascript:void(0)\" id=\"ccXano\">Año</a>\r\n</div>\r\n\r\n<div class=\"chart_cc_det_fab\">\r\n    <div id=\"chart_cc_ciu\" class=\"ocultar\">Grafica Cuota VS Cumplimiento x Ciudad</div>\r\n    <div id=\"chart_cc_ven\" class=\"ocultar\">Grafica Cuota VS Cumplimiento x Vendedor</div>\r\n    <div id=\"chart_cc_tri\">Grafica Cuota VS Cumplimiento x Trimestre</div>\r\n    <div id=\"chart_cc_ano\" class=\"ocultar\">Grafica Cuota VS Cumplimiento x Año</div>\r\n</div>";
  });
})();