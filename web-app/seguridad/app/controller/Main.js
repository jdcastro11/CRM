Ext.define('Seguridad.controller.Main', {
    extend: 'Ext.app.Controller',
    
    stores: [
        'Roles',
        'Usuarios',
        'Opciones',
        'Operaciones',
        'OperacionesList',
        'UsuarioList',
        'OpcionList',
        'RolList',
        'Parametros',
        'Personas'
    ],

    views: [
        'Main',
        'Operacion',
        'Usuario',
        'Opcion',
        'Rol'
    ],


    init: function() {
        document.getElementById("idbody").innerHTML = "";
        Ext.create("Seguridad.view.Main",{});

        this.control({
           'main gridpanel[name=roles]':{
                select: this.seleccionartRol,
                deselect: this.limpiarUsuariosOpciones
           },
           'main gridpanel[name=opciones]':{
                select: this.seleccionartOpcion,
                deselect: this.limpiarOperaciones
           },
           'main button[action=load]':{
                click: this.cargarGrilla
           },
           'main button[action=roles]':{
                click: this.listaRoles
           },
           'main button[action=operaciones]':{
                click: this.listaOperaciones
           },
           'main button[action=usuarios]':{
                click: this.listaUsuarios
           },
           'main button[action=opciones]':{
                click: this.listaOpciones
           },
           'main button[action=quitarOperaciones]':{
                click: this.quitarOperaciones
           },
           'main button[action=quitarUsuarios]':{
                click: this.quitarUsuarios
           },
           'main button[action=quitarOpciones]':{
                click: this.quitarOpciones
           }

        });
    },

    cargarGrilla:function(el){
        el.up("gridpanel").store.load();
    },

    seleccionartRol: function(el, record){
        var records = el.view.up('gridpanel').getSelectionModel().getSelection()
        if(records.length == 1){
            var store = el.view.up('main').down('gridpanel[name=usuarios]').store;
            store.proxy.extraParams.idRol = record.get('id');
            store.load();

            store = el.view.up('main').down('gridpanel[name=opciones]').store;
            store.proxy.extraParams.idRol = record.get('id');
            store.load();
        }else{
            this.limpiarUsuariosOpciones(el,record)
        }
    },

    limpiarUsuariosOpciones:function(el, record){
        var store = el.view.up('main').down('gridpanel[name=usuarios]').store;
        store.proxy.extraParams.idRol = -1;
        store.removeAll();

        store = el.view.up('main').down('gridpanel[name=opciones]').store;
        store.proxy.extraParams.idRol = -1;
        store.removeAll();

        store = el.view.up('main').down('gridpanel[name=operaciones]').store;
        store.proxy.extraParams.idRol = -1;
        store.proxy.extraParams.idOpcion = -1;
        store.removeAll();

        var records = el.view.up('gridpanel').getSelectionModel().getSelection()
        if(records.length == 1){
            var store = el.view.up('main').down('gridpanel[name=usuarios]').store;
            store.proxy.extraParams.idRol = records[0].get('id');
            store.load();

            store = el.view.up('main').down('gridpanel[name=opciones]').store;
            store.proxy.extraParams.idRol = records[0].get('id');
            store.load();
        }
    },

    seleccionartOpcion: function(el, record){
        var records = el.view.up('gridpanel').getSelectionModel().getSelection()
        if(records.length == 1){
            var store = el.view.up('main').down('gridpanel[name=operaciones]').store;
            var recordRol =  el.view.up('main').down('gridpanel[name=roles]').getSelectionModel().getSelection();
            console.log(recordRol)
            store.proxy.extraParams.idRol = recordRol[0].get('id');
            store.proxy.extraParams.idOpcion = record.get('id');
            store.load();
        }else{
            this.limpiarOperaciones(el,record)
        }
    },

    limpiarOperaciones:function(el, record){
        var store = el.view.up('main').down('gridpanel[name=operaciones]').store;
        store.proxy.extraParams.idRol = -1;
        store.proxy.extraParams.idOpcion = -1;
        store.removeAll();

        var records = el.view.up('gridpanel').getSelectionModel().getSelection()
        if(records.length == 1){
            var store = el.view.up('main').down('gridpanel[name=operaciones]').store;
            var recordRol =  el.view.up('main').down('gridpanel[name=roles]').getSelectionModel().getSelection();
            console.log(recordRol)
            store.proxy.extraParams.idRol = recordRol[0].get('id');
            store.proxy.extraParams.idOpcion = records[0].get('id');
            store.load();
        }

    },

    listaRoles:function(el){
        var win = Ext.widget("rol",{main:el.up('gridpanel[name=roles]')});
        win.down('gridpanel').store.load();
        win.show();
    },

    listaOperaciones:function(el){
        var records = el.up('main').down('gridpanel[name=opciones]').getSelectionModel().getSelection();
        if(records.length == 0){
            Ext.Msg.alert("Informacion","Debe seleccionar una OPCION");
            return;
        }
        var win = Ext.widget("operacion",{main:el.up('gridpanel[name=operaciones]')});

        win.down('gridpanel').store.proxy.extraParams.idOpcion = records[0].get('id')

        records = el.up('main').down('gridpanel[name=roles]').getSelectionModel().getSelection();
        if(records.length == 0){
            Ext.Msg.alert("Informacion","Debe seleccionar un ROL");
            return;
        }
        win.down('gridpanel').store.proxy.extraParams.idRol = records[0].get('id')


        win.down('gridpanel').store.load();
        win.show();
    },

    quitarOperaciones:function(el){
        var records = el.up('gridpanel').getSelectionModel().getSelection();
        if(records.length==0){
            Ext.Msg.alert("Informacion","Debe seleccionar alguna operacion")
        }else{
            var lista = new Array();
            for (var i = 0; i < records.length; i++) {
                lista.push(records[i].get("id"))
            };
            var recordRol =  el.up('main').down('gridpanel[name=roles]').getSelectionModel().getSelection();
            var idRol = recordRol[0].get("id")
            var recordOpcion = el.up('main').down('gridpanel[name=opciones]').getSelectionModel().getSelection();
            var idOpcion = recordOpcion[0].get("id")

            Ext.Ajax.request({
                method:'POST',
                url:'/crm/seguridad/quitarOperaciones',
                params:{
                    operaciones:Ext.encode(lista),
                    idRol:idRol,
                    idOpcion:idOpcion
                },
                success:function(response){
                    var resp =  Ext.decode(response.responseText)
                    if(resp.ok){
                        el.up('gridpanel').store.load()
                    }else{
                        Ext.Msg.alert("Informacion","No fue posible realizar la accion");
                    }
                }, 
                failure:function(){
                    Ext.Msg.alert("Informacion","No fue posible realizar la accion");
                }
            })
        }
    },

     listaUsuarios:function(el){
        var records = el.up('main').down('gridpanel[name=roles]').getSelectionModel().getSelection();
        if(records.length == 0){
            Ext.Msg.alert("Informacion","Debe seleccionar un ROL");
            return;
        }
        var win = Ext.widget("usuario",{main:el.up('gridpanel[name=usuarios]')});

        win.down('gridpanel').store.proxy.extraParams.idRol = records[0].get('id')

        win.down('gridpanel').store.load();
        win.show();
    },

    quitarUsuarios:function(el){
        var records = el.up('gridpanel').getSelectionModel().getSelection();
        if(records.length==0){
            Ext.Msg.alert("Informacion","Debe seleccionar algun usuario")
        }else{
            var lista = new Array();
            for (var i = 0; i < records.length; i++) {
                lista.push(records[i].get("id"))
            };
            var recordRol =  el.up('main').down('gridpanel[name=roles]').getSelectionModel().getSelection();
            var idRol = recordRol[0].get("id")
            Ext.Ajax.request({
                method:'POST',
                url:'/crm/seguridad/quitarUsuarios',
                params:{
                    usuarios:Ext.encode(lista),
                    idRol:idRol
                },
                success:function(response){
                    var resp =  Ext.decode(response.responseText)
                    if(resp.ok){
                        el.up('gridpanel').store.load()
                    }else{
                        Ext.Msg.alert("Informacion","No fue posible realizar la accion");
                    }
                }, 
                failure:function(){
                    Ext.Msg.alert("Informacion","No fue posible realizar la accion");
                }
            })
        }
    },

     listaOpciones:function(el){
        var records = el.up('main').down('gridpanel[name=roles]').getSelectionModel().getSelection();
        if(records.length == 0){
            Ext.Msg.alert("Informacion","Debe seleccionar un ROL");
            return;
        }
        var win = Ext.widget("opcion",{main:el.up('gridpanel[name=opciones]')});

        win.down('gridpanel').store.proxy.extraParams.idRol = records[0].get('id')

        win.down('gridpanel').store.load();
        win.show();
    },

    quitarOpciones:function(el){
        var records = el.up('gridpanel').getSelectionModel().getSelection();
        if(records.length==0){
            Ext.Msg.alert("Informacion","Debe seleccionar alguna opcion")
        }else{
            var lista = new Array();
            for (var i = 0; i < records.length; i++) {
                lista.push(records[i].get("id"))
            };
            var recordRol =  el.up('main').down('gridpanel[name=roles]').getSelectionModel().getSelection();
            var idRol = recordRol[0].get("id")
            Ext.Ajax.request({
                method:'POST',
                url:'/crm/seguridad/quitarOpciones',
                params:{
                    opciones:Ext.encode(lista),
                    idRol:idRol
                },
                success:function(response){
                    var resp =  Ext.decode(response.responseText)
                    if(resp.ok){
                        el.up('gridpanel').store.load()
                    }else{
                        Ext.Msg.alert("Informacion","No fue posible realizar la accion");
                    }
                }, 
                failure:function(){
                    Ext.Msg.alert("Informacion","No fue posible realizar la accion");
                }
            })
        }
    }
});
