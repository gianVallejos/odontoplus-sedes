const mixins = {
  data(){
    return{
      permisos_empresa: [ //Nombre Schema - Ambos: 0, Admin: 1, Colaborador: 2
        {
          schema: "1_ODONTOPLUS_CAJ",
          rol: "0"
        }
      ]
    }
  },
  methods: {
    autorizadoVerEmpresa(schema, rolid){
      for( var i = 0; i < this.permisos_empresa.length; i++ ){
        if( this.permisos_empresa[i].schema == schema ){
          if( this.permisos_empresa[i].rol == "0" ) return true
          if( this.permisos_empresa[i].rol == rolid ) return true
        }
      }
      return false
    }
  }
}

export default mixins
