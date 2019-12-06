Ext.define('Seguridad.store.Opciones', {
    extend: 'Ext.data.Store',
    model: 'Seguridad.model.Opcion',
    autoLoad: false,
    proxy: {
        type: 'ajax',
        url: '/crm/seguridad/opcionesPorRol',
        reader: {
            type: 'json',
            root: 'data'
        },
        extraParams: {
            idRol:-1
        }
    }
});