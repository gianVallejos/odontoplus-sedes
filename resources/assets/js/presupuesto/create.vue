<template>
	<b-container class="pb-4">
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Presupuestos" :items="breadcrumb" />
			</b-col>
			<b-col cols="12" class="pt-1">
				<PanelCard>
					<span slot="heading">Crear Presupuestos </span>
					<div slot="body" class="pt-3 pb-3 pl-3 pr-3">
						<b-row>
							<b-col cols="6" class="pt-1 pb-4 d-none d-lg-block">
								<div class="form-title">
									<i class="fas fa-file-invoice-dollar"></i>
									<div class="d-inline"> Crear Presupuesto </div>
								</div>
								<p class="form-description fz-3 pt-3 pr-4">
									Para crear un presupuesto debe seleccionar el paciente a tratar y el doctor responsable.
									<br /><br />Al seleccionar "nuevo presupuesto", le aparecerá un odontograma interactivo, en donde podrá agregar los tratamientos de la historia clínica a cotizar.
								</p>
							</b-col>
							<b-col cols="12" lg="6" class="pt-0 pt-lg-1 pb-0 pb-lg-4">
								<b-form>
									<b-form-group label="Seleccionar Paciente" label-for="pacientes">
										<b-input-group>
									      	<b-form-input id="pacientes" type="text" v-model="form.pacienteSelected" placeholder="Ningun Paciente Seleccionado" disabled />
									      	<b-input-group-append>
										    	<b-btn class="pl-3 pr-3" variant="success" v-b-modal.exampleModal >
										    		<i class="fas fa-search"></i>
										    	</b-btn>
										    </b-input-group-append>
								    	</b-input-group>
									</b-form-group>
									<b-form-group label="Seleccionar Doctor" label-for="apellidos">
										<b-form-select v-model="form.doctorSelected">
											<option :value="null">Ningun Doctor Seleccionado</option>
											<option v-for="(doctor, index) in doctores" :key="index" :value="doctor.id">
												{{ doctor.nombres }} {{ doctor.apellidos}}
											</option>
										</b-form-select>
									</b-form-group>
								</b-form>
							</b-col>
							<b-col cols="12">
								<div class="text-center">
									<b-button type="submit" variant="warning" v-on:click="onSubmit">
										<i class="fas fa-plus"></i>&nbsp; Nuevo Presupuesto
									</b-button>
									<b-button :href="url + '/presupuestos'" variant="danger">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
								</div>
							</b-col>
						</b-row>
						<b-modal ref="myModalRef" id="exampleModal" size="md" title="Lista de Pacientes">
							<b-row>
								<b-col cols="12">
									<b-input-group>
										<div class="input-group-append">
											<span class="icon-input">
				    							<i class="fas fa-search" aria-hidden="true"></i>
				    						</span>
				    					</div>
			    						<input v-model="filter" placeholder="Buscar..." type="text" class="odInput">
								    </b-input-group>
								</b-col>
								<b-col cols="12" class="pt-3 pb-2">
									<b-table 	show-empty
														:items="pacientes"
														:fields="fields"
														:current-page="currentPage"
														:per-page="perPage"
														:filter="filter"
														:sort-by.sync="sortBy"
														:sort-desc.sync="sortDesc"
														:sort-direction="sortDirection"
														responsive
														stacked="md"
							             	@filtered="onFiltered"
														empty-text="No existen campos para mostrar"
														empty-filtered-text="No existen pacientes que coincidan con la búsqueda">
											<template slot="codigo" slot-scope="row">
												<a v-on:click.prevent="agregarPaciente(row.item.id, row.item.nombres, row.item.apellidos)" href="#" class="link-color">
													{{ row.value }}
												</a>
											</template>
											<template slot="nombres" slot-scope="row">
												<a v-on:click.prevent="agregarPaciente(row.item.id, row.item.nombres, row.item.apellidos)" href="#" class="link-color">
									    		{{ row.value }} {{ row.item.apellidos }}
												</a>
									    </template>
									    <template slot="actions" slot-scope="row" class="md-2">
									        <div class="actions-table" style="color: #d1d1d1">
									        	<a v-on:click.prevent="agregarPaciente(row.item.id, row.item.nombres, row.item.apellidos)" href="#" class="action">Seleccionar</a>
									        </div>
									    </template>
									</b-table>
								</b-col>
								<b-col cols="12" class="text-center">
									<b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" class="d-inline-flex" />
								</b-col>
							</b-row>
							<div slot="modal-footer">
								<b-button  variant="secondary" size="sm" :href="url + '/pacientes/create'">
									<i class="fas fa-plus"></i>&nbsp; Nuevo Paciente
								</b-button>
								<b-button variant="primary" size="sm" @click="hideModal">
									<i class="fas fa-times"></i>&nbsp; Cerrar
								</b-button>
							</div>
						</b-modal>
					</div>
				</PanelCard>
			</b-col>
		</b-row>
	</b-container>
</template>

<script>
	import TitleComponent from '../widgets/titulo/index.vue'
	import PanelCard from '../widgets/panel/panel-component.vue'

	export default{
		components:{
			TitleComponent,
			PanelCard
		},
		props: [
			'url',
			'pacientes',
			'doctores'
		],
		data(){
			return {
				breadcrumb: [
			    	{ text: 'Inicio', href: this.url },
			    	{ text: 'Presupuestos', href: this.url + '/presupuestos' },
			    	{ text: 'Crear Presupuesto', active: true }
			    ],
			    isDisabled: false,
			    form: {
			    	idPacienteSelected: null,
			    	pacienteSelected: '',
			    	doctorSelected: null
			    },
			    allerros: [],
			    fields: [
				    { key: 'codigo', label: 'Nro Historia', class: 'text-left text-lg-center' },
				    { key: 'nombres', label: 'Nombre de Paciente', sortable: true, sortDirection: 'desc' },
				    { key: 'actions', label: '', sortable: false },
			    ],
			    currentPage: 1,
			   	perPage: 7,
			    totalRows: 0,
			    pageOptions: [ 5, 10, 15 ],
			    sortBy: null,
			    sortDesc: false,
			    sortDirection: 'asc',
			    filter: ''
			}
		},
		methods: {
			onSubmit () {
				if( this.form.idPacienteSelected == null ){
					this.toastFunction('Para crear un presupuesto debe seleccionar un paciente', 'error')
				}else if( this.form.doctorSelected == null ){
					this.toastFunction('Para crear un presupuesto debe seleccionar un doctor', 'error')
				}else{
					window.location.href = this.url + '/presupuestos/nuevo/' + this.form.idPacienteSelected + '/' + this.form.doctorSelected
				}
			},
			hideModal(){
				this.$refs.myModalRef.hide()
			},
			onFiltered (filteredItems) {
		      this.totalRows = filteredItems.length
		      this.currentPage = 1
		    },
		    agregarPaciente(id, nombres, apellidos){
		    	//alert(id)
		    	this.form.idPacienteSelected = id
		    	this.form.pacienteSelected = nombres + ' ' + apellidos
		    	this.$refs.myModalRef.hide()
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
			}
		}
	}
</script>
