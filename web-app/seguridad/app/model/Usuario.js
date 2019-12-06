Ext.define('Seguridad.model.Usuario', {
    extend: 'Ext.data.Model',
    fields: ['usuario', 
    		'idEstadoUsuario',   
    		'contrasena',
    		'eliminado',
    		'estado',
		    'asignado',
		    'persona_id',
                        'tipoUsuario'

    		]
});
