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
        def consul = "select e.nit, e.razonSocial, t.nombreTerritorio, e.direccion, e.telefonos, e.email, e.empleado_id from Empresa e, Territorio t where e.idCiudad = t.id and e.eliminado = 0"
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

            cliente.put("nit",it.nit)
            cliente.put("razonSocial",it.razonSocial)

            listaClientes.add(cliente)
        }
        render (listaClientes as JSON)
        //render con as JSON
    }
}
