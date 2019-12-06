package crm
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AnexoController extends BaseController{

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def generalService

    def index(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max =itemxview
        String  xoffset=params.offset?:0

        def query="from Anexo  where idEntidad=${params.id} and nombreEntidad='${params.entidad}' and eliminado=0  order by idTipoAnexo asc,id desc"
        def anexoInstanceList=Anexo.findAll(query,[max:params.max,offset:xoffset.toLong()])
        def queryc="select count(a) from Anexo a where a.idEntidad=${params.id} and a.nombreEntidad='${params.entidad}' and a.eliminado=0"
        def num=Anexo.executeQuery(queryc)
        respond anexoInstanceList, model:[anexoInstanceCount: num[0],
                xtitulo:message(code:"listaDeAnexos.label", default:"Lista de Anexos"),
				
				//generalService?.getValorParametro('anexot00'),
                xidentidad:params.id,xentidad:params.entidad]
    }
    def indexo(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max =itemxview
        String  xoffset=params.offset?:0

        def query="from Anexo  where idEntidad=${params.id} and nombreEntidad='${params.entidad}' and eliminado=0  order by idTipoAnexo asc,id desc"
        def anexoInstanceList=Anexo.findAll(query,[max:params.max,offset:xoffset.toLong()])
        def queryc="select count(a) from Anexo a where a.idEntidad=${params.id} and a.nombreEntidad='${params.entidad}' and a.eliminado=0"
        def num=Anexo.executeQuery(queryc)
        respond anexoInstanceList, model:[anexoInstanceCount: num[0],
                                          xtitulo:message(code:"listaDeAnexos.label", default:"Lista de Anexos"),

                                          //generalService?.getValorParametro('anexot00'),
                                          xidentidad:params.id,xentidad:params.entidad]
    }
    
    def indexh(Integer max) {
        int itemxview=generalService.getItemsxView(0)
        params.max =itemxview
        String  xoffset=params.offset?:0
    
        def query="from AnexoH  where idEntidad=${params.id} and nombreEntidad='${params.entidad}' and eliminado=0  order by idTipoAnexo asc,id desc"
        def anexoInstanceList=AnexoH.findAll(query,[max:params.max,offset:xoffset.toLong()])
        def queryc="select count(a) from AnexoH a where a.idEntidad=${params.id} and a.nombreEntidad='${params.entidad}' and a.eliminado=0"
        def num=AnexoH.executeQuery(query)
       
        render view:"indexh", model:[anexoInstanceList:anexoInstanceList,anexoInstanceCount:num[0],
                                        xtitulo:generalService?.getValorParametro('anexot06'),
                                        xidentidad:params.id,xentidad:params.entidad]
    }

    def listarBorrados(Integer max) {

        int itemxview=generalService.getItemsxView(0)
        params.max = Math.min(max ?: itemxview, 100)
        String  xoffset=params.offset?:0

        def query="from Anexo  where idEntidad=${params.id} and nombreEntidad='${params.entidad}' and eliminado=1 "
        def anexoInstanceList=Anexo.findAll(query,[max:params.max,offset:xoffset.toLong()])
        
        def queryb="select count(a) from Anexo a where a.idEntidad=${params.id} and a.nombreEntidad='${params.entidad}' and a.eliminado=1"
        
        def num=Anexo.executeQuery(queryb)
        render view: "index" , model:[anexoInstanceList:anexoInstanceList,
                anexoInstanceCount: num[0],xidentidad:params.id,xentidad:params.entidad,
                itemxview:itemxview,xtitulo:message(code:'listaDeAnexos.eliminados.label',default:'Lista de Anexos Borrados')]
    }
    
    @Transactional // borrar 
    def borrar(Anexo anexoInstance) {

        if (params.id == null) {
            notFound()
            return
        }

        anexoInstance= Anexo.get(params.id)

        anexoInstance.eliminado=1

        anexoInstance.save flush:true
        flash.message = message(code: 'anexo.borrado.message', default: 'Anexo borrado exitosamente')
        redirect url:"/anexo/index/${anexoInstance.idEntidad}?entidad="+anexoInstance.nombreEntidad
            
    }

    def show(Anexo anexoInstance) {
        respond anexoInstance
    }

    def create() {
        respond new Anexo(params)
    }

    @Transactional  //save
    def save(Anexo anexoInstance) {
		
		
		if(params.idTipoAnexo=='anexo02' && params.nombreEntidad=='pedido')//si el anexo es orden de compra cliente
		{
			def usuarioAccede = generalService.getIdEmpleado(session['idUsuario'].toLong())
			println "PARAMS.IDENTIDAD"+params.idEntidad		
			generalService.notificarPreventa(params.idEntidad,usuarioAccede)
			
			
		}

       
       if (anexoInstance == null) {
            notFound()
            return
        }
             

        if (anexoInstance.hasErrors()) {
            respond anexoInstance.errors, view: 'create'
            return
        }
        
         def file = request.getFile('file')
         def resp=generalService.validarNombreArchivo(file.originalFilename)
		 println "IMPRIMEME TODO DEL ANEXO CUADRO "+anexoInstance
         println "Nombre valido" +file.originalFilename
         println resp
         if  (resp){
                if (params.hayAnexo=='S'){
                   try { 

                        anexoInstance.save flush: true  // se requiere para obtener el id
						println "JE JE JE"+anexoInstance                        
                        String zruta =generalService.getValorParametro('ruta01')
                       def xruta = servletContext.getRealPath(zruta)      
                       def nombreFinal=generalService.getNombreAnexo(file.originalFilename,anexoInstance.id.toString())  
                       def  rutayFile=new File( xruta,  nombreFinal)					   
                       if (!rutayFile.exists()){
                           file.transferTo( rutayFile)               
                       }
                       anexoInstance.nombreArchivo=nombreFinal
					   anexoInstance.fechaCreacion=new Date()
                       anexoInstance.save flush: true               
                       flash.message = message(code: 'anexo.creado.message', default: 'Anexo creado exitosamente')

                   }catch(ex){
                       flash.warning =message(code:'anexoEstandar.message',default:'Anexo no cumple estandar para ser cargado al sistema.Verifique')                  
                   }   
                }
           }else{                
                  flash.warning =message(code:'anexo.archivoInvalido.message',default:'Nombre de Archivo Invalido. Solamente Letras,digitos,puntos,-,_')                     
             }
                  redirect url:"/anexo/index/"+anexoInstance.idEntidad+"?entidad="+anexoInstance.nombreEntidad   
    }

    def edit(Anexo anexoInstance) {
        respond anexoInstance
    }

    @Transactional  //update 
    def update(Anexo anexoInstance) {

        anexoInstance=Anexo.get(params.id)
        println "anexo editado jejeje "+params
        if (params.hayAnexo=='S'){
             
            def file = request.getFile('file')
            String zruta =generalService.getValorParametro('ruta01')
            def xruta = servletContext.getRealPath(zruta)

            def nombreFinal=generalService.getNombreAnexo(anexoInstance.nombreArchivo,anexoInstance.id.toString())        
            def  rutayFile=new File( xruta,  nombreFinal)

            anexoInstance.nombreArchivo=nombreFinal

            if (!rutayFile.exists()){
                file.transferTo( rutayFile)
            }
        }
        if (anexoInstance == null) {
            notFound()
            return
        }
        
        anexoInstance.validate()
        
        if (anexoInstance.hasErrors()) {
            respond anexoInstance.errors, view: 'edit'
            return
        }

        anexoInstance.save flush: true
        redirect url:"/anexo/index/"+anexoInstance.idEntidad+"?entidad="+anexoInstance.nombreEntidad
    }

    @Transactional   //delete 
    def delete(Anexo anexoInstance) {

        if (anexoInstance == null) {
            notFound()
            return
        }

        anexoInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Anexo.label', default: 'Anexo'), anexoInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.warning = message(code: 'default.not.found.message', args: [message(code: 'anexoInstance.label', default: 'Anexo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
    
    def anexarArchivo(){

        render view: "/general/importarArchivo", model:[zregreso:'/regresar1.html']
    }
}
