<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="perfectum">
        <g:set var="entityName" value="${message(code: 'oportunidad.label', default: 'Prospecto')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-oportunidad" class="content scaffold-edit" role="main">

            <h2>Ultima Nota </h2>               
            <hr style="margin-top:10px;margin-bottom:10px;">             

            <g:form  class="form-horizontal"  >
                <div class="box-content" > 
                     <%  def notaInstance=Nota.get(oportunidadInstance?.idUltimaNota) %>
                    <fieldset class="form">
                        <div class="control-group">

                            <label class="control-label" >Fecha</label>
                            <div class="controls">
                               <g:textfield  name="fecha" value="<g:formatDate format="dd-MM-yyyy" date="${notaIntance.fecha}" /> 
                            </div>
                        </div>  
                        <div class="control-group">
                            <label  class="control-label" >
                                Ultima Nota
                            </label>                           
                            <div class="controls">
                                <g:textArea style="width:400px;"  name="nota"  rows="4"  value="${notaInstance.nota}" disabled="${true}"  />
                            </div> 
                        </div>


                    </fieldset>		
                </div>
              
            </g:form>
        </div>
    </body>
</html>
