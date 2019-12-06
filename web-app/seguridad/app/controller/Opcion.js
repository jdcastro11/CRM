Ext.define('Seguridad.controller.Opcion', {
    extend: 'Ext.app.Controller',
    
    init: function() {
    
        this.control({
           'opcion button[action=load]':{
                click: this.cargarGrilla
           },
           'opcion button[action=asignar]':{
                click: this.asignar
           },
           'opcion button[action=nuevo]':{
                click: this.mostrarFormulario
           },
           'opcion button[action=cancelar]':{
                click: this.ocultarFormulario
           },
           'opcion button[action=guardar]':{
                click: this.nuevo
           },
           'opcion button[action=guardarcambios]':{
                click: this.guardarCambios
           },
           'opcion button[action=borrar]':{
                click: this.borrar
           },
           'opcion button[action=editar]':{
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
            Ext.Msg.alert("Informacion","Debe seleccionar alguna opcion")
        }else{
            var opciones = new Array();
            for (var i = 0; i < records.length; i++) {
                record = records[i]
                  if(record.get("asignado")!="SI"){
                    opciones.push(record.get("id"));
                  }
            }
            if(opciones.length==0){
                Ext.Msg.alert("Informacion","Debe seleccionar opciones no asignados")
            }else{
                var win = el.up('opcion');
                var idRol = el.up("gridpanel").store.proxy.extraParams.idRol
                Ext.Ajax.request({
                    method:'POST',
                    url:'/crm/seguridad/asignarOpciones',
                    params:{
                        opciones:Ext.encode(opciones),
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
        el.up('opcion').down('form').show()
        el.up('gridpanel').hide()

    },

    ocultarFormulario: function(el){
        el.up('opcion').down('gridpanel').show()
        el.up('form').hide()
        el.up('form').getForm().reset();
        el.up('opcion').down('form').down('button[action=guardar]').show()
        el.up('opcion').down('form').down('button[action=guardarcambios]').hide()
        el.up('opcion').down('form').down('combobox[name=estadoOpcion]').hide()

    },

    nuevo: function(el){
        var values = el.up('form').getForm().getValues();
        me = this;
        Ext.Ajax.request({
            method:'POST',
            url:'/crm/seguridad/nuevaOpcion',
            params:{
                data:Ext.encode(values)
            },
            success:function(response){
                var resp =  Ext.decode(response.responseText)
                if(resp.ok){
                     me.ocultarFormulario(el)
                     el.up('opcion').down('gridpanel').store.load()
                     el.up('opcion').main.store.load()
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
            url:'/crm/seguridad/editarOpcion',
            params:{
                data:Ext.encode(values)
            },
            success:function(response){
                var resp =  Ext.decode(response.responseText)
                if(resp.ok){
                     me.ocultarFormulario(el)
                     el.up('opcion').down('gridpanel').store.load()
                     el.up('opcion').main.store.load()
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
                    Ext.Msg.alert("Informacion","Debe seleccionar alguna opcion")
                }else{
                    var lista = new Array();
                    for (var i = 0; i < records.length; i++) {
                        record = records[i]
                        lista.push(record.get("id"));
                    }
                    Ext.Ajax.request({
                        method:'POST',
                        url:'/crm/seguridad/borrarOpciones',
                        params:{
                            opciones:Ext.encode(lista)
                        },
                        success:function(response){
                            var resp =  Ext.decode(response.responseText)
                            if(resp.ok){
                                el.up("gridpanel").store.load();
                                el.up('opcion').main.store.load()
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
            Ext.Msg.alert("Informacion","Debe seleccionar una sola Opcion")
        }else{
            el.up('opcion').down('form').getForm().loadRecord(records[0])
            el.up('opcion').down('form').show()
            el.up('gridpanel').hide()
            el.up('opcion').down('form').down('button[action=guardar]').hide()
            el.up('opcion').down('form').down('button[action=guardarcambios]').show()
            el.up('opcion').down('form').down('combobox[name=estadoOpcion]').show()
        }
    }
});
