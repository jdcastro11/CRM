Ext.define('Seguridad.store.Usuarios', {
    extend: 'Ext.data.Store',
    model: 'Seguridad.model.Usuario',
    autoLoad: false,
    proxy: {
        type: 'ajax',
        url: '/crm/seguridad/usuariosPorRol',
        reader: {
            type: 'json',
            root: 'data'
        },
        extraParams: {
            idRol: -1 
        }
    }
});