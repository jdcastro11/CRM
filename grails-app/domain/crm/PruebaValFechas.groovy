package crm

class PruebaValFechas {

    Date  fechaAperturaReq
    String tipoRequerimiento
    String tema
    String descripcionReq
    Date fechaCierreEstimadaReq
    String numOptty
    
    static mapping ={
        table 'pruebasFechas'
        version false
    }
    
    static constraints = {
    }
}
