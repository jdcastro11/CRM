Ext.define('Seguridad.store.Personas', {
    extend: 'Ext.data.Store',
    model: 'Seguridad.model.Persona',
    autoLoad: true,
    proxy: {
        type: 'ajax',
        url: '/crm/seguridad/personas',
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});