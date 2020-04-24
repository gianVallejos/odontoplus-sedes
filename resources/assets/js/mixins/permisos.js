const mixins = {
  data(){
    return{
      permisosList: [ //Nombre Schema - Ambos: 0, Admin: 1, Colaborador: 2
        {
          schema: "1_ODONTOPLUS_CAJ",
          rol: "0",
          allow_sedes: "1",
        },
        {
          schema: "2_ATET_CAJ",
          rol: "0",
          allow_sedes: "1",
        },
        {
          schema: "3_ORTHODENTS_CAJ",
          rol: "0",
          allow_sedes: "0",
        },
        {
          schema: "4_CORE_CAJ",
          rol: "0",
          allow_sedes: "0",
        }
      ]
    }
  },
  methods: {
      autorizadoVerEmpresa(schema, rolid){
        for( var i = 0; i < this.permisosList.length; i++ ){
          if( this.permisosList[i].schema == schema ){
            if( this.permisosList[i].rol == "0" ) return true
            if( this.permisosList[i].rol == rolid ) return true
          }
        }
        return false
      },
      autorizadoVerSedes(schema){
        for( var i = 0; i < this.permisosList.length; i++ ){
          if( this.permisosList[i].schema == schema ){
            if( this.permisosList[i].allow_sedes == "1" ) return true
          }
        }
        return false
      }
  }
}

export default mixins
