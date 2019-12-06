(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['detalle_facYped'] = template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "<div>\r\n    <a href=\"javascript:void(0)\" id=\"fpXciu\">Ciudad</a> |\r\n    <a href=\"javascript:void(0)\" id=\"fpXven\">Vendedor</a> |\r\n    <a href=\"javascript:void(0)\" id=\"fpXtri\">Trimestre</a> \r\n</div>\r\n\r\n<div class=\"chart_fp_det_fab\">\r\n    <div id=\"chart_fp_ciu\" class=\"ocultar\">Gráfica Facturados y Pedidos x Ciudad</div>\r\n    <div id=\"chart_fp_ven\" class=\"ocultar\">Gráfica Facturados y Pedidos x Vendedor</div>\r\n    <div id=\"chart_fp_tri\">Vista de laGrafica Facturados y Pedidos x Trimestre</div>\r\n</div>";
  });
})();