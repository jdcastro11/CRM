package crm
import  groovy.transform.Synchronized
import grails.transaction.Transactional

@Transactional
class ConsecutivoService {

     def synchronized prospecto(String xidSucursal){
        String prefijo
        def xempresa
        if (xidSucursal != null) {
            xempresa=Empresa.get(xidSucursal.toLong())
            if (xempresa?.iniciales!=null)
            prefijo=xempresa.iniciales
            else
            prefijo='BAQ'
        } else{ prefijo='BAQ'}

        Date hoy = new Date()  
        def xregUltimo=Consecutivo.find("from Consecutivo c where  c.entidad='Prospecto' and  c.empresa.id=${xidSucursal} and c.anio=year(current_date()) and c.eliminado=0")
         xregUltimo?.lock()
        Long lnreg 
        if (xregUltimo){
             lnreg = xregUltimo['secuencia'].toLong()          
        }else{
             def ConcecutivoInstance= new Consecutivo()
             ConcecutivoInstance.entidad="Prospecto"
              ConcecutivoInstance.empresa=xempresa
              ConcecutivoInstance.anio=hoy[Calendar.YEAR].toString()
              ConcecutivoInstance.secuencia=1
              ConcecutivoInstance.eliminado=0
              ConcecutivoInstance.save()
              lnreg=1
        }
        Consecutivo.executeUpdate("""update Consecutivo c set secuencia=secuencia+1 
                                       where c.entidad='Prospecto' and
                                             c.empresa.id=${xidSucursal} and 
                                             c.anio=year(current_date()) and 
                                             c.eliminado=0""")
          
        String snreg=lnreg.toString()
       
        snreg="PRO"+"-"+prefijo+"-"+snreg.padLeft(4,'0')+"-"+hoy[Calendar.YEAR].toString().substring(2,4)

        return snreg
    }    
   
     def synchronized vencimiento(String idpedido){
        def pedidoInstance=Pedido.get(idpedido.toLong())
        def xidSucursal= pedidoInstance.idSucursal      
         String prefijo  
        def xempresa
        if (xidSucursal != null) {
            xempresa=Empresa.get(xidSucursal.toLong())
            if (xempresa?.iniciales!=null)
               prefijo=xempresa.iniciales
            else
               prefijo='BAQ'
        } else{ prefijo='BAQ'}
       
       Date hoy = new Date()  
        def xregUltimo=Consecutivo.find("from Consecutivo c where  c.entidad='Vencimiento' and  c.empresa.id=${xidSucursal} and c.anio=year(current_date()) and c.eliminado=0")
         xregUltimo?.lock()
        Long lnreg 
        if (xregUltimo){
             lnreg = xregUltimo['secuencia'].toLong()          
        }else{
            def ConcecutivoInstance= new Consecutivo()
            ConcecutivoInstance.entidad="Vencimiento"
            ConcecutivoInstance.empresa=xempresa
            ConcecutivoInstance.anio=hoy[Calendar.YEAR].toString()
            ConcecutivoInstance.secuencia=1
            ConcecutivoInstance.eliminado=0
            ConcecutivoInstance.save()
            lnreg=1
        }
        Consecutivo.executeUpdate("""update Consecutivo c set secuencia=secuencia+1 
                                       where c.entidad='Vencimiento' and
                                             c.empresa.id=${xidSucursal} and 
                                             c.anio=year(current_date()) and 
                                             c.eliminado=0""")
          
        String snreg=lnreg.toString()
        
        snreg="V"+"-"+prefijo+"-"+snreg.padLeft(4,'0')+"-"+hoy[Calendar.YEAR].toString().substring(2,4)
        return snreg
    }
    
