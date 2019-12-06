package crm
import wslite.soap.*
import grails.converters.*	
import grails.converters.JSON
import grails.converters.XML
import java.util.Random
import groovy.transform.CompileDynamic
import groovy.transform.CompileStatic
import wslite.soap.SOAPClient
import wslite.soap.SOAPResponse


class GeneralController extends BaseController{
    def generalService
    def pedidoService
    def consecutivoService 
    def oportunidadService
   
    def index(){ 
        def hoy =new Date()
        def x= hoy -365
       println "Fecha Actual="; println hoy
       println "Nueva Fecha";println x
      render text:"ok"
    }

    def subirArchivo() {
          println "Entre Aquia subir Archivo"
        def file = request.getFile('nombreArchivo')
        
            println "Entre Aqui validadr nombre archivo"
            String ref=""
            // def rows = file.inputStream.toCsvReader().readAll()

            String zruta =generalService.getValorParametro('ruta01')
            def xruta = servletContext.getRealPath(zruta)

            file.transferTo( new File( xruta, file.originalFilename))
      
           
        redirect url:"${params.xregreso}"
    }
    
    def validarArchivo(def file)  {
        switch (ref) {
        case "prospectos":
            importarProspectos(rows)
            break
        case 'productos':
            break
        }
        if(file.empty){
            return false
        }

    }
    
    def importarProspectos(def rows){

        return true
    }   
    
    def borrarMensajes(){       
        flash.message=''     
    }  
   
    def setDireccion(){//apoya la modificacion de direcciones
        def entidadInstance;String xdireccion
        Long xpais;Long xdpto;Long xciudad;String divdir
        String divPais;String divDpto;String divCiudad
        
        if (params.entidad=='empresa'){ 
            entidadInstance=Empresa.get(params.id)
            xdireccion=entidadInstance?.direccion
            xpais=entidadInstance?.idPais
            xdpto=entidadInstance?.idDpto
            xciudad=entidadInstance?.idCiudad
            divdir='direccion'
            divPais='idPais'
            divDpto='idDpto'
            divCiudad='idCiudad'
        }
        if (params.entidad=='pedido1'){ 
           
            entidadInstance=Pedido.get(params.id)
            xdireccion= entidadInstance?.dirDespacho        
            xpais     = entidadInstance?.idPaisDirDes        
            xdpto     = entidadInstance?.idDptoDirDes        
            xciudad   = entidadInstance?.idCiudadDirDes    
            divdir    = 'dirDespacho'            
            divPais   = 'idPaisDirDes'
            divDpto   = 'idDptoDirDes'
            divCiudad = 'idCiudadDirDes'
        }   
        
        if (params.entidad=='pedido2'){ 
            entidadInstance=Pedido.get(params.id)
            xdireccion=entidadInstance?.dirEntregaFactura
            xpais=entidadInstance?.idPaisDirFac
            xdpto=entidadInstance?.idDptoDirFac
            xciudad=entidadInstance?.idCiudadDirFac          
            divdir='dirEntregaFactura'
            divPais='idPaisDirFac'
            divDpto='idDptoDirFac'
            divCiudad='idCiudadDirFac'
        }  
       
        
        render view:"/general/direccion", model:[xdireccion:xdireccion,xciudad:xciudad,
                                                xdpto:xdpto,xpais:xpais,divdir:divdir,
                                                divPais:divPais,divDpto:divDpto,divCiudad:divCiudad] 
    }
    
    def error = {
        // Grails has already set the response status to 500

        // Did the original controller set a exception handler?
        if (request.exceptionHandler) {
            if (request.exceptionHandler.call(request.exception)) {
                return
            }           
            // Otherwise exceptionHandler did not want to handle it
        }       
        render(view:"/error")        
    }
    
    def webServiceRequerimiento(){
        //Acceso al servicio web que trae el listado de requerimientos creados a
        //partir de ese numero de oportunidad
        def  numOptty = params.numOportunidad.toString()
        println "OPORTUNIDAD:"+numOptty
        def respuestaSW
               Requerimiento req = new Requerimiento()
		try {
	        respuestaSW = req.leer(numOptty, '2')
	
		} catch (Exception e) {
			println 'Excepcion: ' + e.message
		}
        println "Respuesta texto: " + respuestaSW     
        def  datoJSON = JSON.parse(respuestaSW)  // Parse a JSON String
        println datoJSON
   
        def datosReq = datoJSON.respuesta
       // println "DATOS REQ:" + datosReq
       // println "El id "+datosReq.tema
        def resultado =[:]
	String templateTablaOportunidad = (g.render(template: "/reqLotusSw/listadoReq",
         model : [requerimientoList : datoJSON.respuesta]))?.toString()
	resultado.templateTablaOportunidad = templateTablaOportunidad
        //println resultado as JSON
        render  resultado as JSON
    }
    
    def email() {
        println( "Sending email.." );
        sendMail {
            to "mquintero@redsis.com"
            subject "PRUEBAS dos"
            body ("This is a test email, time: " + new Date() )
        }
        println( "  success!!!" );
        flash.message = "Successfully sent email"
        redirect( uri: "/" );
    }
    
   def cliente(){
       
      render(view:"/general/cliente")    
        
   }


    def serviceliscli(){
        //def cli = new SOAPClient('localhost:8080/crm/empresa/serviceLisCli')
        def consul = "select nit, razonSocial from Empresa"
        def con = Empresa.executeQuery(consul)
        //def jsonCon = JSON.parse(con)
        //def resp = cli.send(con)
        render con
        println(con)
    }
   
}
