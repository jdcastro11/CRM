Ext.define('Seguridad.store.OpcionList', {
    extend: 'Ext.data.Store',
    model: 'Seguridad.model.Opcion',
    autoLoad: false,
    proxy: {
        type: 'ajax',
        url: '/crm/seguridad/opciones',
        reader: {
            type: 'json',
            root: 'data'
        },
        extraParams: {
            idRol:-1
        }
    }
});