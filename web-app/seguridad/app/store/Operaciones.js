Ext.define('Seguridad.store.Operaciones', {
    extend: 'Ext.data.Store',
    model: 'Seguridad.model.Operacion',
    autoLoad: false,
    proxy: {
        type: 'ajax',
        url: '/crm/seguridad/operacionesPorOpcion',
        reader: {
            type: 'json',
            root: 'data'
        },
        extraParams: {
            idRol:-1,
            idOpcion:-1
        }
    }
});