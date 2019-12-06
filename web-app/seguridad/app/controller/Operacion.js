Ext.define('Seguridad.controller.Operacion', {
    extend: 'Ext.app.Controller',
    
    init: function() {
    
        this.control({
           'operacion button[action=load]':{
                click: this.cargarGrilla
           },
           'operacion button[action=asignar]':{
                click: this.asignar
           },
           'operacion button[action=nuevo]':{
                click: this.mostrarFormulario
           },
           'operacion button[action=cancelar]':{
                click: this.ocultarFormulario
           },
           'operacion button[action=guardar]':{
                click: this.nuevo
           },
           'operacion button[action=guardarcambios]':{
                click: this.guardarCambios
           },
           'operacion button[action=borrar]':{
                click: this.borrar
           },
           'operacion button[action=editar]':{
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
            Ext.Msg.alert("Informacion","Debe seleccionar alguna operacion")
        }else{
            var operaciones = new Array();
            for (var i = 0; i < records.length; i++) {
                record = records[i]
                  if(record.get("asignado")!="SI"){
                    operaciones.push(record.get("id"));
                  }
            }
            if(operaciones.length==0){
                Ext.Msg.alert("Informacion","Debe seleccionar operaciones no asignadas")
            }else{
                var win = el.up('operacion');
                var idRol = el.up("gridpanel").store.proxy.extraParams.idRol
                var idOpcion = el.up("gridpanel").store.proxy.extraParams.idOpcion
                Ext.Ajax.request({
                    method:'POST',
                    url:'/crm/seguridad/asignarOperaciones',
                    params:{
                        operaciones:Ext.encode(operaciones),
                        idRol:idRol,
                        idOpcion:idOpcion
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
        el.up('operacion').down('form').show()
        el.up('gridpanel').hide()

    },

    ocultarFormulario: function(el){
        el.up('operacion').down('gridpanel').show()
        el.up('form').hide()
        el.up('form').getForm().reset();
        el.up('operacion').down('form').down('button[action=guardar]').show()
        el.up('operacion').down('form').down('button[action=guardarcambios]').hide()
        el.up('operacion').down('form').down('combobox[name=estadoOperacion]').hide()

    },

    nuevo: function(el){
        var values = el.up('form').getForm().getValues();
        me = this;
        Ext.Ajax.request({
            method:'POST',
            url:'/crm/seguridad/nuevaOperacion',
            params:{
                data:Ext.encode(values)
            },
            success:function(response){
                var resp =  Ext.decode(response.responseText)
                if(resp.ok){
                     me.ocultarFormulario(el)
                     el.up('operacion').down('gridpanel').store.load()
                     el.up('operacion').main.store.load()
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
            url:'/crm/seguridad/editarOperacion',
            params:{
                data:Ext.encode(values)
            },
            success:function(response){
                var resp =  Ext.decode(response.responseText)
                if(resp.ok){
                     me.ocultarFormulario(el)
                     el.up('operacion').down('gridpanel').store.load()
                     el.up('operacion').main.store.load()
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
                    Ext.Msg.alert("Informacion","Debe seleccionar alguna Operacion")
                }else{
                    var lista = new Array();
                    for (var i = 0; i < records.length; i++) {
                        record = records[i]
                        lista.push(record.get("id"));
                    }
                    Ext.Ajax.request({
                        method:'POST',
                        url:'/crm/seguridad/borrarOperaciones',
                        params:{
                            operaciones:Ext.encode(lista)
                        },
                        success:function(response){
                            var resp =  Ext.decode(response.responseText)
                            if(resp.ok){
                                el.up("gridpanel").store.load();
                                el.up('operacion').main.store.load()
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
            Ext.Msg.alert("Informacion","Debe seleccionar una sola Operacion")
        }else{
            el.up('operacion').down('form').getForm().loadRecord(records[0])
            el.up('operacion').down('form').show()
            el.up('gridpanel').hide()
            el.up('operacion').down('form').down('button[action=guardar]').hide()
            el.up('operacion').down('form').down('button[action=guardarcambios]').show()
            el.up('operacion').down('form').down('combobox[name=estadoOperacion]').show()
        }
    }
});
