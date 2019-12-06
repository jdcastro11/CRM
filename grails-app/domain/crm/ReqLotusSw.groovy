package crm

class ReqLotusSw {
    static transients = ["fechaAperturaReq","tipoRequerimiento","tema", "descripcionReq","fechaCierreEstimadaReq", "numOptty", "file", "file1", "vienedepedido"];
    Date  fechaAperturaReq
    String tipoRequerimiento
    String tema
    String descripcionReq
    Date fechaCierreEstimadaReq
    String numOptty
    String file
    String file1
    String vienedepedido
    
    
    static constraints = {
        
    }
}
