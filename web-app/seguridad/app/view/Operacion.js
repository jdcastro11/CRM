Ext.define('Seguridad.view.Operacion', {
    extend: 'Ext.window.Window',
    alias:'widget.operacion',
    title:'Operaciones',
    iconCls:'icon-hand-up',
    height:400,
    width:500,
    layout: 'border',
    modal:true,
    items: [
        {
            region: 'center',
            flex:1,
            xtype:'gridpanel',
            store:'OperacionesList',
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
            bbar:[
                {   xtype:'label',
                    text:'',
                    flex:1
                },
                {
                    xtype:'button',
                    text:'Asignar',
                    action:'asignar',
                    tooltip: 'Asignar Operaciones seleccionadas',
                    //iconCls:'icon-hand-up'
                }
            ],
            columns: [
               {
                    dataIndex:'id',
                    text:'ID',
                    hidden:true,
                    flex:1
               },{
                    dataIndex:'nombreOperacion',
                    text:'Operacion',
                    flex:1
               },{
                    dataIndex:'acciones',
                    text:'Acciones',
                    flex:1
               },{
                    dataIndex:'asignado',
                    text:'Asignado?',
                    flex:1
               },{
                    dataIndex:'estadoOperacion',
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
                    name: 'nombreOperacion',
                    padding:5,
                    width:400,
                    fieldLabel: 'Operacion',
                    allowBlank: false
                },{
                    xtype: 'textfield',
                    name: 'acciones',
                    padding:5,
                    width:400,
                    fieldLabel: 'Acciones',
                },{
                    xtype: 'combobox',
                    hidden:true,
                    name: 'estadoOperacion',
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
