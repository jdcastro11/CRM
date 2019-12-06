Ext.define('Seguridad.view.Usuario', {
    extend: 'Ext.window.Window',
    alias:'widget.usuario',
    title:'Usuarios',
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
            store:'UsuarioList',
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
                    dataIndex:'usuario',
                    text:'Usuario',
                    flex:1
               },{
                    dataIndex:'asignado',
                    text:'Asignado?',
                    flex:0.5
               },{
                    dataIndex:'tipoUsuario',
                    text:'Tipo',
                    flex:0.5,
                    renderer:function(value){
                        return (value == 'INT' ? 'Interno' : 'Externo')
                    }
               },{
                    dataIndex:'estado',
                    text:'Estado',
                    flex:1
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
                    name: 'usuario',
                    padding:5,
                    width:400,
                    fieldLabel: 'Usuario',
                    allowBlank: false
                },{
                    xtype: 'textfield',
                    name: 'contrasena',
                    inputType: 'password',
                    padding:5,
                    width:400,
                    fieldLabel: 'Contraseña',
                },
                {
                    xtype: 'combobox',
                    name: 'persona_id',
                    padding:5,
                    width:400,
                    store: 'Personas',
                    queryMode: 'local',
                    valueField: 'id',
                    displayField: 'nombre',
                    fieldLabel: 'Persona',
                    allowBlank: false
                },{
                    xtype: 'combobox',
                    //hidden:true,
                    name: 'tipoUsuario',
                    padding:5,
                    width:400,
                    store: Ext.create('Ext.data.Store', {
                        fields: ['key', 'name'],
                        data : [
                            {"key":"INT", "name":"Interno"},
                            {"key":"EXT", "name":"Externo"}
                           
                        ]
                    }),
                    queryMode: 'local',
                    valueField: 'key',
                    displayField: 'name',
                    fieldLabel: 'Tipo'
                },{
                    xtype: 'combobox',
                    hidden:true,
                    name: 'idEstadoUsuario',
                    padding:5,
                    width:400,
                    store: 'Parametros',
                    queryMode: 'local',
                    valueField: 'idValorParametro',
                    displayField: 'valor',
                    fieldLabel: 'Estado'
                }
            ]
        }
    ]
});
