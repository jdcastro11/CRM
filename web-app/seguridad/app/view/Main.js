Ext.define('Seguridad.view.Main', {
    extend: 'Ext.container.Viewport',
    alias:'widget.main',
    /*height:600,
    flex:1,*/
    layout: 'border',
    items: [
        
        {
            xtype:'container',
            region:'west',
            layout: 'border',
            flex:1,
            items:[
                {
                    region: 'center',
                    title:'&nbsp;Roles',
                    iconCls:'icon-thumbs-up',
                    name:'roles',
                    xtype:'gridpanel',
                    store:'Roles',
                    selModel: {
                        selType: 'checkboxmodel',
                        headerWidth: 25,
                        mode:'SINGLE'
                    },
                    layout: {
                        type : 'border'
                    },
                    
                    tools:[
                    {
                        xtype:'button',
                        text:'Roles',
                        tooltip: 'Gestionar Roles',
                        cls:'button',
                        action:'roles',
                        overCls:'my-over',
                        disabledCls:'my-disabled',
                        //iconCls:'icon-plus',
                    },{
                        xtype:'label',
                        text:'',
                        width:5
                    },
                    {
                        xtype:'button',
                        text:'Refrescar',
                        action:'load',
                        tooltip: 'Cargar datos',
                        //iconCls:'icon-refresh'
                    },{
                        xtype:'label',
                        text:'',
                        width:25
                    }],
                    columns: [
                       {
                            dataIndex:'id',
                            text:'ID',
                            hidden:true,
                            flex:1
                       },{
                            dataIndex:'nombreRol',
                            text:'Rol',
                            flex:40
                       },{
                            dataIndex:'descRol',
                            text:'Descripcion',
                            flex:45
                       },{
                            dataIndex:'estadoRol',
                            text:'Estado',
                            flex:15,
                            renderer:function(value){
                                return (value == "A" ? "Activo":"Inactivo")
                            }
                       },{
                            dataIndex:'eliminado',
                            text:'Eliminado',
                            hidden:true,
                            flex:1
                       }
                    ]
                },{
                    region: 'south',
                    flex:1,
                    title:'&nbsp;Usuarios',
                    name:'usuarios',
                    iconCls:'icon-user',
                    store:'Usuarios',
                    xtype:'gridpanel',
                    layout: {
                        type : 'border'
                    },
                    selModel: {
                        selType: 'checkboxmodel',
                        headerWidth: 25
                    },
                    tools:[{
                        xtype:'button',
                        text:'Usuarios',
                        tooltip: 'Gestionar usuario',
                        cls:'button',
                        action:'usuarios',
                        overCls:'my-over',
                        disabledCls:'my-disabled',
                        //iconCls:'icon-plus',
                    },{
                        xtype:'label',
                        text:'',
                        width:5
                    },{
                        xtype:'button',
                        text:'Quitar Usuario',
                        action:'quitarUsuarios',
                        tooltip: 'Quitar usuario',
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
                    }],
                    columns: [
                       {
                            dataIndex:'id',
                            text:'ID',
                            hidden:true,
                            flex:1
                       },{
                            dataIndex:'usuario',
                            text:'Usuario',
                            flex:80
                       },{
                            dataIndex:'estado',
                            text:'Estado',
                            flex:20
                       }
                    ]
                }
            ]
        },
        
        {
            xtype:'container',
            region: 'center',
            layout: 'border',
            flex:1,
            items:[
                {
                    region: 'center',
                    flex:1,
                    title:'&nbsp;Opciones',
                    store:'Opciones',
                    name:'opciones',
                    iconCls:'icon-list',
                    xtype:'gridpanel',
                    layout: {
                        type : 'border'
                    },
                    selModel: {
                        selType: 'checkboxmodel',
                        headerWidth: 25
                    },
                    tools:[{
                        xtype:'button',
                        text:'Opciones',
                        tooltip: 'Gestionar opciones',
                        cls:'button',
                        overCls:'my-over',
                        action:'opciones',
                        disabledCls:'my-disabled',
                        //iconCls:'icon-plus',
                    },{
                        xtype:'label',
                        text:'',
                        width:5
                    },{
                        xtype:'button',
                        text:'Quitar Opciones',
                        action:'quitarOpciones',
                        tooltip: 'Quitar opciones',
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
                    }],
                    columns: [
                       {
                            dataIndex:'id',
                            text:'ID',
                            hidden:true,
                            flex:1
                       },{
                            dataIndex:'nombreOpcion',
                            text:'Opcion',
                            flex:40
                       },{
                            dataIndex:'descOpcion',
                            text:'Descripcion',
                            flex:45
                       },{
                            dataIndex:'estadoOpcion',
                            text:'Estado',
                            flex:15,
                            renderer:function(value){
                                return (value == "A" ? "Activo":"Inactivo")
                            }
                       }
                    ]
                },{
                    region: 'south',
                    flex:1,
                    title:'&nbsp;Operaciones',
                    iconCls:'icon-hand-up',
                    xtype:'gridpanel',
                    store:'Operaciones',
                    name:'operaciones',
                    selModel: {
                        selType: 'checkboxmodel',
                        headerWidth: 25
                    },
                    layout: {
                        type : 'border'
                    },
                    tools:[{
                        xtype:'button',
                        text:'Operaciones',
                        action:'operaciones',
                        tooltip: 'Gestionar operaciones',
                        cls:'button',
                        overCls:'my-over',
                        disabledCls:'my-disabled',
                       // iconCls:'icon-plus',
                    },{
                        xtype:'label',
                        text:'',
                        width:5
                    },{
                        xtype:'button',
                        text:'Quitar Operaciones',
                        action:"quitarOperaciones",
                        tooltip: 'Quitar operaciones',
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
                    }],
                    columns: [
                       {
                            dataIndex:'id',
                            text:'ID',
                            hidden:true,
                            flex:1
                       },{
                            dataIndex:'nombreOperacion',
                            text:'Operacion',
                            flex:40
                       },{
                            dataIndex:'acciones',
                            text:'Acciones',
                            flex:45
                       },{
                            dataIndex:'estadoOperacion',
                            text:'Estado',
                            flex:15,
                            renderer:function(value){
                                return (value == "A" ? "Activo":"Inactivo")
                            }
                       }
                    ]
                }
            ]
        }
        

    ]
});
