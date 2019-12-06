(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['detalle_forecast'] = template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "<div>\r\n    <a href=\"javascript:void(0)\" id=\"fXciu\">Ciudad</a> |\r\n    <a href=\"javascript:void(0)\" id=\"fXven\">Vendedor</a> |\r\n    <a href=\"javascript:void(0)\" id=\"fXtri\">Trimestre</a> |\r\n    <a href=\"javascript:void(0)\" id=\"fXpro\">Probabilidad</a>\r\n</div>\r\n\r\n<div class=\"chart_f_det_fab\">\r\n    <div id=\"chart_f_ciu\" class=\"ocultar\">Grafica Forecast x Ciudad</div>\r\n    <div id=\"chart_f_ven\" class=\"ocultar\">Grafica Forecast x Vendedor</div>\r\n    <div id=\"chart_f_tri\">Grafica Forecast x Trimestre</div>\r\n    <div id=\"chart_f_pro\" class=\"ocultar\">Grafica Forecast x Probabilidad</div>\r\n</div>";
  });
})();