package crm
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
class IndicadorController {

    def generalService
    
    def index(Integer max) {
        int itemxview = generalService.getItemsxView(0);
        params.max = itemxview 
        String xoffset = params.offset?:0
        def idvendedor=generalService.getIdEmpleado(session['idUsuario'].toLong())
        
        def query="from Indicador where eliminado=0 and idEntidad=${idvendedor} order by nomEntidad,anio,periodo,idTipoIndicador"
        def queryc="select count(i) from Indicador  i where eliminado=0 and idEntidad=${idvendedor}"
        
        def num=Indicador.executeQuery(queryc)
        
        def indicadorInstanceList=Indicador.findAll(query, [max:params.max,offset:xoffset.toLong()])
        
        render view: "index", model:[indicadorInstanceList:indicadorInstanceList, indicadorInstanceCount:num[0]]
    }
    
    def mostrarGraficaHbar(){
              
        def xidemp= generalService.getIdEmpleado(session['idUsuario'])  
        def hoy =  new Date()
        def xanio=hoy[Calendar.YEAR]
       
        String xdiv
		
       //if (params.id.indexOf('Q') !=-1) xdiv="Hbarra01" else
		xdiv="Hbarra01"
		//xdiv="Hbarra02" 
       
        def colsQ = [['string', ''], ['number', 'Miles Us'] ]
        
        def datosQ = [['Prosp'  ,generalService.getValorIndicador(xidemp,params.id,xanio,'prospecto','vprospxven')], 
            ['Opor10%', 50000], 
            ['Opor25%', 350000], 
            ['Opor50%', 125000],
            ['Ganadas', 750000]]
		
		//println "DATOSQ "+datosQ
		//println "COLSQ "+colsQ
      
        render template:"mostrarGraficaHbar", model:[colsQ:colsQ,datosQ:datosQ,xdiv:xdiv]
    }
}
