Ext.define('Seguridad.controller.Usuario', {
    extend: 'Ext.app.Controller',
    
    init: function() {
    
        this.control({
           'usuario button[action=load]':{
                click: this.cargarGrilla
           },
           'usuario button[action=asignar]':{
                click: this.asignar
           },
           'usuario button[action=nuevo]':{
                click: this.mostrarFormulario
           },
           'usuario button[action=cancelar]':{
                click: this.ocultarFormulario
           },
           'usuario button[action=guardar]':{
                click: this.nuevo
           },
           'usuario button[action=guardarcambios]':{
                click: this.guardarCambios
           },
           'usuario button[action=borrar]':{
                click: this.borrar
           },
           'usuario button[action=editar]':{
                click: this.editar
           }
        });
    },

    cargarGrilla:function(el){
        el.up("gridpanel").store.load();
    },

    asignar: function(el){
        var records = el.up("gridpanel").getSelectionModel().getSelection();
        if(records.length==0){
            Ext.Msg.alert("Informacion","Debe seleccionar algun usuario")
        }else{
            var usuarios = new Array();
            for (var i = 0; i < records.length; i++) {
                record = records[i]
                  if(record.get("asignado")!="SI"){
                    usuarios.push(record.get("id"));
                  }
            }
            if(usuarios.length==0){
                Ext.Msg.alert("Informacion","Debe seleccionar usuarios no asignados")
            }else{
                var win = el.up('usuario');
                var idRol = el.up("gridpanel").store.proxy.extraParams.idRol
                Ext.Ajax.request({
                    method:'POST',
                    url:'/crm/seguridad/asignarUsuarios',
                    params:{
                        usuarios:Ext.encode(usuarios),
                        idRol:idRol
                    },
                    success:function(response){
                        var resp =  Ext.decode(response.responseText)
                        if(resp.ok){
                            win.main.store.load();
                            win.close();

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
    },

    mostrarFormulario: function(el){
        el.up('usuario').down('form').show()
        el.up('gridpanel').hide()

    },

    ocultarFormulario: function(el){
        el.up('usuario').down('gridpanel').show()
        el.up('form').hide()
        el.up('form').getForm().reset();
        el.up('usuario').down('form').down('button[action=guardar]').show()
        el.up('usuario').down('form').down('button[action=guardarcambios]').hide()
        el.up('usuario').down('form').down('combobox[name=idEstadoUsuario]').hide()

    },

    nuevo: function(el){
        var values = el.up('form').getForm().getValues();
        me = this;
        Ext.Ajax.request({
            method:'POST',
            url:'/crm/seguridad/nuevaUsuario',
            params:{
                data:Ext.encode(values)
            },
            success:function(response){
                var resp =  Ext.decode(response.responseText)
                if(resp.ok){
                     me.ocultarFormulario(el)
                     el.up('usuario').down('gridpanel').store.load()
                     el.up('usuario').main.store.load()
                }else{
                    Ext.Msg.alert("Informacion","No fue posible realizar la accion");
                }
            }, 
            failure:function(){
                Ext.Msg.alert("Informacion","No fue posible realizar la accion");
            }
        });
    },
    
    guardarCambios: function(el){
        var values = el.up('form').getForm().getValues();
        me = this;
        Ext.Ajax.request({
            method:'POST',
            url:'/crm/seguridad/editarUsuario',
            params:{
                data:Ext.encode(values)
            },
            success:function(response){
                var resp =  Ext.decode(response.responseText)
                if(resp.ok){
                     me.ocultarFormulario(el)
                     el.up('usuario').down('gridpanel').store.load()
                     el.up('usuario').main.store.load()
                }else{
                    Ext.Msg.alert("Informacion","No fue posible realizar la accion");
                }
            }, 
            failure:function(){
                Ext.Msg.alert("Informacion","No fue posible realizar la accion");
            }
        });
    },

    borrar: function(el){
         Ext.MessageBox.confirm('Confirmacion', '¿Esta seguro que quiere borrar los elementos seleccionados?', function(btn){
            if(btn == "yes"){
                var records = el.up("gridpanel").getSelectionModel().getSelection();
                if(records.length==0){
                    Ext.Msg.alert("Informacion","Debe seleccionar algun usuario")
                }else{
                    var lista = new Array();
                    for (var i = 0; i < records.length; i++) {
                        record = records[i]
                        lista.push(record.get("id"));
                    }
                    Ext.Ajax.request({
                        method:'POST',
                        url:'/crm/seguridad/borrarUsuarios',
                        params:{
                            usuarios:Ext.encode(lista)
                        },
                        success:function(response){
                            var resp =  Ext.decode(response.responseText)
                            if(resp.ok){
                                el.up("gridpanel").store.load();
                                el.up('usuario').main.store.load()
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
    },

    editar: function(el){
        var records = el.up("gridpanel").getSelectionModel().getSelection();
        if(records.length!=1){
            Ext.Msg.alert("Informacion","Debe seleccionar una solo usuario")
        }else{
            el.up('usuario').down('form').getForm().loadRecord(records[0])
            el.up('usuario').down('form').show()
            el.up('gridpanel').hide()
            el.up('usuario').down('form').down('button[action=guardar]').hide()
            el.up('usuario').down('form').down('button[action=guardarcambios]').show()
            el.up('usuario').down('form').down('combobox[name=idEstadoUsuario]').show()
        }
    }
});
