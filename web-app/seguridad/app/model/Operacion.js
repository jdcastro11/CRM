Ext.define('Seguridad.model.Operacion', {
    extend: 'Ext.data.Model',
    fields: [
    	'id',
    	'nombreOperacion', 
	    'estadoOperacion', 
	    'acciones',
	    'eliminado',
	    'asignado'
    ]
});
