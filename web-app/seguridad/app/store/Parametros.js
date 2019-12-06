Ext.define('Seguridad.store.Parametros', {
    extend: 'Ext.data.Store',
    model: 'Seguridad.model.Parametro',
    autoLoad: true,
    proxy: {
        type: 'ajax',
        url: '/crm/seguridad/parametros',
        reader: {
            type: 'json',
            root: 'data'
        },
        extraParams: {
            id:'estadouser'
        }
    }
});