<template>
	<div class="card">
		<div class="card-heading" v-if="hasHeadingSlot">
			<slot name="heading"></slot>
		</div>
		<div class="card-body" v-if="hasBodySlot">
			<slot name="body"></slot>
		</div>
		<div class="card-footer" v-if="hasFooterSlot">
			<slot name="footer"></slot>
		</div>
	</div>
</template>

<script>
	export default{
		computed: {
		    hasHeadingSlot () {
		      return !!this.$slots['heading']
		    },
		    hasBodySlot () {
		      return !!this.$slots['body']
		    },
		    hasFooterSlot () {
		      return !!this.$slots['footer']
		    }
	    }
	}
</script>
