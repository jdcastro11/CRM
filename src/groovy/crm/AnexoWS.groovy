package crm
import java.nio.file.Files;
import java.nio.file.Path
import java.nio.file.Paths


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

public class AnexoSW {
 
    /**
	String leerLibro(String notesId) {
		def clienteLeer = new SOAPClient('http://saturno.redsis.com/PruebasApps/WSBookstore.nsf/BookDownloadUpload')
		def respuesta
		try {
			respuesta = clienteLeer.send(
					"""<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:DefaultNamespace">
						   <soapenv:Header/>
						   <soapenv:Body>
						      <urn:getDocByNoteID soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
						         <noteID xsi:type="xsd:string">$notesId</noteID>
						      </urn:getDocByNoteID>
						   </soapenv:Body>
						</soapenv:Envelope>
					""")
		} catch (SOAPFaultException sfe) {
			println 'SOAPFaultException.message: ' + sfe.message
			println 'SOAPFaultException.text: ' + sfe.text
			println 'SOAPFaultException.statusCode: ' + sfe.httpResponse.statusCode
			throw new Exception(sfe.message)
		} catch (SOAPClientException sce) {
			println 'SOAPClientException.message: ' + sce.message
			throw new Exception(sce.message)
		}
		String nombreArchivo = respuesta.getDocByNoteIDResponse.getDocByNoteIDReturn.FILENAME.text()
		println "Titulo: " + respuesta.getDocByNoteIDResponse.getDocByNoteIDReturn.TITLE.text()
		println "Tipo de libro: " + respuesta.getDocByNoteIDResponse.getDocByNoteIDReturn.TYPEOFBOOK.text()
		println "Descripcion: " + respuesta.getDocByNoteIDResponse.getDocByNoteIDReturn.DESCRIPTION.text()
		println "Nombre archivo: " + nombreArchivo
		String base64 = respuesta.getDocByNoteIDResponse.getDocByNoteIDReturn.BASE64FILE.text()
		Path path = Paths.get("datos")
		if ( Files.notExists(path)) {
			new File("datos").mkdir()
			println "Creada carpeta 'datos'"
		}
		File f = new File('./datos/' + nombreArchivo)
		f.setBytes(base64.decodeBase64())
		println "Archivo descargado en " + f
		return "ok"
	}
    **/

	/**
	 * Notar que en el mensaje XML el parametro noteID se rellena con ?
	 * Si esto no se hace -darle algun valor- a momento de la consulta presenta error.
	 * 
	 * @param tipoLibro
	 * @param titulo
	 * @param descripcion
	 * @param autor
	 * @param archivo
	 * @return
	 */
        
	String crear(String tipoLibro,
			String titulo,
			String descripcion,
			String autor,
			String archivo,
                        String id, String url) {
		//def clienteCrear = new SOAPClient('http://saturno.redsis.com/PruebasApps/WSBookstore.nsf/CargaArchivoReq')
	        def clienteCrear = new SOAPClient(url)	
        
                def respuesta
		try {
			File f = new File(archivo)
                        if (f.size() == 0){
                            log.info InetAddress.getLocalHost().getHostAddress()+ " -- El archivo adjunto se encuentra vacio, no tiene información " + archivo
                            throw new Exception("Anexo vacio no se transfiere.")
                        }
			String base64 = f.getBytes().encodeBase64().toString()
			String nombreArchivo = f.getName()
			respuesta = clienteCrear.send(
					"""<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:DefaultNamespace">
					<soapenv:Header/>
						<soapenv:Body>
						      <urn:addNewFileComplex soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
						         <book xsi:type="urn:BookInfoAndFile">
						            <base64File xsi:type="xsd:base64Binary">$base64</base64File>
						            <typeOfBook xsi:type="urn:BookType">$tipoLibro</typeOfBook>
						            <title xsi:type="xsd:string">$titulo</title>
						            <noteID xsi:type="xsd:string">"$id"</noteID>
						            <fileName xsi:type="xsd:string">$nombreArchivo</fileName>
						            <description xsi:type="xsd:string">$descripcion</description>
						            <author xsi:type="xsd:string">$autor</author>
						         </book>
						      </urn:addNewFileComplex>
						</soapenv:Body>
					</soapenv:Envelope>""")
		} catch (SOAPFaultException sfe) {
                        log.error InetAddress.getLocalHost().getHostAddress()+" - " + "Error generado la procesar el servicio "+  sfe.message
                        log.error InetAddress.getLocalHost().getHostAddress()+" - " + "Codigo de Error "+  sfe.httpResponse.statusCode
                        
			println 'SOAPFaultException.message: ' + sfe.message
			println 'SOAPFaultException.text: ' + sfe.text
			println 'SOAPFaultException.statusCode: ' + sfe.httpResponse.statusCode
			throw new Exception(sfe.message)
		} catch (SOAPClientException sce) {
                        log.error InetAddress.getLocalHost().getHostAddress()+" - " + "Error generado la procesar el servicio "+  sce.message
                        log.error InetAddress.getLocalHost().getHostAddress()+" - " + "Codigo de Error "+  sce.httpResponse.statusCode
			println 'SOAPClientException.message: ' + sce.message
			throw new Exception(sce.message)
		}
		return respuesta.body
	}
        
/**    
    String crearReq(String tipoLibro,
			String titulo,
			String descripcion,
			String autor,
			String archivo,
                        String id) {
		def clienteCrear = new SOAPClient('http://saturno.redsis.com/PruebasApps/WSBookstore.nsf/CargaArchivoReq')
		def respuesta
		try {
			File f = new File(archivo)
                        if (f.size() == 0){
                            throw new Exception("Anexo vacio no se transfiere.")
                        }
			String base64 = f.getBytes().encodeBase64().toString()
			String nombreArchivo = f.getName()
			respuesta = clienteCrear.send(
					"""<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:DefaultNamespace">
					<soapenv:Header/>
						<soapenv:Body>
						      <urn:addNewFileComplex soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
						         <book xsi:type="urn:BookInfoAndFile">
						            <base64File xsi:type="xsd:base64Binary">$base64</base64File>
						            <typeOfBook xsi:type="urn:BookType">$tipoLibro</typeOfBook>
						            <title xsi:type="xsd:string">$titulo</title>
						            <noteID xsi:type="xsd:string">"$id"</noteID>
						            <fileName xsi:type="xsd:string">$nombreArchivo</fileName>
						            <description xsi:type="xsd:string">$descripcion</description>
						            <author xsi:type="xsd:string">$autor</author>
						         </book>
						      </urn:addNewFileComplex>
						</soapenv:Body>
					</soapenv:Envelope>""")
		} catch (SOAPFaultException sfe) {
			println 'SOAPFaultException.message: ' + sfe.message
			println 'SOAPFaultException.text: ' + sfe.text
			println 'SOAPFaultException.statusCode: ' + sfe.httpResponse.statusCode
			throw new Exception(sfe.message)
		} catch (SOAPClientException sce) {
			println 'SOAPClientException.message: ' + sce.message
			throw new Exception(sce.message)
		}
		return respuesta.body
	}
     **/   
    
}


