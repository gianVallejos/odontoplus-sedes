<template>
  <b-container>
		<div class="row">
			<div class="col-md-12">
				<TitleComponent titulo="Lista de Usuarios" :items="breadcrumb" />
			</div>
      <div class="col-md-12">
      {{ items }}
        <PanelCard>
          <span slot="heading">Últimos Pacientes</span>
          <FormBuscar slot="body" />
          <div class="table mt-3" slot="body">
                <!-- User Interface controls -->
            <b-row>
              <b-col md="6" class="my-1">
                <b-form-group horizontal label="Filter" class="mb-0">
                  <b-input-group>
                    <b-form-input v-model="filter" placeholder="Type to Search" />
                    <b-input-group-append>
                      <b-btn :disabled="!filter" @click="filter = ''">Clear</b-btn>
                    </b-input-group-append>
                  </b-input-group>
                </b-form-group>
              </b-col>

            </b-row>

            <!-- Main table element -->
            <b-table show-empty
                    stacked="md"
                    :items="items"
                    :fields="fields"
                    :current-page="currentPage"
                    :per-page="perPage"
                    :filter="filter"
                    :sort-by.sync="sortBy"
                    :sort-desc.sync="sortDesc"
                    :sort-direction="sortDirection"
                    @filtered="onFiltered" >
              <template slot="name" slot-scope="row">{{row.value}}</template>
              <template slot="actions" slot-scope="row">
                <p>fkjd</p>
              </template>
              <template slot="isActive" slot-scope="row">
                <b-badge :variant="row.value ? 'success' : 'danger'">{{row.value?'Activo':'Inactivo'}}</b-badge>
              </template>
            </b-table>

          <b-row align-h="between">
          <b-col align-self="start">One of three columns</b-col>
              <b-col cols="auto">
                <b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" class="my-0" />
              </b-col>
          </b-row>
          </div>
        </PanelCard>
			</div>
		</div>



  </b-container>

</template>

<script>
	import PanelCard from '../widgets/panel/panel-component.vue'
	import TitleComponent from '../widgets/titulo/index.vue'

  const dasd = [
    { isActive: true, email: 'test_qwe@email.com', rol:'Invitado', name: { first: 'Dickerson', last: 'Macdonald' }},
    { isActive: false, email: 'test_qwe@email.com', rol:'Invitado', name: { first: 'Larsen', last: 'Shaw' }},
    { isActive: false, email: 'test_qwe@email.com', rol:'Invitado', name: { first: 'Mini', last: 'Navarro' }},
    { isActive: false, email: 'test_qwe@email.com', rol:'Invitado', name: { first: 'Geneva', last: 'Wilson' }},
    { isActive: true, email: 'test_qwe@email.com', rol:'Invitado', name: { first: 'Jami', last: 'Carney' }},
    { isActive: false, email: 'test_qwe@email.com', rol:'Admin', name: { first: 'Essie', last: 'Dunlap' }},
    { isActive: true, email: 'test_qwe@email.com', rol:'Invitado', name: { first: 'Thor', last: 'Macdonald' }},
    { isActive: true, email: 'test_qwe@email.com', rol:'Invitado', name: { first: 'Larsen', last: 'Shaw' } },
    { isActive: false, email: 'test_qwe@email.com', rol:'Invitado', name: { first: 'Mitzi', last: 'Navarro' }},
    { isActive: false, email: 'test_qwe@email.com', rol:'Admin', name: { first: 'Genevieve', last: 'Wilson' }},
    { isActive: true, email: 'test_qwe@email.com', rol:'Invitado', name: { first: 'John', last: 'Carney' }},
    { isActive: false, email: 'test_qwe@email.com', rol:'Invitado', name: { first: 'Dick', last: 'Dunlap' }}
  ]

  export default{
    mounted() { 
      console.log('Users mounted')
    },
    name: 'Users',
    components:{
			PanelCard,
      TitleComponent
		},
    props:[
      'items'
    ],
    data(){
			return{
        fields: [
          { key: 'actions', label: 'Actions' },
          { key: 'name', label: 'Nombre', sortable: true, sortDirection: 'desc' },
          { key: 'email', label: 'Email', sortable: true, 'class': 'text-center' },
          { key: 'rol', label: 'Rol', sortable: true },
          { key: 'isActive', label: 'Estado', sortable: true }
          ],
        currentPage: 1,
        perPage: 10,
        totalRows: this.items.length,
        pageOptions: [ 5, 10, 15 ],
        sortBy: null,
        sortDesc: false,
        sortDirection: 'asc',
        filter: null,
        modalInfo: { title: '', content: '' },
        breadcrumb: [
          { text: 'Home', href: '/' },
          { text: 'Lista de Usuarios', active: true }
        ]
			}
		},
    computed: {
      sortOptions () {
        // Create an options list from our fields
        return this.fields
          .filter(f => f.sortable)
          .map(f => { return { text: f.label, value: f.key } })
      }
    },
		methods:{
			onSubmit (evt) {
		      evt.preventDefault();
		      alert(JSON.stringify(this.form));
		  },
      info (item, index, button) {
        this.modalInfo.title = `Row index: ${index}`
        this.modalInfo.content = JSON.stringify(item, null, 2)
        this.$root.$emit('bv::show::modal', 'modalInfo', button)
      },
      resetModal () {
        this.modalInfo.title = ''
        this.modalInfo.content = ''
      },
      onFiltered (filteredItems) {
        // Trigger pagination to update the number of buttons/pages due to filtering
        this.totalRows = filteredItems.length
        this.currentPage = 1
      }
		}
  }
</script>