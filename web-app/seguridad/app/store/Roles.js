Ext.define('Seguridad.store.Roles', {
    extend: 'Ext.data.Store',
    model: 'Seguridad.model.Rol',
    autoLoad: true,
    proxy: {
        type: 'ajax',
        url: '/crm/seguridad/roles',
        reader: {
            type: 'json',
            root: 'data'
        },
        extraParams: {
        }
    }
});