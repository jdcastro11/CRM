package crm
import wslite.soap.*

/**
 * Encapsula invocacion a servicio web de requerimientos, para 
 * consulta o creacion.
 * 
 * Hace uso de https://github.com/jwagenleitner/groovy-wslite
 * 
 * @author Jose Hugo Torres
 *
 */

public class Requerimiento {
   
    def generalService
    
	String leer(String codigoRequerimiento, String tipoInfo, String url) {
               
		def clienteLeer = new SOAPClient(url)
		def respuesta
		try {
			respuesta = clienteLeer.send(
					"""<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:DefaultNamespace">
				   <soapenv:Header/>
				   <soapenv:Body>
				      <urn:MOSTRARINFOREQ soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
				         <NUMREQUERIMIENTO xsi:type="xsd:string">$codigoRequerimiento</NUMREQUERIMIENTO>
				         <TIPOINFOMOSTRAR xsi:type="xsd:string">$tipoInfo</TIPOINFOMOSTRAR>
				      </urn:MOSTRARINFOREQ>
				   </soapenv:Body>
				</soapenv:Envelope>
				""")
		} catch (SOAPFaultException sfe) {
			//println 'SOAPFaultException.message: ' + sfe.message 
			//println 'SOAPFaultException.text: ' + sfe.text
			//println 'SOAPFaultException.statusCode: ' + sfe.httpResponse.statusCode
			throw new Exception(sfe.message)
		} catch (SOAPClientException sce) {
			//println 'SOAPClientException.message: ' + sce.message
			throw new Exception(sce.message)
		}
		return respuesta.MOSTRARINFOREQResponse.MOSTRARINFOREQReturn.text()
	}

	String crear(String nroOportunidad,
			String tipoRequerimiento,
			String empresa,
			String contacto,
			String tema,
			String creadoPor,
			String fechaRequerida,
			String descripcion, 
                        String idOptty, String url) {
                       
		def clienteCrear = new SOAPClient(url)
		def respuesta
		try {
			respuesta = clienteCrear.send(
					"""<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:DefaultNamespace">
				   <soapenv:Header/>
				   <soapenv:Body>
				      <urn:CREARREQ soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
				         <NUMOPORTUNIDAD xsi:type="xsd:string">$nroOportunidad</NUMOPORTUNIDAD>
				         <TIPOREQUERIMIENTO xsi:type="xsd:string">$tipoRequerimiento</TIPOREQUERIMIENTO>
				         <CLIENTEREQ xsi:type="xsd:string">$empresa</CLIENTEREQ>
				         <CONTACTOREQ xsi:type="xsd:string">$contacto</CONTACTOREQ>
				         <TEMAREQ xsi:type="xsd:string">$tema</TEMAREQ>
				         <CREADOPOR xsi:type="xsd:string">$creadoPor</CREADOPOR>
				         <FECHAREQUERIDA xsi:type="xsd:string">$fechaRequerida</FECHAREQUERIDA>
				         <DESCRIPCION xsi:type="xsd:string">$descripcion</DESCRIPCION>
                                         <ID xsi:type="xsd:string">$idOptty</ID>\n\
				      </urn:CREARREQ>
				   </soapenv:Body>
				</soapenv:Envelope>
				""")
		} catch (SOAPFaultException sfe) {
			//println 'SOAPFaultException.message: ' + sfe.message 
			//println 'SOAPFaultException.text: ' + sfe.text   
			//println 'SOAPFaultException.statusCode: ' + sfe.httpResponse.statusCode
                        
                        log.error InetAddress.getLocalHost().getHostAddress()+" - " + "Error generado la procesar el servicio "+  sfe.message
                        log.error InetAddress.getLocalHost().getHostAddress()+" - " + "Codigo de Error "+  sfe.httpResponse.statusCode
                      
			throw new Exception(sfe.message)
		} catch (SOAPClientException sce) {
                        log.error InetAddress.getLocalHost().getHostAddress()+" - " + "Error generado la procesar el servicio "+  sce.message
                        log.error InetAddress.getLocalHost().getHostAddress()+" - " + "Codigo de Error "+  sce.httpResponse.statusCode
			println 'SOAPClientException.message: ' + sce.message
			throw new Exception(sce.message)
		}
                log.info InetAddress.getLocalHost().getHostAddress()+" - " + " Requerimiento creado, respuesta enviada por el servidor domino " + respuesta.body
		return respuesta.body
	}
}


