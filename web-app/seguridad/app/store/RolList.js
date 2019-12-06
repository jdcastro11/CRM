Ext.define('Seguridad.store.RolList', {
    extend: 'Ext.data.Store',
    model: 'Seguridad.model.Rol',
    autoLoad: false,
    proxy: {
        type: 'ajax',
        url: '/crm/seguridad/roles',
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});