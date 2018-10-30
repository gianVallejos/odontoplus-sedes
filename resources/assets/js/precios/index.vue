<template>
  <b-container>
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Precios" :items="breadcrumb" />
			</b-col>
      <b-col cols="12">
        <PanelCard>
          <span slot="heading">Lista de Precios</span>
          <div slot="body" class="pt-3 pb-3 pl-3 pr-3">
            <!-- User Interface controls -->
            <b-row class="pb-3">
                <div class="col-md-6">
                    <div class="input-group d-inline-block">
                        <b-input-group>
                            <div class="input-group-append">
                                <span class="icon-input">
                                    <i class="fas fa-search" aria-hidden="true"></i>
                                </span>
                            </div>
                            <input v-model="search" placeholder="Buscar..." type="text" class="odInput buscar">   
                            <div class="input-group-append">
                              <b-btn class="pl-3 pr-3" variant="secondary" :disabled="!search" @click="search = ''">
                                <i class="fas fa-sync-alt"></i>
                              </b-btn>
                            </div>                         
                        </b-input-group>
                    </div>
                </div>
                <div class="col-md-6">							
                  <div class="float-right d-inline-block">
                    <b-button-group>										
                      <b-button :href="this.url+'/tratamientos'" variant="secondary">
                        <i class="fas fa-tooth"></i>&nbsp; Ir a Tratamientos
                      </b-button>
                      <b-button :href="this.url+'/empresas'" variant="warning">
                        <i class="fas fa-building"></i>&nbsp; Ir a Empresas
                      </b-button>
                    </b-button-group>
                  </div>
							  </div>
            </b-row>

            <!-- Main table element -->
            <div class="scrollable">
              <table class="table">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Tratamiento</th>
                    <th scope="col">Empresa</th>
                    <th scope="col">Monto</th>
                    <th scope="col"></th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(item, index) in computedData" :key="index" >
                    <th scope="row">{{ index + 1}}</th>
                    <td>{{item.tratamiento}}</td>
                    <td>
                      <b-form-select :ref="'emp-' + index" class="small" v-model="item.id_empresa" v-on:input="onSelectedCompany(index, item)">
                        <option v-for="(e,index) in companies" :key="index" :value="e.id">
                          {{ e.nombre }}
                        </option>
                      </b-form-select>
                    </td>
                    <td>
                      <b-input-group class="small" prepend="S/.">
                        <b-form-input :ref="'monto-'+index" class="small" type="text" v-model="item.monto"></b-form-input>
                      </b-input-group>
                      <div class="text-center">
                      <span v-if="all_errors.index == index" :class="['label label-danger']">{{ all_errors.monto[0] }}</span>

                      </div>
                    </td>
                    <td v-if="curUser.rolid == 1">
                      <b-button class="small" variant="success" v-on:click.prevent="onModificar(index, item)">
                        Guardar
                      </b-button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>

          </div>
        </PanelCard>
			</b-col>
		</b-row>
  </b-container>
</template>

<script>
	import PanelCard from '../widgets/panel/panel-component.vue'
  import TitleComponent from '../widgets/titulo/index.vue'
	import axios from 'axios'  

  export default{
    mounted() { 
      console.log('Precios mounted')
      this.data = this.prices
    },
    name: 'precios',
    components:{
			PanelCard,
      TitleComponent
		},
    props:[
      'companies',
      'prices',
      'curUser',
      'url',
    ],
    data(){
			return{
        all_errors: [],
        breadcrumb: [
          { text: 'Inicio', href: this.url },
          { text: 'Precios', active: true }
        ],
        search: '',
        computedTodos:[]
			}
		},
    computed: {      
      computedData: function() { 
          this.computedTodos = this.prices;  
          if (this.search) {
            this.computedTodos = this.computedTodos.filter(item => item.tratamiento.toUpperCase().includes(this.search.toUpperCase()));   
            return this.computedTodos;
          }
          return this.computedTodos;
      }
    },
    methods:{
      onSelectedCompany(index, item){
        this.cleanErrosMessage()
        var ind = this.buscarPosicion(item.tratamiento)
        var company_id = this.$refs['emp-'+index][0].$el.value
        var treatment_id = this.prices[ind].id_tratamiento
        var request = { method: 'GET', url: this.url+'/consulta_precio?empresa_id='+ company_id + '&tratamiento_id=' + treatment_id}

        axios(request).then((response) => {
          if(response.data.price){
            this.prices[ind].id = response.data.price[0].id
            this.$refs['monto-'+index][0].$el.value = response.data.price[0].monto
          }
          else{
            console.log('price not found!')
          }
        }).catch(function (error) {
          console.log(error);
        });

      },
      onModificar(index, item){
        this.cleanErrosMessage()
        var id = this.prices[this.buscarPosicion(item.tratamiento)].id
        var amount = this.$refs['monto-'+index][0].$el.value
        var request = { method: 'PUT', url: this.url+'/precios/'+ id, data: { monto: amount } }
        
        axios(request).then((response) => {
          if(response.data.success){
              this.toastFunctionRedirect('Éxito', 'El precio ha sido actualizado correctamente. <br />Redireccionando...', 'success')
          }
          else if (response.data.error){
            this.all_errors = response.data.error
            this.all_errors.index = index
            console.log(response.data.error)
          }
        }).catch(function (error) {
          console.log(error);
        });
        
      },
      buscarPosicion(tratamiento){
          for( var i = 0; i < this.prices.length; i++ ){
            if( this.prices[i].tratamiento == tratamiento ) 
                return i
          }
      },
      cleanErrosMessage(){
        this.all_errors = []
      },
      toastFunction(msg, type){
        this.$swal({
            type: type,
            title: msg,
            toast: true,
            position: 'top',
            showConfirmButton: false,
              timer: 3000
        })
      },
      totalCurrentPages(){
        var res = Math.round(this.totalRows / this.perPage)
        if( res == 0 ) return res + 1
        return Math.ceil(this.totalRows / this.perPage )
      },
      toastFunctionRedirect(title, msg, type){
        this.$swal({
            type: type,
            title: title,
            html: msg,
            toast: false,
            position: 'center',
            showConfirmButton: false,
              timer: 3000,
              backdrop: `rgba(0, 0, 0, 0.6)`
        }).then(() => {
          window.location.href = this.url + '/precios'
        })  
      }
		}
  }
</script>