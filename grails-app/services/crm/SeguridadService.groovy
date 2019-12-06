package crm
class SeguridadService {
  
  def excepciones = ['/elementoPorOportunidad/infoSublineas','/empresa/saveAsync','/encLog/index',
                       '/empresa/updateAsync','/persona/saveAsync','/persona/updateAsync','/detLog/index','/tactica/getTacticas',
                       '/sublinea/infoSublineas','/territorio/traerMunicipios','/persona/datosContacto','/nota/mostrarNota','/propuesta/propuestaNormal',
                       '/empresa/autoCompletar','/contacto/autocompletar','/empresa/datosCliente','/general/error','/propuesta/propuestaFinal',
                       '/general/consumirSoap','/producto/autoCompletarProducto','/producto/datosProducto','/contacto/filter',
                       '/detPedido/procesarProductoCompraDef','/general/index','/territorio/traerDptos','/general/setDireccion','/oportunidad/buscarListadoRegistros','/pedido/buscarListadoRegistros','/oportunidad/traerDatosGraficaCuotaVsCump',
                       '/oportunidad/traerNodo1','/pedido/traerNodo','/general/webServiceRequerimiento',
                       '/general/email','/general/cliente','/pedido/vistaPedido','/empresa/convertirACliente','/pedido/devolverAVendedorDef','/empresa/validarUnicidad','/vencimiento/getMarcas','/vencimiento/actuVenci','/reqLotusSw/jsonPrueba','/reqLotusSw/crearRequerimientoSRR','/vencimiento/listarSeriales',
					   '/nota/empleadosNoti','/tactica/listarArchivadas','/empresa/servicelis', '/general/serviceliscli'/*,'/tactica/campanasYEventos','/tactica/tacticasDisponibles','/tactica/traerInformacionAsociadaTactica'*/]
    

    def menuPorUsuario(long idUsuario) {
       
        def opciones = Opcion.executeQuery(""" 
            select o from Opcion as o 
            where o.id in 
            (   select ro.opcion.id from RolOpcionOperacion as ro 
                join ro.rol as r where r.id in 
                (   select rol.id from RolUsuario as ru 
                    where ru.usuario.id = ${idUsuario} 
                    and ru.estadoRolUsuario = 'A'
                    and ru.eliminado = 0
                ) 
                and ro.operacion.id = 1 
                and ro.estadoRolOpcionOperacion = 'A'
                and ro.rol.eliminado = 0
                and ro.opcion.eliminado = 0
                and ro.operacion.eliminado = 0  
                and ro.eliminado = 0
                and o.eliminado = 0
            ) 
            and o.estadoOpcion = 'A'           
            and (o.idPadre=null or idPadre !=0)
            and o.eliminado = 0
            order by orden
        """); 

        return opciones
    }
    
    def validarOpcion (long idUsuario, String uri){
  
        if(excepciones.contains(uri)){
            return true;            
        }
        else{
            def vec = uri.split("/")
            if(vec.size()==3){
                def controlador = vec[1].toString()                
                def accion = vec[2].toString()
                  
                if (controlador != 'dashboard') {            
                                                        
                    def roo = RolOpcionOperacion.executeQuery(""" 
                        select o from RolOpcionOperacion as o
                        where  o.operacion.acciones like '%${accion},%'
                        and o.opcion.controlador='${controlador}' 
                        and o.estadoRolOpcionOperacion = 'A'
                        and o.opcion.estadoOpcion = 'A'
                        and o.operacion.estadoOperacion = 'A'  
                        and o.rol.id in (
                            select ru.rol.id from RolUsuario ru
                            where ru.usuario.id = ${idUsuario} 
                            and ru.estadoRolUsuario = 'A' 
                            and ru.eliminado=0) 
                        and o.rol.eliminado=0                                                                                         
                        and o.opcion.eliminado = 0
                        and o.operacion.eliminado = 0
                        and o.eliminado = 0
                    """);                    
                    if(roo.size()>0){
                        return true 
                    }
                }else{
                    return true;
                }
            }
            return false;
        }
    }

    def tipoOpcion (String uri){
      
        def vec = uri.split("/")
          if(vec.size()==3){
            def controlador = vec[1].toString()
            def accion = vec[2].toString()
            if (controlador != 'dashboard') {
                def roo = Opcion.executeQuery(""" 
                    select o.idTipoOpcion from Opcion as o 
                    where o.controlador = '${controlador}'
                    and o.url like '%${accion}%'
                    and o.estadoOpcion = 'A'
                    and o.eliminado = 0
                """); 
                 
                if(roo.size()>0) return roo[0] else return 'D'
            }
        }
        return "D";
    }

    
    def operacionesPorOpcion (long idUsuario, String uri) {   
        
        def vec = uri.split("/")		
        if(vec.size()==3){
			
            def controlador = vec[1].toString()
            if (controlador != 'dashboard') {
				
                def roo = RolOpcionOperacion.executeQuery(""" 
                    select distinct o.operacion.nombreOperacion from RolOpcionOperacion as o 
                    where o.opcion.controlador = '${controlador}'
                    and o.estadoRolOpcionOperacion = 'A'
                    and o.opcion.estadoOpcion = 'A'
                    and o.operacion.estadoOperacion = 'A'
                    and o.rol.id in (
                         select rol.id from RolUsuario  ru where ru.usuario.id = ${idUsuario} 
                         and ru.estadoRolUsuario = 'A' and ru.eliminado=0                        
                    )
                    and o.rol.eliminado = 0
                    and o.opcion.eliminado = 0
                    and o.operacion.eliminado = 0
                    and o.eliminado = 0
                """); 
        
                return roo
            }else{
                return ["VER"]
            }
        }
        return null;
    }
    
    def hayExcepcion(String uri){
       
        def xcount=ValorParametro.executeQuery("select count(vp) from ValorParametro vp where valor='${uri}' and estadoValorParametro='A' and eliminado=0")
        println "xcount"
        println uri
        println  xcount
        if (xcount[0]>=1)
           return true
        else 
            return false
   }
	
	def wsRequerimiento(String username,String password,String uri)//autenticacion para consumo de WS Requerimientos desarrollo agil
	{
		
		def query=Usuario.where{
			usuario==username
			contrasena==password
			eliminado==0
			idEstadoUsuario=="useractivo"
		}
		

		
	}
	
	 

}
