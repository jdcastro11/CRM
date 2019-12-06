<%@ page import="crm.Faq" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="perfectum">	
		<title>Mostrar Preguntas Frecuente</title>
       
	</head>
	<body>
            <%  def baseUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath()+"/images/faq/"
                          
             %>
         
	  <g:set var="generalService" bean="generalService" />                 
        <div class="contanier">
           <a  class="btn btn-mini" href="/crm/faq/indexn"><i class="icon-remove"></i>&nbsp;Regresar</a>
          <br><br>				
          <table class="table table-bordered">
            <tr style="background-color:#FCF8E3">
                <th class="text-info" style="font-size:14px;">${"("+generalService.getValorParametro(faqInstance?.idTipo)+") " + faqInstance.pregunta}</th>
            </tr>
            <tr>
                <td ><div style="font-size:14px;">${raw(faqInstance.respuesta)}</div></td>
            </tr>
          </table>  
        </div>
	   <script>
            var xdirBase="${baseUrl}";
            $(".faqimg").each(function(index){   
                var xdir=xdirBase+$("#"+this.id).attr('src');
               $("#"+this.id).attr('src',xdir);
                    
              });
            
         </script>
	</body>
</html>
