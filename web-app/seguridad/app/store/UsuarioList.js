Ext.define('Seguridad.store.UsuarioList', {
    extend: 'Ext.data.Store',
    model: 'Seguridad.model.Usuario',
    autoLoad: false,
    proxy: {
        type: 'ajax',
        url: '/crm/seguridad/usuarios',
        reader: {
            type: 'json',
            root: 'data'
        },
        extraParams: {
            idRol:-1
        }
    }
});