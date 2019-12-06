Ext.define('Seguridad.view.Opcion', {
    extend: 'Ext.window.Window',
    alias:'widget.opcion',
    title:'Opciones',
    iconCls:'icon-hand-up',
    height:450,
    width:550,
    layout: 'border',
    modal:true,
    items: [
        {
            region: 'center',
            flex:1,
            xtype:'gridpanel',
            store:'OpcionList',
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
                    hidden:false,
                    flex:0.5
               },{
                    dataIndex:'nombreOpcion',
                    text:'Opcion',
                    flex:1
               },{
                    dataIndex:'idPadre',
                    text:'Padre',
                    flex:0.5
               },{
                    dataIndex:'descOpcion',
                    text:'Descripcion',
                    flex:1
               },{
                    dataIndex:'idTipoOpcion',
                    text:'Tipo',
                    flex:1,
                    renderer:function(value){
                        return (value == "M" ? "Menu":"Det")
                    }
               },{
                    dataIndex:'controlador',
                    text:'Controlador',
                    hidden:true,
                    flex:1
               },{
                    dataIndex:'url',
                    text:'URL',
                    flex:1
               },{
                    dataIndex:'asignado',
                    text:'Asignado?',
                    flex:1
               },{
                    dataIndex:'orden',
                    text:'Orden',
                    flex:0.5
               },{
                    dataIndex:'cls',
                    hidden:true,
                    text:'cls',
                    flex:0.5
               },{
                    dataIndex:'estadoOpcion',
                    text:'Estado',
                    flex:1,
                    renderer:function(value){
                        return (value == "A" ? "Activo":"Inactivo")
                    }
               },{
                   dataIndex:'tieneHijos',
                    text:'Hijos?',
                    flex:0.5,
                    renderer:function(value){
                        return (value == 1 ? "S":"N")
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
            width:540,
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
                    width:200,
                    fieldLabel: 'ID'
                },{
                    xtype: 'textfield',
                    name: 'nombreOpcion',
                    padding:5,
                    width:400,
                    fieldLabel: 'Nombre',
                    allowBlank: false
                },{
                    xtype: 'textfield',
                    name: 'descOpcion',
                    padding:5,
                    width:400,
                    fieldLabel: 'Descripcion',
                }, {
                    xtype: 'textfield',
                    name: 'idPadre',
                    padding:5,
                    width:200,
                    fieldLabel: 'Padre',
                },{
                    xtype: 'textfield',
                    name: 'tieneHijos',
                    padding:5,
                    width:200,
                    fieldLabel: 'Tiene Hijos',
                },{
                    xtype: 'combobox',                   
                    name: 'idTipoOpcion',
                    padding:5,
                    width:400,
                    store: Ext.create('Ext.data.Store', {
                        fields: ['key', 'valor'],
                        data : [
                            {"key":"M", "valor":"Menu"},
                            {"key":"D", "valor":"Det"}
                        ]
                    }),
                    queryMode: 'local',
                    valueField: 'key',
                    displayField: 'valor',
                    fieldLabel: 'Tipo Opción'
                },{
                    xtype: 'textfield',
                    name: 'controlador',
                    padding:5,
                    width:400,
                    fieldLabel: 'Controlador',
                },{
                    xtype: 'textfield',
                    name: 'url',
                    padding:5,
                    width:400,
                    fieldLabel: 'URL',
                },{
                    xtype: 'textfield',
                    name: 'orden',
                    padding:5,
                    width:400,
                    fieldLabel: 'Orden',
                },{
                    xtype: 'textfield',
                    name: 'cls',
                    padding:5,
                    width:400,
                    fieldLabel: 'cls',
                },{
                    xtype: 'combobox',
                    hidden:true,
                    name: 'estadoOpcion',
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
