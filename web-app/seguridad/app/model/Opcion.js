Ext.define('Seguridad.model.Opcion', {
    extend: 'Ext.data.Model',
    fields: [
    	    'idTipoOpcion',
	    'idPadre',
            'tieneHijos',
	    'nombreOpcion',             
	    'descOpcion',
	    'url',
	    'cls',
	    'estadoOpcion',
	    'controlador',
	    'eliminado',
	    'asignado',
   	    'orden'
    ]
});
