package crm

import java.lang.ProcessBuilder.Redirect;
import java.text.DecimalFormat
import java.text.SimpleDateFormat

import javax.servlet.http.HttpServletResponse;

import org.codehaus.groovy.grails.commons.DomainClassArtefactHandler;
import org.codehaus.groovy.grails.commons.GrailsApplication;
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsWebRequest
import org.codehaus.groovy.grails.web.util.WebUtils

import grails.transaction.Transactional

@Transactional
class ExportarService {
	
	def exportService	
	def grailsApplication	
    def exportar(Class dominio,List listaaexportar, List fields, Map labels,HttpServletResponse response,Map formatters,String filename) 
	{
		response.contentType = grailsApplication.config.grails.mime.types["xls"]
		response.setHeader("Content-disposition", "attachment; filename=${filename}.xls")				
									
		exportService.export("excel", response.outputStream,listaaexportar,fields,labels,formatters, [:])
    }
	
	
	List obtenerItemsSeleccionados(Class dominio,List ids)//lista de ids y la clase dominio
	{
		List itemsSelected=[]
		ids.each
		{
			//Aqui se guarda un registro sin tener en cuenta los atributos asociados con otra entidad
			//def listop=Oportunidad.get(it).properties.findAll { !( it.key in Oportunidad.hasMany?.keySet() ) }
			def item=dominio.get(it).properties
			itemsSelected.add(item)
		}
		
		return itemsSelected
	}
	
	
	String setfilename(String nombre)
	{
		def date = new Date()
		def sdf1 = new SimpleDateFormat("dd-MM-yyyy HH:mm")
		return nombre+" "+sdf1.format(date).toString()
	}
	
	def formatNumber(String numero)
	{
		double amount = Double.parseDouble(numero)
		DecimalFormat df = new DecimalFormat("#,###.00")
		return df.format(amount)
	}
}
