Ext.Loader.setConfig({ enabled: true });

Ext.application({
    name: 'Seguridad',
    path:  'app',
    appFolder: '../app',
    controllers: [
        'Main',
        'Operacion',
        'Usuario',
        'Opcion',
        'Rol'
    ],
    launch: function(){
       
    }
});
