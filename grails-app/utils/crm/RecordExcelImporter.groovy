package crm

//import org.grails.plugins.excelimport.ExcelImportUtils
import org.grails.plugins.excelimport.*
import org.grails.plugins.excelimport.AbstractExcelImporter
import sample.*


class RecordExcelImporter extends AbstractExcelImporter {

	Map CONFIG_RECORD_CELL_MAP = [ 
		sheet:'Sheet2', 
		cellMap: [ 'D3':'title',
        'D4':'author',
        'D6':'numSold',
		]
	]

	Map CONFIG_RECORD_COLUMN_MAP = [
		sheet:'Hoja1', 
		startRow: 1,
		columnMap:  [
			'A':'column1'
		]
	]

    //can also configure injection in resources.groovy
	def getExcelImportService() {
		ExcelImportService.getService()
	}

	public RecordExcelImporter(fileName) {
		super(fileName)
	}

	List<Map> getRecords() {
		List recordList = excelImportService.columns(workbook, CONFIG_RECORD_COLUMN_MAP)
	}


	Map getOneMoreRecordParams() {
		Map recordParams = excelImportService.cells(workbook, CONFIG_RECORD_CELL_MAP )
	}

}