    def synchronized oportunidad(String xidSucursal){

        String prefijo
        def xempresa
        if (xidSucursal != null) {
             xempresa=Empresa.get(xidSucursal.toLong())
            if (xempresa?.iniciales!=null)
            prefijo=xempresa.iniciales
            else
            prefijo='BAQ'
        } else{ prefijo='BAQ'}

              Date hoy = new Date()  
        def xregUltimo=Consecutivo.find("from Consecutivo c where  c.entidad='Oportunidad' and  c.empresa.id=${xidSucursal} and c.anio=year(current_date()) and c.eliminado=0")
        xregUltimo?.lock()
        Long lnreg 
        if (xregUltimo){
             lnreg = xregUltimo['secuencia'].toLong()          
        }else{
             def ConcecutivoInstance= new Consecutivo()
             ConcecutivoInstance.entidad="Oportunidad"
              ConcecutivoInstance.empresa=xempresa
              ConcecutivoInstance.anio=hoy[Calendar.YEAR].toString()
              ConcecutivoInstance.secuencia=1
              ConcecutivoInstance.eliminado=0
              ConcecutivoInstance.save()
              lnreg=1
        }
        Consecutivo.executeUpdate("""update Consecutivo c set secuencia=secuencia+1 
                                       where c.entidad='Oportunidad' and
                                             c.empresa.id=${xidSucursal} and 
                                             c.anio=year(current_date()) and 
                                             c.eliminado=0""")
        
        String snreg=lnreg.toString()
        snreg=prefijo+"-"+snreg.padLeft(4,'0')  +"-"+hoy[Calendar.YEAR].toString().substring(2,4)

        return snreg
    }

    def synchronized pedido(String xidSucursal){

        String prefijo
        def xempresa
        if (xidSucursal != null) {
             xempresa=Empresa.get(xidSucursal.toLong())
            if (xempresa?.iniciales!=null)
            prefijo=xempresa.iniciales
            else
            prefijo='BAQ'
        } else{ prefijo='BAQ'}

         Date hoy = new Date()  
        def xregUltimo=Consecutivo.find("from Consecutivo c where  c.entidad='Pedido' and  c.empresa.id=${xidSucursal} and c.anio=year(current_date()) and c.eliminado=0")
        xregUltimo?.lock()
        Long lnreg 
        if (xregUltimo){
             lnreg = xregUltimo['secuencia'].toLong()          
        }else{
             def ConcecutivoInstance= new Consecutivo()
             ConcecutivoInstance.entidad="Pedido"
              ConcecutivoInstance.empresa=xempresa
              ConcecutivoInstance.anio=hoy[Calendar.YEAR].toString()
              ConcecutivoInstance.secuencia=1
              ConcecutivoInstance.eliminado=0
              ConcecutivoInstance.save()
              lnreg=1
        }
        Consecutivo.executeUpdate("""update Consecutivo c set secuencia=secuencia+1 
                                       where c.entidad='Pedido' and
                                             c.empresa.id=${xidSucursal} and 
                                             c.anio=year(current_date()) and 
                                             c.eliminado=0""")
       
        String snreg=lnreg.toString()
        snreg=prefijo+"-"+snreg.padLeft(4,'0')+"-"+hoy[Calendar.YEAR].toString().substring(2,4)

        return snreg
    }

    def synchronized  propuesta(String xidSucursal){

        String prefijo
        def xempresa
        if (xidSucursal != null) {
            xempresa=Empresa.get(xidSucursal.toLong())
            if (xempresa?.iniciales!=null)
            prefijo=xempresa.iniciales
            else
            prefijo='BAQ'
        } else{ prefijo='BAQ'}
       
           Date hoy = new Date()  
        def xregUltimo=Consecutivo.find("from Consecutivo c where  c.entidad='Propuesta' and  c.empresa.id=${xidSucursal} and c.anio=year(current_date()) and c.mes=month(current_date()) and c.eliminado=0")
        xregUltimo?.lock()
        Long lnreg 
        if (xregUltimo){
             lnreg = xregUltimo['secuencia'].toLong()          
        }else{
             def ConcecutivoInstance= new Consecutivo()
             ConcecutivoInstance.entidad="Propuesta"
              ConcecutivoInstance.empresa=xempresa
              ConcecutivoInstance.anio=hoy[Calendar.YEAR].toString()
               ConcecutivoInstance.mes=hoy[Calendar.MONTH]+1
              ConcecutivoInstance.secuencia=1
              ConcecutivoInstance.eliminado=0
              ConcecutivoInstance.save()
              lnreg=1
        }
        Consecutivo.executeUpdate("""update Consecutivo c set secuencia=secuencia+1 
                                       where c.entidad='Propuesta' and
                                             c.empresa.id=${xidSucursal} and 
                                             c.anio=year(current_date()) and 
                                             c.mes=month(current_date()) and
                                             c.eliminado=0""")
          
        String snreg=lnreg.toString()
        def zmes=hoy[Calendar.MONTH]+1
        String xmes=zmes.toString()       
        snreg=prefijo+"-"+hoy[Calendar.YEAR].toString()+xmes.padLeft(2,'0')+"-"+snreg.padLeft(3,'0')

        return snreg
    }
    

        
        
    
}
