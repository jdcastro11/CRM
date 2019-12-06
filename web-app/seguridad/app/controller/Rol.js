Ext.define('Seguridad.controller.Rol', {
    extend: 'Ext.app.Controller',
    
    init: function() {
    
        this.control({
           'rol button[action=load]':{
                click: this.cargarGrilla
           },
           'rol button[action=nuevo]':{
                click: this.mostrarFormulario
           },
           'rol button[action=cancelar]':{
                click: this.ocultarFormulario
           },
           'rol button[action=guardar]':{
                click: this.nuevo
           },
           'rol button[action=guardarcambios]':{
                click: this.guardarCambios
           },
           'rol button[action=borrar]':{
                click: this.borrar
           },
           'rol button[action=editar]':{
                click: this.editar
           }
        });
    },

    cargarGrilla: function(el){
        el.up("gridpanel").store.load();
    },

    mostrarFormulario: function(el){
        el.up('rol').down('form').show()
        el.up('gridpanel').hide()

    },

    ocultarFormulario: function(el){
        el.up('rol').down('gridpanel').show()
        el.up('form').hide()
        el.up('form').getForm().reset();
        el.up('rol').down('form').down('button[action=guardar]').show()
        el.up('rol').down('form').down('button[action=guardarcambios]').hide()
        el.up('rol').down('form').down('combobox[name=estadoRol]').hide()

    },

    nuevo: function(el){
        var values = el.up('form').getForm().getValues();
        me = this;
        Ext.Ajax.request({
            method:'POST',
            url:'/crm/seguridad/nuevoRol',
            params:{
                data:Ext.encode(values)
            },
            success:function(response){
                var resp =  Ext.decode(response.responseText)
                if(resp.ok){
                     me.ocultarFormulario(el)
                     el.up('rol').down('gridpanel').store.load()
                     el.up('rol').main.store.load()
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
            url:'/crm/seguridad/editarRol',
            params:{
                data:Ext.encode(values)
            },
            success:function(response){
                var resp =  Ext.decode(response.responseText)
                if(resp.ok){
                     me.ocultarFormulario(el)
                     el.up('rol').down('gridpanel').store.load()
                     el.up('rol').main.store.load()
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
                    Ext.Msg.alert("Informacion","Debe seleccionar algun rol")
                }else{
                    var lista = new Array();
                    for (var i = 0; i < records.length; i++) {
                        record = records[i]
                        lista.push(record.get("id"));
                    }
                    Ext.Ajax.request({
                        method:'POST',
                        url:'/crm/seguridad/borrarRoles',
                        params:{
                            roles:Ext.encode(lista)
                        },
                        success:function(response){
                            var resp =  Ext.decode(response.responseText)
                            if(resp.ok){
                                el.up("gridpanel").store.load();
                                el.up('rol').main.store.load()
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
            Ext.Msg.alert("Informacion","Debe seleccionar un solo ROL")
        }else{
            el.up('rol').down('form').getForm().loadRecord(records[0])
            el.up('rol').down('form').show()
            el.up('gridpanel').hide()
            el.up('rol').down('form').down('button[action=guardar]').hide()
            el.up('rol').down('form').down('button[action=guardarcambios]').show()
            el.up('rol').down('form').down('combobox[name=estadoRol]').show()
        }
    }
    
});
