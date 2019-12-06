Ext.define('Seguridad.view.Rol', {
    extend: 'Ext.window.Window',
    alias:'widget.rol',
    title:'Roles',
    iconCls:'icon-thumbs-up',
    height:400,
    width:500,
    layout: 'border',
    modal:true,
    items: [
        {
            region: 'center',
            flex:1,
            xtype:'gridpanel',
            store:'RolList',
            selModel: {
                selType: 'checkboxmodel',
                headerWidth: 25
            },
            layout: {
                type : 'border'
            },
            tbar:[
                {
                    xtype:'button',
                    text:'Nuevo',
                    action:'nuevo',
                    cls:'button',
                    overCls:'my-over',
                    disabledCls:'my-disabled',
                    //iconCls:'icon-plus',
                },{
                    xtype:'label',
                    text:'',
                    width:5
                },{
                    xtype:'button',
                    text:'Borrar',
                    action:'borrar'
                    //iconCls: 'icon-remove'
                },{
                    xtype:'label',
                    text:'',
                    width:5
                },{
                    xtype:'button',
                    text:'Editar',
                    action:'editar'
                    //iconCls: 'icon-remove'
                },{
                    xtype:'label',
                    text:'',
                    width:5
                },{
                    xtype:'button',
                    text:'Refrescar',
                    action:'load',
                    tooltip: 'Cargar datos',
                    //iconCls:'icon-refresh'
                },{
                    xtype:'label',
                    text:'',
                    width:25
                }
            ],
            columns: [
               {
                    dataIndex:'id',
                    text:'ID',
                    hidden:true,
                    flex:1
               },{
                    dataIndex:'nombreRol',
                    text:'Rol',
                    flex:1
               },{
                    dataIndex:'descRol',
                    text:'Descripcion',
                    flex:1
               },{
                    dataIndex:'estadoRol',
                    text:'Estado',
                    flex:1,
                            renderer:function(value){
                                return (value == "A" ? "Activo":"Inactivo")
                            }
               }
            ],
            viewConfig: {
                getRowClass: function(record, rowIndex, rowParams, store){
                    if(record.get("asignado") == "SI") return  "row-asignado";
                }
            }
        },
        {
            region: 'west',
            name:'form',
            hidden:true,
            width:490,
            xtype:'form',
            
            buttons:[
            {
                xtype:'button',
                text:'Guardar',
                action:'guardar',
                formBind:true                
            },{
                xtype:'label',
                text:'',
                width:5
            },{
                xtype:'button',
                text:'Guardar',
                hidden:true,
                action:'guardarcambios',
                formBind:true                
            },{
                xtype:'label',
                text:'',
                width:5
            },{
                xtype:'button',
                text:'Cancelar',
                action:'cancelar'
                //iconCls: 'icon-remove'
            }],
            items:[
                {
                    xtype: 'textfield',
                    hidden:true,
                    name: 'id',
                    padding:5,
                    width:400,
                    fieldLabel: 'ID'
                },{
                    xtype: 'textfield',
                    name: 'nombreRol',
                    padding:5,
                    width:400,
                    fieldLabel: 'Nombre',
                    allowBlank: false
                }, {
                    xtype: 'textfield',
                    name: 'descRol',
                    padding:5,
                    width:400,
                    fieldLabel: 'Descripcion',
                }, {
                    xtype: 'combobox',
                    hidden:true,
                    name: 'estadoRol',
                    padding:5,
                    width:400,
                    store: Ext.create('Ext.data.Store', {
                        fields: ['estadoRol', 'valor'],
                        data : [
                            {"estadoRol":"A", "valor":"Activo"},
                            {"estadoRol":"I", "valor":"Inactivo"}
                        ]
                    }),
                    queryMode: 'local',
                    valueField: 'estadoRol',
                    displayField: 'valor',
                    fieldLabel: 'Estado'
                }
            ]
        }
    ]
});
