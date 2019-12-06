Ext.define('Seguridad.store.OperacionesList', {
    extend: 'Ext.data.Store',
    model: 'Seguridad.model.Operacion',
    autoLoad: false,
    proxy: {
        type: 'ajax',
        url: '/crm/seguridad/operaciones',
        reader: {
            type: 'json',
            root: 'data'
        },
        extraParams: {
            idOpcion:-1,
            idRol:-1
        }
    }
});