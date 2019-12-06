(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['detalle_leads'] = template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "<div>\r\n    <a href=\"javascript:void(0)\" id=\"leadXtri\">Trimestre</a> |\r\n    <a href=\"javascript:void(0)\" id=\"leadXfab\">Fabricante</a> |\r\n    <a href=\"javascript:void(0)\" id=\"leadXciu\">Ciudad</a> |\r\n    <a href=\"javascript:void(0)\" id=\"leadXven\">Vendedor</a>\r\n</div>\r\n\r\n<div class=\"chart_lead_det_fab\">\r\n    <div id=\"chart_tri\">Grafica Lead x Trimestre</div>\r\n    <div id=\"chart_fab\" class=\"ocultar\">Grafica Lead x Fabricante</div>\r\n    <div id=\"chart_ciu\" class=\"ocultar\">Grafica Lead x Ciudad</div>\r\n    <div id=\"chart_ven\" class=\"ocultar\">Grafica Lead x Vendedor</div>\r\n</div>";
  });
})();