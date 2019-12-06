<% 
def mensaje="Este Explorador no es el recomendado. Debe utilizar Google Chrome para un correcto funcionamiento del CRM"
%>
<browser:isMsie><center><span style="color:#fff;font-weight:bold !important">${mensaje}</span></center></browser:isMsie>
<browser:isSafari><center><span style="color:#fff;font-weight:bold !important">${mensaje}</span></center></browser:isSafari>
<browser:isFirefox ><center><span style="color:#fff;font-weight:bold !important">${mensaje}</span></center></browser:isFirefox>
<browser:isOpera><center><span style="color:#fff;font-weight:bold !important">${mensaje}</span></center></browser:isOpera>