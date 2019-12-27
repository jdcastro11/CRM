package crm

import grails.converters.JSON
import org.codehaus.groovy.grails.web.json.JSONArray;
import org.codehaus.groovy.grails.web.json.JSONObject;
import wslite.soap.SOAPClient
import wslite.soap.SOAPResponse

class WSController {
    def generalService
    def index() {
        render "Escriba la URL completa que se le proporciono para el WS"
    }

    //Ws lista de clientes para el señor José Hugo
    def serverclilist(){
        //def cli = new SOAPClient('localhost:8080/crm/empresa/serviceLisCli')
        //Lista de Clientes solo Nit y Razon Social
        def consul = "select e.nit, e.razonSocial, t.nombreTerritorio, e.direccion, e.telefonos, e.email, e.empleado.primerNombre, e.empleado.primerApellido from Empresa e, Territorio t where e.idCiudad = t.id and e.eliminado = 0"
        def con = Empresa.executeQuery(consul)
        //def jsonCon = JSON.parse(con)
        //def resp = cli.send(con)
        render con as JSON
        //println(con)
    }
    def clienteXnit(){
        def peticion=request.JSON
        //def nit=peticion.nit
        println("parametros: "+params.nit)
        JSONArray listaClientes=new JSONArray()
        def consul = "select e from Empresa e where e.eliminado=0 and e.nit="+params.nit
        def con = Empresa.executeQuery(consul)
       con.each {
            JSONObject cliente=new JSONObject()
           // String nit9digitos=generalService.formatearNitPedido(it.nit.toString())

            //cliente.put("nit",it.nit)
           cliente.put("ejecutivo_id",it.empleado?.id)
           cliente.put("ejecutivo",it.empleado?.nombreCompleto())
           cliente.put("razonSocial",it.razonSocial)
           cliente.put("direccion",it.direccion)
           cliente.put("telefonos",it.telefonos)
           cliente.put("email",it.email)
           def consul2 = "select c from Contacto c where c.eliminado=0 and c.empresa="+it.id
           def con2 = Contacto.executeQuery(consul2)
           con2.each {
               cliente.put("contactoID",it.persona?.id)
               cliente.put("email contacto",it.persona?.email)
               cliente.put("celular contacto",it.persona?.celularPrincipal)
               cliente.put("telefono contacto",it.persona?.telefonoFijo)
               cliente.put("nombre contacto", it.persona?.nombreCompleto())
           }
           listaClientes.add(cliente)
       }
        println listaClientes
        render (listaClientes as JSON)
        //render con as JSON
    }
    def generarOferta(Long idOportunidad,Long idVendedor,Long idContacto,String estadoOport){


    }
}
